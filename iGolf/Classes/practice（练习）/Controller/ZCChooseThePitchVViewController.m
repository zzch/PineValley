//
//  ZCChooseThePitchVViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/1/30.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCChooseThePitchVViewController.h"
#import "ZCChooseTableViewCell.h"
#import "UIBarButtonItem+DC.h"
#import "MTScenicShopCell.h"
#import "AFNetworking.h"
#import "ZCAccount.h"
#import "ZCstadium.h"
#import "ZCSwitchTableViewController.h"
#import "ZCSettingTVController.h"
#import "ZCStadiumInformation.h"
#import "SVProgressHUD.h"
#import "MBProgressHUD+NJ.h"
#import "ZCEventUuidTool.h"
#import "ZCCompetitiveSetTableViewController.h"
@interface ZCChooseThePitchVViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate,CLLocationManagerDelegate>

//搜索栏
@property (nonatomic , strong)UISearchDisplayController *mySearchDisplayController;
@property(strong,nonatomic) UISearchBar *mySearchBar;
@property(strong,nonatomic) UITableView *tableView;
//数据源
@property(strong,nonatomic) NSMutableArray *dataArray;
//搜索结果数据
@property(strong,nonatomic) NSMutableArray *resultsData;
//定位
@property(nonatomic,retain) CLLocationManager *locationMgr;

@property(nonatomic,assign) double latitude;

@property(nonatomic,assign) double longitude;
@end



@implementation ZCChooseThePitchVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    customLab.textAlignment=NSTextAlignmentCenter;
    [customLab setTextColor:ZCColor(240, 208, 122)];
    [customLab setText:@"选择球场"];
    customLab.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = customLab;

    
    
    
    
    
    
    UIBarButtonItem *newBar= [[UIBarButtonItem alloc] initWithTitle:@"切换" style:UIBarButtonItemStyleDone target:self action:@selector(switchOtherView)];
    //改变UIBarButtonItem字体颜色
    [newBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:ZCColor(240, 208, 122), UITextAttributeTextColor,nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem =newBar;
    
    //返回
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barBtnItemWithNormalImageName:@"suoyou_fanhui" hightImageName:@"ffanhui_anxia" action:@selector(liftBthClick:) target:self];
    
    
  // self.navigationController.navigationBarHidden = YES;
    _dataArray = [NSMutableArray array];
   // _resultsData = [NSMutableArray array];
    
   // [self initDataSource];
    
    
    
    
    
    //1.获取经纬度
    // 初始化并开始更新
    self.locationMgr=[[CLLocationManager alloc] init];
    self.locationMgr.delegate=self;
    self.locationMgr.desiredAccuracy=kCLLocationAccuracyBest;
    self.locationMgr.distanceFilter=5.0;
    if([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
    {
        NSLog(@"是iOS8");
        // 主动要求用户对我们的程序授权, 授权状态改变就会通知代理
        [self.locationMgr requestAlwaysAuthorization]; // 请求前台和后台定位权限
        [self.locationMgr startUpdatingLocation];
    }else
    {
        NSLog(@"是iOS7");
        // 3.开始监听(开始获取位置)
        [self.locationMgr startUpdatingLocation];
    }
    
    //[self.locationMgr startUpdatingLocation];
    

    
    
    
    
    
    //[self initMysearchBarAndMysearchDisPlay];
   // [SVProgressHUD show];
    
    [MBProgressHUD showMessage:@"加载中..."];
}
//返回到上个界面
-(void)liftBthClick:(UIButton *)bth
{
    [self.navigationController popViewControllerAnimated:YES];
}


//切换球场地址
-(void)switchOtherView
{
    ZCSwitchTableViewController *switchTableView=[[ZCSwitchTableViewController alloc] init];
    
    [self.navigationController  pushViewController:switchTableView animated:YES];
    
    
    
}


//网络请求数据
-(void)initDataSource1
{
    

    
   
    
    //2.发送网络请求
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    
    mgr.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"text/plain",@"application/xhtml+xml",@"application/xml",@"application/json", nil];
 // mgr.responseSerializer.acceptableContentTypes = [mgr.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
   
//    double  latitude=39.975368;
//    double  longitude =116.300841;
    // 2.封装请求参数
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    
    // 说明服务器返回的JSON数据
   // mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"longitude"] = @(116.300841);
//    params[@"latitude"]=@(39.975368);
    
    
    params[@"longitude"] = @(self.longitude);
    params[@"latitude"]=@(self.latitude) ;

    params[@"token"]=account.token;
     NSString *url=[NSString stringWithFormat:@"%@%@",API,@"venues/nearby"];
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        ZCLog(@"%@------",responseObject);
        //将字典转换成模型数据
        NSMutableArray *stadiunArray=[NSMutableArray array];
        for (NSDictionary *dict in responseObject) {
            //创建模型
            ZCstadium *stadium=[ZCstadium stadiumWithDict:dict];
            //添加模型
            [stadiunArray addObject:stadium];
            
        }
        self.dataArray=stadiunArray;
        
        //刷新表格
        [self.tableView reloadData];
        
        //移除
       // [SVProgressHUD dismiss];
        [MBProgressHUD hideHUD];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ZCLog(@"%@",error);
        //移除
        //[SVProgressHUD dismiss];
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"cuowu"];

    }];
    
}

