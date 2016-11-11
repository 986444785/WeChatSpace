//
//  NearDymanicVC.m
//  RitaApp
//
//  Created by BBC on 16/7/11.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "NearDymanicVC.h"
#import "NearDymanicImageCell.h"
#import "NearDymaicTopicCell.h"
#import "NearFootReusableView.h"

#import "SDPhotoBrowser.h"
#import "DynamicDetailVC.h"
#import "UIBarButtonItem+CH.h"
#import "ZyReleaseViewController.h"
#import "PersonDetailViewController.h"

#import "JPFPSStatus.h"

@interface NearDymanicVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,SDPhotoBrowserDelegate>
@property(nonatomic,strong)     UICollectionView * collectionview;
@property(nonatomic,strong) NSMutableArray * dataList;

@property (nonatomic, strong) NSArray *modelsArray;
@property(nonatomic,assign)    NSInteger   listPage;

@end


@implementation NearDymanicVC

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ZAN_COMMENT" object:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];


#if defined(DEBUG)||defined(_DEBUG)
    [[JPFPSStatus sharedInstance] open];
#endif

    self.navigationItem.title = @"动态";
  
    // 1.添加右边导航栏上面的点击按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"icon_carmer" highIcon:@"icon_carmer" target:self action:@selector(rightItemClick)];

    self.dataList = [NSMutableArray array];

    [self setColloectionview];

    //注册接收通知  ---- 局部更新
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(receiveNotify:) name:@"ZAN_COMMENT" object:nil];
    //注册接收通知  ---- 整体更新
    NSNotificationCenter * refreshCenter = [NSNotificationCenter defaultCenter];
    [refreshCenter addObserver:self selector:@selector(receiveRefeshNotify:) name:@"REFRESH_DYNAMIC" object:nil];
}    

#pragma mark  【接收到通知 更新页面】
-(void)receiveNotify:(NSNotification*)notify{
    NSDictionary * dic = [notify userInfo];

    NSInteger section = [dic[@"section"] integerValue];

    NSMutableArray * items = self.dataList[section];
    NearDynamicModel * model = [items lastObject];

    if (dic[@"zan"]) {
        int  count = [model.zan_count intValue] + 1 ;
        model.zan_count = [NSString stringWithFormat:@"%d",count];
    }
    if (dic[@"comment"]) {
        int  count = [model.comment_count intValue] + 1 ;
        model.comment_count = [NSString stringWithFormat:@"%d",count];
    }
       //只更新这一行
    NSIndexSet * indexSet = [[NSIndexSet alloc]initWithIndex:section];
    [self.collectionview reloadSections:indexSet];
}

-(void)receiveRefeshNotify:(NSNotification*)notify{
    [self requestDynamicListWithUpdate:YES];
}


-(void)rightItemClick{

    ZyReleaseViewController * relesaeVC = [[ZyReleaseViewController alloc]init];
    relesaeVC.photos = nil;
    relesaeVC.delegate = self;
    UINavigationController * nav0 = [[UINavigationController alloc]initWithRootViewController:relesaeVC];
    [self  presentViewController:nav0 animated:YES completion:nil];
}

   
-(void)requestDynamicListWithUpdate:(BOOL)update
{
    __unsafe_unretained typeof(self) vc = self;

    if (update) {
        vc.listPage = 1;
    }

    //请求请纬度 
    ZYLocationSingle * single = [ZYLocationSingle defaultSingleLocation];
    if (!single.log) {
    [single getLocationInfo];
    }


    [HttpHelper requestNearDynamicListWithUid:nil withPage:vc.listPage witjLog:single.log withLat:single.lat complate:^(NSDictionary *responseDic) {

//        NSLog(@"%@",responseDic);

        if (update) {
            [vc.collectionview.mj_header endRefreshing];
        }else{
            [vc.collectionview.mj_footer endRefreshing];
        }
    
        if (responseDic) {
            if ([responseDic[@"success"] intValue]==1) {

                if (update) {
                    [vc.dataList removeAllObjects];
                }

                NSDictionary * dataDic = responseDic[@"data"];
                NSArray * items = dataDic[@"items"];

                for (NSDictionary * dic in items) {

                    [vc.dataList addObject:[NearDynamicModel nearDynamicWithDict:dic]];
                }

//                vc.listPage ++ ;
                [vc.collectionview reloadData];

            }else{
                [LSFMessageHint showToolMessage:responseDic[@"message"] hideAfter:1.5 yOffset:0];
            }
        }

    }];
}
 

-(void)setColloectionview{
 
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing = 2.0;
    flowLayout.minimumLineSpacing = 2.0;

    _collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HIGHT-49) collectionViewLayout:flowLayout];
    _collectionview.backgroundColor = [UIColor whiteColor];
    _collectionview.delegate = self ;
    _collectionview.dataSource = self;
    [self.view addSubview:_collectionview]; 

    [_collectionview registerClass:[NearDymanicImageCell class] forCellWithReuseIdentifier:@"NearDymanicImageCell"];
    [_collectionview registerClass:[NearDymaicTopicCell class] forCellWithReuseIdentifier:@"NearDymaicTopicCell"];
    [_collectionview registerClass:[NearFootReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"NearFootReusableView"];
 
    [self requestDynamicListWithUpdate:YES]; 

    __unsafe_unretained typeof(self) vc  = self;

    _collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [vc requestDynamicListWithUpdate:YES];
    }];

    _collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [vc requestDynamicListWithUpdate:NO];
    }];
   
}
   
#pragma mark------
#pragma mark  UICollectionViewDatasource
//组个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return self.dataList.count;
}

//每组的cell个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    NSArray * items = self.dataList[section];
    return items.count-1;
}
 

