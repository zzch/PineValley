//
//  ZCCheckTheScorecardTableViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/4/29.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//查看记分卡

#import "ZCCheckTheScorecardTableViewController.h"
#import "ZCScorecarTableViewCell.h"

#import "ZCCheckTheScorecardTTableViewCell.h"
@interface ZCCheckTheScorecardTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ZCCheckTheScorecardTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"查看记分卡";
    
    
    self.tableView.backgroundColor=ZCColor(23, 25, 28);
    //去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        
        ZCCheckTheScorecardTTableViewCell *cell=[ZCCheckTheScorecardTTableViewCell cellWithTable:tableView];
       // cell.delegate=self;
       // cell.playerModel=self.competitiveModel.player;
        return cell;
    }else
    {
        
        
        //以indexPath来唯一确定cell
        NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", [indexPath section], [indexPath row]];
        
        ZCScorecarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[ZCScorecarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
    
        
       // cell.delegate=self;
       // NSMutableArray *scorecards=self.competitiveModel.scorecards;
        
        
      //  cell.scorecard=scorecards[indexPath.row];
        
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
