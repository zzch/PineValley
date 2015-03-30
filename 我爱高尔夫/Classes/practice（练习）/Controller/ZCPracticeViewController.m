//
//  ZCPracticeViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/1/29.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCPracticeViewController.h"
#import "ZCBackBackButtonitem.h"
#import "ZCQuickScoringTableViewController.h"
#import "AppDelegate.h"
#import "ZCEventUuidTool.h"

@interface ZCPracticeViewController ()

@end

@implementation ZCPracticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *app=  (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app setAllowRotation:NO];
    
    
    
    if ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    //NSString *as=API;
   // NSString *str=[NSString stringWithFormat:@"%@%@",API,@"ASDASD"];
   // ZCLog(@"%@",str);
    self.navigationItem.title=@"选择计分卡";
    //返回按钮
    self.navigationItem.backBarButtonItem = [[ ZCBackBackButtonitem alloc] init];
    self.view.backgroundColor=ZCColor(23, 25, 28);
   // ZCLog(@"%f,%f",SCREEN_HEIGHT,SCREEN_WIDTH);
//    self.view.backgroundColor=[UIColor c]
    
//    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    [fmt setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSDate *date1=[NSDate date];
//    NSString *currentDateStr = [fmt stringFromDate:date1];
//    ZCLog(@"%@",currentDateStr);
}
- (IBAction)clickQuickScoring {
    
    ZCEventUuidTool *tool=[ZCEventUuidTool sharedEventUuidTool];
    tool.scoring=@"simple";
    
    ZCQuickScoringTableViewController *quickScoringTableViewController=[[ZCQuickScoringTableViewController alloc] init];
    quickScoringTableViewController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:quickScoringTableViewController animated:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
