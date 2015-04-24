//
//  ZCCompetitiveScorecardTableViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/4/24.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCCompetitiveScorecardTableViewController.h"
#import "ZCEventUuidTool.h"
#import "UIBarButtonItem+DC.h"
#import "ZCScorecarTableViewCell.h"
#import "MBProgressHUD+NJ.h"
#import "ZCScorecard.h"
#import "ZCShowButton.h"
#import "AFNetworking.h"
#import "ZCAccount.h"
#import "ZCModifyTheScorecardViewController.h"
#import "ZCCompetitiveModel.h"
#import "ZCCompetitiveTableViewCell.h"
@interface ZCCompetitiveScorecardTableViewController ()<UITableViewDataSource,UITableViewDelegate,ZCScorecarDelegate,ZCModifyTheScorecardViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *scorecards;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation ZCCompetitiveScorecardTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    // 修改返回按钮
//    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barBtnItemWithNormalImageName:@"fanhui" hightImageName:@"fanhui-anxia" action:@selector(liftBthClick:) target:self];
    
    self.navigationItem.title=@"快捷记分卡";
    
    
    self.tableView.backgroundColor=ZCColor(23, 25, 28);
    //去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    // self.tableView.sectionHeaderHeight=60;
    
    
    //self.tableView.rowHeight=125;

    
}





#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section==0) {
        return 1;
    }else{
        return 18;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section==0) {
        
        ZCCompetitiveTableViewCell *cell=[ZCCompetitiveTableViewCell cellWithTable:tableView];
        
        return cell;
    }else
    {
    
    
    //以indexPath来唯一确定cell
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", [indexPath section], [indexPath row]];
    
    ZCScorecarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[ZCScorecarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    
    cell.delegate=self;
    NSMutableArray *scorecards=self.competitiveModel.scorecards;
    
    
    cell.scorecard=scorecards[indexPath.row];
    
    return cell;
        
    }

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 200;
    }else
    {
        return 125;
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
    
    
    
    
    NSMutableArray *scorecards=self.competitiveModel.scorecards;
    ZCscorecard *scorecard=scorecards[indexPath.row];
    
    
    ZCModifyTheScorecardViewController *fillView=[[ZCModifyTheScorecardViewController alloc] init];
    //传递数据模型给下个控制器
    fillView.scorecard=scorecard;
    [self.navigationController pushViewController:fillView animated:YES];
    fillView.delegate=self;

    
    
//    //单利
//    ZCEventUuidTool *UuidTool=[ZCEventUuidTool sharedEventUuidTool];
//    if ([UuidTool.scoring isEqual:@"simple"]) {
//        ZCModifyTheScorecardViewController *fillView=[[ZCModifyTheScorecardViewController alloc] init];
//        //传递数据模型给下个控制器
//        fillView.scorecard=scorecard;
//        [self.navigationController pushViewController:fillView animated:YES];
//        fillView.delegate=self;
//    }else
//    {
//        ZCModifyTheProfessionalScorecardController *professional=[[ZCModifyTheProfessionalScorecardController alloc] init];
//        professional.scorecard=scorecard;
//        [self.navigationController pushViewController:professional animated:YES];
//    }
    
 
    
}

#pragma mark - ZCZCFillViewControllerDelegate代理方法

-(void)ZCZCFillViewController:(ZCModifyTheScorecardViewController *)modifyTheScorecardViewController didSaveScorecardt:(ZCscorecard *)scorecard
{
    
    // 1.替换模型数据
    // ZCLog(@"section=%zd--row=%zd",self.indexPath.section,self.indexPath.row);
    // NSMutableArray *array=[self.totalScorecards.scorecards objectAtIndex:_indexPath.row];
    [self.competitiveModel.scorecards replaceObjectAtIndex:_indexPath.row withObject:scorecard];
    
    // 2.刷新表格
    
    [self.tableView reloadData ];
    
    
    
    
}



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