#pragma mark -- -尾部
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
 
    NSArray * items = self.dataList[section];

    NearDynamicModel * model = [items lastObject];

    return CGSizeMake(KSCREEN_WIDTH, model.cell_height);
//    return CGSizeMake(KSCREEN_WIDTH, 60);
}


#pragma mark --cell与四周的距离
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 2, 5);
}

 
#pragma mark -- 每个cell大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    NSArray * items = self.dataList[indexPath.section];
    NearDynamicModel * model = items[indexPath.row];

    if ([model.cell_type isEqualToString:@"topc_cell"]) {
    
        return CGSizeMake(KSCREEN_WIDTH-10,model.cell_height);
    }else if ([model.cell_type isEqualToString:@"image_cell"]) {

        return CGSizeMake(model.image_hight, model.image_hight);

    } 
    return CGSizeMake(0, 0);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    NSArray * items = self.dataList[indexPath.section];
 
    NearDynamicModel * model = items[indexPath.row];

    if ([model.cell_type isEqualToString:@"topc_cell"]) {

        NearDymaicTopicCell * topiceCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NearDymaicTopicCell" forIndexPath:indexPath];
        [topiceCell updateTopciWithModel:model withIndex:indexPath];
        if (!topiceCell.avatarImageViewAction) {
            __weak NearDymanicVC * vc  = self ;
            topiceCell.avatarImageViewAction = ^(NSInteger index){

                [vc personalCenterWithIndex:index];
            };
        }
 
        return topiceCell;
        
    }else if ([model.cell_type isEqualToString:@"image_cell"]){

        NearDymanicImageCell * imagecell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NearDymanicImageCell" forIndexPath:indexPath];
        
        [imagecell updateImageViewWithImageUrl:model.image_url withIndex:indexPath];

        return imagecell;
    }  

    return nil;
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    if (kind == UICollectionElementKindSectionFooter) {

        NearFootReusableView * footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"NearFootReusableView" forIndexPath:indexPath];

        NSArray * items = self.dataList[indexPath.section];

        NearDynamicModel * model = [items lastObject];

        [footView updateNearFootReusableViewWithModel:model withIndex:indexPath];

        __weak NearDymanicVC * vc  = self ;

        footView.zanAction = ^(NSInteger index){

            NSLog(@"zanButtonClick  %ld",(long)index);
            [vc dianzanWithIndx:index];
        };

        footView.commentAction = ^(NSInteger index){

            [vc commentDetailPageWithIndex:indexPath isEdit:YES];
        };
 
        footView.moreAction = ^(NSInteger index){
            NSLog(@"moreAction   %ld",(long)index);
        };

        return footView;
    }

    return nil; 
} 
 

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"section %ld   row %ld",(long)indexPath.section,(long)indexPath.row);
    
    if (indexPath.row == 0) {

        [self commentDetailPageWithIndex:indexPath isEdit:NO];
    }else if (indexPath.row>0) {

        [self showImageWithIndex:indexPath];
    }
}
 
#pragma mark 【点赞】
-(void)dianzanWithIndx:(NSInteger)index{

    NSMutableArray * items = self.dataList[index];
    NearDynamicModel * model = [items lastObject];
    
    __unsafe_unretained typeof(self) vc = self;

     [HttpHelper diantZanWithDynamic_id:model.dynamicID complate:^(NSDictionary *responseDic) {

         if ([responseDic[@"success"] intValue]==1) {
             int  count = [model.zan_count intValue] + 1 ;
             //只更新这一行
             model.zan_count = [NSString stringWithFormat:@"%d",count];

             NSIndexSet * indexSet = [[NSIndexSet alloc]initWithIndex:index];
             [vc.collectionview reloadSections:indexSet];
         }
         [LSFMessageHint showToolMessage:responseDic[@"message"] hideAfter:1.5 yOffset:0];
     }];
}


#pragma mark 【展示图片】
-(void)showImageWithIndex:(NSIndexPath*)indexPath {

    NSArray * items = self.dataList[indexPath.section];
    NearDynamicModel * model = items[indexPath.row];
    self.modelsArray = model.show_images;

    SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
    photoBrowser.delegate = self;
    photoBrowser.currentImageIndex = indexPath.item-1;
    photoBrowser.imageCount = self.modelsArray.count;
    photoBrowser.sourceImagesContainerView = _collectionview;
    photoBrowser.currentSection = indexPath.section;
    [photoBrowser show];
}

 
#pragma mark 【个人动态中心】
-(void)personalCenterWithIndex:(NSInteger)index{

    NSArray * items = self.dataList[index];

    PersonDetailViewController * vc = [[PersonDetailViewController alloc]init];
    vc.topModel = items[0];
    [self.navigationController pushViewController:vc animated:YES];
}

  

#pragma mark  【去评论详情页面】
-(void)commentDetailPageWithIndex:(NSIndexPath*)indexPath isEdit:(BOOL)isEdit{

    NSArray * items = self.dataList[indexPath.section];
    NearDynamicModel * model = items[0];

    DynamicDetailVC * vc = [[DynamicDetailVC alloc]init];

    vc.isEdit            = isEdit;

    vc.dynamic_id = model.dynamicID;

    vc.fromSection = indexPath.section;

    vc.topArrays = items;
    
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark  SDPhotoBrowserDelegate
// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    // 不建议用此种方式获取小图，这里只是为了简单实现展示而已
    NearDymanicImageCell *cell = (NearDymanicImageCell *)[self collectionView:self.collectionview cellForItemAtIndexPath:[NSIndexPath indexPathForItem:browser.currentImageIndex+1 inSection:browser.currentSection]];
    return cell.show_imageView.image;
}
   

// 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString * urlStr = self.modelsArray[index];
    return [NSURL URLWithString:urlStr];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