//代理方法实现

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    
    // 如果只需要获取一次, 可以获取到位置之后就停止
      //  [self.locationMgr stopUpdatingLocation];
    
    // 1.获取最后一次的位置
    /*
     location.coordinate; 坐标, 包含经纬度
     location.altitude; 设备海拔高度 单位是米
     location.course; 设置前进方向 0表示北 90东 180南 270西
     location.horizontalAccuracy; 水平精准度
     location.verticalAccuracy; 垂直精准度
     location.timestamp; 定位信息返回的时间
     location.speed; 设备移动速度 单位是米/秒, 适用于行车速度而不太适用于不行
     */
    /*
     可以设置模拟器模拟速度
     bicycle ride 骑车移动
     run 跑动
     freeway drive 高速公路驾车
     */
    CLLocation *location = [locations lastObject];
    ZCLog(@"%f, %f ", location.coordinate.latitude , location.coordinate.longitude);
    self.longitude=location.coordinate.longitude;
    self.latitude=location.coordinate.latitude;
    
    
    
    
    [self initDataSource1];
    [self initTableView];
    
}

//获取失败时候调用
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    ZCLog(@"%@",error);
   
    self.longitude=116.300841;
    self.latitude=39.975368;
    
    [self initDataSource1];
    [self initTableView];
}


//创建tableview
- (void)initTableView
{
    _tableView = [[UITableView alloc] init];
   // _tableView.frame = CGRectMake(0, is_IOS_7?64:44, 320, SCREEN_HEIGHT-64);
    _tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.showsVerticalScrollIndicator = NO;
//    _tableView.tableHeaderView = [[UIView alloc] init];
//    _tableView.tableFooterView = [[UIView alloc] init];
   
     
        //背景颜色suoyou_bj
        self.tableView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"suoyou_bj_02"]];
        [self.tableView   setSeparatorColor:ZCColor(240, 208, 122)];
    
        self.tableView.tableFooterView = [[UIView alloc] init];
        

    
    
    [self.view addSubview:_tableView];
    
//    if (is_IOS_7)
//        //分割线的位置不带偏移
//        _tableView.separatorInset = UIEdgeInsetsZero;
}

//分割线显示全
-(void)viewDidLayoutSubviews {
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

//分割线显示全
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}






#pragma mark - tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
return _dataArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myCell = @"cell_identifier";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
    ZCChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
    
    if (cell == nil) {
        cell = [[ZCChooseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myCell];

    }
    
    
    ZCstadium *stadium=self.dataArray[indexPath.row];
    cell.stadium=stadium;
    
   // ZCChooseTableViewCell *cell=[ZCChooseTableViewCell cellWithTable:tableView];


    
    return cell;
    
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{ //取消选中
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];

   
    //点击单个cell时候，发送请求获取单个球场信息   uuid    /v1/matches/show.json
    
    ZCstadium *stadiumStr=self.dataArray[indexPath.row];
    
    NSString *uuidStr=stadiumStr.uuid;
    
    
    if ([self.delegate respondsToSelector:@selector(ZCChooseThePitchVViewController:andUuid:)]) {
        [self.delegate ZCChooseThePitchVViewController:self andUuid:uuidStr];
    }

    
    [self.navigationController popViewControllerAnimated:YES];
    
    

//    ZCEventUuidTool *tool=[ZCEventUuidTool sharedEventUuidTool];
//    if ([tool.eventType isEqual:@"practice"]) {
//        
//    //ZCSettingTVController *settingView=[[ZCSettingTVController alloc] init];
//        
//        
//    
//    
//    
//    [self.navigationController pushViewController:settingView animated:YES];
//    
//    }else
//    {
//        ZCCompetitiveSetTableViewController *competitiveSetTableViewController=[[ZCCompetitiveSetTableViewController alloc] init];
//        competitiveSetTableViewController.uuidStr=uuidStr;
//        [self.navigationController pushViewController:competitiveSetTableViewController animated:YES];
//    
//    }
//    
}




@end
