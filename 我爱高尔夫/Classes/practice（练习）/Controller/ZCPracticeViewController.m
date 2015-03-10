//
//  ZCPracticeViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/1/29.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCPracticeViewController.h"
#import "ZCQuickScoringViewController.h"
#import "ZCQuickScoringTableViewController.h"
@interface ZCPracticeViewController ()

@end

@implementation ZCPracticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"选择计分卡";
    // 修改下一个界面返回按钮的文字
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
    
    
}
- (IBAction)clickQuickScoring {
    
//    ZCQuickScoringViewController *quick=[[ZCQuickScoringViewController alloc] init];
//    [self.navigationController pushViewController:quick animated:YES];
//    
    ZCQuickScoringTableViewController *quickScoringTableViewController=[[ZCQuickScoringTableViewController alloc] init];
    quickScoringTableViewController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:quickScoringTableViewController animated:YES];
    
    
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
