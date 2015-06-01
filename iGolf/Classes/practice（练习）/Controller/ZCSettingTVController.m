//
//  ZCSettingTVController.m
//  我爱高尔夫
//
//  Created by hh on 15/2/27.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCSettingTVController.h"
#import "ZCChooseThePitchVViewController.h"
#import "ZCStadiumInformation.h"
#import "ZCChildStadium.h"
#import "AFNetworking.h"
#import "ZCAccount.h"
#import "ZCSettingHeadView.h"
#import "ZCScorecardTableViewController.h"
#import "ZCTotalScorecards.h"
#import "ZCScorecardTableViewController.h"
#import "ZCEventUuidTool.h"
#import "ZCEventUuidTool.h"
#import "UIBarButtonItem+DC.h"
#import "MBProgressHUD+NJ.h"
#import "ZCChooseThePitchVViewController.h"
#import "ZCSwitchTableViewController.h"

@interface ZCSettingTVController ()<UITableViewDelegate,UITableViewDataSource,ZCSettingHeadViewDelegate,CLLocationManagerDelegate,ZCChooseThePitchDelegate,ZCSwitchTableViewControllerDelegate>
@property(nonatomic,assign) int count;

//创建的tableView
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,strong) ZCStadiumInformation *stadiumInformation;
//保存用户选择球场的uuid
@property(nonatomic,copy) NSString *uuid;
//保存用户选择球场的T台
@property(nonatomic,copy) NSString *tee_boxe;
//保存选中一个子场的数据
@property(nonatomic, strong) ZCChildStadium *childStadium;
//保存在选择9洞后 列出后9洞的子场
@property(nonatomic,strong) NSMutableArray *childStadiumMutableArray;
//保存用户选择后9洞的球场的uuid
@property(nonatomic,copy) NSString *lastUuid;
//保存选中后9洞子场的数据
@property(nonatomic, strong) ZCChildStadium *lastChildStadium;
//保存用户选择后9洞球场的T台
@property(nonatomic,copy) NSString *lastTee_boxe;
@property(nonatomic,assign) NSInteger index;
// 标记一下是否展开，YES：展开，NO：收起
@property (nonatomic, assign, getter = isOpened1) BOOL opened1;
@property (nonatomic, assign, getter = isOpened2) BOOL opened2;
@property (nonatomic, assign, getter = isOpened3) BOOL opened3;
@property (nonatomic, assign, getter = isOpened4) BOOL opened4;
@property (nonatomic, assign, getter = isOpened5) BOOL opened5;

@property(nonatomic, strong) ZCSettingHeadView *settingHeadView;
//保存选中的子场名字
@property(nonatomic,copy) NSString *firstChildName;
//保存选中的子场名字
@property(nonatomic,copy) NSString *lastChildName;
//保存记分卡类型  专业 或者简单
@property(nonatomic,copy) NSString *type;
@property(nonatomic,weak) UIButton *startButton;


//表头里的球场名字
@property(nonatomic,weak)UILabel *nameLabel;

//定位
@property(nonatomic,retain) CLLocationManager *locationMgr;

@property(nonatomic,assign) double latitude;

@property(nonatomic,assign) double longitude;

@end

@implementation ZCSettingTVController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //返回
//    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barBtnItemWithNormalImageName:@"suoyou_fanhui" hightImageName:@"ffanhui_anxia" action:@selector(liftBthClick:) target:self];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.title=@"球场设置";
//    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
//    customLab.textAlignment=NSTextAlignmentCenter;
//    [customLab setTextColor:ZCColor(240, 208, 122)];
//    [customLab setText:@"球场设置"];
//    customLab.font = [UIFont boldSystemFontOfSize:20];
//    self.navigationItem.titleView = customLab;
    
    
    self.view.backgroundColor=ZCColor(237, 237, 237);
    
    
    
    //创建CLLocationManager定位
    [self initCLLocationManager];

}

-(void)dealloc
{

    ZCLog(@"#3333333333333333333");
}



