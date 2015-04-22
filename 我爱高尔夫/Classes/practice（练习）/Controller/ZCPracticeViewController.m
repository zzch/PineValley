//
//  ZCPracticeViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/1/29.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCPracticeViewController.h"

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
    //返回按钮UIBarButtonItemStylePlain
//    UIBarButtonItem *bar=[[ ZCBackBackButtonitem alloc] init] ;
//    bar.style=UIBarButtonItemStylePlain;
//    self.navigationItem.backBarButtonItem = bar;//[[ ZCBackBackButtonitem alloc] init] ;
    
//    UIImage* image = [UIImage imageNamed:@"fanhui-anxia"];
//    UIImage *image1=[UIImage imageNamed:@"fanhui"];
//
//     self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithImage:image1 landscapeImagePhone:image style:UIBarButtonItemStylePlain target:nil action:nil];
    
   
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
    tool.eventType=@"practice";
    
    ZCQuickScoringTableViewController *quickScoringTableViewController=[[ZCQuickScoringTableViewController alloc] init];
    quickScoringTableViewController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:quickScoringTableViewController animated:YES];
    
    
}
- (IBAction)chickModifyTheProfessionalScorecard {
    ZCEventUuidTool *tool=[ZCEventUuidTool sharedEventUuidTool];
     tool.scoring=@"professional";
    
    tool.eventType=@"practice";
    ZCQuickScoringTableViewController *quickScoringTableViewController=[[ZCQuickScoringTableViewController alloc] init];
    quickScoringTableViewController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:quickScoringTableViewController animated:YES];
    
}

- (IBAction)clickEvent {
    
    
    ZCEventUuidTool *tool=[ZCEventUuidTool sharedEventUuidTool];
   tool.eventType=@"tournament";
   
    ZCQuickScoringTableViewController *quickScoringTableViewController=[[ZCQuickScoringTableViewController alloc] init];
    quickScoringTableViewController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:quickScoringTableViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
