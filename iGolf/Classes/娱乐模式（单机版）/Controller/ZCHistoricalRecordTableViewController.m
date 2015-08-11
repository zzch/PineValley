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
    
    self.tableView.rowHeight=120;
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