//创建tableView
-(void)initTableView
{

    
    //创建tabelView
    UITableView *tableView=[[UITableView alloc] init];
    tableView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
    ;
    [self.view addSubview:tableView];
    self.tableView=tableView;
    
    
    
    //让分割线不显示
    // self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //分割线颜色
    [self.tableView   setSeparatorColor:ZCColor(170, 170, 170)];
    //让下面没内容的分割线不显示
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    
    self.tableView.backgroundColor=ZCColor(237, 237, 237);
    
    
    //    self.tableView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"suoyou_bj_02"]];
    self.tableView.rowHeight=45;
    
    
    
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.sectionHeaderHeight = 52;
    //self.tableView.
    self.tableView.tableHeaderView=[self tableViewForheaderView];
    
   
    
    
    
    
    UIButton *startButton=[[UIButton alloc] init];
    CGFloat startButtonX=0;
    
    CGFloat startButtonW=SCREEN_WIDTH;
    CGFloat startButtonH=65;
    CGFloat startButtonY=SCREEN_HEIGHT-startButtonH;
    
    startButton.frame=CGRectMake(startButtonX, startButtonY, startButtonW, startButtonH);
    
    // startButton.frame=CGRectMake(0, 300, 317, 40);
    [startButton setTitle:@"开始回合" forState:UIControlStateNormal];
    startButton.backgroundColor=ZCColor(100, 175, 102);
    //[startButton setBackgroundImage:[UIImage imageNamed:@"kedianji_zhuangtai"] forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(clickTheDidStartButton) forControlEvents:UIControlEventTouchUpInside];
    UIWindow *wd = [[UIApplication sharedApplication].delegate window];
    [wd addSubview:startButton];
    // startButton.userInteractionEnabled=NO;
    startButton.enabled=NO;
    self.startButton=startButton;
    

    

}





//表头里面内容
-(UIView *)tableViewForheaderView
{
    UIView *headerView=[[UIView alloc] init];
    headerView.frame=CGRectMake(0, 0, SCREEN_WIDTH, 50);
    headerView.backgroundColor=ZCColor(60, 57, 78);
    
    
    UIButton *chooseBtn=[[UIButton alloc] init];
    chooseBtn.frame=CGRectMake(0, 0, SCREEN_WIDTH, 50);
    [chooseBtn addTarget:self action:@selector(clickTheChoose) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:chooseBtn];
    
    UIImageView *imageView=[[UIImageView alloc] init];
    imageView.image=[UIImage imageNamed:@"cjbs_weizhi"];
    imageView.frame=CGRectMake(10, (chooseBtn.frame.size.height-15)*0.5, 10, 15);
    [chooseBtn addSubview:imageView];
    
    UILabel *nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(30, (chooseBtn.frame.size.height-20)*0.5, 180, 20)];
    nameLabel.textColor=[UIColor whiteColor];
    self.nameLabel=nameLabel;
    [chooseBtn addSubview:nameLabel];
    
    
    UIImageView *rightImageView=[[UIImageView alloc] init];
    
    rightImageView.frame=CGRectMake(SCREEN_WIDTH-25, (chooseBtn.frame.size.height-15)*0.5, 10, 15);
    rightImageView.image=[UIImage imageNamed:@"cjbs_shuru"];
    [chooseBtn addSubview:rightImageView];
    
    
    
    
    return headerView;
}


//点击表头
-(void)clickTheChoose
{
    
    
//    self.opened1=NO;
//    self.opened2=NO;
//    self.opened3=NO;
//    self.opened4=NO;
//    self.opened5=NO;
//    self.firstChildName=nil;
//    self.tee_boxe=nil;
//    self.lastChildName=nil;
//    self.lastTee_boxe=nil;
//    
//    self.childStadium=nil;
//    self.childStadiumMutableArray=nil;
//    
//    self.lastChildStadium=nil;
//    self.index=0;
//    self.type=nil;
//    self.nameLabel.text=nil;
//    self.count=0;
//    self.stadiumInformation=nil;
//
    
    
    
    ZCChooseThePitchVViewController *ChooseThePitchVView=[[ZCChooseThePitchVViewController alloc] init];
    ChooseThePitchVView.delegate=self;
    [self.navigationController pushViewController:ChooseThePitchVView animated:YES];
}


//ZCSwitchTableView控制器传值过来时候的set方法
-(void)setUuidStr:(NSString *)uuidStr
{
    _uuidStr=uuidStr;
    
    [self selectCourseLoadData:uuidStr];
    
}


