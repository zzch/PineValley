//
//  ZCTotalGradeViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/4/16.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//总成绩

#import "ZCTotalGradeViewController.h"
#import "ZCProfessionalScorecardModel.h"
#import "AppDelegate.h"
#import "ZCProfessionalLandscape.h"
@interface ZCTotalGradeViewController ()
//横屏的View
@property(nonatomic,weak)ZCProfessionalLandscape *landscapeView;

//分段成绩
@property(nonatomic,weak)UIView *piecewiseView;
//竖屏的View
@property(nonatomic,weak)UIView *verticalScreenView;

@property(nonatomic,weak)UIScrollView *scrollView;
@property(nonatomic,weak)UIScrollView *scoringScrollView;
@property(nonatomic,weak)UIView *nameScoringScrollView;
@property(nonatomic,weak)UIView *beforeScoringView;
@property(nonatomic,weak)UIView *afterScoringView;
//注释界面的View
@property(nonatomic,weak)UIView *annotationView;
//成绩界面的View
@property(nonatomic,weak)UIView *resultsView;

@end

@implementation ZCTotalGradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    if ([[UIDevice currentDevice]orientation] == UIInterfaceOrientationLandscapeLeft){
        
        [self supportedInterfaceOrientations];
        
        self.verticalScreenView.hidden=YES;
        self.landscapeView.hidden=NO;
//        
       ZCProfessionalLandscape *landscapeView=[[ZCProfessionalLandscape alloc] init];
       [self.view addSubview:landscapeView];
        self.landscapeView=landscapeView;
//        
//        ZCLog(@"landscape left");
    }
    if ([[UIDevice currentDevice]orientation] == UIInterfaceOrientationLandscapeRight){
        [self supportedInterfaceOrientations];
        self.verticalScreenView.hidden=YES;
        self.landscapeView.hidden=NO;
        
        
        ZCProfessionalLandscape *landscapeView=[[ZCProfessionalLandscape alloc] init];
        [self.view addSubview:landscapeView];
        self.landscapeView=landscapeView;
        ZCLog(@"landscape right");
    }
    if ([[UIDevice currentDevice]orientation] == UIInterfaceOrientationPortrait){
        [self supportedInterfaceOrientations];
        
        self.verticalScreenView.hidden=NO;
        self.landscapeView.hidden=YES;
        
        
        UIView *verticalScreenView=[[UIView alloc] initWithFrame: [ UIScreen mainScreen ].bounds];
        self.verticalScreenView=verticalScreenView;
        [self.view addSubview:verticalScreenView];
        
        
        [self addControls];
        
        
    }

    
    
    
}


