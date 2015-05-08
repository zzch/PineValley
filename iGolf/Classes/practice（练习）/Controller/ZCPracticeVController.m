//
//  ZCPracticeVController.m
//  我爱高尔夫
//
//  Created by hh on 15/5/7.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCPracticeVController.h"
#import "ZCQuickScoringTableViewController.h"
#import "AppDelegate.h"
#import "ZCEventUuidTool.h"
#import "ZCChooseThePitchVViewController.h"
#import "ZCHistoryOfCompetitiveTableViewController.h"

@interface ZCPracticeVController ()

@end

@implementation ZCPracticeVController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    AppDelegate *app=  (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app setAllowRotation:NO];
    
    
    
    if ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    
    
    
    //背景颜色suoyou_bj
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"suoyou_bj_02"]];
    
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    customLab.textAlignment=NSTextAlignmentCenter;
    [customLab setTextColor:ZCColor(240, 208, 122)];
    [customLab setText:@"选择记分卡"];
    customLab.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = customLab;
    

    //简单
    UIButton *practice=[[UIButton alloc] init];
    CGFloat practiceW=259;
    CGFloat practiceH=59;
    CGFloat practiceY=SCREEN_HEIGHT*0.5465;
    CGFloat practiceX=(SCREEN_WIDTH-practiceW)/2;
    
    practice.frame=CGRectMake(practiceX, practiceY, practiceW, practiceH);
    
    [practice setBackgroundImage:[UIImage imageNamed:@"xzjfk_jdjfk_anniu"] forState:UIControlStateNormal];
    [practice addTarget:self action:@selector(clickThePractice) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:practice ];
    
    
    //描述
    UILabel *describeLabel1=[[UILabel alloc] init];
    describeLabel1.frame=CGRectMake(0, practiceY+practiceH+10, SCREEN_WIDTH, 20);
    describeLabel1.textColor=ZCColor(136, 119, 73);
    describeLabel1.text=@"快速开始计分，简单易用";
    describeLabel1.font=[UIFont systemFontOfSize:15];
    describeLabel1.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:describeLabel1];
    
    
    

    
    
    
    
    //专业
    UIButton *professional=[[UIButton alloc] init];
    CGFloat professionalW=259;
    CGFloat professionalH=59;
    CGFloat professionalY=SCREEN_HEIGHT*0.134;
    CGFloat professionalX=(SCREEN_WIDTH-professionalW)/2;
    
    professional.frame=CGRectMake(professionalX, professionalY, professionalW, professionalH);
    
    [professional setBackgroundImage:[UIImage imageNamed:@"xzjfk_zyjfk_anniu"] forState:UIControlStateNormal];
    [professional addTarget:self action:@selector(clickTheprofessional) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:professional ];

    
    
    UILabel *describeLabel2=[[UILabel alloc] init];
    describeLabel2.frame=CGRectMake(0, professional.frame.size.height+professional.frame.origin.y+20, SCREEN_WIDTH, 20);
    describeLabel2.textColor=ZCColor(136, 119, 73);
    describeLabel2.text=@"记录更加精准";
    describeLabel2.font=[UIFont systemFontOfSize:15];
    describeLabel2.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:describeLabel2];
    
    
    
    UILabel *describeLabel3=[[UILabel alloc] init];
    describeLabel3.frame=CGRectMake(0, describeLabel2.frame.origin.y+describeLabel2.frame.size.height+5, SCREEN_WIDTH, 20);
    describeLabel3.textColor=ZCColor(136, 119, 73);
    describeLabel3.text=@"能得到多维度的数据分析";
    describeLabel3.font=[UIFont systemFontOfSize:15];
    describeLabel3.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:describeLabel3];
    
    
}

//专业
-(void)clickTheprofessional
{
    ZCEventUuidTool *tool=[ZCEventUuidTool sharedEventUuidTool];
    tool.scoring=@"professional";
    
    tool.eventType=@"practice";
    ZCQuickScoringTableViewController *quickScoringTableViewController=[[ZCQuickScoringTableViewController alloc] init];
    quickScoringTableViewController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:quickScoringTableViewController animated:YES];

}


//简单
-(void)clickThePractice
{

    ZCEventUuidTool *tool=[ZCEventUuidTool sharedEventUuidTool];
    tool.scoring=@"simple";
    tool.eventType=@"practice";
    
    ZCQuickScoringTableViewController *quickScoringTableViewController=[[ZCQuickScoringTableViewController alloc] init];
    quickScoringTableViewController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:quickScoringTableViewController animated:YES];

}

//备用
- (void)clickEvent {
    
    
    ZCEventUuidTool *tool=[ZCEventUuidTool sharedEventUuidTool];
    tool.eventType=@"tournament";
    
    
    ZCHistoryOfCompetitiveTableViewController *HistoryOfCompetitiveTableViewController=[[ZCHistoryOfCompetitiveTableViewController alloc] init];
    HistoryOfCompetitiveTableViewController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:HistoryOfCompetitiveTableViewController animated:YES];
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