//创建定位GPS
-(void)initCLLocationManager
{
    self.locationMgr=[[CLLocationManager alloc] init];
    self.locationMgr.delegate=self;
    self.locationMgr.desiredAccuracy=kCLLocationAccuracyBest;
   // 移动多少米开始重新定位
    self.locationMgr.distanceFilter=255.0;
    
    if([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)

    {
        // 主动要求用户对我们的程序授权, 授权状态改变就会通知代理
        [self.locationMgr requestAlwaysAuthorization]; // 请求前台和后台定位权限
        [self.locationMgr startUpdatingLocation];

    }else
    {
        NSLog(@"是iOS7");
        // 3.开始监听(开始获取位置)
        [self.locationMgr startUpdatingLocation];
    }

    
}




//刚进来时候根据经纬度获取最近的坐标来显示球场信息
-(void)initDataLoading
{

    //加载圈圈
    [MBProgressHUD showMessage:@"加载中..."];
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
    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"venues/nearest.json"];
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        ZCLog(@"%@------",responseObject);
        ZCStadiumInformation  *stadiumInformation=[ZCStadiumInformation stadiumInformationWithDict:responseObject];
        
        self.stadiumInformation=stadiumInformation;
        
        //加载tableView
        [self initTableView];
        
       
        
        //给表头里的label的名字赋值
        self.nameLabel.text=self.stadiumInformation.name;
        //刷新表格
        [self.tableView reloadData];
        
        [MBProgressHUD hideHUD];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ZCLog(@"%@",error);
        //移除
        //[SVProgressHUD dismiss];
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"cuowu"];
        
    }];
    
    
}


//选择球场后加载数据
-(void)selectCourseLoadData:(NSString *)uuid
{
   // 加载圈圈
    [MBProgressHUD showMessage:@"加载中..."];
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    params[@"uuid"]=uuid;
    params[@"token"]=account.token;
    
    //发送请求/v1/courses/show.json
    
    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"venues/show.json"];
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        ZCLog(@"%@",responseObject);
        
        
        ZCStadiumInformation  *stadiumInformation=[ZCStadiumInformation stadiumInformationWithDict:responseObject];
        
        self.stadiumInformation=stadiumInformation;
        
        
        
        //给表头里的label的名字赋值
        self.nameLabel.text=self.stadiumInformation.name;
        //隐藏圈圈
        [MBProgressHUD hideHUD];
        // 刷新表格
        [self.tableView reloadData];
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ZCLog(@"请求失败%@",error);
        //隐藏圈圈
        [MBProgressHUD hideHUD];
    }];
    


}


//ZCChooseThePitchVViewController代理方法
-(void)ZCChooseThePitchVViewController:(ZCChooseThePitchVViewController *)ChooseThePitchVViewController andUuid:(NSString *)uuid
{
    [self selectCourseLoadData:uuid];
}


////ZCSwitchTableViewController代理方法
//-(void)ZCSwitchTableViewController:(ZCSwitchTableViewController *)SwitchTableViewController andUuid:(NSString *)uuid
//{
//   [self selectCourseLoadData:uuid];
//}
//





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
    
    //网络数据加载
    [self initDataLoading];
    
}



//获取失败时候调用或者用户拒绝时候调用
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    ZCLog(@"%@",error);
    
    self.longitude=116.300841;
    self.latitude=39.975368;
    
    //网络数据加载
    [self initDataLoading];
}






//返回到上个界面
//-(void)liftBthClick:(UIButton *)bth
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}


-(void)viewWillDisappear:(BOOL)animated
{
  self.startButton.hidden=YES;
    
       //[self.startButton removeFromSuperview];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
    self.startButton.hidden=NO;
}