//竖屏添加控件
-(void)addControls
{
    
    UIScrollView *scrollView=[[UIScrollView alloc] init];
    scrollView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    //scrollView.frame=  [ UIScreen mainScreen ].bounds ;
    self.scrollView=scrollView;
    [self.verticalScreenView addSubview:scrollView];
    
    // 增加额外的滚动区域(在顶部增加64的区域,在底部增加44的区域)
    // self.scrollView.contentInset = UIEdgeInsetsMake(64, 0, 10, 0);
    
    // 设置一开始的滚动位置(往下滚动64)
    //self.scrollView.contentOffset = CGPointMake(0, -164);
    
    
    UIView *nameView=[[UIView alloc] init];
    CGFloat nameViewX=0;
    CGFloat nameViewY=0;
    CGFloat nameViewW=SCREEN_WIDTH;
    CGFloat nameViewH=60;
    nameView.frame=CGRectMake(nameViewX, nameViewY, nameViewW, nameViewH);
    [self.scrollView addSubview:nameView];
    
    UILabel *nameLabel=[[UILabel alloc] init];
    CGFloat nameLabelX=10;
    CGFloat nameLabelY=10;
    CGFloat nameLabelW=SCREEN_WIDTH*0.6;
    CGFloat nameLabelH=20;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.text=@"北京高尔夫球场";
    nameLabel.textColor=ZCColor(208, 210, 212);
    nameLabel.font=[UIFont systemFontOfSize:22];
    [nameView addSubview:nameLabel];
    //时间
    UILabel *timeLabel=[[UILabel alloc] init];
    CGFloat timeLabelX=10;
    CGFloat timeLabelY=nameLabelY+nameLabelH+10;
    CGFloat timeLabelW=SCREEN_WIDTH*0.4;
    CGFloat timeLabelH=20;
    
    timeLabel.frame=CGRectMake(timeLabelX, timeLabelY, timeLabelW, timeLabelH);
    timeLabel.text=@"2015年2月13号";
    timeLabel.textColor=ZCColor(208, 210, 212);
    timeLabel.font=[UIFont systemFontOfSize:18];
    [nameView addSubview:timeLabel];
    //    //前九洞
    //    UIButton *beforeButton=[[UIButton alloc] init];
    //    beforeButton.backgroundColor=[UIColor redColor];
    //    beforeButton.frame=CGRectMake(SCREEN_WIDTH-(SCREEN_WIDTH-200), 30, 60, 40);
    //    [beforeButton setTitle:@"前九洞" forState:UIControlStateNormal];
    //    [self.scrollView addSubview:beforeButton];
    //    //后九洞
    //    UIButton *afterButton=[[UIButton alloc] init];
    //    afterButton.backgroundColor=[UIColor redColor];
    //    afterButton.frame=CGRectMake(SCREEN_WIDTH-(SCREEN_WIDTH-260), 30, 60, 40);
    //    [afterButton setTitle:@"后九洞" forState:UIControlStateNormal];
    //    [self.scrollView addSubview:afterButton];
    //计分页面前的名称
    UIView *nameScoringScrollView=[[UIView alloc] init];
    CGFloat nameScoringScrollViewX=nameViewX;
    CGFloat nameScoringScrollViewY=nameViewH;
    CGFloat nameScoringScrollViewW=SCREEN_WIDTH*0.2;
    CGFloat nameScoringScrollViewH=202;
    
    nameScoringScrollView.frame=CGRectMake(nameScoringScrollViewX, nameScoringScrollViewY, nameScoringScrollViewW, nameScoringScrollViewH);
    nameScoringScrollView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jstj_yihangbeijing"]];
    [self.scrollView addSubview:nameScoringScrollView];
    
    self.nameScoringScrollView=nameScoringScrollView;
    for (int i=0; i<4; i++) {
        UILabel *nameScoringView=[[UILabel alloc] init];
        nameScoringView.frame=CGRectMake(0, i*(nameScoringScrollViewH/4), nameScoringScrollViewW, nameScoringScrollViewH/4);
        nameScoringView.textColor=ZCColor(208, 210, 212);
        //jstj_yihangbeijing
        // nameScoringView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jstj_yihangbeijing"]];
        nameScoringView.font=[UIFont systemFontOfSize:15];
        if (i==0) {
            nameScoringView.text=@"洞";
        }else if (i==1)
        {
            nameScoringView.text=@"标准杆";
        }else if (i==2)
        {
            nameScoringView.text=@"成绩";
        }else
        {
            nameScoringView.text=@"距标准杆";
            
        }
        nameScoringView.textAlignment=NSTextAlignmentCenter;
        //        nameScoringView.font=[UIFont font]
        
        [self.nameScoringScrollView addSubview:nameScoringView];
    }
    
    //计分的ScrollView
    UIScrollView *scoringScrollView=[[UIScrollView alloc] init];
    CGFloat scoringScrollViewX=nameScoringScrollViewW;
    CGFloat scoringScrollViewY=nameScoringScrollViewY;
    CGFloat scoringScrollViewW=SCREEN_WIDTH-nameScoringScrollViewW;
    CGFloat scoringScrollViewH=nameScoringScrollViewH;
    
    scoringScrollView.frame=CGRectMake(scoringScrollViewX, scoringScrollViewY, scoringScrollViewW, scoringScrollViewH);
    [self.scrollView addSubview:scoringScrollView];
    self.scoringScrollView=scoringScrollView;
    //滚动的区域
    self.scoringScrollView.contentSize=CGSizeMake(2*scoringScrollViewW, 0);
    //前九洞的view
    UIView *beforeScoringView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, scoringScrollView.frame.size.width, scoringScrollView.frame.size.height)];
    //beforeScoringView.backgroundColor=[UIColor whiteColor];
    beforeScoringView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jstj_yihangbeijing"]];
    [self.scoringScrollView addSubview:beforeScoringView];
    
    self.beforeScoringView=beforeScoringView;
    [self addForBeforeScoringView];
    
    
    
    //后九洞的view
    UIView *afterScoringView=[[UIView alloc] initWithFrame:CGRectMake(beforeScoringView.frame.size.width, 0, scoringScrollView.frame.size.width, scoringScrollView.frame.size.height)];
    
    afterScoringView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jstj_yihangbeijing"]];
    [self.scoringScrollView addSubview:afterScoringView];
    self.afterScoringView=afterScoringView;
    //添加后九的显示值
    [self addForAfterScoringView];
    
    
    
    //添加注释界面
    UIView *annotationView=[[UIView alloc] init];
    CGFloat annotationViewX=nameScoringScrollViewX;
    CGFloat annotationViewY=nameScoringScrollViewY+nameScoringScrollViewH;
    CGFloat annotationViewW=SCREEN_WIDTH;
    CGFloat annotationViewH=51;
    
    
    annotationView.frame=CGRectMake(annotationViewX, annotationViewY, annotationViewW, annotationViewH);
    [self.scrollView addSubview:annotationView];
    annotationView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jstj_yihangbeijing"]];
    self.annotationView=annotationView;
    //注释界面里面的内容
    [self annotationContent];
    
    //添加成绩的view
    UIView *resultsView=[[UIView alloc] init];
    CGFloat resultsViewX=annotationViewX;
    CGFloat resultsViewY=annotationViewY+annotationViewH+15;
    CGFloat resultsViewW=SCREEN_WIDTH;
    CGFloat resultsViewH=120;
    
    resultsView.frame=CGRectMake(resultsViewX, resultsViewY, resultsViewW, resultsViewH);
    self.resultsView=resultsView;
    resultsView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jstj_chengjibeijing"]];
    [self.scrollView addSubview:resultsView];
    //成绩内容
    [self resultsViewContent];
    
    
    //分段成绩
    UIView *piecewiseView=[[UIView alloc] init];
    piecewiseView.frame=CGRectMake(0, resultsView.frame.size.height+resultsView.frame.origin.y+15, SCREEN_WIDTH, 400);
    self.piecewiseView=piecewiseView;
    piecewiseView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jstj_kaiqiujili_beijing"]];
    [self.scrollView addSubview:piecewiseView];
    
    //成功率View里面的内容
    [self piecewiseViewViewContent];
