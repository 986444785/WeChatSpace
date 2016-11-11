//
//  ZYPOIViewController.m
//  RitaApp
//
//  Created by BBC on 16/7/26.
//  Copyright © 2016年 Chen. All rights reserved.
//
 
#import "ZYPOIViewController.h"
#import "UIBarButtonItem+CH.h"
#import "ZyReleaseViewController.h"
#import <AMapSearchKit/AMapSearchKit.h>

@interface ZYPOIViewController ()<AMapSearchDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)    AMapSearchAPI * search;
@property(nonatomic,strong)    NSMutableArray * POIMutablearray;
@property(nonatomic,strong)       UITableView * tableview;
@end

@implementation ZYPOIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
       self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"所在位置";

    _POIMutablearray = [NSMutableArray array];


    [_POIMutablearray addObject:@"不显示"];

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:@"取消" WithTitleColor: [UIColor grayColor] withFont:14 target:self action:@selector(backBtnclick)];


    [self initTableview];

    [self searchPOI];
}

-(void)initTableview{
    _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableview.delegate =self;
    _tableview.dataSource =self;
    [self.view addSubview:_tableview];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _POIMutablearray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];

    }


    cell.accessoryType = UITableViewCellAccessoryNone;
    if (indexPath.row == 0) {
        cell.textLabel.text =  @"不显示";
        cell.detailTextLabel.text= nil;
        cell.textLabel.textColor = [UIColor redColor];

    }else{
            cell.textLabel.textColor = [UIColor blackColor];

            AMapPOI *p = _POIMutablearray[indexPath.row];
            cell.textLabel.text = p.name;
            cell.detailTextLabel.text= p.address;
    }

    return cell;
}
 

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    ZyReleaseViewController * vc = self.deleagte;

    if (indexPath.row == 0) {
 
        vc.selectAddress = nil;
    }else{

        AMapPOI *p = _POIMutablearray[indexPath.row];

        ZYLocationSingle * single = [ZYLocationSingle defaultSingleLocation];

        if (single.city) {

            vc.selectAddress  = [NSString stringWithFormat:@"%@ %@",single.city,p.name];
        }else{
             vc.selectAddress =  p.name;
        }
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)backBtnclick{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark ====POI查询
-(void)searchPOI{

    _search = [[AMapSearchAPI alloc]init];
    _search.delegate = self;

    //构造AMapPOIAroundSearchRequest对象，设置周边请求参数
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];

    ZYLocationSingle * single = [ZYLocationSingle defaultSingleLocation];

    request.location = [AMapGeoPoint locationWithLatitude:[single.lat floatValue] longitude:[single.log floatValue]];
//    request.keywords = @"方恒";
    // types属性表示限定搜索POI的类别，默认为：餐饮服务|商务住宅|生活服务
    // POI的类型共分为20种大类别，分别为：
    // 汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|
    // 医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|
    // 交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施
    request.types = @"交通设施服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务";
    request.sortrule = 1;
    request.requireExtension = YES;
    request.offset = 30;

    //发起周边搜索
    [_search AMapPOIAroundSearch: request];

}


//实现POI搜索对应的回调函数
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if(response.pois.count == 0)
    {
        return;
    }

    //通过 AMapPOISearchResponse 对象处理搜索结果
//    NSString *strCount = [NSString stringWithFormat:@"count: %d",response.count];
//    NSString *strSuggestion = [NSString stringWithFormat:@"Suggestion: %@", response.suggestion];
//    NSString *strPoi = @"";
//    for (AMapPOI *p in response.pois) {
//        strPoi = [NSString stringWithFormat:@"%@\nPOI: %@     名字：%@    地址:%@", strPoi, p.description,p.name ,p.address];
//    }
//    NSString *result = [NSString stringWithFormat:@"%@ \n %@ \n %@", strCount, strSuggestion, strPoi];
//    NSLog(@"Place: %@", result);

    [_POIMutablearray addObjectsFromArray:response.pois];
    [_tableview reloadData];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