-(void)clickTheDidStartButton
{
    ZCLog(@"--------可以点击Button");
    
    ZCScorecardTableViewController *scorecardTableView=[[ZCScorecardTableViewController alloc] init];
    
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
        if (self.lastUuid==nil&&self.lastTee_boxe==nil) {
        params[@"course_uuids"]=self.uuid;
//        ZCLog(@"%@",self.uuid);
//        ZCLog(@"%@",self.tee_boxe);
        params[@"tee_boxes"]=self.tee_boxe;
    }else{
    params[@"course_uuids"]= [NSString stringWithFormat:@"%@,%@" , self.uuid,self.lastUuid ];
        params[@"tee_boxes"]=[NSString stringWithFormat:@"%@,%@" , self.tee_boxe,self.lastTee_boxe ];
    }
    
    if ([self.type isEqual:@"简单"]) {
        params[@"scoring_type"]=@"simple";
    }else
    {
    params[@"scoring_type"]=@"professional";
    }
    

   params[@"token"]=account.token;
///v1/matches/practice.json
    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"matches.json"];
    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
      
        
       // ZCTotalScorecards *totalScorecards= [ZCTotalScorecards totalScorecardsWithDict:responseObject];
       // ZCLog(@"-------%@",totalScorecards.type);
       // scorecardTableView.totalScorecards=totalScorecards;
//        //单利模式  为统计页面保存uuid
//        ZCEventUuidTool *tool=[ZCEventUuidTool sharedEventUuidTool];
//        tool.uuid=responseObject[@"uuid"];
        
        scorecardTableView.uuid=responseObject[@"uuid"];
        
        [self.navigationController pushViewController:scorecardTableView animated:YES];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ZCLog(@"%@",error);
    }];
    
    
    
    
    
}


//是否可以点击开始按钮
-(void)canStart
{
    
    self.startButton.enabled=NO;
    self.startButton.backgroundColor=ZCColor(100, 175, 102);
    //[self.startButton setTitleColor:ZCColor(240, 208, 122) forState:UIControlStateNormal];

     //ZCLog(@"进入该方法了");
    
    if (self.childStadium.holes_count==18) {
        if (self.tee_boxe &&self.type) {
            self.startButton.enabled=YES;
            self.startButton.backgroundColor=ZCColor(9, 133, 12);
           // [self.startButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
           
            
        }
    }else if (self.childStadium.holes_count==9)
    {
        if (self.tee_boxe&&self.type) {
            if (self.lastChildName) {
                if (self.lastTee_boxe) {
                    self.startButton.enabled=YES;
                    self.startButton.backgroundColor=ZCColor(9, 133, 12);
                    
                   // [self.startButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    
                }
            }
        }
        
    }


}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    if (self.count) {
        return self.count;
    }else if(self.stadiumInformation.courses.count==1)
    {
        //默认调用点击方法
        
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:1];
        [self tableView:tableView didSelectRowAtIndexPath:indexPath];
        
        return 3;
    }else
    {
        return 2;
    }
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return (self.opened5? 0:2) ;
    }
    
    else if  (section==1) {
        
        return (self.opened1? 0:self.stadiumInformation.courses.count) ;
    }else if(section==2){
        
        NSLog(@"%zd",self.childStadium.tee_boxes.count);
        return (self.opened2? 0: self.childStadium.tee_boxes.count );
    }else if (section==3)
    {
        return  (self.opened3? 0: self.childStadiumMutableArray.count);
    }else //if(section==3)
    {
        return( self.opened4? 0:self.lastChildStadium.tee_boxes.count );
    }
    
   
    
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    NSString *myCell = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
    
    
       if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:myCell];
    }
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.textLabel.text=@"简单";
        }else
        {
            cell.textLabel.text=@"专业";

        }
        
        
    }else if(indexPath.section==1)
  {
        ZCChildStadium *childStadium=self.stadiumInformation.courses[indexPath.row];
        cell.textLabel.text=childStadium.name;
       // cell.detailTextLabel.text=[NSString stringWithFormat:@"%@",[NSNumber numberWithFloat:childStadium.holes_count]];
        cell.detailTextLabel.text=[NSString stringWithFormat:@"%d洞",childStadium.holes_count];
    }else if(indexPath.section==2)
    {
        NSString *tee=self.childStadium.tee_boxes[indexPath.row];
       
        if ([tee isEqual:@"white"]) {
            cell.textLabel.text=@"白色";
            cell.imageView.image=[UIImage imageNamed:@"bai"];
        }else if ([tee isEqual:@"red"])
        {
            cell.textLabel.text=@"红色";
            cell.imageView.image=[UIImage imageNamed:@"hong"];
        }else if ([tee isEqual:@"blue"])
        {
            cell.textLabel.text=@"蓝色";
            cell.imageView.image=[UIImage imageNamed:@"lan"];

        }else if ([tee isEqual:@"black"])
        {
            cell.textLabel.text=@"黑色";
            cell.imageView.image=[UIImage imageNamed:@"hei"];
        }else if ([tee isEqual:@"gold"])
        {
            cell.textLabel.text=@"金色";
            cell.imageView.image=[UIImage imageNamed:@"huang"];

        }
        
       
        
    
    }else if (indexPath.section==3)
    {
        ZCChildStadium *childStadium=self.childStadiumMutableArray[indexPath.row];
        cell.textLabel.text=childStadium.name;
        cell.detailTextLabel.text=[NSString stringWithFormat:@"%d洞",childStadium.holes_count];
        
    }else
    {
        NSString *tee=self.lastChildStadium.tee_boxes[indexPath.row];
        
        if ([tee isEqual:@"white"]) {
            cell.textLabel.text=@"白色";
            cell.imageView.image=[UIImage imageNamed:@"bai"];
        }else if ([tee isEqual:@"red"])
        {
            cell.textLabel.text=@"红色";
            cell.imageView.image=[UIImage imageNamed:@"hong"];
        }else if ([tee isEqual:@"blue"])
        {
            cell.textLabel.text=@"蓝色";
            cell.imageView.image=[UIImage imageNamed:@"lan"];
            
        }else if ([tee isEqual:@"black"])
        {
            cell.textLabel.text=@"黑色";
            cell.imageView.image=[UIImage imageNamed:@"hei"];
        }else if ([tee isEqual:@"gold"])
        {
            cell.textLabel.text=@"金色";
            cell.imageView.image=[UIImage imageNamed:@"huang"];
            
        }
        

        
    }
    

    
    //设置cell的背景
    //cell.backgroundView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell-bj"]];
   // cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"suoyou_bj_02"]];
    cell.textLabel.textColor=ZCColor(85, 85, 85);
    //cell.detailTextLabel.textColor=ZCColor(240, 208, 122);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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



