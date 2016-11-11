//
//  ZyReleaseViewController.m
//  SuiYu
//
//  Created by BBC on 16/3/30.
//  Copyright © 2016年 陈伟滨. All rights reserved.
//

#import "ZyReleaseViewController.h"

#import "ZyRContentCell.h"
#import "ZyRLocationCell.h"
#import "DPPhotoGroupViewController.h"
#import "BrowseImagesViewController.h"
#import "UIBarButtonItem+CH.h"

#import "ZYPOIViewController.h"

// 数据配置
#define LINE_COUNT 4
#define SPACING 10 * BiLv

@interface ZyReleaseViewController ()<DPPhotoGroupViewControllerDelegate,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UITextViewDelegate>

@property(nonatomic,strong )  UITableView * tableview;
@property(nonatomic,copy) NSString * contentStr;  //发表的内容
//@property(nonatomic,copy) NSString * locationStr;//位置

@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UIButton *addButton;
@property (assign, nonatomic) CGFloat imageWidth;

@property (strong, nonatomic) NSMutableArray *selectImages;
@property (strong, nonatomic) NSMutableArray *selectButtons;

@end

@implementation ZyReleaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor  = [UIColor whiteColor];

    [self createTopView];

    [self initializeDataSource];

    [self initTableview];

    ZYLocationSingle * single = [ZYLocationSingle defaultSingleLocation];
    [single getLocationInfo];
}

-(void)createTopView
{
    self.title = @"发布动态";

    self.navigationItem.leftBarButtonItem =[UIBarButtonItem  itemWithTitle:@"取消" WithTitleColor:[UIColor grayColor] withFont:(14) target:self action:@selector(backBtnclick)];

    self.navigationItem.rightBarButtonItem =[UIBarButtonItem  itemWithTitle:@"发布" WithTitleColor:[UIColor grayColor] withFont:(14) target:self action:@selector(releaseBtnClick)];


}

-(void)backBtnclick
{   
    [ self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];

    if (_tableview) {

        [_tableview reloadData];
    }
}
 


#pragma mark ---  发布
-(void)releaseBtnClick
{
    __unsafe_unretained typeof(self) vc  = self;
    if ([_selectAddress isEqualToString:@"所在位置"]) {
        _selectAddress = nil;
    }
    [HttpHelper writeDynamicWithContent:_contentStr WithImages:_selectImages WithAddress:_selectAddress withDelegate:self complate:^(NSDictionary *responseDic) {

        [LSFMessageHint showToolMessage:responseDic[@"message"] hideAfter:1.2 yOffset:0];

        if ([responseDic[@"success"] intValue]==1) {

            [vc releseSuccess];
        }
    }];

}  

/**
 *  发布成功后退出
 */
-(void)releseSuccess{

    [HttpHelper refreshDynamicList];

    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)initTableview
{
   _tableview= [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HIGHT) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.tableFooterView = [[UIView alloc]init];
    _tableview.backgroundColor = TB_BGColor;
    [self.view addSubview:_tableview];

    //注册cell
    [_tableview registerNib:[UINib nibWithNibName:@"ZyRContentCell" bundle:nil] forCellReuseIdentifier:@"ZyRContentCell"];
    [_tableview registerNib:[UINib nibWithNibName:@"ZyRLocationCell" bundle:nil] forCellReuseIdentifier:@"ZyRLocationCell"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;  //判断有没有位置
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 100;
    }else if (indexPath.row == 1){
        return 50;
    }

    return _contentView.frame.size.height;
}
  

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) { 
        ZyRContentCell * contentCell =  [tableView dequeueReusableCellWithIdentifier:@"ZyRContentCell" forIndexPath:indexPath];
        contentCell.tag = 8888;
        contentCell.contentTextView.delegate = self;
        contentCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _contentStr = contentCell.contentTextView.text;
        return contentCell;
    }else if (indexPath.row == 1){ 
        ZyRLocationCell * locationcell = [tableView dequeueReusableCellWithIdentifier:@"ZyRLocationCell" forIndexPath:indexPath];
        locationcell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_selectAddress) {
            locationcell.locationLable.text =  _selectAddress ;
        }else{
            locationcell.locationLable.text = @"所在位置";
        }
        return locationcell;
    }
    UITableViewCell * imagecell = [tableView dequeueReusableCellWithIdentifier:@"imagecell"];
    if (!imagecell) {

        imagecell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"imagecell"];
        imagecell.selectionStyle = UITableViewCellSelectionStyleNone;
        [imagecell.contentView addSubview:_contentView];
     
    }
    return imagecell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        ZYPOIViewController * poiVC = [[ZYPOIViewController alloc]init];
        poiVC.deleagte = self;
        //    [self presentViewController:poiVC animated:YES completion:nil];

        UINavigationController * nav0 = [[UINavigationController alloc]initWithRootViewController:poiVC];
        [self  presentViewController:nav0 animated:YES completion:nil];

    }
}

