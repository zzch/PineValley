//
//  ZCScorecardTableViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/2/3.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCScorecardTableViewController.h"
#import "ZCModifyTheProfessionalScorecardController.h"
#import "ZCEventUuidTool.h"
#import "UIBarButtonItem+DC.h"
#import "ZCScorecarTableViewCell.h"
#import "ZCQrCodeViewController.h"
#import "ZCScorecard.h"
#import "ZCShowButton.h"
#import "AFNetworking.h"
#import "ZCAccount.h"
#import "ZCAmateurStatisticsViewController.h"
#import "ZCModifyTheScorecardViewController.h"
#import "ZCProfessionalStatisticalViewController.h"
#import "ZCCompetitiveTableViewCell.h"
#import "ZCScorecarHeadView.h"
#import "ZCPersonalizedSettingsViewController.h"
#import "ZCInvitationViewController.h"
#import "ZCListViewController.h"
#import "ZCQuickScoringTableViewController.h"
#import "MJRefresh.h"
@interface ZCScorecardTableViewController ()<UITableViewDataSource,UITableViewDelegate,ZCScorecarDelegate,ZCModifyTheScorecardViewControllerDelegate,ZCModifyTheProfessionalScorecardControllerDelegate,ZCCompetitiveTableViewCellDelagate,ZCScorecarHeadViewDelagate,MJRefreshBaseViewDelegate>

@property(nonatomic,weak)UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *scorecards;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, weak) MJRefreshHeaderView *header;
@property(nonatomic,weak)ZCScorecarHeadView *ScorecarHeadView;
@end

@implementation ZCScorecardTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       
    //返回
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barBtnItemWithNormalImageName:@"fanhui" hightImageName:@"fanhui" action:@selector(liftBthTheClick:) target:self];
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"记分卡";
//    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
//    customLab.textAlignment=NSTextAlignmentCenter;
//    [customLab setTextColor:ZCColor(240, 208, 122)];
//    [customLab setText:@"修改记分卡"];
//    customLab.font = [UIFont boldSystemFontOfSize:20];
//    self.navigationItem.titleView = customLab;
//     self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
//    UIBarButtonItem *newBar= [[UIBarButtonItem alloc] initWithTitle:@"统计" style:UIBarButtonItemStyleDone target:self action:@selector(clickOnTheStatistics)];
//    //改变UIBarButtonItem字体颜色
//   // [newBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:ZCColor(240, 208, 122), UITextAttributeTextColor,nil] forState:UIControlStateNormal];
//    self.navigationItem.rightBarButtonItem =newBar;
    
    
    
    ZCScorecarHeadView *ScorecarHeadView=[[ZCScorecarHeadView alloc] init];
    ScorecarHeadView.frame=CGRectMake(0, 0, SCREEN_WIDTH, 134);
    ScorecarHeadView.delegate=self;
//    ScorecarHeadView.playerModel=self.totalScorecards.player;
    [self.view addSubview:ScorecarHeadView];
    self.ScorecarHeadView=ScorecarHeadView;
    
    
    [self initTableView];

    
    
 }




-(void)initTableView
{
    UITableView  *tableView=[[UITableView alloc] init];
    tableView.frame=CGRectMake(0, 134, self.view.frame.size.width, self.view.frame.size.height-134);
    [self.view addSubview: tableView];
    self.tableView=tableView;
    
    
    //让tableView没有弹簧效果
   // self.tableView.bounces=NO;
    
    
    //背景颜色suoyou_bj
    self.tableView.backgroundColor=ZCColor(237, 237, 237);
    //去掉分割线
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //分割线颜色
    [self.tableView   setSeparatorColor:ZCColor(170, 170, 170)];
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    //self.tableView.sectionHeaderHeight=134;
    
    
    self.tableView.rowHeight=80;
    
    // 1.下拉刷新
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.delegate = self;
    // 自动进入刷新状态
    [header beginRefreshing];
    self.header = header;
    
    

}



/**
 *  框架 刷新控件进入开始刷新状态的时候调用
 */
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) { // 上拉刷新加载
        
    } else { // 下拉刷新
        [self online];
    }
}




