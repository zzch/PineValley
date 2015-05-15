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
#import "MBProgressHUD+NJ.h"
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
@interface ZCScorecardTableViewController ()<UITableViewDataSource,UITableViewDelegate,ZCScorecarDelegate,ZCModifyTheScorecardViewControllerDelegate,ZCModifyTheProfessionalScorecardControllerDelegate,ZCCompetitiveTableViewCellDelagate,ZCScorecarHeadViewDelagate>
@property (nonatomic, strong) NSMutableArray *scorecards;

@property (nonatomic, strong) NSIndexPath *indexPath;
@end

@implementation ZCScorecardTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       
    //返回
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barBtnItemWithNormalImageName:@"suoyou_fanhui" hightImageName:@"ffanhui_anxia" action:@selector(liftBthClick:) target:self];
    
    
    
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    customLab.textAlignment=NSTextAlignmentCenter;
    [customLab setTextColor:ZCColor(240, 208, 122)];
    [customLab setText:@"修改记分卡"];
    customLab.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = customLab;
    
    UIBarButtonItem *newBar= [[UIBarButtonItem alloc] initWithTitle:@"统计" style:UIBarButtonItemStyleDone target:self action:@selector(clickOnTheStatistics)];
    //改变UIBarButtonItem字体颜色
    [newBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:ZCColor(240, 208, 122), UITextAttributeTextColor,nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem =newBar;
    
    
   
    //背景颜色suoyou_bj
    self.tableView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"suoyou_bj_02"]];
    //去掉分割线
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //分割线颜色
    [self.tableView   setSeparatorColor:ZCColor(240, 208, 122)];

    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.sectionHeaderHeight=130;
    
    
    self.tableView.rowHeight=125;
    
    
    [self online];

    
    
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
-(void)liftBthClick:(UIButton *)bth
{
    [self.navigationController popViewControllerAnimated:YES];
}

//网络加载
-(void)online
{

    //显示圈圈
    [MBProgressHUD showMessage:@"加载中..."];
    
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
        
       
        ZCLog(@"%@",responseObject[@"message"]);
        
        ZCTotalScorecards *totalScorecards= [ZCTotalScorecards totalScorecardsWithDict:responseObject];
        
        self.totalScorecards=totalScorecards;
        //隐藏圈圈
        [MBProgressHUD hideHUD];
        [self.tableView reloadData ];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //隐藏圈圈
        [MBProgressHUD hideHUD];

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
  NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", [indexPath section], [indexPath row]];
   
    ZCScorecarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
    if (cell == nil) {
        cell = [[ZCScorecarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    
    
     cell.delegate=self;
    NSMutableArray *scorecards=self.totalScorecards.scorecards;
    
    
    cell.scorecard=scorecards[indexPath.row];
  
    return cell;
    
}



//头部
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ZCScorecarHeadView *ScorecarHeadView=[[ZCScorecarHeadView alloc] init];
    ScorecarHeadView.delegate=self;
    ScorecarHeadView.playerModel=self.totalScorecards.player;
    return ScorecarHeadView;
}


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
