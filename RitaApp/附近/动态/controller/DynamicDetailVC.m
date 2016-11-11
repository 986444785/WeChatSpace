//
//  DynamicDetailVC.m
//  RitaApp
//
//  Created by BBC on 16/7/17.
//  Copyright © 2016年 Chen. All rights reserved.
// 

#import "DynamicDetailVC.h"
#import "UIBarButtonItem+CH.h"
#import "NearDymanicImageCell.h"
#import "NearDymaicTopicCell.h"
#import "NearFootReusableView.h"
#import "SDPhotoBrowser.h"
#import "NearCommentCell.h"
#import "KeyBoardLinkMoveUtility.h"

#import "PersonDetailViewController.h"

#define CommentView_h 50
#define LableTag    1000

@interface DynamicDetailVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UITextViewDelegate>
@property(nonatomic,strong)    UICollectionView * collectionview;
@property(nonatomic,strong)    UIView      * bgtextView ;
@property(nonatomic,strong)    UIControl   * control  ;
@property(nonatomic,strong)    UITextView  * textView;

@property(nonatomic,strong)   NSMutableArray * dataItems;
@property(nonatomic,assign)   NSInteger listPage;


@end

@implementation DynamicDetailVC

 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"动态详情";

    _dataItems = [NSMutableArray array];

    [_dataItems addObject:_topArrays];

    _listPage = 1;

    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing = 2.0;
    flowLayout.minimumLineSpacing = 2.0;
    _collectionview= [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HIGHT-49) collectionViewLayout:flowLayout];
    _collectionview.delegate = self;
    _collectionview.dataSource = self;
    _collectionview.backgroundColor = TB_BGColor;
    _collectionview.alwaysBounceVertical = YES;
    [self.view addSubview:_collectionview];

    [_collectionview registerClass:[NearDymanicImageCell class] forCellWithReuseIdentifier:@"NearDymanicImageCell"];
    [_collectionview registerClass:[NearDymaicTopicCell class] forCellWithReuseIdentifier:@"NearDymaicTopicCell"];
    [_collectionview registerClass:[NearCommentCell class] forCellWithReuseIdentifier:@"NearCommentCell"];

    [_collectionview registerClass:[NearFootReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"NearFootReusableView"];
    [_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionElementKindSectionHeader"];


    __unsafe_unretained typeof(self) vc = self;

    [self requestCommentList];

    _collectionview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [vc requestCommentList];
    }];

    NearDynamicModel * model  = self.topArrays[0];
    if (model.owner == NO) {
        // 1.添加右边导航栏上面的点击按钮
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"关注" WithTitleColor:[UIColor grayColor] withFont:14 target:self action:@selector(followAction)];
    }

    //评论键盘
    [self setCommentView];
} 

#pragma mark 【关注按钮】
-(void)followAction{

//    ALERT_MSG(@"是否关注她");

    NearDynamicModel * model  = self.topArrays[0];
    [HttpHelper requestFocusUserWithID:model.user_id complate:^(NSDictionary *responsedic) {

        [LSFMessageHint showToolMessage:responsedic[@"message"] hideAfter:1.5 yOffset:0];
        if ([responsedic[@"success"] intValue]==1) {
            self.navigationItem.rightBarButtonItem = nil;
        }

    }];
}

 
#pragma mark 【数据区域】
-(void)requestListWithUpdate:(BOOL)update{

    __unsafe_unretained typeof(self) vc = self ;

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        [HttpHelper requestDynamicDetailWithdynamyc_id:self.dynamic_id complate:^(NSDictionary *responseDic) {
 

            if ([responseDic[@"success"] integerValue]== 1) {

                vc.listPage = 2;
                [vc.dataItems removeAllObjects];

                NSDictionary * dataDic = responseDic[@"data"];
                [vc.dataItems addObject:[NearDynamicModel nearDynamicWithDict:dataDic]];

                [HttpHelper requestCommentListWithDynamic_id:vc.dynamic_id withPage:@"1" complate:^(NSDictionary *responseDic) {

                    NSDictionary     *    comDic = responseDic[@"data"];
                    NSArray          *    items = comDic[@"items"];
                    NSMutableArray   *    commentMutablearray = [NSMutableArray array];
                    for (NSDictionary * userDic in items) {

                        [commentMutablearray addObjectsFromArray:[NearDynamicModel nearDynamicWithDict:userDic]];
                    }
                    if (commentMutablearray.count>0) {
                        [vc.dataItems addObject:commentMutablearray];
                    }

                    dispatch_async(dispatch_get_main_queue(), ^{

                        [vc.collectionview.mj_header endRefreshing];
                        
                        [vc.collectionview reloadData];

                        if (update) {
        
                            [self postNotificationWithKey:@"comment" withValues:[NSString stringWithFormat:@"%lu",(unsigned long)items.count] indexKey:@"section" indexValues:[NSString stringWithFormat:@"%ld",(long)self.fromSection]];
                        }
   

                    });
                    
                }];
            }
        }];
    });
}

