//
//  PersonDetailViewController.m
//  RitaApp
//
//  Created by BBC on 16/7/19.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "PersonDetailViewController.h"
#import "NoDataCell.h"
#import "PersonalHelpTool.h"
#import "GSKSpotyLikeHeaderView.h"

#import "NearDymanicImageCell.h"
#import "NearDymaicTopicCell.h"
#import "NearFootReusableView.h"

#import "SDPhotoBrowser.h"
#import "DynamicDetailVC.h"
#import "UIBarButtonItem+CH.h"
#import "ZyReleaseViewController.h"
#import "PersonDetailViewController.h"
 
@interface PersonDetailViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,SDPhotoBrowserDelegate,UIActionSheetDelegate>
@property(nonatomic,strong)     UICollectionView  * collectionview;
@property(nonatomic,strong)     NSMutableArray    * dataList;
@property (nonatomic, strong)   NSArray           * modelsArray;
@property(nonatomic,assign)     NSInteger           listPage;

@end

@implementation PersonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = TB_BGColor;

    self.automaticallyAdjustsScrollViewInsets = NO;

    self.dataList = [NSMutableArray array];

    [self setCollectionview];

   
    PersonalHelpTool * toolView = [[PersonalHelpTool alloc]initWithFrame:CGRectMake(0, KSCREEN_HIGHT-50, KSCREEN_WIDTH, 50)];
    [self.view addSubview:toolView];
    __block PersonDetailViewController * vc = self;
    toolView.personToolAction = ^(NSInteger index){
        NSLog(@"选择了   %ld",(long)index);
        [vc toolViewActionWithIndex:index];
    };

}   
 

-(void)toolViewActionWithIndex:(NSInteger)index{

    switch (index) {
        case 10000:

            break;

        case 1001:
            break;

        case 10002:
            [self focusOn];
            break;
        default:
            break;
    }
}

#pragma mark 【关注按钮】
-(void)focusOn{
    [HttpHelper requestFocusUserWithID:self.topModel.user_id complate:^(NSDictionary *responsedic) {

        [LSFMessageHint showToolMessage:responsedic[@"message"] hideAfter:1.5 yOffset:0];
        if ([responsedic[@"success"] intValue]==1) {
            self.navigationItem.rightBarButtonItem = nil;
        }
    }];
}



#pragma mark 【获取动态列表】

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


    [HttpHelper requestNearDynamicListWithUid:self.topModel.user_id withPage:vc.listPage witjLog:single.log withLat:single.lat complate:^(NSDictionary *responseDic) {

        if (update) {

        }else{
            [vc.collectionview.mj_footer endRefreshing];
        }

        if (responseDic) {
            if ([responseDic[@"success"] intValue]==1) {

                NSDictionary * dataDic = responseDic[@"data"];
                NSArray * items = dataDic[@"items"];

                for (NSDictionary * dic in items) {

                    [vc.dataList addObject:[NearDynamicModel nearDynamicWithDict:dic]];
                }

                vc.listPage ++ ;
                [vc.collectionview reloadData];

            }else{
                [LSFMessageHint showToolMessage:responseDic[@"message"] hideAfter:1.5 yOffset:0];
            }
        }
        
    }];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self gsk_setNavigationBarTransparent:YES animated:NO];

    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self gsk_setNavigationBarTransparent:NO animated:NO];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
}

- (void)gsk_setNavigationBarTransparent:(BOOL)transparent
                               animated:(BOOL)animated {
    [UIView animateWithDuration:animated ? 0.33 : 0 animations:^{
        if (transparent) {
            [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                          forBarMetrics:UIBarMetricsDefault];
            self.navigationController.navigationBar.shadowImage = [UIImage new];
            self.navigationController.navigationBar.translucent = YES;
            self.navigationController.view.backgroundColor = [UIColor clearColor];
            self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
        } else {
            [self.navigationController.navigationBar setBackgroundImage:nil
                                     forBarMetrics:UIBarMetricsDefault];
        }
    }];
}



-(void)setCollectionview{

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];;
    layout.minimumInteritemSpacing = 2.0;
    layout.minimumLineSpacing = 2.0;

    _collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HIGHT-49) collectionViewLayout:layout];
    _collectionview.backgroundColor = TB_BGColor;
    _collectionview.delegate = self ;
    _collectionview.dataSource = self;
    _collectionview.alwaysBounceVertical = YES;
    [self.view addSubview:_collectionview];

    [_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [_collectionview registerClass:[NoDataCell class] forCellWithReuseIdentifier:@"NoDataCell"];

    [_collectionview registerClass:[NearDymanicImageCell class] forCellWithReuseIdentifier:@"NearDymanicImageCell"];
    [_collectionview registerClass:[NearDymaicTopicCell class] forCellWithReuseIdentifier:@"NearDymaicTopicCell"];
    [_collectionview registerClass:[NearFootReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"NearFootReusableView"];


    //头部的view
    GSKSpotyLikeHeaderView * headerView = [[GSKSpotyLikeHeaderView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 240)];
    [headerView updateHeadviewWithmodel:self.topModel];
    [_collectionview addSubview:headerView];


    [self requestDynamicListWithUpdate:YES];

    __unsafe_unretained typeof(self) vc  = self;


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
//        __weak PersonDetailViewController * vc  = self ;
        topiceCell.avatarImageViewAction = ^(NSInteger index){

//            [vc personalCenterWithIndex:index];
        };
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

        __weak PersonDetailViewController * vc  = self ;

        footView.zanAction = ^(NSInteger index){

            NSLog(@"zanButtonClick  %ld",(long)index);
            [vc dianzanWithIndx:index];
        };

        footView.commentAction = ^(NSInteger index){

            [vc commentDetailPageWithIndex:indexPath isEdit:YES];
        };

        footView.moreAction = ^(NSInteger index){
            NSLog(@"moreAction   %ld",(long)index);
            [vc deleDynamicWithIndex:index];
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

#pragma mark 【删除动态】
-(void)deleDynamicWithIndex:(NSInteger)index{

    UIActionSheet * actionsheet = [[UIActionSheet alloc]initWithTitle:@"操作" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"删除", nil];
    actionsheet.tag = index;
    [actionsheet showInView:self.view];
}
     
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 0) {

        NSArray * items = self.dataList[actionSheet.tag];
        NearDynamicModel * model = items[0];
        __unsafe_unretained typeof(self) vc = self;

        [HttpHelper deleteDynamicWithDynamic_id:model.dynamicID complate:^(NSDictionary *responseDic)
        {
            [LSFMessageHint showToolMessage:responseDic[@"message"] hideAfter:1.0 yOffset:0];
            if ([responseDic[@"success"] intValue]==1) {

                [vc deleteSuccessWithIndex:actionSheet.tag];
            }
        }];
    }

}

#pragma mark 【删除成功，事件处理】
-(void)deleteSuccessWithIndex:(NSInteger)index{
    //刷新数据
    [self.dataList removeObjectAtIndex:index];
    [self.collectionview reloadData];

    [HttpHelper refreshDynamicList];
}

#pragma mark  【去评论详情页面】
-(void)commentDetailPageWithIndex:(NSIndexPath*)indexPath isEdit:(BOOL)isEdit{

    NSArray * items = self.dataList[indexPath.section];
    NearDynamicModel * model = items[0];

    DynamicDetailVC * vc = [[DynamicDetailVC alloc]init];

    vc.isEdit            = isEdit;
 
    vc.dynamic_id = model.dynamicID;

    vc.fromSection = indexPath.section;

    vc.isFrom_personal = YES;

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