//
//
//    // 平均分View
//    UIView *averageView=[[UIView alloc] init];
//    averageView.frame=CGRectMake(0, successRateView.frame.origin.y+successRateView.frame.size.height+15, SCREEN_WIDTH, 150);
//    self.averageView=averageView;
//    averageView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jstj_kaiqiujili_beijing"]];
//    [self.scrollView addSubview:averageView];
//    
//    [self averageViewContent];
//    
    
    
    
//    // 球成绩界面的View
//    UIView *ballScoresView=[[UIView alloc] init];
//    ballScoresView.frame=CGRectMake(0, averageView.frame.size.height+averageView.frame.origin.y+15, SCREEN_WIDTH, 300);
//    self.ballScoresView=ballScoresView;
//    ballScoresView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jstj_kaiqiujili_beijing"]];
//    [self.scrollView addSubview:ballScoresView];
//    
//    [self ballScoresViewContent];
    
    
    
    
}


//前九洞的view

-(void)addForBeforeScoringView
{
    
    // 0.总列数(一行最多3列)
    int totalColumns = 10;
    
    // 1.数字的尺寸
    CGFloat appW = (self.beforeScoringView.frame.size.width-0)/10;
    CGFloat appH = (self.beforeScoringView.frame.size.height-0)/4;
    
    // 2.间隙 = (控制器view的宽度 - 3 * 应用宽度) / 4
    //CGFloat marginX = (self.view.frame.size.width - totalColumns * appW) / (totalColumns + 1);
    CGFloat marginX = 0;
    CGFloat marginY = 0;
    
    for (int index=0; index<40; index++) {
        UIView *labelView=[[UIView alloc] init];
        // 3.2.计算框框的位置
        // 计算行号和列号
        int row = index / totalColumns;
        int col = index % totalColumns;
        // 计算x和y
        CGFloat appX = marginX + col * (appW + marginX);
        CGFloat appY = row * (appH + marginY);
        // 设置frame
        labelView.frame = CGRectMake(appX, appY, appW, appH);
        // holesResult.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jstj_yihangbeijing"]];
        //holesResult.textColor=ZCColor(208, 210, 212);
        [self.beforeScoringView addSubview:labelView];
        UIView *bjView=[[UIView alloc] init];
        bjView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"tj_shutiao"]];
        bjView.frame=CGRectMake(0, 0, 1, labelView.frame.size.height);
        [labelView addSubview:bjView];
        UILabel *holesResult=[[UILabel alloc] init];
        holesResult.frame=CGRectMake(1, 0, labelView.frame.size.width-1, labelView.frame.size.height);
        holesResult.textColor=ZCColor(208, 210, 212);
        holesResult.textAlignment=NSTextAlignmentCenter;
        holesResult.font=[UIFont systemFontOfSize:14];
        [labelView addSubview:holesResult];
        
        
        if (index<9) {
            holesResult.text=[NSString stringWithFormat:@"%d",index];
            
        }else if (index==9)
        {
            holesResult.text=@"前九";
            
        }else if (index>9&&index<20)
        {
            ZCProfessionalScorecardModel *statisticalScorecard=self.professionalScorecardModel;
            //            ZCLog(@"%@",statisticalScorecard.par);
            //            ZCLog(@"%@",self.statistical.scorecards.par);
            
            holesResult.text=[NSString stringWithFormat:@"%@",statisticalScorecard.par[index-10]];
            
            // holesResult.text=@"as";
            
        }else if (index>=20&&index<30)
        {
            
            //if //([self.statistical.scorecards.score[index-20]==(id)[NSNull null]])
            if ( [self.professionalScorecardModel.score[index-20]  isKindOfClass:[NSNull class]]) {
                holesResult.text=@"";
            }else{
                holesResult.text=[NSString stringWithFormat:@"%@",self.professionalScorecardModel.score[index-20]];
            }
            
        }else if(index>=30)
        {
            if ( [self.professionalScorecardModel.status[index-30]  isKindOfClass:[NSNull class]]) {
                holesResult.text=@"";
            }else{
                holesResult.text=[NSString stringWithFormat:@"%@",self.professionalScorecardModel.status[index-30]];
            }
        }
    }
}


