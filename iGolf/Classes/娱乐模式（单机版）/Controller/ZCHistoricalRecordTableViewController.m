//
//  ZCHistoricalRecordTableViewController.m
//  iGolf
//
//  Created by hh on 15/8/7.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCHistoricalRecordTableViewController.h"
#import "ZCHistoricalRecordCell.h"
#import "ZCDatabaseTool.h"
#import "ZCRegisteredViewController.h"
#import "ZCDoudizhuGameViewController.h"
#import "ZCLasVegasViewController.h"
#import "ZCSingletonTool.h"
#import "ZCHoleViewController.h"
@interface ZCHistoricalRecordTableViewController ()
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation ZCHistoricalRecordTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight=100;
    self.tableView.sectionHeaderHeight=140;
    self.dataArray= [ZCDatabaseTool theHistoricalRecord];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

   
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZCHistoricalRecordCell *cell=[ZCHistoricalRecordCell cellWithTable:tableView];
    
    cell.historicalRecordModel=self.dataArray[indexPath.row];
    return cell;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView=[[UIView alloc] init];
    headView.backgroundColor=[UIColor redColor];
    UILabel *nameLabel=[[UILabel alloc] init];
    nameLabel.textColor=[UIColor whiteColor];
    nameLabel.text=@"累计分数";
    nameLabel.font=[UIFont systemFontOfSize:20];
    nameLabel.frame=CGRectMake(10, 15, 80, 25);
    [headView addSubview:nameLabel];
    
    
    UILabel *totalScoreLabel=[[UILabel alloc] init];
    totalScoreLabel.text=@"0";
    totalScoreLabel.textAlignment=NSTextAlignmentCenter;
    totalScoreLabel.textColor=[UIColor whiteColor];
    totalScoreLabel.font=[UIFont systemFontOfSize:25];
    totalScoreLabel.frame=CGRectMake(0, (140-(nameLabel.frame.size.height+15))/2, SCREEN_WIDTH, 50);
    [headView addSubview:totalScoreLabel];
    
    return headView;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCHistoricalRecordModel *historicalRecordModel=self.dataArray[indexPath.row];
    ZCSingletonTool *tool=[ZCSingletonTool sharedEventUuidTool];
    tool.uuid=historicalRecordModel.uuid;
    
    if (historicalRecordModel.type==1) {
        ZCHoleViewController *vc=[[ZCHoleViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (historicalRecordModel.type==2){
        ZCDoudizhuGameViewController *vc=[[ZCDoudizhuGameViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        ZCLasVegasViewController *vc=[[ZCLasVegasViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    

}


@end
