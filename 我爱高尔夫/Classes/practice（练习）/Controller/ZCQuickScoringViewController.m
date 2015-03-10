//
//  ZCQuickScoringViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/1/29.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//选择球场控制器

#import "ZCQuickScoringViewController.h"
#import "ZCChooseThePitchVViewController.h"
#import "AFNetworking.h"
#import "ZCAccount.h"
#import "ZCEvent.h"
#import "ZCEventTableViewCell.h"
#import "ZCScorecardTableViewController.h"
#import "ZCscorecard.h"
@interface ZCQuickScoringViewController ()<UITableViewDataSource,UITableViewDelegate>
//模型数组
@property(nonatomic,strong)NSMutableArray *eventArray;
//创建的tableView
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSIndexPath *indexPath;

@property(nonatomic,strong)UIRefreshControl *refreshControl;

/**
 *  是否删除,默认是NO
 */
@property (nonatomic, assign, getter = isDelete) BOOL delete;



@end

@implementation ZCQuickScoringViewController


-(NSMutableArray *)eventArray
{
    if (_eventArray==nil) {
        _eventArray=[NSMutableArray array];
    }
    return _eventArray;
}

//-viewdidappear
-(void)viewWillAppear:(BOOL)animated
{
    
 //网络请求
   // [self onlineData:nil];
    
    
    // 0.集成刷新控件
    [self setupRefreshView];

    
}


/**
 *  集成刷新控件
 */
- (void)setupRefreshView
{
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl=refreshControl;
    // 监听刷新控件的状态改变
    [self.refreshControl addTarget:self action:@selector(onlineData:) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView addSubview:refreshControl];
    
    // 自动进入刷新状态(不会触发监听方法)
    [refreshControl beginRefreshing];
    
    // 直接加载数据
    [self onlineData:refreshControl];


}



-(void)onlineData:(UIRefreshControl *)refreshControl
{
    //2.发送网络请求
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    
    mgr.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"text/plain",@"application/xhtml+xml",@"application/xml",@"application/json", nil];
    
    // 2.封装请求参数
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    //ZCLog(@"%@-------",account.token);
    // 说明服务器返回的JSON数据
    // mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"page"]=@"1";
    params[@"token"]=account.token;
    
    [mgr GET:@"http://augusta.aforeti.me/api/v1/matches.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // ZCLog(@"----%@",responseObject);
        
        NSMutableArray *eventMutableArray=[NSMutableArray array];
        for (NSDictionary *dict in responseObject) {
            ZCEvent *event=[ZCEvent eventWithDict:dict];
            [eventMutableArray addObject:event];
        }
        self.eventArray=eventMutableArray;
        
        
        if (self.eventArray.count) {
           // UITableView *tableVc=[[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
             UITableView *tableVc=[[UITableView alloc] init];
            tableVc.frame=CGRectMake(0, 70,SCREEN_WIDTH , SCREEN_HEIGHT);
            [self.view addSubview:tableVc];
            self.tableView=tableVc;
            self.tableView.dataSource=self;
            self.tableView.delegate=self;
            self.tableView.rowHeight=140;
        }
//        if (self.delete) {
//            self.delete=NO;
//            
//            // 从数据源删除数据
//            [self.eventArray removeObjectAtIndex:self.indexPath.row];
//            
//            // 表格删除数据，会重新调用数据源方法，产生越界
//            [self.tableView deleteRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        }
        
  

        
        [self.tableView reloadData];
        
        // 让刷新控件停止显示刷新状态
      //  [refreshControl endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ZCLog(@"获取数据失败");
        
        // 让刷新控件停止显示刷新状态
        //[refreshControl endRefreshing];
    }];
    
    

    
    
}



