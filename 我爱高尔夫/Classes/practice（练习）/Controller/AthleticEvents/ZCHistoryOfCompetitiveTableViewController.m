//
//  ZCHistoryOfCompetitiveTableViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/4/28.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCHistoryOfCompetitiveTableViewController.h"
#import "MJRefresh.h"
#import "ZCAccount.h"
#import "AFNetworking.h"
@interface ZCHistoryOfCompetitiveTableViewController ()<MJRefreshBaseViewDelegate>
@property (nonatomic, weak) MJRefreshFooterView *footer;
@property (nonatomic, weak) MJRefreshHeaderView *header;

//加载的页数
@property(nonatomic,assign)int page;

@end

@implementation ZCHistoryOfCompetitiveTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    
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




//服务器数据请求
-(void)serverData
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
    
    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"matches/tournament.json"];
    //ZCLog(@"%@",url);
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        ZCLog(@"----%@",responseObject);
//        
//        NSMutableArray *eventMutableArray=[NSMutableArray array];
//        for (NSDictionary *dict in responseObject) {
//            ZCEvent *event=[ZCEvent eventWithDict:dict];
//            [eventMutableArray addObject:event];
//        }
//        self.eventArray=eventMutableArray;
        
        
        
//        //无内容时候
//        if (self.eventArray.count==0) {
//            UIView *vc=[[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.156, 0, 257, 67)];
//            vc.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"wuneirong"]];
//            self.vc=vc;
//            [self.tableView addSubview:vc];
//        }else
//        {
//            self.vc.hidden=YES;
//        }
        
        
        
        
        
        
        
        [self.tableView reloadData];
        [self.header endRefreshing];
      //  [self showNewStatusCount];
        
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
    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"matches/tournament.json"];
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
         ZCLog(@"----%@",responseObject);
        
//        NSMutableArray *eventMutableArray=[NSMutableArray array];
//        for (NSDictionary *dict in responseObject) {
//            ZCEvent *event=[ZCEvent eventWithDict:dict];
//            [eventMutableArray addObject:event];
//        }
//        
//        
//        // 添加新数据到旧数据的后面
//        [self.eventArray addObjectsFromArray:eventMutableArray];
//        
        
        
        
        
        
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


- (void)dealloc
{
    // 释放内存
    [self.header free];
    [self.footer free];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

   
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
