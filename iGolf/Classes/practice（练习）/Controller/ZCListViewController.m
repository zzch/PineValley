//
//  ZCListViewController.m
//  iGolf
//
//  Created by hh on 15/5/18.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCListViewController.h"
#import "ZCListTableViewCell.h"
#import "AFNetworking.h"
#import "ZCAccount.h"
#import "ZCListModel.h"
#import "ZCViewTheResultsViewController.h"
@interface ZCListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *listArray;
@end

@implementation ZCListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self onlineData];
    
    
}


//网络数据加载
-(void)onlineData
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
    
    params[@"match_uuid"]=self.uuid;
    params[@"token"]=account.token;
    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"leaderboards.json"];
    
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        ZCLog(@"%@",responseObject);
        self.listArray=[NSMutableArray array];
        for (NSDictionary *dict in responseObject) {
            ZCListModel *listModel=[ZCListModel listModelWithDict:dict ];
            [self.listArray addObject:listModel];
            
        }
        
        
        
        
        //创建tableView
        [self initTableView];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}




//创建tableView
-(void)initTableView
{
    UITableView *tableView=[[UITableView alloc] init];
    tableView.frame=self.view.frame;
    [self.view addSubview:tableView];
    
    self.tableView=tableView;
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.rowHeight=100;
    
   
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.listArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCListTableViewCell *cell=[ZCListTableViewCell cellWithTable:tableView];
   
    cell.listModel=self.listArray[indexPath.row];
   return cell;
}




//点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZCViewTheResultsViewController *ViewTheResultsViewController=[[ZCViewTheResultsViewController alloc] init];
    ViewTheResultsViewController.uuid=[self.listArray[indexPath.row] uuid];
    [self.navigationController pushViewController:ViewTheResultsViewController animated:YES];

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
