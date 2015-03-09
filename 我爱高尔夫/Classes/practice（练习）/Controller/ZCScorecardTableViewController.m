//
//  ZCScorecardTableViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/2/3.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCScorecardTableViewController.h"



#import "ZCScorecarTableViewCell.h"
#import "ZCFillViewController.h"
#import "ZCScorecard.h"
#import "ZCShowButton.h"
#import "AFNetworking.h"
#import "ZCAccount.h"

@interface ZCScorecardTableViewController ()<UITableViewDataSource,UITableViewDelegate,ZCScorecarDelegate,ZCZCFillViewControllerDelegate>
@property (nonatomic, strong) NSMutableArray *scorecards;

@property (nonatomic, strong) NSIndexPath *indexPath;
@end

@implementation ZCScorecardTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //网络请求
    //[self scorecardsData];
    //[self.tableView reloadData];
//    ZCLog(@"---%lu----",self.totalScorecards.scorecards.count);
//    ZCscorecard *scorecard=self.totalScorecards.scorecards[0];
//    ZCLog(@"------%@",scorecard.number );
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:nil];

    
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
   // self.tableView.sectionHeaderHeight=60;
    
    
    self.tableView.rowHeight=100;
    
    
    }












#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    ZCLog(@"先执行吗");
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

    
    
    ZCFillViewController *fillView=[[ZCFillViewController alloc] init];
    [self.navigationController pushViewController:fillView animated:YES];
    fillView.delegate=self;
}


#pragma mark - ZCZCFillViewControllerDelegate代理方法 

-(void)ZCZCFillViewController:(ZCFillViewController *)FillViewController didSaveScorecardt:(ZCscorecard *)scorecard
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
    NSMutableArray *scorecards=self.totalScorecards.scorecards;
    ZCscorecard *scorecard=scorecards[indexPath.row];
    
    ZCFillViewController *fillView=[[ZCFillViewController alloc] init];
    //传递数据模型给下个控制器
    fillView.scorecard=scorecard;
    [self.navigationController pushViewController:fillView animated:YES];
    fillView.delegate=self;
    
    self.indexPath=indexPath;
    
    
    
}


@end
