//
//  ZCQuickScoringTableViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/3/10.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCQuickScoringTableViewController.h"
#import "ZCChooseThePitchVViewController.h"
#import "AFNetworking.h"
#import "ZCAccount.h"
#import "ZCEvent.h"

#import "ZCScorecardTableViewController.h"
#import "ZCscorecard.h"
#import "MJRefresh.h"
#import "ZCEventUuidTool.h"
#import "ZCEventCell.h"
@interface ZCQuickScoringTableViewController ()<MJRefreshBaseViewDelegate>
//模型数组
@property(nonatomic,strong)NSMutableArray *eventArray;
//创建的tableView
@property(nonatomic,strong) UIView *view;
@property(nonatomic,strong) NSIndexPath *indexPath;

@property(nonatomic,strong)UIRefreshControl *refreshControl;


@property (nonatomic, weak) MJRefreshFooterView *footer;
@property (nonatomic, weak) MJRefreshHeaderView *header;

//加载的页数
@property(nonatomic,assign)int page;


@end

@implementation ZCQuickScoringTableViewController


-(NSMutableArray *)eventArray
{
    if (_eventArray==nil) {
        _eventArray=[NSMutableArray array];
    }
    return _eventArray;
}


-(void)viewWillAppear:(BOOL)animated
{
   
  
    
    
//    //如果没有数据执行此方法
//    if (self.eventArray.count==0) {
//        
//        UIView *vc=[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//        vc.backgroundColor=[UIColor whiteColor];
//        
//        
//        
//        [self.tableView addSubview:vc];
//        self.view=vc;
//        
//        UILabel *seelabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 300, 350, 20)];
//        
//        seelabel.text=  @"您还没有记分卡，点击右上角新建按钮创建记分卡";
//        seelabel.textColor=[UIColor blackColor];
//        //seelabel.textAlignment=13;
//        [vc addSubview:seelabel];
//        
//        
//    }

    
}

//-viewdidappear
- (void)viewDidLoad {
    [super viewDidLoad];
    
 
    
    self.navigationItem.title=@"快捷记分卡";
    
    UIBarButtonItem *newBar= [[UIBarButtonItem alloc] initWithTitle:@"新建" style:UIBarButtonItemStyleDone target:self action:@selector(chooseThePitch)];
    self.navigationItem.rightBarButtonItem =newBar;

    //背景颜色
    self.tableView.backgroundColor=ZCColor(23, 25, 28);
    
    
    
    // 修改下一个界面返回按钮的文字
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];

    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.rowHeight=100;
    self.page=1;
    //让分割线不显示
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 1.下拉刷新
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.delegate = self;
    // 自动进入刷新状态
    [header beginRefreshing];
    self.header = header;
    
    // 2.上拉刷新(上拉加载更多数据)
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView;
    footer.delegate = self;
    self.footer = footer;
    

    
//    
//    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
//    self.refreshControl=refreshControl;
//    // 监听刷新控件的状态改变
//    [self.refreshControl addTarget:self action:@selector(onlineData:) forControlEvents:UIControlEventValueChanged];
//    
//    [self.tableView addSubview:refreshControl];
    
    // 自动进入刷新状态(不会触发监听方法)
    //[refreshControl beginRefreshing];
    
    // 直接加载数据
    //[self onlineData:refreshControl];
    
  // [self serverData];
   // 如果没有数据执行此方法
   // int q=1;
    ZCLog(@"先执行吗%lu",self.eventArray.count);
//    if (self.eventArray.count) {
//       
//        UIView *vc=[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//        vc.backgroundColor=[UIColor whiteColor];
//        
//        
//        
//        [self.tableView addSubview:vc];
//        self.view=vc;
//        
//        UILabel *seelabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 300, 350, 20)];
//        
//        seelabel.text=  @"您还没有记分卡，点击右上角新建按钮创建记分卡";
//        seelabel.textColor=[UIColor blackColor];
//        //seelabel.textAlignment=13;
//        [vc addSubview:seelabel];
//        
//        
//    }
    
    

    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
    
    
    
}

- (void)dealloc
{
    // 释放内存
    [self.header free];
    [self.footer free];
}

/**
 *  框架 刷新控件进入开始刷新状态的时候调用
 */
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) { // 上拉刷新加载
        [self loadMoreData];
    } else { // 下拉刷新
       [self serverData];
    }
}



//点击新建时候调用
-(void)chooseThePitch
{
    ZCChooseThePitchVViewController *chooes=[[ZCChooseThePitchVViewController alloc] init];
    [self.navigationController pushViewController:chooes animated:YES];

}

//服务器数据请求
-(void)serverData
{
    ZCLog(@"中执行%lu",self.eventArray.count);
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
    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"matches/practice"];
    //ZCLog(@"%@",url);
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
       // ZCLog(@"----%@",responseObject);
        
        NSMutableArray *eventMutableArray=[NSMutableArray array];
        for (NSDictionary *dict in responseObject) {
            ZCEvent *event=[ZCEvent eventWithDict:dict];
            [eventMutableArray addObject:event];
        }
        self.eventArray=eventMutableArray;
        
        