// 设置每一组的头View

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //创建一个View
    ZCSettingHeadView *headerView=[ZCSettingHeadView headerViewWithTableView:tableView];
    headerView.delegate=self;
  
   // 把数据扔给自定义View
    if (section==0) {
        headerView.nameButton.tag=99;
        if (self.opened5) {
            headerView.imageName=@"icon_shang";
        }else
        {
            headerView.imageName=@"icon_xia";
        }

        headerView.cleicedName=self.type;
        
        if (self.type==nil) {
            headerView.liftName=@"选择计分方式";
        }else
        {
        headerView.liftName=@"计分方式";
        }
        
        
        
    }else if (section==1) {
       
      
        headerView.nameButton.tag=100;
        headerView.tag=1001;
        
        if (self.opened1) {
             headerView.imageName=@"icon_shang";
        }else
        {
           headerView.imageName=@"icon_xia";
        }
        
        if (self.firstChildName==nil) {
            headerView.liftName=@"请选择球场";
        }else
        {
            if (self.childStadium.holes_count==18) {
                headerView.liftName=@"球场";
            }else{
                headerView.liftName=@"前九洞";
            }

        }
        
   headerView.cleicedName=self.firstChildName;
        
        ZCLog(@"%@",self.firstChildName);
        
}else if(section==2)
    {
        headerView.nameButton.tag=101;
        headerView.tag=1002;
        
        if (self.opened2) {
            headerView.imageName=@"icon_shang";
        }else
        {
            headerView.imageName=@"icon_xia";
        }

        
        
        if (self.tee_boxe==nil) {
            headerView.liftName=@"请选择T台";
        }else
        {
            headerView.liftName=@"开球T台";
        }

        
        headerView.cleicedName=self.tee_boxe;
        
    }else if (section==3)
        
    {
        
        headerView.nameButton.tag=102;
        headerView.tag=1003;
        
        if (self.opened3) {
            headerView.imageName=@"icon_shang";
        }else
        {
            headerView.imageName=@"icon_xia";
        }

        
        
        if (self.lastChildName==nil) {
            headerView.liftName=@"请选择球场";
        }else
        {
            headerView.liftName=@"后九洞";
        }

        
        
        headerView.cleicedName=self.lastChildName;
        
    }else{
        if (self.opened4) {
            headerView.imageName=@"icon_shang";
        }else
        {
            headerView.imageName=@"icon_xia";
        }

        
        headerView.nameButton.tag=103;
        headerView.tag=1004;
        headerView.cleicedName=self.lastTee_boxe;
        if (self.lastTee_boxe==nil) {
            headerView.liftName=@"请选择T台";
        }else
        {
            headerView.liftName=@"开球T台";
        }

    }
   
   
    //headerView.
    return headerView;
}