-(void)textViewDidChange:(UITextView *)textView
{

    ZyRContentCell * cell = [_tableview viewWithTag:8888];

        if (textView.text.length > 0) {
            cell.placeLable.alpha = 0;
        }else{
            cell.placeLable.alpha = 1;
        }

    _contentStr = textView.text;


}


-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}


#pragma mark --- 提取图片
/**
 *  读取图片
 */
- (void)initializeDataSource {

    _selectButtons = [[NSMutableArray alloc] init];
    _selectImages = [[NSMutableArray alloc] init];

    [self initializeUserInterface];

    [self didSelectPhotos:(NSMutableArray *)self.photos];
}


//添加图片
- (void)initializeUserInterface {

    _imageWidth = (KSCREEN_WIDTH - ((LINE_COUNT + 1) * SPACING)) / LINE_COUNT;

    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, _imageWidth + 2 * SPACING)];
    _contentView.clipsToBounds = YES;
    _contentView.backgroundColor = [UIColor whiteColor];


    _addButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _addButton.frame = CGRectMake(SPACING, SPACING, _imageWidth, _imageWidth);
    [_addButton setBackgroundImage:[UIImage imageNamed:@"news_add_button"] forState:UIControlStateNormal];
    [_addButton addTarget:self action:@selector(selectPicture) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_addButton];

} 


-(void)selectPicture
{
    DPPhotoGroupViewController *groupVC = [DPPhotoGroupViewController new];
    groupVC.maxSelectionCount = 9 - _selectImages.count ;
    groupVC.delegate = self;
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:groupVC] animated:YES completion:nil];
}


#pragma mark - ---------------------- DPPhotoGroupViewControllerDelegate
- (void)didSelectPhotos:(NSMutableArray *)photos{

    for (int i = 0; i < photos.count; i ++) {
 
        UIImage * image = photos[i];
        [_selectImages addObject:image];

        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(SPACING, SPACING, _imageWidth, _imageWidth)];
        [button setImage:image forState:UIControlStateNormal];

        button.layer.masksToBounds = YES;
        button.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [button addTarget:self action:@selector(imageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:button];

        [_selectButtons addObject:button];
    }
    [self updateUserInterface];

}
 

- (void)updateUserInterface {

    [self resetAllImagePosition];

    _addButton.frame = [self frameWithButtonIndex:_selectButtons.count];

    _contentView.frame = CGRectMake(_contentView.frame.origin.x, _contentView.frame.origin.y, SCREEN_WIDTH, _addButton.bounds.size.height + _addButton.frame.origin.y + SPACING);

    if (_selectImages.count==9) {
        _addButton.alpha = 0.0;
        _addButton.userInteractionEnabled = NO;
    }else{
        _addButton.alpha = 1.0;
        _addButton.userInteractionEnabled = YES;
    }

    [_tableview reloadData];
}

- (void)resetAllImagePosition {

    NSInteger count = _selectButtons.count;
    for (NSInteger i = 0; i < count; i ++) {
        UIButton *button = _selectButtons[i];
        button.frame = [self frameWithButtonIndex:i];
    }
}
 
- (CGRect)frameWithButtonIndex:(NSInteger)index {

    index ++;
    NSInteger row = ceil(index * 1.0 / LINE_COUNT); // 第几行
    NSInteger cloumn = index % LINE_COUNT; // 第几列

    if (cloumn == 0) {
        cloumn += LINE_COUNT;
    }
    return CGRectMake(SPACING * cloumn + _imageWidth * (cloumn - 1), SPACING * row + _imageWidth * (row - 1), _imageWidth, _imageWidth);

}


- (void)imageButtonPressed:(UIButton *)sender {

    BrowseImagesViewController *vc = [[BrowseImagesViewController alloc] initWithIndex:[_selectButtons indexOfObject:sender] selectImages:_selectImages];
    __weak ZyReleaseViewController *weakSelf = self;
    vc.deleteBlock = ^(NSInteger index) {

        UIButton *button = [weakSelf.selectButtons objectAtIndex:index];

        [button removeFromSuperview];
        [weakSelf.selectButtons removeObjectAtIndex:index];

        [weakSelf updateUserInterface];
    };

    [self.navigationController pushViewController:vc animated:YES];
}
 
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