//后九洞数值显示

-(void)addForAfterScoringView
{
    
    // 0.总列数(一行最多3列)
    int totalColumns = 11;
    
    // 1.数字的尺寸
    CGFloat appW = (self.beforeScoringView.frame.size.width-0)/11;
    CGFloat appH = (self.beforeScoringView.frame.size.height-0)/4;
    
    // 2.间隙 = (控制器view的宽度 - 3 * 应用宽度) / 4
    //CGFloat marginX = (self.view.frame.size.width - totalColumns * appW) / (totalColumns + 1);
    CGFloat marginX = 0;
    CGFloat marginY = 0;
    
    for (int index=0; index<44; index++) {
        UIView *labelView=[[UIView alloc] init];
        // 3.2.计算框框的位置
        // 计算行号和列号
        int row = index / totalColumns;
        int col = index % totalColumns;
        // 计算x和y
        CGFloat appX = marginX + col * (appW + marginX);
        CGFloat appY = row * (appH + marginY);
        // 设置frame
        labelView.frame = CGRectMake(appX, appY, appW, appH);
        // holesResult.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jstj_yihangbeijing"]];
        //holesResult.textColor=ZCColor(208, 210, 212);
        [self.afterScoringView addSubview:labelView];
        UIView *bjView=[[UIView alloc] init];
        bjView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jstj_shutiao"]];
        bjView.frame=CGRectMake(0, 0, 1, labelView.frame.size.height);
        [labelView addSubview:bjView];
        UILabel *holesResult=[[UILabel alloc] init];
        holesResult.frame=CGRectMake(1, 0, labelView.frame.size.width-1, labelView.frame.size.height);
        holesResult.textColor=ZCColor(208, 210, 212);
        holesResult.textAlignment=NSTextAlignmentCenter;
        holesResult.font=[UIFont systemFontOfSize:14];
        [labelView addSubview:holesResult];
        
        if (index<9) {
            holesResult.text=[NSString stringWithFormat:@"%d",index+10];
        }else if (index==9)
        {
            holesResult.text=@"IN";
            
        }else if(index==10)
        {
            holesResult.text=@"TOT";
            
        }else if (index>10&&index<22)
        {
            holesResult.text=[NSString stringWithFormat:@"%@",self.professionalScorecardModel.par[index-1]];
            
        }else if (index>=22&&index<33)
        {
            if ( [self.professionalScorecardModel.score[index-12]  isKindOfClass:[NSNull class]]) {
                holesResult.text=@"";
            }else{
                holesResult.text=[NSString stringWithFormat:@"%@",self.professionalScorecardModel.score[index-12]];
            }
            
        }else if(index>=33)
        {
            if ( [self.professionalScorecardModel.status[index-23]  isKindOfClass:[NSNull class]]) {
                holesResult.text=@"";
            }else{
                holesResult.text=[NSString stringWithFormat:@"%@",self.professionalScorecardModel.status[index-23]];
            }
            
        }
    }
}

