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
#import "ZCStatisticalViewController.h"
#import "ZCPersonalViewController.h"
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
    self.view.backgroundColor=ZCColor(237, 237, 237);
    
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    
//    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
//    customLab.textAlignment=NSTextAlignmentCenter;
//    [customLab setTextColor:ZCColor(240, 208, 122)];
//    [customLab setText:@"选择记分卡"];
//    customLab.font = [UIFont boldSystemFontOfSize:20];
//    self.navigationItem.titleView = customLab;
    

    
    UIImageView *persinImage=[[UIImageView alloc] init];
    
    CGFloat  persinImageY=60;
    CGFloat  persinImageW=70;
    CGFloat  persinImageH=70;
    CGFloat  persinImageX=(SCREEN_WIDTH-persinImageW)/2;
    persinImage.frame=CGRectMake(persinImageX, persinImageY, persinImageW, persinImageH);
    persinImage.image=[UIImage imageNamed:@"tubiao"];
    [self.view addSubview:persinImage];
//    persinImage.layer.cornerRadius=10;//设置圆角的半径为10
//    persinImage.layer.masksToBounds=YES;
    
    UILabel *nameLabel=[[UILabel alloc] init];
    CGFloat  nameLabelY=persinImageY+persinImageH+20;
    CGFloat  nameLabelW=150;
    CGFloat  nameLabelH=25;
    CGFloat  nameLabelX=(SCREEN_WIDTH-nameLabelW)/2;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.text=@"我 爱 高 尔 夫";
    nameLabel.textColor=ZCColor(85, 85, 85);
    nameLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:nameLabel];
    
    //竞技比赛
    UIButton *sportsCompetition=[[UIButton alloc] init];
    CGFloat sportsCompetitionX=0;
    CGFloat sportsCompetitionY=SCREEN_HEIGHT*0.4;
    CGFloat sportsCompetitionW=SCREEN_WIDTH;
    CGFloat sportsCompetitionH=SCREEN_HEIGHT*0.2;
    sportsCompetition.frame=CGRectMake(sportsCompetitionX, sportsCompetitionY, sportsCompetitionW, sportsCompetitionH);
    sportsCompetition.backgroundColor=ZCColor(0, 194, 123);
    [sportsCompetition setTitle:@"竞技比赛" forState:UIControlStateNormal];
    [sportsCompetition addTarget:self action:@selector(clickThesportsCompetition) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sportsCompetition];
    
    
    
    
    
    
    //技术统计
    UIButton *technicalStatistics=[[UIButton alloc] init];
    CGFloat technicalStatisticsX=0;
    CGFloat technicalStatisticsY=SCREEN_HEIGHT*0.6;
    CGFloat technicalStatisticsW=SCREEN_WIDTH;
    CGFloat technicalStatisticsH=SCREEN_HEIGHT*0.2;
    technicalStatistics.frame=CGRectMake(technicalStatisticsX, technicalStatisticsY, technicalStatisticsW, technicalStatisticsH);
    technicalStatistics.backgroundColor=ZCColor(72, 172, 204);
    [technicalStatistics setTitle:@"技术统计" forState:UIControlStateNormal];
    [technicalStatistics addTarget:self action:@selector(clickTheTechnicalStatistics) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:technicalStatistics];

    
    //个人中心
    UIButton *personalCenter=[[UIButton alloc] init];
    CGFloat personalCenterX=0;
    CGFloat personalCenterY=SCREEN_HEIGHT*0.8;
    CGFloat personalCenterW=SCREEN_WIDTH;
    CGFloat personalCenterH=SCREEN_HEIGHT*0.2;
    personalCenter.frame=CGRectMake(personalCenterX, personalCenterY, personalCenterW, personalCenterH);
    personalCenter.backgroundColor=ZCColor(226, 159, 64);
    [personalCenter setTitle:@"个人中心" forState:UIControlStateNormal];
    [personalCenter addTarget:self action:@selector(clickThePersonalCenter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:personalCenter];

    
    
    
    
}




-(void)viewWillAppear:(BOOL)animated
{
    //影藏状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
 self.navigationController.navigationBarHidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    //影藏状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
self.navigationController.navigationBarHidden=NO;
}

//点击竞技比赛
-(void)clickThesportsCompetition
{

     ZCQuickScoringTableViewController *quickScoringTableViewController=[[ZCQuickScoringTableViewController alloc] init];

    
    [self.navigationController pushViewController:quickScoringTableViewController animated:YES];
    
    // [self presentModalViewController:nav animated:YES];
    

}


//点击技术统计
-(void)clickTheTechnicalStatistics
{

    ZCStatisticalViewController *statistical=[[ZCStatisticalViewController alloc] init];
    [self.navigationController pushViewController:statistical animated:YES];
    
}

//点击个人中心
-(void)clickThePersonalCenter
{
   ZCPersonalViewController *personal=[[ZCPersonalViewController alloc] init];
    [self.navigationController pushViewController:personal animated:YES];

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
    
    
//    ZCHistoryOfCompetitiveTableViewController *HistoryOfCompetitiveTableViewController=[[ZCHistoryOfCompetitiveTableViewController alloc] init];
//    HistoryOfCompetitiveTableViewController.hidesBottomBarWhenPushed=YES;
//    [self.navigationController pushViewController:HistoryOfCompetitiveTableViewController animated:YES];
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
