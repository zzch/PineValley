//
//  ZCCompetitiveSetTableViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/4/22.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCCompetitiveSetTableViewController.h"
#import "ZCAthleticEventTableViewCell.h"
#import "ZCCreateAGameTableViewController.h"
@interface ZCCompetitiveSetTableViewController ()

@end

@implementation ZCCompetitiveSetTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"新建" style:UIBarButtonItemStyleDone target:self action:@selector(clickRightBarButton)];
    
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.rowHeight=100;
    
    
    [self onlineData];
    
}


//网络加载
-(void)onlineData
{


}

//点击新建/v1/venues/matches/tournament.json
-(void)clickRightBarButton
{
    ZCCreateAGameTableViewController *createAGameTableViewController=[[ZCCreateAGameTableViewController alloc] init];
    createAGameTableViewController.uuidStr=self.uuidStr;
    [self.navigationController pushViewController:createAGameTableViewController animated:YES];
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

    // Return the number of rows in the section.
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZCAthleticEventTableViewCell *cell=[ZCAthleticEventTableViewCell cellWithTable:tableView];
    
    
    return cell;
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