#pragma mark - ZCSettingHeaderView的代理方法
-(void)headerViewDidClicked:(ZCSettingHeadView *)headerView didClickButton:(UIButton *)button
{
    if (button.tag==99) {
        self.opened5=!self.opened5;
        
    }else if (button.tag==100) {
        self.opened1=!self.opened1;

      
    }else if (button.tag==101)
    {
        
      self.opened2=!self.opened2;

    }else if (button.tag==102)
    {
        self.opened3=!self.opened3;

    
    }else
    {
      self.opened4=!self.opened4;

    }
    
    
    [self.tableView reloadData];
   
    
}






-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        self.opened5=YES;
        if (indexPath.row==0) {
            self.type=@"简单";
        }else
        {
        self.type=@"专业";
        }
        
        
        
    }else if (indexPath.section==1) {
        //点击第0组拿到的子场
        self.opened1=YES;
        self.opened2=NO;
        self.opened3=NO;
        self.opened4=NO;
        self.tee_boxe=nil;
        self.lastChildName=nil;
        self.lastTee_boxe=nil;
        self.lastUuid=nil;
       
        self.count=3;
        ZCChildStadium *childStadium=self.stadiumInformation.courses[indexPath.row];
        self.childStadium = childStadium;
        NSString *uuidStr=childStadium.uuid;
        self.uuid=uuidStr;
        

        
        self.firstChildName=childStadium.name;
        ZCLog(@"%@",self.firstChildName);
       
        self.index=indexPath.row;

    }else if (indexPath.section==2)
    {//点击第1组拿到的子场的T台，并判断是否是18洞 是开始回合，不是增加一组在重新选择子场
        
        
      self.opened2=YES;
        self.opened3=NO;
        self.opened4=NO;
;


        self.lastTee_boxe=nil;
        self.lastChildName=nil;
        
        NSString *tee_boxe= self.childStadium.tee_boxes[indexPath.row];
        ZCLog(@"%@",tee_boxe);
        self.tee_boxe=tee_boxe;
        
        
        if (self.childStadium.holes_count==18) {
            ZCLog(@"----开始回合-----");
        }else
        {
            self.count=4;
            
            
            
            NSMutableArray *childStadiums=self.stadiumInformation.courses;
            for (ZCChildStadium *childStadium in childStadiums) {
                if (childStadium.holes_count==18) {
                    
                    [childStadiums removeObject:childStadium];
                }
               // ZCLog(@"%lu",childStadiums.count);
                self.childStadiumMutableArray=childStadiums;
                
            }
            
        }
    
    }else if (indexPath.section==3)
    {
         self.opened3=YES;
        self.opened4=NO;
//        ZCSettingHeadView *headView4= (ZCSettingHeadView *)[self.tableView viewWithTag:1004]   ;
//        headView4.cleicedName=nil;
        self.lastTee_boxe=nil;

        //点击第3组时候保存子场uuid，并且增加一组选择T台
        self.count=5;
        
        //拿到选择后场的子场uuid
        ZCChildStadium *lastChildStadium=self.childStadiumMutableArray[indexPath.row];
        self.lastChildStadium=lastChildStadium;
        self.lastUuid=lastChildStadium.uuid;
        self.lastChildName=lastChildStadium.name;
        
    
    }else if(indexPath.section==4)
    {
        self.opened4=YES;        //保存后9洞的T台
        NSString *houTee_box=self.lastChildStadium.tee_boxes[indexPath.row];
        self.lastTee_boxe=houTee_box;
        ZCLog(@"%@",houTee_box);
        
        ZCLog(@"开始回合------");
    
    
    }
    
    [self canStart];
    
    [self.tableView reloadData];
    
    
}





@end