//注释界面里面的内容
-(void)annotationContent
{
    for (int i=0; i<6; i++) {
        UIView *tempview=[[UIView alloc] init];
        tempview.frame=CGRectMake(i*(SCREEN_WIDTH/6),0, SCREEN_WIDTH/6, 60);
        [self.annotationView addSubview:tempview];
        
        UIImageView *imageView=[[UIImageView alloc] init];
        
        imageView.frame=CGRectMake(5, 20, 10, 10);
        [tempview addSubview:imageView];
        UILabel *label=[[UILabel alloc] init];
        
        
        label.frame=CGRectMake(20, 15, 40, 20);
        label.textColor=ZCColor(208, 210, 212);
        [tempview addSubview:label];
        
        if (i==0) {
            imageView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jstj_xintianwen"]];
            label.text=@"信天翁";
            label.font=[UIFont systemFontOfSize:10];
            
        }else if (i==1)
        {
            imageView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jstj_laoying"]];
            label.text=@"老鹰";
            label.font=[UIFont systemFontOfSize:10];
            
        }else if (i==2)
        {
            imageView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jstj_xiaoniao"]];
            label.text=@"小鸟";
            label.font=[UIFont systemFontOfSize:10];
            
        }else if (i==3)
        {
            imageView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jstj_biaozhungan"]];
            label.text=@"标准";
            label.font=[UIFont systemFontOfSize:10];
        }else if(i==4)
        {
            imageView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jstj_boji"]];
            label.text=@"柏忌";
            label.font=[UIFont systemFontOfSize:10];
        }else if (i==5)
        {
            imageView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jstj_shuangboji"]];
            label.text=@"双柏忌+";
            label.font=[UIFont systemFontOfSize:10];
        }
        
        
        
    }
    
    
}

//成绩页面内容
-(void)resultsViewContent
{
    // 0.总列数(一行最多3列)
    int totalColumns = 2;
    
    // 1.数字的尺寸
    CGFloat appW = (self.resultsView.frame.size.width-0)/2;
    CGFloat appH = (self.resultsView.frame.size.height-0)/2;
    
    // 2.间隙 = (控制器view的宽度 - 3 * 应用宽度) / 4
    //CGFloat marginX = (self.view.frame.size.width - totalColumns * appW) / (totalColumns + 1);  jstj_chengji_zjx
    CGFloat marginX = 0;
    CGFloat marginY = 0;
    
    for (int index=0; index<4; index++) {
        
        UIView *resultsView1=[[UIView alloc] init];
        
        // 3.2.计算框框的位置
        // 计算行号和列号
        int row = index / totalColumns;
        int col = index % totalColumns;
        // 计算x和y
        CGFloat appX = marginX + col * (appW + marginX);
        CGFloat appY = row * (appH + marginY);
        // 设置frame
        resultsView1.frame = CGRectMake(appX, appY, appW, appH);
        [self.resultsView addSubview:resultsView1];
        
        //创建2个view   一个放显示内容一个放1像素的背景
        UIView *resultsView2=[[UIView alloc] init];
        resultsView2.frame=CGRectMake(0, 0, resultsView1.frame.size.width-1, resultsView1.frame.size.height);
        [resultsView1 addSubview:resultsView2];
        //1像素的背景
        UIView *bjView=[[UIView alloc] init];
        bjView.frame=CGRectMake(resultsView1.frame.size.width-1, 0, 1, resultsView1.frame.size.height);
        bjView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jstj_chengji_zjx"]];
        [resultsView1 addSubview:bjView];
        
        UILabel *resultsLabel1=[[UILabel alloc] init];
        resultsLabel1.frame=CGRectMake((resultsView2.frame.size.width-70)/2,(resultsView2.frame.size.height-20*2)/3 , 70, 20);
        resultsLabel1.textAlignment=NSTextAlignmentCenter;
        resultsLabel1.textColor=ZCColor(37, 176, 101);
        [resultsView2 addSubview:resultsLabel1];
        
        
        //创建下面文字
        UILabel *resultsLabel2=[[UILabel alloc] init];
        resultsLabel2.frame=CGRectMake((resultsView2.frame.size.width-70)/2,resultsLabel1.frame.size.height+resultsLabel1.frame.origin.y+5 , 70, 20);
        resultsLabel2.textAlignment=NSTextAlignmentCenter;
        resultsLabel2.textColor=ZCColor(121, 121, 121);
        [resultsView2 addSubview:resultsLabel2];
        
        
        
        
        //给每个内容赋值
        if (index==0) {
            resultsLabel1.text=[NSString stringWithFormat:@"%@",self.totalModel[@"score"]];
            resultsLabel2.text=@"成绩";
        }else if (index==1)
        {
            resultsLabel1.text=[NSString stringWithFormat:@"%@",self.totalModel[@"net"]];
            resultsLabel2.text=@"净杆";
            
        }else if (index==2)
        {
            resultsLabel1.text=[NSString stringWithFormat:@"%@",self.totalModel[@"putts"]];
            resultsLabel2.text=@"推杆";
            
            
        }else
        {
            resultsLabel1.text=[NSString stringWithFormat:@"%@",self.totalModel[@"penalties"]];
            resultsLabel2.text=@"罚杆";
            
            
        }
        
    }
}