//        //如果没有数据执行此方法
//        if (self.eventArray.count) {
//            
//            UIView *vc=[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//            vc.backgroundColor=[UIColor whiteColor];
//            
//            
//            
//            [self.tableView addSubview:vc];
//            self.view=vc;
//            
//            UILabel *seelabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 300, 350, 20)];
//            
//            seelabel.text=  @"您还没有记分卡，点击右上角新建按钮创建记分卡";
//            seelabel.textColor=[UIColor blackColor];
//            //seelabel.textAlignment=13;
//            [vc addSubview:seelabel];
//            
//           
//        }//else
////        {
//
//           // [self.tableView reloadData];
//            
//            // 让刷新控件停止显示刷新状态
//            //[refreshControl endRefreshing];
//            
//            // 让刷新控件停止显示刷新状态
//            
//        
//        }
//
        
        [self.tableView reloadData];
        [self.header endRefreshing];
        [self showNewStatusCount];

        ZCLog(@"后执行吗%lu",self.eventArray.count);

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ZCLog(@"获取数据失败%@",error);
        
        // 让刷新控件停止显示刷新状态
        [self.header endRefreshing];
        
        // 让刷新控件停止显示刷新状态
        //[refreshControl endRefreshing];
    }];

}


//下拉加载的网络请求
-(void)loadMoreData
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
    self.page++;
    params[@"page"]=[NSString stringWithFormat:@"%d",self.page];
    params[@"token"]=account.token;
    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"matches/practice"];
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // ZCLog(@"----%@",responseObject);
        
        NSMutableArray *eventMutableArray=[NSMutableArray array];
        for (NSDictionary *dict in responseObject) {
            ZCEvent *event=[ZCEvent eventWithDict:dict];
            [eventMutableArray addObject:event];
        }
        //self.eventArray=eventMutableArray;
        
        // 添加新数据到旧数据的后面
        [self.eventArray addObjectsFromArray:eventMutableArray];

        

        
        
        
       // [self.tableView reloadData];
        
        // 让刷新控件停止显示刷新状态
        //[refreshControl endRefreshing];
        
        // 让刷新控件停止显示刷新状态
        [self.footer endRefreshing];
       // [self showNewStatusCount];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ZCLog(@"获取数据失败");
        
        // 让刷新控件停止显示刷新状态
        [self.footer endRefreshing];
        
        // 让刷新控件停止显示刷新状态
        //[refreshControl endRefreshing];
    }];
    


    
    
}

/**
 * 数据跟新提示
 *
 *  @param count 最数量
 */

- (void)showNewStatusCount
{
    // 1.创建一个按钮
    UIButton *btn = [[UIButton alloc] init];
    // below : 下面  btn会显示在self.navigationController.navigationBar的下面
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    
    // 2.设置图片和文字
    btn.userInteractionEnabled = NO;
    //[btn setBackgroundImage:[UIImage resizedImageWithName:@"timeline_new_status_background"] forState:UIControlStateNormal];
    btn.backgroundColor=[UIColor yellowColor];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:24];
    [btn setTitle:@"数据已跟新" forState:UIControlStateNormal];
    
    // 3.设置按钮的初始frame
    CGFloat btnH = 35;
    CGFloat btnY = 64 - btnH;
    CGFloat btnX = 2;
    CGFloat btnW = self.tableView.frame.size.width; //- 2 * btnX;
    btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    // 4.通过动画移动按钮(按钮向下移动 btnH + 1)
    [UIView animateWithDuration:0.7 animations:^{
        
        btn.transform = CGAffineTransformMakeTranslation(0, btnH + 2);
        
    } completion:^(BOOL finished) { // 向下移动的动画执行完毕后
        
        // 建议:尽量使用animateWithDuration, 不要使用animateKeyframesWithDuration
        [UIView animateWithDuration:0.7 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            // 将btn从内存中移除
            [btn removeFromSuperview];
        }];
        
    }];
}






#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

   
    return self.eventArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier = @"cellID";
    
    ZCEventCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[ZCEventCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    cell.event=self.eventArray[indexPath.row];
    
//    
//    ZCEventTableViewCell *eventTableViewCell=[ZCEventTableViewCell cellWithTableView:tableView];
   
    //cell.event=self.eventArray[indexPath.row];
    
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
  //  cell.selectedBackgroundView.backgroundColor = [UIColor redColor];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //单利模式  为统计页面保存uuid
    ZCEventUuidTool *tool=[ZCEventUuidTool sharedEventUuidTool];
    tool.uuid=[self.eventArray[indexPath.row] uuid];
    
    
     ZCScorecardTableViewController *scorecardTableView=[[ZCScorecardTableViewController alloc] init];
     [self.navigationController pushViewController:scorecardTableView animated:YES];
    
    scorecardTableView.uuid=[self.eventArray[indexPath.row] uuid];
    
   

}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self alert];
        self.indexPath=indexPath;
        // 从数据源删除数据
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
    
     NSString *url=[NSString stringWithFormat:@"%@%@",API,@"matches/practice"];
    [mgr DELETE:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //请求网络重新加载数据
        [self serverData];
        
        ZCLog(@"删除成功");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ZCLog(@"%@",error);
    }];
    
}



@end