- (void)dealloc
{
    // 释放内存
    [self.header free];
    
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



//返回到上个界面
-(void)liftBthTheClick:(UIButton *)bth
{
    for (id viewController in self.navigationController.viewControllers) {
     
        if ([viewController isKindOfClass:[ZCQuickScoringTableViewController class]]) {
            ZCQuickScoringTableViewController *Quick=viewController;
            Quick.black=@"black";
            [self.navigationController popToViewController:viewController animated:YES];
            break;
        }
    }
    
  
}

//网络加载
-(void)online
{

    //显示圈圈
 // [MBProgressHUD showMessage:@"加载中..."];
    
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    params[@"uuid"]=self.uuid;
    // ZCLog(@"%@",[self.eventArray[indexPath.row] uuid]);
    params[@"token"]=account.token;
    
    ///v1/matches/show.json
    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"matches/show.json"];
    
//    ZCLog(@"%@",url);
//    ZCLog(@"%@",account.token);
//    ZCLog(@"%@",self.uuid);
    
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        ZCLog(@"%@",responseObject);
        ZCLog(@"%@",responseObject[@"message"]);
        
        if (responseObject[@"error_code"] ) {
            
            [ZCprompt initWithController:self andErrorCode:[NSString stringWithFormat:@"%@",responseObject[@"error_code"]]];
            
        }else
        {
        
        ZCTotalScorecards *totalScorecards= [ZCTotalScorecards totalScorecardsWithDict:responseObject];
        
        self.totalScorecards=totalScorecards;
        
        
       
        
         self.ScorecarHeadView.playerModel=self.totalScorecards.player;
        
        [self.tableView reloadData ];
            [self.header endRefreshing];
        }
        //隐藏圈圈
       // [MBProgressHUD hideHUD];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //隐藏圈圈
     // [MBProgressHUD hideHUD];
        [self.header endRefreshing];
        [ZCprompt initWithController:self andErrorCode:[NSString stringWithFormat:@"%ld",(long)[operation.response statusCode]]];
        ZCLog(@"%@",error);
    }];
    

    
}


-(void)clickOnTheStatistics
{
    //单利
    ZCEventUuidTool *UuidTool=[ZCEventUuidTool sharedEventUuidTool];
    if ([UuidTool.scoring isEqual:@"simple"]){
    ZCAmateurStatisticsViewController *statisticsViewController=[[ZCAmateurStatisticsViewController alloc] init];
    
    [self.navigationController pushViewController:statisticsViewController animated:YES];
    
    }else{
    
    ZCProfessionalStatisticalViewController *ProfessionalStatistical=[[ZCProfessionalStatisticalViewController alloc] init];
    
    [self.navigationController pushViewController:ProfessionalStatistical animated:YES];
    
    }
}