#pragma mark 【评论列表】
-(void)requestCommentList{
 
    __unsafe_unretained typeof(self) vc = self ;

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [HttpHelper requestCommentListWithDynamic_id:vc.dynamic_id withPage:[NSString stringWithFormat:@"%ld",(long)vc.listPage] complate:^(NSDictionary *responseDic) {



            if ([responseDic[@"success"] intValue]==1) {

                NSDictionary * comDic = responseDic[@"data"];
                NSArray * items = comDic[@"items"];
                NSMutableArray * commentMutablearray = [NSMutableArray array];
                for (NSDictionary * userDic in items) {

                    [commentMutablearray addObjectsFromArray:[NearDynamicModel nearDynamicWithDict:userDic]];
                }
                if (commentMutablearray.count>0) {
                    [vc.dataItems addObject:commentMutablearray];
                }

                dispatch_async(dispatch_get_main_queue(), ^{
                       [vc.collectionview.mj_footer endRefreshing];
                    vc.listPage++;
                    [vc.collectionview reloadData];
                });

            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [LSFMessageHint showToolMessage:responseDic[@"message"] hideAfter:1.0 yOffset:0];
                });

            }
        }];

    });


}


#pragma mark------
#pragma mark  UICollectionViewDatasource
//组个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return self.dataItems.count;
}

//每组的cell个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    NSArray * array = self.dataItems[section];
    if (section==0) {
        return  array.count-1;
    }
   return  array.count;
}


#pragma mark -- -尾部
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{

    if (section == 0) {
        NSArray * items = self.dataItems[section];
        NearDynamicModel * model = [items lastObject];
        return CGSizeMake(KSCREEN_WIDTH, model.cell_height);
    }
     return CGSizeMake(0, 0);

}
     
#pragma mark --cell与四周的距离
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
          return UIEdgeInsetsMake(1, 1, 1, 1);
    }
      return UIEdgeInsetsMake(0, 0, 0, 0);
}

 

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    NSArray * items = self.dataItems[indexPath.section];
    NearDynamicModel * model = items[indexPath.row];

    if (indexPath.section == 0) {

        if ([model.cell_type isEqualToString:@"topc_cell"]) {

            return CGSizeMake(KSCREEN_WIDTH-4,model.cell_height);
        }else if ([model.cell_type isEqualToString:@"image_cell"]) {

            return CGSizeMake(model.image_hight, model.image_hight);
        }
    }  
   return CGSizeMake(KSCREEN_WIDTH,model.cell_height - 35);

}
   

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    NSArray * items = self.dataItems[indexPath.section];
    NearDynamicModel * model = items[indexPath.row];
    if (indexPath.section == 0) {

        if ([model.cell_type isEqualToString:@"topc_cell"]) {

            NearDymaicTopicCell * topiceCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NearDymaicTopicCell" forIndexPath:indexPath];

            [topiceCell updateTopciWithModel:model withIndex:indexPath];

            __weak DynamicDetailVC * vc  = self ;
            topiceCell.avatarImageViewAction = ^(NSInteger index){

                [vc personalCenterWithindex:index];
            };

            return topiceCell;

        }else if ([model.cell_type isEqualToString:@"image_cell"]){

            NearDymanicImageCell * imagecell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NearDymanicImageCell" forIndexPath:indexPath];
            [imagecell updateImageViewWithImageUrl:model.image_url withIndex:indexPath];
            
            return imagecell;
        }
    }else{
  
        NearCommentCell * comCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NearCommentCell" forIndexPath:indexPath];
        [comCell updateNearCommentWithModel:model withIndex:indexPath];
        __unsafe_unretained typeof(self) vc  = self;
        comCell.avatarAcction = ^(NSInteger index){
            [vc personalCenterWithindex:index];
        };
        return comCell;
    }

    return nil;
}
   