-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
   if(self)
   {
      
       self.hidesBottomBarWhenPushed=YES;
       self.navigationItem.title=@"快捷记分卡";
      UIBarButtonItem *newBar= [[UIBarButtonItem alloc] initWithTitle:@"新建" style:UIBarButtonItemStyleDone target:self action:@selector(chooseThePitch)];
       
       self.navigationItem.rightBarButtonItem =newBar;
      
       // 修改下一个界面返回按钮的文字
       self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
      
//       UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
//       // 监听刷新控件的状态改变
//       [refreshControl addTarget:self action:@selector(onlineData:) forControlEvents:UIControlEventValueChanged];
//       [self.tableView addSubview:refreshControl];
//
   }
    return self;
}
//点击新建跳转到选择球场页面




- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    
    UILabel *seelabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 300, 350, 20)];

    seelabel.text=  @"您还没有记分卡，点击右上角新建按钮创建记分卡";
    seelabel.textColor=[UIColor blackColor];
    //seelabel.textAlignment=13;
    [self.view addSubview:seelabel];
    
    
           UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
           // 监听刷新控件的状态改变
           [refreshControl addTarget:self action:@selector(onlineData:) forControlEvents:UIControlEventValueChanged];
           [self.tableView addSubview:refreshControl];


}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.eventArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCEventTableViewCell *eventTableViewCell=[ZCEventTableViewCell cellWithTableView:tableView];
    
    eventTableViewCell.event=self.eventArray[indexPath.row];
    
    
    return eventTableViewCell;

}





-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    params[@"uuid"]=[self.eventArray[indexPath.row] uuid];
    params[@"token"]=account.token;
    ///v1/matches/show.json
    [mgr GET:@"http://augusta.aforeti.me/api/v1/matches/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
       // ZCLog(@"%@",responseObject);
        ZCScorecardTableViewController *scorecardTableView=[[ZCScorecardTableViewController alloc] init];
      
        ZCTotalScorecards *totalScorecards= [ZCTotalScorecards totalScorecardsWithDict:responseObject];
//        ZCscorecard *as=totalScorecards.scorecards[indexPath.row];
//        as.score=@"asd";
       // [totalScorecards.scorecards[indexPath.row] score]
       // [scorecardTableView.totalScorecards.scorecards[indexPath.row] score]=[NSString stringWithFormat:@"dasdas"];
       // ZCLog(@"-------%@",totalScorecards.type);
        scorecardTableView.totalScorecards=totalScorecards;
        [self.navigationController pushViewController:scorecardTableView animated:YES];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ZCLog(@"%@",error);
    }];

}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
   if (editingStyle == UITableViewCellEditingStyleDelete)
   {
       [self alert];
       self.indexPath=indexPath;
//       // 从数据源删除数据
//      [self.eventArray removeObjectAtIndex:indexPath.row];
//       
//       // 表格删除数据，会重新调用数据源方法，产生越界
//       [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
   }
}


-(void)alert
{
    // 弹框
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"是否要删除该比赛记录" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    // 设置对话框的类型
    alert.alertViewStyle = UIKeyboardTypeNumberPad;
    
    [alert show];
    
}

#pragma mark - alertView的代理方法
/**
 *  点击了alertView上面的按钮就会调用这个方法
 *
 *  @param buttonIndex 按钮的索引,从0开始
 */

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        
        return;
    }else
    {
        ///v1/matches.json
        [self deleteData];
        
//               // 从数据源删除数据
//      [self.eventArray removeObjectAtIndex:self.indexPath.row];
//        
//              // 表格删除数据，会重新调用数据源方法，产生越界
//      [self.tableView deleteRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    // 按钮的索引肯定不是0
    
}

-(void)deleteData
{
    //2.发送网络请求
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    
    mgr.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"text/plain",@"application/xhtml+xml",@"application/xml",@"application/json", nil];
    
    // 2.封装请求参数
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    //ZCLog(@"%@-------",account.token);
    // 说明服务器返回的JSON数据
    // mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"uuid"]=[self.eventArray[self.indexPath.row] uuid];
    params[@"token"]=account.token;
    [mgr DELETE:@"http://augusta.aforeti.me/api/v1/matches.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //请求网络重新加载数据
        [self onlineData:nil];
        self.delete=YES;
        ZCLog(@"删除成功");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ZCLog(@"%@",error);
    }];

}

@end