#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

   
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 18;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    //以indexPath来唯一确定cell
  NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
   
    ZCScorecarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
    if (cell == nil) {
        cell = [[ZCScorecarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    
    
     cell.delegate=self;
    NSMutableArray *scorecards=self.totalScorecards.scorecards;
    
    
    cell.scorecard=scorecards[indexPath.row];
  
    return cell;
    
}



////头部
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    ZCScorecarHeadView *ScorecarHeadView=[[ZCScorecarHeadView alloc] init];
//    ScorecarHeadView.delegate=self;
//    ScorecarHeadView.playerModel=self.totalScorecards.player;
//    return ScorecarHeadView;
//}


- (id) _valueOrNil:(id)obj {
    if (!obj) {
        return nil;
    }
    if (obj == [NSNull null]) {
        return nil;
    }
    return obj;
}

-(void)ZCScorecarHeadView:(ZCScorecarHeadView *)scorecarHeadView andClickButton:(UIButton *)button
{
    if (button.tag==2790) {
        
        if ([self _valueOrNil:self.totalScorecards.player.user.portrait]==nil) {
            
            ZCLog(@"%@",self.totalScorecards.player.user.portrait);
            
            ZCEventUuidTool *tool=[ZCEventUuidTool sharedEventUuidTool];
            tool.isJoin=NO;
            ZCPersonalizedSettingsViewController *ZPersonalizedSettingsViewController=[[ZCPersonalizedSettingsViewController alloc] init];
            ZPersonalizedSettingsViewController.uuid=self.uuid;
            [self.navigationController pushViewController:ZPersonalizedSettingsViewController animated:YES];
            
        }else
        {
            ZCInvitationViewController *InvitationViewController=[[ZCInvitationViewController alloc] init];
            
            InvitationViewController.isYes=YES;
            InvitationViewController.uuid=self.uuid;
            [self.navigationController pushViewController:InvitationViewController animated:YES];

        }
        
        
    }else if (button.tag==2789)
    {
        ZCListViewController *ListViewController=[[ZCListViewController alloc] init];
        ListViewController.uuid=self.uuid;
        [self.navigationController pushViewController:ListViewController animated:YES];
    }else if (button.tag==2791)
    {
        
        
        if ([self.totalScorecards.player.scoring_type isEqual:@"simple"]){
            ZCAmateurStatisticsViewController *statisticsViewController=[[ZCAmateurStatisticsViewController alloc] init];
            statisticsViewController.uuid=self.uuid;
            [self.navigationController pushViewController:statisticsViewController animated:YES];
            
        }else{
            
            ZCProfessionalStatisticalViewController *ProfessionalStatistical=[[ZCProfessionalStatisticalViewController alloc] init];
            ProfessionalStatistical.uuid=self.uuid;
            [self.navigationController pushViewController:ProfessionalStatistical animated:YES];
            
        }

        
        
        
    
    }else if (button.tag==2777)
    {
        ZCQrCodeViewController *QrCode=[[ZCQrCodeViewController alloc] init];
        QrCode.uuid=self.uuid;
        [self.navigationController pushViewController:QrCode animated:YES];
        
    }
}




//ZCScorecarTableViewCell的代理方法
-(void)addImageDidClick:(UIButton *)sender
{
    //拿到对应cell的indexPath
    UIView *view=(UIView *)sender;
    UIView *superView=view.superview;
    while (![superView isKindOfClass:[UITableViewCell class]]) {
        superView=superView.superview;
    }
    
    
    NSIndexPath *indexPath=[self.tableView  indexPathForCell:(UITableViewCell *)superView ];
    self.indexPath=indexPath;

    
    
    
    NSMutableArray *scorecards=self.totalScorecards.scorecards;
    ZCscorecard *scorecard=scorecards[indexPath.row];
//    
//    //单利
//    ZCEventUuidTool *UuidTool=[ZCEventUuidTool sharedEventUuidTool];
    if ([self.totalScorecards.player.scoring_type isEqual:@"simple"]) {
        ZCModifyTheScorecardViewController *fillView=[[ZCModifyTheScorecardViewController alloc] init];
        //传递数据模型给下个控制器
        fillView.scorecard=scorecard;
        [self.navigationController pushViewController:fillView animated:YES];
        fillView.delegate=self;
    }else
    {
        ZCModifyTheProfessionalScorecardController *professional=[[ZCModifyTheProfessionalScorecardController alloc] init];
        professional.delegate=self;
        professional.scorecard=scorecard;
        [self.navigationController pushViewController:professional animated:YES];
    }
    
    
    
    

    
   
}


#pragma mark - ZCZCFillViewControllerDelegate代理方法 

-(void)ZCZCFillViewController:(ZCModifyTheScorecardViewController *)modifyTheScorecardViewController didSaveScorecardt:(ZCscorecard *)scorecard
{
    
    
    [self online];
    // 1.替换模型数据
    // ZCLog(@"section=%zd--row=%zd",self.indexPath.section,self.indexPath.row);
   // NSMutableArray *array=[self.totalScorecards.scorecards objectAtIndex:_indexPath.row];
//    [self.totalScorecards.scorecards replaceObjectAtIndex:_indexPath.row withObject:scorecard];
//
//    // 2.刷新表格
//    
//    [self.tableView reloadData ];
    
    
   
    
}



#pragma mark - ZCModifyTheProfessionalScorecardControllerDelegate代理方法
-(void)modifyTheProfessionalScorecardController:(ZCModifyTheProfessionalScorecardController *)modifyTheProfessionalScorecardController didSaveScorecardt:(ZCscorecard *)scorecard
{

    [self online];
    
    // 1.替换模型数据
    // ZCLog(@"section=%zd--row=%zd",self.indexPath.section,self.indexPath.row);
    // NSMutableArray *array=[self.totalScorecards.scorecards objectAtIndex:_indexPath.row];
//    [self.totalScorecards.scorecards replaceObjectAtIndex:_indexPath.row withObject:scorecard];
//    
//    // 2.刷新表格
//    
//    [self.tableView reloadData ];


}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
//    NSMutableArray *scorecards=self.totalScorecards.scorecards;
//    ZCscorecard *scorecard=scorecards[indexPath.row];
//    
//    ZCModifyTheScorecardViewController *fillView=[[ZCModifyTheScorecardViewController alloc] init];
//    //传递数据模型给下个控制器
//    fillView.scorecard=scorecard;
//    [self.navigationController pushViewController:fillView animated:YES];
//    fillView.delegate=self;
//    
//    self.indexPath=indexPath;
//    
    
    
}


@end