-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    if (kind == UICollectionElementKindSectionFooter) {

        NearFootReusableView * footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"NearFootReusableView" forIndexPath:indexPath];

        NSArray * items = self.dataItems[indexPath.section];

        NearDynamicModel * model = [items lastObject];

        [footView updateNearFootReusableViewWithModel:model withIndex:indexPath];

        __weak DynamicDetailVC * vc  = self ;

        footView.zanAction = ^(NSInteger index){

            [vc dianzanWithIndx:index];
        };
 

        footView.commentAction = ^(NSInteger index){

             [vc.textView becomeFirstResponder];
        };

        footView.moreAction = ^(NSInteger index){
            NSLog(@"moreAction   %ld",(long)index);
        };

        return footView; 
    }

    UICollectionReusableView * headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionElementKindSectionHeader" forIndexPath:indexPath];
    headView.backgroundColor = TB_BGColor;
    return headView;

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row > 0) {
        NSLog(@"图片展示  %ld    %ld",(long)indexPath.section,(long)indexPath.row);
    }
}

#pragma mark 【点赞】
-(void)dianzanWithIndx:(NSInteger)index{

    NSMutableArray * items = self.dataItems[index];
    NearDynamicModel * model = [items lastObject];

    __unsafe_unretained typeof(self) vc = self;

    [HttpHelper diantZanWithDynamic_id:model.dynamicID complate:^(NSDictionary *responseDic) {

        if ([responseDic[@"success"] intValue]==1) {
            int  count = [model.zan_count intValue] + 1 ;
            //只更新这一行
            model.zan_count = [NSString stringWithFormat:@"%d",count];

            NSIndexSet * indexSet = [[NSIndexSet alloc]initWithIndex:index];
            [vc.collectionview reloadSections:indexSet];

            [self postNotificationWithKey:@"zan"  withValues:model.zan_count indexKey:@"section" indexValues:[NSString stringWithFormat:@"%ld",(long)index] ];
        }
        [LSFMessageHint showToolMessage:responseDic[@"message"] hideAfter:1.5 yOffset:0];
    }];
}
   
#pragma mark --- 通知动态列表页面刷新数据
-(void)postNotificationWithKey:(NSString *)key withValues:(NSString *)values indexKey:(NSString *)indexKey indexValues:(NSString *)indexValues {
 
    NSLog(@"  通知动态列表页面刷新数据 "); 

    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:values,key,indexValues,indexKey, nil];
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    NSNotification * notify = [[NSNotification alloc]initWithName:@"ZAN_COMMENT" object:self userInfo:dic];
    [center postNotification:notify];

}
   
 

#pragma mark 【个人动态中心】
-(void)personalCenterWithindex:(NSInteger)index{

    if (_isFrom_personal) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }

    NSArray * items = self.dataItems[index];
    PersonDetailViewController * vc = [[PersonDetailViewController alloc]init];
    vc.topModel = items[0];
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark 【底部的评论键盘---暂时没封装】