-(void)piecewiseViewViewContent
{
    UILabel *nameLabel=[[UILabel alloc] init];
    CGFloat nameLabelX=20;
    CGFloat nameLabelY=10;
    CGFloat nameLabelW=80;
    CGFloat nameLabelH=20;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.text=@"分段成绩";
    [self.piecewiseView addSubview:nameLabel];
    
    UIView *downView=[[UIView alloc] init];
    CGFloat downViewX=0;
    CGFloat downViewY=nameLabelY+nameLabelH+10;
    CGFloat downViewW=SCREEN_WIDTH;
    CGFloat downViewH=80;
    downView.frame=CGRectMake(downViewX, downViewY, downViewW, downViewH);
    [self.piecewiseView addSubview:downView];
    
    // 0.总列数(一行最多3列)
    int totalColumns = 3;
    
    // 1.数字的尺寸
    CGFloat appW = downViewW/3;
    CGFloat appH = downViewH;
    
    // 2.间隙 = (控制器view的宽度 - 3 * 应用宽度) / 4
    //CGFloat marginX = (self.view.frame.size.width - totalColumns * appW) / (totalColumns + 1);  jstj_chengji_zjx
    CGFloat marginX = 0;
    CGFloat marginY = 0;
    
    for (int index=0; index<3; index++) {
        
        UIView *resultsView1=[[UIView alloc] init];
        
        // 3.2.计算框框的位置
        // 计算行号和列号
        int row = index / totalColumns;
        int col = index % totalColumns;
        // 计算x和y
        CGFloat appX = marginX + col * (appW + marginX);
        CGFloat appY = row * (appH + marginY);
        // 设置frame
        resultsView1.frame = CGRectMake(appX, appY, appW, appH);
        [downView addSubview:resultsView1];
        
        //创建2个view   一个放显示内容一个放1像素的背景
        UIView *resultsView2=[[UIView alloc] init];
        resultsView2.frame=CGRectMake(0, 0, resultsView1.frame.size.width-1, resultsView1.frame.size.height);
        [resultsView1 addSubview:resultsView2];
        //1像素的背景
        UIView *bjView=[[UIView alloc] init];
        bjView.frame=CGRectMake(resultsView1.frame.size.width-1, 0, 1, resultsView1.frame.size.height);
        bjView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jstj_chengji_zjx"]];
        [resultsView1 addSubview:bjView];
        
        UILabel *resultsLabel1=[[UILabel alloc] init];
        resultsLabel1.frame=CGRectMake((resultsView2.frame.size.width-70)/2,(resultsView2.frame.size.height-20*2)/3 , 70, 20);
        resultsLabel1.textAlignment=NSTextAlignmentCenter;
        resultsLabel1.textColor=ZCColor(37, 176, 101);
        [resultsView2 addSubview:resultsLabel1];
        
        
        //创建下面文字
        UILabel *resultsLabel2=[[UILabel alloc] init];
        resultsLabel2.frame=CGRectMake((resultsView2.frame.size.width-70)/2,resultsLabel1.frame.size.height+resultsLabel1.frame.origin.y+5 , 70, 20);
        resultsLabel2.textAlignment=NSTextAlignmentCenter;
        resultsLabel2.textColor=ZCColor(121, 121, 121);
        [resultsView2 addSubview:resultsLabel2];
        
        
        
        //给每个内容赋值
        if (index==0) {
            resultsLabel1.text=[NSString stringWithFormat:@"%@",self.totalModel[@"front_6_score"]];
            resultsLabel2.text=@"前六";
        }else if (index==1)
        {
            resultsLabel1.text=[NSString stringWithFormat:@"%@",self.totalModel[@"middle_6_score"]];
            resultsLabel2.text=@"中六";
            
        }else if (index==2)
        {
            resultsLabel1.text=[NSString stringWithFormat:@"%@",self.totalModel[@"last_6_score"]];
            resultsLabel2.text=@"后六";
            
            
        }

        

    }

}



