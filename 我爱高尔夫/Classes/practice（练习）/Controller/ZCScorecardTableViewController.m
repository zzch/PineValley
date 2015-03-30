//
//  ZCScorecardTableViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/2/3.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCScorecardTableViewController.h"



#import "ZCScorecarTableViewCell.h"
#import "ZCBackBackButtonitem.h"
#import "ZCScorecard.h"
#import "ZCShowButton.h"
#import "AFNetworking.h"
#import "ZCAccount.h"
#import "ZCAmateurStatisticsViewController.h"
#import "ZCModifyTheScorecardViewController.h"
@interface ZCScorecardTableViewController ()<UITableViewDataSource,UITableViewDelegate,ZCScorecarDelegate,ZCModifyTheScorecardViewControllerDelegate>
@property (nonatomic, strong) NSMutableArray *scorecards;

@property (nonatomic, strong) NSIndexPath *indexPath;
@end

@implementation ZCScorecardTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       
    // 修改下一个界面返回按钮的文字
    
    self.navigationItem.backBarButtonItem = [[ ZCBackBackButtonitem alloc] init];
    
    self.navigationItem.title=@"快捷记分卡";
    
    UIBarButtonItem *newBar= [[UIBarButtonItem alloc] initWithTitle:@"统计" style:UIBarButtonItemStyleDone target:self action:@selector(clickOnTheStatistics)];
    //改变UIBarButtonItem字体颜色
    [newBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor,nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem =newBar;
    
    
   
    self.tableView.backgroundColor=ZCColor(23, 25, 28);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
   // self.tableView.sectionHeaderHeight=60;
    
    
    self.tableView.rowHeight=125;
    
    
    [self online];

    
    
 }

-(void)online
{

    
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    params[@"uuid"]=self.uuid;
    // ZCLog(@"%@",[self.eventArray[indexPath.row] uuid]);
    params[@"token"]=account.token;
    
    ///v1/matches/show.json
    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"matches/practice/show"];
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
       
        
        
        ZCTotalScorecards *totalScorecards= [ZCTotalScorecards totalScorecardsWithDict:responseObject];
        
        self.totalScorecards=totalScorecards;
        
        [self.tableView reloadData ];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ZCLog(@"%@",error);
    }];
    

    
}


-(void)clickOnTheStatistics
{
    
    ZCAmateurStatisticsViewController *statisticsViewController=[[ZCAmateurStatisticsViewController alloc] init];
    
    [self.navigationController pushViewController:statisticsViewController animated:YES];
    

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
    
    ZCModifyTheScorecardViewController *fillView=[[ZCModifyTheScorecardViewController alloc] init];
    //传递数据模型给下个控制器
    fillView.scorecard=scorecard;
    [self.navigationController pushViewController:fillView animated:YES];
    fillView.delegate=self;
    
    
    

    
   
}


#pragma mark - ZCZCFillViewControllerDelegate代理方法 

-(void)ZCZCFillViewController:(ZCModifyTheScorecardViewController *)modifyTheScorecardViewController didSaveScorecardt:(ZCscorecard *)scorecard
{
    
    // 1.替换模型数据
    // ZCLog(@"section=%zd--row=%zd",self.indexPath.section,self.indexPath.row);
   // NSMutableArray *array=[self.totalScorecards.scorecards objectAtIndex:_indexPath.row];
    [self.totalScorecards.scorecards replaceObjectAtIndex:_indexPath.row withObject:scorecard];

    // 2.刷新表格
    
    [self.tableView reloadData ];
    
    
   
    
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
