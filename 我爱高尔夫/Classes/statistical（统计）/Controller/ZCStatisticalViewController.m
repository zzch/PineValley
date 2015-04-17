//
//  ZCStatisticalViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/4/17.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCStatisticalViewController.h"

@interface ZCStatisticalViewController ()

@end

@implementation ZCStatisticalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addControls];
}



-(void)addControls
{
   //顶部View
    UIView *topView=[[UIView alloc] init];
    CGFloat topViewX=0;
    CGFloat topViewY=10;
    CGFloat topViewW=SCREEN_WIDTH;
    CGFloat topViewH=100;
    topView.frame=CGRectMake(topViewX, topViewY, topViewW, topViewH);
    [self.view addSubview:topView];
    
    [self topviewControls:topView];
    
    
//    //中部View
//    UIView *topView=[[UIView alloc] init];
//    CGFloat topViewX=0;
//    CGFloat topViewY=10;
//    CGFloat topViewW=SCREEN_WIDTH;
//    CGFloat topViewH=100;
//    topView.frame=CGRectMake(topViewX, topViewY, topViewW, topViewH);
//
    
}


-(void)topviewControls:(UIView *)topview
{
    //差点
    UIView *almostView=[[UIView alloc] init];
    CGFloat almostViewX=0;
    CGFloat almostViewY=0;
    CGFloat almostViewW=topview.frame.size.width/2;
    CGFloat almostViewH=topview.frame.size.height/2;
    almostView.frame=CGRectMake(almostViewX, almostViewY, almostViewW, almostViewH);
    [topview addSubview:almostView];
    [self addModuleView:almostView numberLabel:@"12" nameLabel:@"差点"];
    
    
    //排名ranking
    UIView *rankingView=[[UIView alloc] init];
    CGFloat rankingViewX=almostViewW;
    CGFloat rankingViewY=almostViewY;
    CGFloat rankingViewW=almostViewW;
    CGFloat rankingViewH=almostViewH;
    rankingView.frame=CGRectMake(rankingViewX, rankingViewY, rankingViewW, rankingViewH);
    [topview addSubview:rankingView];
    [self addModuleView:rankingView numberLabel:@"12" nameLabel:@"排名"];
    
    //最好成绩
    UIView *bestView=[[UIView alloc] init];
    CGFloat bestViewX=almostViewX;
    CGFloat bestViewY=almostViewH;
    CGFloat bestViewW=almostViewW;
    CGFloat bestViewH=almostViewH;
    bestView.frame=CGRectMake(bestViewX, bestViewY, bestViewW, bestViewH);
    [topview addSubview:bestView];
    [self addModuleView:bestView numberLabel:@"12" nameLabel:@"最好成绩"];
    
    //总成绩场次
    UIView *totalNumberView=[[UIView alloc] init];
    CGFloat totalNumberViewX=rankingViewX;
    CGFloat totalNumberViewY=bestViewY;
    CGFloat totalNumberViewW=almostViewW;
    CGFloat totalNumberViewH=almostViewH;
    totalNumberView.frame=CGRectMake(totalNumberViewX, totalNumberViewY, totalNumberViewW, totalNumberViewH);
    [topview addSubview:totalNumberView];
    [self addModuleView:totalNumberView numberLabel:@"12" nameLabel:@"完成计分/总场次"];

    
}


-(void)addModuleView:(UIView *)view numberLabel:(NSString*)number  nameLabel:(NSString *)name
{
    UILabel *numberLabel=[[UILabel alloc] init];
    CGFloat numberLabelX=0;
    CGFloat numberLabelY=0;
    CGFloat numberLabelW=view.frame.size.width;
    CGFloat numberLabelH=view.frame.size.height/2;
    numberLabel.frame=CGRectMake(numberLabelX, numberLabelY, numberLabelW, numberLabelH);
    numberLabel.text=number;
    numberLabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:numberLabel];
    
    
    UILabel *nameLabel=[[UILabel alloc] init];
    CGFloat nameLabelX=0;
    CGFloat nameLabelY=numberLabelH;
    CGFloat nameLabelW=view.frame.size.width;
    CGFloat nameLabelH=view.frame.size.height/2;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.text=name;
    nameLabel.textAlignment=NSTextAlignmentCenter;

    [view addSubview:nameLabel];
    

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