//视图消失时调用

-(void)viewWillDisappear:(BOOL)animated
{
    
    AppDelegate *app=  (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app setAllowRotation:NO];
    
    //强制竖屏
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIDeviceOrientationPortrait;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
    
    
    
    //[self.startButton removeFromSuperview];
}

-(void)viewWillAppear:(BOOL)animated
{
    AppDelegate *app=  (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app setAllowRotation:YES];
    
}



- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        
        ZCLog(@"---%f",SCREEN_WIDTH);
        self.verticalScreenView.hidden=YES;
        self.landscapeView.hidden=NO;
        
        //         if (self.landscapeView==nil) {
        //             ZCAmateurStatisticsView *landscapeView=[[ZCAmateurStatisticsView alloc] init];
        //             [self.view addSubview:landscapeView];
        //             self.landscapeView=landscapeView;
        //
        //         }else
        //         {
        //             [self.landscapeView removeFromSuperview];
        //
        //             ZCAmateurStatisticsView *landscapeView=[[ZCAmateurStatisticsView alloc] init];
        //             [self.view addSubview:landscapeView];
        //             self.landscapeView=landscapeView;
        //
        //
        //         }
        //
        //
        
        
        
        
    }else if (toInterfaceOrientation == UIInterfaceOrientationPortrait)
    {
        self.verticalScreenView.hidden=NO;
        self.landscapeView.hidden=YES;
        NSLog(@"书屏将要旋转了?");
        
    }
    
    
    ZCLog(@"%ld",toInterfaceOrientation);
    
    
    
    
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    NSLog(@"如果让我旋转,我已经旋转完了!");
    
    
    
    
    
    
    if ([[UIDevice currentDevice]orientation] == UIInterfaceOrientationLandscapeLeft||[[UIDevice currentDevice]orientation] == UIInterfaceOrientationLandscapeRight){
        
        [self supportedInterfaceOrientations];
        
        
        //
        //        self.verticalScreenView.hidden=YES;
        //        self.landscapeView.hidden=NO;
        
        if (self.landscapeView==nil) {
            ZCProfessionalLandscape *landscapeView=[[ZCProfessionalLandscape alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
           
            [self.view addSubview:landscapeView];
            //传值
            landscapeView.professionalScorecardModel=self.professionalScorecardModel;
            landscapeView.totalModel=self.totalModel;
            
            self.landscapeView=landscapeView;
            
        }else
        {
            [self.landscapeView removeFromSuperview];
            
            ZCProfessionalLandscape *landscapeView=[[ZCProfessionalLandscape alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            
            
            //传值
            landscapeView.professionalScorecardModel=self.professionalScorecardModel;
            landscapeView.totalModel=self.totalModel;

            [self.view addSubview:landscapeView];
            
            self.landscapeView=landscapeView;
            
            
            
        }
        
        
        
        
    }
    if ([[UIDevice currentDevice]orientation] == UIInterfaceOrientationPortrait){
        [self supportedInterfaceOrientations];
        
                      self.verticalScreenView.hidden=NO;
                       self.landscapeView.hidden=YES;
        
        
    }
    
    
    
    // ZCLog(@"%f",self.view.frame.size.width);
    
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
