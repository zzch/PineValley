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
#import "ZCInvitationViewController.h"
#import "ZCPersonalizedSettingsViewController.h"
#import "MJRefresh.h"
@interface ZCListViewController ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *listArray;

@property (nonatomic, weak) MJRefreshHeaderView *header;
@end

@implementation ZCListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=ZCColor(237, 237, 237);
    self.navigationItem.title=@"排行榜";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    
    //返回
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barBtnItemWithNormalImageName:@"fanhui" hightImageName:@"fanhui" action:@selector(liftBthClick:) target:self];
    //创建tableView
    [self initTableView];
  // [self onlineData];
    
    
}
//返回到上个界面
-(void)liftBthClick:(UIButton *)bth
{
    [self.navigationController popViewControllerAnimated:YES];
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
        
        ZCLog(@"%@",responseObject );
        
       
            
            
        
        self.listArray=[NSMutableArray array];
        for (NSDictionary *dict in responseObject) {
            ZCListModel *listModel=[ZCListModel listModelWithDict:dict ];
            [self.listArray addObject:listModel];
            
        }
        
        if (self.listArray.count==0) {
            [self valueIsNil];
        }
        
 
        [self.tableView  reloadData];
         [self.header endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         [self.header endRefreshing];
        
        
        [ZCprompt initWithController:self andErrorCode:[NSString stringWithFormat:@"%ld",(long)[operation.response statusCode]]];
        
    }];
}



/**
 *  值为空得情况下
 */
-(void)valueIsNil
{

    UIImageView *trophyImage=[[UIImageView alloc] init];
   
    CGFloat trophyImageY=SCREEN_HEIGHT*0.211;
    CGFloat trophyImageW=81;
    CGFloat trophyImageH=80;
    CGFloat trophyImageX=(SCREEN_WIDTH-trophyImageW)/2;
    trophyImage.frame=CGRectMake(trophyImageX, trophyImageY, trophyImageW, trophyImageH);
    trophyImage.image=[UIImage imageNamed:@"paihangbang_wu"];
    [self.view addSubview:trophyImage];
    
    
    UILabel *firstLabel=[[UILabel alloc] init];
    CGFloat firstLabelY=trophyImageY+trophyImageH+15;
    CGFloat firstLabelW=SCREEN_WIDTH;
    CGFloat firstLabelH=20;
    CGFloat firstLabelX=0;
    firstLabel.frame=CGRectMake(firstLabelX, firstLabelY, firstLabelW, firstLabelH);
    firstLabel.textColor=ZCColor(102, 102, 102);
    firstLabel.textAlignment=NSTextAlignmentCenter;
    firstLabel.text=@"没有好友加入比赛";
    [self.view addSubview:firstLabel];
    
    
    UILabel *secondLabel=[[UILabel alloc] init];
    CGFloat secondLabelY=firstLabelY+firstLabelH+10;
    CGFloat secondLabelW=SCREEN_WIDTH;
    CGFloat secondLabelH=20;
    CGFloat secondLabelX=0;
    secondLabel.frame=CGRectMake(secondLabelX, secondLabelY, secondLabelW, secondLabelH);
    secondLabel.textColor=ZCColor(102, 102, 102);
    secondLabel.textAlignment=NSTextAlignmentCenter;
    secondLabel.text=@"没有好友加入比赛吧";
    [self.view addSubview:secondLabel];
    
    UIButton *invitationButton=[[UIButton alloc] init];
    CGFloat invitationButtonW=140;
    CGFloat invitationButtonH=40;
    CGFloat invitationButtonX=(SCREEN_WIDTH-invitationButtonW)/2;
    CGFloat invitationButtonY=secondLabelY+secondLabelH+20;
    invitationButton.frame=CGRectMake(invitationButtonX, invitationButtonY, invitationButtonW, invitationButtonH);
    [invitationButton setTitle:@"邀请好友" forState:UIControlStateNormal];
    invitationButton.backgroundColor=ZCColor(9, 133, 12);
    invitationButton.layer.cornerRadius=5;
    invitationButton.layer.masksToBounds=YES;
    [invitationButton addTarget:self action:@selector(clickTheinvitationButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:invitationButton];
    
}

//点击邀请好友
-(void)clickTheinvitationButton
{
    // 获取路劲 取出图片
    NSString *path=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"personImage.png"];
    NSData *imageData=[NSData dataWithContentsOfFile:path];
    UIImage *image=[[UIImage alloc] initWithData:imageData];
    

    if (image) {
        ZCInvitationViewController *InvitationViewController=[[ZCInvitationViewController alloc] init];
        InvitationViewController.uuid=self.uuid;
        [self.navigationController pushViewController:InvitationViewController animated:YES];
    }else{
    
    ZCPersonalizedSettingsViewController *ZPersonalizedSettingsViewController=[[ZCPersonalizedSettingsViewController alloc] init];
    ZPersonalizedSettingsViewController.uuid=self.uuid;
    [self.navigationController pushViewController:ZPersonalizedSettingsViewController animated:YES];
    
    }
   
    
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
    
    //让下面没内容的分割线不显示
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.backgroundColor=ZCColor(237, 237, 237);
    //分割线颜色
    [self.tableView   setSeparatorColor:ZCColor(170, 170, 170)];
   
    
    
    // 1.下拉刷新
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.delegate = self;
    // 自动进入刷新状态
    [header beginRefreshing];
    self.header = header;

    
}


- (void)dealloc
{
    // 释放内存
    [self.header free];
    
}


/**
 *  框架 刷新控件进入开始刷新状态的时候调用
 */
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) { // 上拉刷新加载
        
    } else { // 下拉刷新
        [self onlineData];
    }
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