-(void)setCommentView
{
    _bgtextView = [[UIView alloc]initWithFrame:CGRectMake(0, KSCREEN_HIGHT-CommentView_h, KSCREEN_WIDTH, CommentView_h)];
    _bgtextView.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:_bgtextView];

    UILabel * lineLable = [UILabel new];
    lineLable.frame = CGRectMake(0, 0, KSCREEN_WIDTH, 1);
    lineLable.backgroundColor =  [UIColor colorWithRed:0.937 green:0.945 blue:0.969 alpha:1.000];
    [_bgtextView addSubview:lineLable];

    int space = 10 ;
    int sendBtn_w = 60 ;

    _textView = [[UITextView alloc]initWithFrame:CGRectMake(space, space,KSCREEN_WIDTH-(3*space+sendBtn_w) , CommentView_h-2*space)];
    _textView.backgroundColor =  [UIColor colorWithRed:0.937 green:0.945 blue:0.969 alpha:1.000];
    _textView.delegate = self ;
    _textView.returnKeyType = UIReturnKeySend;
    _textView.layer.borderWidth = 0.5;
    _textView.layer.masksToBounds = YES ;
    _textView.layer.cornerRadius = 5;
    _textView.layer.borderColor = [UIColor grayColor].CGColor;
    _textView.font = [UIFont systemFontOfSize:15];
    [_bgtextView addSubview:_textView];

    
    UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(space, space, 150,CommentView_h-2*space )];
    lable.text = @" 说点什么吧";
    lable.font = [UIFont systemFontOfSize:14];
    lable.textColor = [UIColor grayColor];
    lable.tag  = LableTag;
    //    lable.backgroundColor = [UIColor redColor];
    [_bgtextView addSubview:lable];


    UIButton * sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBtn.frame  =CGRectMake(KSCREEN_WIDTH-(sendBtn_w+space), space, sendBtn_w,_textView.frame.size.height );
    [sendBtn setTitle:@"发表" forState:UIControlStateNormal];
    sendBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [sendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    sendBtn.layer.cornerRadius = 5;
    sendBtn.layer.masksToBounds = YES;
    sendBtn.layer.borderWidth = 0.5;
    sendBtn.layer.borderColor  = [UIColor grayColor].CGColor;
    [sendBtn addTarget:self action:@selector(senderMessage) forControlEvents:UIControlEventTouchUpInside];
    [_bgtextView addSubview:sendBtn];

    [[KeyBoardLinkMoveUtility sharedInstance] addObserverWithLinkView:_bgtextView];

    if (self.isEdit == YES) {
        [_textView becomeFirstResponder];
    }

}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{

    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        NSLog(@"在这里做你响应return键的代码");
        [self senderMessage];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    NSLog(@"换行");
    return YES;
}


- (void)textViewDidChange:(UITextView *)textView
{
    UILabel * lable = (UILabel *)[self.view viewWithTag:LableTag];
    if (textView.text.length > 0  ) {
        lable.alpha = 0.0 ;
    }else{
        lable.alpha = 1.0 ;
    }
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    //添加control，点击背景，让键盘下去
    if (!_control) {
        _control = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
        [_control addTarget:self action:@selector(keyDown2) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_control];
    }
    //注意位置
    [self.view insertSubview:_control aboveSubview:_collectionview];
}


-(void)keyDown2
{
    if (_control) {
        [_control removeFromSuperview];
    }
    [self.view endEditing:YES];

}

#pragma mark  发送评论

-(void)senderMessage
{
    //判断内容是否为空
    if ([self isBlankString:_textView.text]) {
        _textView.text = nil ;
        [LSFMessageHint showToolMessage:@"不能发送空消息" hideAfter:1.0 yOffset: -100];
    }else{
        //发送评论
        [self requestSendMessageWithMessage:_textView.text];
        _textView.text = nil ;
        UILabel * lable = (UILabel *)[self.view viewWithTag:LableTag];
        lable.alpha = 1.0 ;
        //键盘下落
        [self keyDown2];
    }
}


-(void)requestSendMessageWithMessage:(NSString *)text
{
    NSLog(@"请求发送消息  %@",text);
    //先判断有没登录

    __unsafe_unretained typeof(self) vc = self ;

    [HttpHelper writeCommentWithContent:text withDynamic_id:vc.dynamic_id complate:^(NSDictionary * responsedic) {

        [LSFMessageHint showToolMessage:responsedic[@"message"] hideAfter:1.0 yOffset:0];
        if ([responsedic[@"success"] integerValue]==1) {
            //刷新列表
            [vc requestListWithUpdate:YES];

        }
    }];

}

-(BOOL)isBlankString:(NSString *)string {

    if (string == nil || string == NULL) {

        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {

        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        
        return YES;
    }
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
