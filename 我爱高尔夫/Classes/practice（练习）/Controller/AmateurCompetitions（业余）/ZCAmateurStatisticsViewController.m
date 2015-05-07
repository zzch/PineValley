//
//  ZCAmateurStatisticsViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/3/12.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCAmateurStatisticsViewController.h"
#import "AppDelegate.h"
#import "ZCAmateurStatisticsView.h"
#import "ZCAccount.h"
#import "AFNetworking.h"
#import "ZCStatisticalScorecard.h"
#import "ZCStatistical.h"
#import "ZCEventUuidTool.h"
#import "UIBarButtonItem+DC.h"
#import "MBProgressHUD+NJ.h"
//#define UIDeviceOrientationIsPortrait(orientation)  ((orientation) == UIDeviceOrientationPortrait || (orientation) == UIDeviceOrientationPortraitUpsideDown)
//#define UIDeviceOrientationIsLandscape(orientation) ((orientation) == UIDeviceOrientationLandscapeLeft || (orientation) == UIDeviceOrientationLandscapeRight)
//


@interface ZCAmateurStatisticsViewController ()
//竖屏的View
@property(nonatomic,weak)UIView *verticalScreenView;
//横屏的View
@property(nonatomic,weak)ZCAmateurStatisticsView *landscapeView;
@property(nonatomic,weak)UIScrollView *scrollView;
@property(nonatomic,weak)UIScrollView *scoringScrollView;
@property(nonatomic,weak)UIView *nameScoringScrollView;
@property(nonatomic,weak)UIView *beforeScoringView;
@property(nonatomic,weak)UIView *afterScoringView;
//注释界面的View
@property(nonatomic,weak)UIView *annotationView;
//成绩界面的View
@property(nonatomic,weak)UIView *resultsView;
//成功率界面的View
@property(nonatomic,weak)UIView *successRateView;
//平均分界面的View
@property(nonatomic,weak)UIView *averageView;
//球成绩界面的View  ball scores
@property(nonatomic,weak)UIView *ballScoresView;
//模型数据
@property(nonatomic,strong)ZCStatistical *statistical;
@end

@implementation ZCAmateurStatisticsViewController





- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"suoyou_bj_02"]];
    
    
    
    
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    customLab.textAlignment=NSTextAlignmentCenter;
    [customLab setTextColor:ZCColor(240, 208, 122)];
    [customLab setText:@"统计"];
    customLab.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = customLab;
    
    
    
    // 修改返回按钮
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barBtnItemWithNormalImageName:@"fanhui" hightImageName:@"fanhui-anxia" action:@selector(liftBthClick:) target:self];
    

    
    
    
    [MBProgressHUD showMessage:@"加载中..."];
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    
    ZCEventUuidTool *tool=[ZCEventUuidTool sharedEventUuidTool];
    //tool.uuid=@"923e4a1c-3731-4d8a-8807-3c84bf813088";
    
    params[@"match_uuid"]=tool.uuid;
    
    params[@"token"]=account.token;
    
    ///GET GET /v1/statistics/show.json
    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"matches/practice/statistics/simple"];
    
    mgr.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"text/plain",@"application/xhtml+xml",@"application/xml",@"application/json", nil];
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        //ZCLog(@"%@",responseObject);
        
        ZCStatistical *statistical=[ZCStatistical statisticalWithDict:responseObject];
//        ZCLog(@"%@",statistical.score);
//        ZCLog(@"%@",statistical.scorecards.par);
//
        
        self.statistical=statistical;
       //隐藏
        [MBProgressHUD hideHUD];
        
        
        if ([[UIDevice currentDevice]orientation] == UIInterfaceOrientationLandscapeLeft){
            
            [self supportedInterfaceOrientations];
            
            self.verticalScreenView.hidden=YES;
            self.landscapeView.hidden=NO;
            
            ZCAmateurStatisticsView *landscapeView=[[ZCAmateurStatisticsView alloc] init];
            [self.view addSubview:landscapeView];
            self.landscapeView=landscapeView;
            
            ZCLog(@"landscape left");
        }
        if ([[UIDevice currentDevice]orientation] == UIInterfaceOrientationLandscapeRight){
            [self supportedInterfaceOrientations];
            self.verticalScreenView.hidden=YES;
            self.landscapeView.hidden=NO;
            
            
            ZCAmateurStatisticsView *landscapeView=[[ZCAmateurStatisticsView alloc] init];
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
        
        
        

        
        
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ZCLog(@"%@",error);
        //隐藏
        [MBProgressHUD hideHUD];
        
    }];
      //    scrollView.backgroundColor=[UIColor redColor];
    
    
    // 增加额外的滚动区域(在顶部增加64的区域,在底部增加44的区域)
   // self.scrollView.contentInset = UIEdgeInsetsMake(64, 0, 44, 0);
    // 设置一开始的滚动位置(往下滚动64)
    //self.scrollView.contentOffset = CGPointMake(0, -64);

//    UILabel *lab=[[UILabel alloc] init];
//    lab.backgroundColor=[UIColor redColor];
//    lab.frame=CGRectMake(100, 100, 200, 200);
//    lab.text=@"asdasdasd";
//    [self.scrollView addSubview:lab];
//    
    
    
    
//    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
//    ZCLog(@"-----%ld",interfaceOrientation);
//    if (interfaceOrientation==1) {
//        ZCLog(@"-----%ld",interfaceOrientation);
//    }else if (interfaceOrientation==3 &&interfaceOrientation==4)
//    {
//     ZCLog(@"-----2");
//    }
    
//    
//    if ([[UIDevicecurrentDevice]orientation]==UIDeviceOrientationLandscapeRight ) {
//        ZCLog(@"像右转啦");
//        
//    }
    
//    ZCLog(@"%@",[[UIDevicecurrentDevice]orientation]);
    
    
    
    
    
    
}


//返回到上个界面
-(void)liftBthClick:(UIButton *)bth
{
    [self.navigationController popViewControllerAnimated:YES];
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
    nameLabel.text=@"球场信息统计";
    nameLabel.textColor=ZCColor(240, 208, 122);
    nameLabel.font=[UIFont systemFontOfSize:22];
    [nameView addSubview:nameLabel];
    //时间
    UILabel *timeLabel=[[UILabel alloc] init];
    CGFloat timeLabelX=10;
    CGFloat timeLabelY=nameLabelY+nameLabelH+10;
    CGFloat timeLabelW=SCREEN_WIDTH*0.4;
    CGFloat timeLabelH=20;

    timeLabel.frame=CGRectMake(timeLabelX, timeLabelY, timeLabelW, timeLabelH);
    //timeLabel.text=@"2015年2月13号";
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
    CGFloat nameScoringScrollViewH=201;

    nameScoringScrollView.frame=CGRectMake(nameScoringScrollViewX, nameScoringScrollViewY, nameScoringScrollViewW, nameScoringScrollViewH);
    nameScoringScrollView.backgroundColor=ZCColor(136, 119, 73);
    //nameScoringScrollView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"suoyou_bj_02"]];
    [self.scrollView addSubview:nameScoringScrollView];
    
    self.nameScoringScrollView=nameScoringScrollView;
    
    
    
    // 0.总列数(一行最多3列)
    int totalColumns = 1;
    
    // 1.数字的尺寸
    CGFloat appW = (self.nameScoringScrollView.frame.size.width-0)/1;
    CGFloat appH = (self.nameScoringScrollView.frame.size.height-5)/4;
    
    // 2.间隙 = (控制器view的宽度 - 3 * 应用宽度) / 4
    //CGFloat marginX = (self.view.frame.size.width - totalColumns * appW) / (totalColumns + 1);
    CGFloat marginX = 0;
    CGFloat marginY = 1;
    
    for (int index=0; index<4; index++) {
        UILabel *labelView=[[UILabel alloc] init];
        // 3.2.计算框框的位置
        // 计算行号和列号
        int row = index / totalColumns;
        int col = index % totalColumns;
        // 计算x和y
        CGFloat appX = marginX + col * (appW + marginX);
        CGFloat appY = row * (appH + marginY)+marginY;
        // 设置frame
        labelView.frame = CGRectMake(appX, appY, appW, appH);
        labelView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"suoyou_bj_02"]];
        //holesResult.textColor=ZCColor(208, 210, 212);
       // [self.beforeScoringView addSubview:labelView];
        
        labelView.textColor=ZCColor(240, 208, 122);
        labelView.font=[UIFont systemFontOfSize:15];
        labelView.textAlignment=NSTextAlignmentCenter;
        //        nameScoringView.font=[UIFont font]
        
        [self.nameScoringScrollView addSubview:labelView];
        
        
        if (index==0) {
            labelView.text=@"洞";
        }else if (index==1)
        {
            labelView.text=@"标准杆";
        }else if (index==2)
        {
            labelView.text=@"成绩";
        }else
        {
            labelView.text=@"距标准杆";
            
        }

  
    
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
    beforeScoringView.backgroundColor=ZCColor(136, 119, 73);
    //beforeScoringView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jstj_yihangbeijing"]];
    [self.scoringScrollView addSubview:beforeScoringView];
    
    self.beforeScoringView=beforeScoringView;
    [self addForBeforeScoringView];
   
    
    
    //后九洞的view
    UIView *afterScoringView=[[UIView alloc] initWithFrame:CGRectMake(beforeScoringView.frame.size.width, 0, scoringScrollView.frame.size.width, scoringScrollView.frame.size.height)];
    
    afterScoringView.backgroundColor=ZCColor(136, 119, 73);
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
   annotationView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"suoyou_bj_02"]];
    self.annotationView=annotationView;
    //注释界面里面的内容
    [self annotationContent];
    
    //添加成绩的view
    UIView *resultsView=[[UIView alloc] init];
    CGFloat resultsViewX=annotationViewX;
    CGFloat resultsViewY=annotationViewY+annotationViewH+15;
    CGFloat resultsViewW=SCREEN_WIDTH;
    CGFloat resultsViewH=119;

    resultsView.frame=CGRectMake(resultsViewX, resultsViewY, resultsViewW, resultsViewH);
    self.resultsView=resultsView;
    resultsView.backgroundColor=ZCColor(136, 119, 73);
    //resultsView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"suoyou_bj_02"]];
    [self.scrollView addSubview:resultsView];
    //成绩内容
    [self resultsViewContent];
    
    
    //success rate 成功率View
    UIView *successRateView=[[UIView alloc] init];
    successRateView.frame=CGRectMake(0, resultsView.frame.size.height+resultsView.frame.origin.y+15, SCREEN_WIDTH, 393);
    self.successRateView=successRateView;
    successRateView.backgroundColor=ZCColor(136, 119, 73);
    [self.scrollView addSubview:successRateView];

    //成功率View里面的内容
    [self successRateViewContent];
    
    
    // 平均分View
    UIView *averageView=[[UIView alloc] init];
    averageView.frame=CGRectMake(0, successRateView.frame.origin.y+successRateView.frame.size.height+15, SCREEN_WIDTH, 148);
    self.averageView=averageView;
    averageView.backgroundColor=ZCColor(136, 119, 73);
    [self.scrollView addSubview:averageView];

    [self averageViewContent];
    
    
   
    
    // 球成绩界面的View
    UIView *ballScoresView=[[UIView alloc] init];
    ballScoresView.frame=CGRectMake(0, averageView.frame.size.height+averageView.frame.origin.y+15, SCREEN_WIDTH, 295);
    self.ballScoresView=ballScoresView;
    ballScoresView.backgroundColor=ZCColor(136, 119, 73);
    [self.scrollView addSubview:ballScoresView];
    
    [self ballScoresViewContent];

    
    
    
}

//前九洞的view

-(void)addForBeforeScoringView
{
    
    // 0.总列数(一行最多3列)
    int totalColumns = 10;
    
    // 1.数字的尺寸
    CGFloat appW = (self.beforeScoringView.frame.size.width-10)/10;
    CGFloat appH = (self.beforeScoringView.frame.size.height-5)/4;
    
    // 2.间隙 = (控制器view的宽度 - 3 * 应用宽度) / 4
    //CGFloat marginX = (self.view.frame.size.width - totalColumns * appW) / (totalColumns + 1);
    CGFloat marginX = 1;
    CGFloat marginY = 1;

    for (int index=0; index<40; index++) {
        UIView *labelView=[[UIView alloc] init];
         // 3.2.计算框框的位置
        // 计算行号和列号
        int row = index / totalColumns;
        int col = index % totalColumns;
        // 计算x和y
        CGFloat appX = marginX + col * (appW + marginX);
        CGFloat appY = row * (appH + marginY)+marginY;
        // 设置frame
        labelView.frame = CGRectMake(appX, appY, appW, appH);
         labelView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"suoyou_bj_02"]];
        //holesResult.textColor=ZCColor(208, 210, 212);
        [self.beforeScoringView addSubview:labelView];
       // UIView *bjView=[[UIView alloc] init];
        //bjView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"suoyou_bj_02"]];
       // bjView.frame=CGRectMake(0, 0, 1, labelView.frame.size.height);
       // [labelView addSubview:bjView];
        UILabel *holesResult=[[UILabel alloc] init];
        holesResult.frame=CGRectMake(0, 0, labelView.frame.size.width, labelView.frame.size.height);
        holesResult.textColor=ZCColor(240, 208, 122);
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
            ZCStatisticalScorecard *statisticalScorecard=self.statistical.scorecards;
//            ZCLog(@"%@",statisticalScorecard.par);
//            ZCLog(@"%@",self.statistical.scorecards.par);

            holesResult.text=[NSString stringWithFormat:@"%@",statisticalScorecard.par[index-10]];
            
           // holesResult.text=@"as";
        
        }else if (index>=20&&index<30)
       {
          
            //if //([self.statistical.scorecards.score[index-20]==(id)[NSNull null]])
           if ( [self.statistical.scorecards.score[index-20]  isKindOfClass:[NSNull class]]) {
                 holesResult.text=@"";
           }else{
               holesResult.text=[NSString stringWithFormat:@"%@",self.statistical.scorecards.score[index-20]];
           }
          
        }else if(index>=30)
        {
            if ( [self.statistical.scorecards.status[index-30]  isKindOfClass:[NSNull class]]) {
                holesResult.text=@"";
            }else{
           holesResult.text=[NSString stringWithFormat:@"%@",self.statistical.scorecards.status[index-30]];
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
    CGFloat appW = (self.beforeScoringView.frame.size.width-11)/11;
    CGFloat appH = (self.beforeScoringView.frame.size.height-5)/4;
    
    // 2.间隙 = (控制器view的宽度 - 3 * 应用宽度) / 4
    //CGFloat marginX = (self.view.frame.size.width - totalColumns * appW) / (totalColumns + 1);
    CGFloat marginX = 1;
    CGFloat marginY = 1;
    
    for (int index=0; index<44; index++) {
        UILabel *labelView=[[UILabel alloc] init];
        // 3.2.计算框框的位置
        // 计算行号和列号
        int row = index / totalColumns;
        int col = index % totalColumns;
        // 计算x和y
        CGFloat appX = marginX + col * (appW + marginX);
        CGFloat appY = marginX +row * (appH + marginY);
        // 设置frame
        labelView.frame = CGRectMake(appX, appY, appW, appH);
        // holesResult.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jstj_yihangbeijing"]];
        //holesResult.textColor=ZCColor(208, 210, 212);
        [self.afterScoringView addSubview:labelView];
        labelView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"suoyou_bj_02"]];
        labelView.textColor=ZCColor(240, 208, 122);
        labelView.textAlignment=NSTextAlignmentCenter;
        labelView.font=[UIFont systemFontOfSize:14];
//        UIView *bjView=[[UIView alloc] init];
//        bjView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jstj_shutiao"]];
//        bjView.frame=CGRectMake(0, 0, 1, labelView.frame.size.height);
//        [labelView addSubview:bjView];
//        UILabel *holesResult=[[UILabel alloc] init];
//        holesResult.frame=CGRectMake(1, 0, labelView.frame.size.width-1, labelView.frame.size.height);
//        holesResult.textColor=ZCColor(208, 210, 212);
//        holesResult.textAlignment=NSTextAlignmentCenter;
//        holesResult.font=[UIFont systemFontOfSize:14];
//        [labelView addSubview:holesResult];
        
        if (index<9) {
            labelView.text=[NSString stringWithFormat:@"%d",index+10];
        }else if (index==9)
        {
            labelView.text=@"IN";
            
        }else if(index==10)
        {
            labelView.text=@"TOT";
          
        }else if (index>10&&index<22)
        {
             labelView.text=[NSString stringWithFormat:@"%@",self.statistical.scorecards.par[index-1]];
            
        }else if (index>=22&&index<33)
        {
            if ( [self.statistical.scorecards.score[index-12]  isKindOfClass:[NSNull class]]) {
                labelView.text=@"";
            }else{
                labelView.text=[NSString stringWithFormat:@"%@",self.statistical.scorecards.score[index-12]];
            }

        }else if(index>=33)
        {
            if ( [self.statistical.scorecards.status[index-23]  isKindOfClass:[NSNull class]]) {
                labelView.text=@"";
            }else{
                labelView.text=[NSString stringWithFormat:@"%@",self.statistical.scorecards.status[index-23]];
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
        label.textColor=ZCColor(240, 208, 122);
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
    // 0.总列数(一行最多3列)suoyou_bj_02
    int totalColumns = 2;
    
    // 1.数字的尺寸
    CGFloat appW = (self.resultsView.frame.size.width-0)/2;
    CGFloat appH = (self.resultsView.frame.size.height-3)/2;
    
    // 2.间隙 = (控制器view的宽度 - 3 * 应用宽度) / 4
    //CGFloat marginX = (self.view.frame.size.width - totalColumns * appW) / (totalColumns + 1);  jstj_chengji_zjx
    CGFloat marginX = 0;
    CGFloat marginY = 1;
    
    for (int index=0; index<4; index++) {
        
         UIView *resultsView1=[[UIView alloc] init];
        
        // 3.2.计算框框的位置
        // 计算行号和列号
        int row = index / totalColumns;
        int col = index % totalColumns;
        // 计算x和y
        CGFloat appX = marginX + col * (appW + marginX);
        CGFloat appY = marginY +row * (appH + marginY);
        // 设置frame
        resultsView1.frame = CGRectMake(appX, appY, appW, appH);
        resultsView1.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"suoyou_bj_02"]];
        [self.resultsView addSubview:resultsView1];
        
        //创建2个view   一个放显示内容一个放1像素的背景
        UIView *resultsView2=[[UIView alloc] init];
        resultsView2.frame=CGRectMake(0, 0, resultsView1.frame.size.width-1, resultsView1.frame.size.height);
        [resultsView1 addSubview:resultsView2];
        //1像素的背景
        UIView *bjView=[[UIView alloc] init];
        bjView.frame=CGRectMake(resultsView1.frame.size.width-1, 15, 1, resultsView1.frame.size.height-30);
        bjView.backgroundColor=ZCColor(136, 119, 73);
        [resultsView1 addSubview:bjView];
        
        UILabel *resultsLabel1=[[UILabel alloc] init];
        resultsLabel1.frame=CGRectMake((resultsView2.frame.size.width-70)/2,(resultsView2.frame.size.height-20*2)/3 , 70, 20);
        resultsLabel1.textAlignment=NSTextAlignmentCenter;
        resultsLabel1.textColor=ZCColor(240, 208, 122);
        [resultsView2 addSubview:resultsLabel1];
        
        
        //创建下面文字
        UILabel *resultsLabel2=[[UILabel alloc] init];
        resultsLabel2.frame=CGRectMake((resultsView2.frame.size.width-70)/2,resultsLabel1.frame.size.height+resultsLabel1.frame.origin.y+5 , 70, 20);
        resultsLabel2.textAlignment=NSTextAlignmentCenter;
        resultsLabel2.textColor=ZCColor(136, 119, 73);
        [resultsView2 addSubview:resultsLabel2];
        
        

        
        //给每个内容赋值
        if (index==0) {
            resultsLabel1.text=[NSString stringWithFormat:@"%@",self.statistical.score];
            resultsLabel2.text=@"成绩";
        }else if (index==1)
        {
            resultsLabel1.text=[NSString stringWithFormat:@"%@",self.statistical.net];
            resultsLabel2.text=@"净杆";

        }else if (index==2)
        {
            resultsLabel1.text=[NSString stringWithFormat:@"%@",self.statistical.putts];
            resultsLabel2.text=@"推杆";

        
        }else
        {
            resultsLabel1.text=[NSString stringWithFormat:@"%@",self.statistical.penalties];
            resultsLabel2.text=@"罚杆";
            

        }
        
    }
}


//成功率里面的内容
-(void)successRateViewContent
{
    
    // 0.总列数(一行最多3列)
    int totalColumns = 1;
    
    // 1.数字的尺寸
    CGFloat appW = self.successRateView.frame.size.width;
    CGFloat appH = (self.successRateView.frame.size.height-9)/8;
    
    // 2.间隙 = (控制器view的宽度 - 3 * 应用宽度) / 4
    //CGFloat marginX = (self.view.frame.size.width - totalColumns * appW) / (totalColumns + 1);
    CGFloat marginX = 0;
    CGFloat marginY = 1;
    
    for (int index=0; index<8; index++) {
        UIView *successView=[[UIView alloc] init];
        
        // 3.2.计算框框的位置
        // 计算行号和列号
        int row = index / totalColumns;
        int col = index % totalColumns;
        // 计算x和y
        CGFloat appX = marginX + col * (appW + marginX);
        CGFloat appY = marginY+row * (appH + marginY);
        // 设置frame
        successView.frame = CGRectMake(appX, appY, appW, appH);
        [self.successRateView addSubview:successView];
        successView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"suoyou_bj_02"]];
        
        
        UILabel *successLabel1=[[UILabel alloc] init];
        successLabel1.frame=CGRectMake(10,0 , 200, successView.frame.size.height);
         successLabel1.textColor=ZCColor(240, 208, 122);
        [successView addSubview:successLabel1];
        
        //创建下面文字
        UILabel *successLabel2=[[UILabel alloc] init];
        successLabel2.frame=CGRectMake(successView.frame.size.width-70,0 , 70, successView.frame.size.height);
       successLabel2.textAlignment=NSTextAlignmentRight;
        successLabel2.textColor=ZCColor(240, 208, 122);
        [successView addSubview:successLabel2];
        
        
        
        if (index==0) {
            successLabel1.text=@"开球最远距离";
            successLabel2.text=[NSString stringWithFormat:@"%@码",self.statistical.longest_drive_length];
        }else if (index==1)
        {
            successLabel1.text=@"开球成功率";
            successLabel2.text=[NSString stringWithFormat:@"%@",self.statistical.drive_fairways_hit];
        
        }else if (index==2)
        {
            successLabel1.text=@"标准杆上果岭率";
            successLabel2.text=[NSString stringWithFormat:@"%@",self.statistical.greens_in_regulation];
        }else if (index==3)
        {
            successLabel1.text=@"救球成功率";
            successLabel2.text=[NSString stringWithFormat:@"%@",self.statistical.scrambles];
        }else if (index==4)
        {
            successLabel1.text=@"反弹率";
            successLabel2.text=[NSString stringWithFormat:@"%@",self.statistical.bounce];
        }else if (index==5)
        {
            successLabel1.text=@"标准杆上果岭平均推杆数";
            successLabel2.text=[NSString stringWithFormat:@"%@",self.statistical.putts_per_gir];
        }else if (index==6)
        {
            successLabel1.text=@"优势转化率";
            successLabel2.text=[NSString stringWithFormat:@"%@",self.statistical.advantage_transformation];
        }else if (index==7)
        {
            successLabel1.text=@"平均开球距离";
            successLabel2.text=[NSString stringWithFormat:@"%@",self.statistical.average_drive_length];
        }


        
    }
    
}

//平均分成绩界面内容
-(void)averageViewContent
{
    
    // 0.总列数(一行最多3列)
    int totalColumns = 1;
    
    // 1.数字的尺寸
    CGFloat appW = self.averageView.frame.size.width;
    CGFloat appH = (self.averageView.frame.size.height-4)/3;
    
    // 2.间隙 = (控制器view的宽度 - 3 * 应用宽度) / 4
    //CGFloat marginX = (self.view.frame.size.width - totalColumns * appW) / (totalColumns + 1);
    CGFloat marginX = 0;
    CGFloat marginY = 1;
    
    for (int index=0; index<3; index++) {
        UIView *averageView1=[[UIView alloc] init];
        
        // 3.2.计算框框的位置
        // 计算行号和列号
        int row = index / totalColumns;
        int col = index % totalColumns;
        // 计算x和y
        CGFloat appX = marginX + col * (appW + marginX);
        CGFloat appY = marginY+row * (appH + marginY);
        // 设置frame
        averageView1.frame = CGRectMake(appX, appY, appW, appH);
        [self.averageView addSubview:averageView1];
        averageView1.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"suoyou_bj_02"]];
        
        
        UILabel *averageLabel1=[[UILabel alloc] init];
        averageLabel1.frame=CGRectMake(10,0 , 140, averageView1.frame.size.height);
        
        averageLabel1.textColor=ZCColor(240, 208, 122);
        [averageView1 addSubview:averageLabel1];
        
        
        //创建下面文字
        UILabel *averageLabel2=[[UILabel alloc] init];
        averageLabel2.frame=CGRectMake(averageView1.frame.size.width-70,0 , 70, averageView1.frame.size.height);
        averageLabel2.textColor=ZCColor(240, 208, 122);
        averageLabel2.textAlignment=NSTextAlignmentRight;
        [averageView1 addSubview:averageLabel2];
        
        
        
        
        
        
        if (index==0) {
            averageLabel1.text=@"PAR3平均得分";
            averageLabel2.text=[NSString stringWithFormat:@"%@",self.statistical.score_par_3];
        }else if (index==1)
        {
            averageLabel1.text=@"PAR4平均得分";
            averageLabel2.text=[NSString stringWithFormat:@"%@",self.statistical.score_par_4];
            
        }else if (index==2)
        {
            averageLabel1.text=@"PAR5平均得分";
            averageLabel2.text=[NSString stringWithFormat:@"%@",self.statistical.score_par_5];
        }
    }
   
}
//球成绩界面的View内容
-(void)ballScoresViewContent
{
    
    // 0.总列数(一行最多3列)
    int totalColumns = 1;
    
    // 1.数字的尺寸
    CGFloat appW = self.ballScoresView.frame.size.width;
    CGFloat appH = (self.ballScoresView.frame.size.height-7)/6;
    
    // 2.间隙 = (控制器view的宽度 - 3 * 应用宽度) / 4
    //CGFloat marginX = (self.view.frame.size.width - totalColumns * appW) / (totalColumns + 1);
    CGFloat marginX = 0;
    CGFloat marginY = 1;
    
    for (int index=0; index<6; index++) {
        UIView *ballScoresView1=[[UIView alloc] init];
        
        // 3.2.计算框框的位置
        // 计算行号和列号
        int row = index / totalColumns;
        int col = index % totalColumns;
        // 计算x和y
        CGFloat appX = marginX + col * (appW + marginX);
        CGFloat appY = marginY+row * (appH + marginY);
        // 设置frame
        ballScoresView1.frame = CGRectMake(appX, appY, appW, appH);
        [self.ballScoresView addSubview:ballScoresView1];
      ballScoresView1.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"suoyou_bj_02"]];
        
        
        UILabel *ballScoresLabel1=[[UILabel alloc] init];
        ballScoresLabel1.frame=CGRectMake(10,0 , 140, ballScoresView1.frame.size.height);
       
        ballScoresLabel1.textColor=ZCColor(240, 208, 122);
        [ballScoresView1 addSubview:ballScoresLabel1];
       
        
        //创建下面文字
        UILabel *ballScoresLabel2=[[UILabel alloc] init];
        ballScoresLabel2.frame=CGRectMake(ballScoresView1.frame.size.width-70,0 , 70, ballScoresView1.frame.size.height);
        
        ballScoresLabel2.textColor=ZCColor(240, 208, 122);
        ballScoresLabel2.textAlignment=NSTextAlignmentRight;
        [ballScoresView1 addSubview:ballScoresLabel2];
        
        
        
        
        
        
        if (index==0) {
            ballScoresLabel1.text=@"信天翁球";
            ballScoresLabel2.text=[NSString stringWithFormat:@"%@",self.statistical.double_eagle];
        }else if (index==1)
        {
            ballScoresLabel1.text=@"老鹰球";
            ballScoresLabel2.text=[NSString stringWithFormat:@"%@",self.statistical.eagle];
            
        }else if (index==2)
        {
            ballScoresLabel1.text=@"小鸟球";
            ballScoresLabel2.text=[NSString stringWithFormat:@"%@",self.statistical.birdie];
        }else if (index==3)
        {
            ballScoresLabel1.text=@"标准杆数";
            ballScoresLabel2.text=[NSString stringWithFormat:@"%@",self.statistical.par];
        }else if (index==4)
        {
            ballScoresLabel1.text=@"柏忌数";
            ballScoresLabel2.text=[NSString stringWithFormat:@"%@",self.statistical.bogey];
        }else if (index==5)
        {
            ballScoresLabel1.text=@"双柏忌数";
            ballScoresLabel2.text=[NSString stringWithFormat:@"%@",self.statistical.double_bogey];
        }

    }
    

 self.scrollView.contentSize = CGSizeMake(0, self.ballScoresView.frame.origin.y+self.ballScoresView.frame.size.height+60);
}



////视图销毁时调用
//- (void)dealloc
//{
//    AppDelegate *app=  (AppDelegate *)[UIApplication sharedApplication].delegate;
//    [app setAllowRotation:NO];
//    
//    //强制竖屏
//    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
//        SEL selector = NSSelectorFromString(@"setOrientation:");
//        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
//        [invocation setSelector:selector];
//        [invocation setTarget:[UIDevice currentDevice]];
//        int val = UIDeviceOrientationPortrait;
//        [invocation setArgument:&val atIndex:2];
//        [invocation invoke];
//    }
//    
//    
//
//
//}
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


//- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
//    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
//}
//
//- (NSUInteger)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskLandscapeRight;
//}
//// 支持设备自动旋转
//- (BOOL)shouldAutorotate
//{
//    return YES;
//}
//
// 支持横竖屏显示
//- (NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskAll;
//}



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
           ZCAmateurStatisticsView *landscapeView=[[ZCAmateurStatisticsView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            
//            ZCAmateurStatisticsView *landscapeView=[ZCAmateurStatisticsView amateurStatisticsView:self.statistical];
            [self.view addSubview:landscapeView];
            //传值
            landscapeView.statistical=self.statistical;

           self.landscapeView=landscapeView;
           
        }else
        {
            [self.landscapeView removeFromSuperview];

            ZCAmateurStatisticsView *landscapeView=[[ZCAmateurStatisticsView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];

            
            //传值
           landscapeView.statistical=self.statistical;
         [self.view addSubview:landscapeView];
            
          self.landscapeView=landscapeView;
          
            
            
 }
        

        
        
           }
    if ([[UIDevice currentDevice]orientation] == UIInterfaceOrientationPortrait){
        [self supportedInterfaceOrientations];
        
//               self.verticalScreenView.hidden=NO;
//               self.landscapeView.hidden=YES;
        
        
    }

    
    
   // ZCLog(@"%f",self.view.frame.size.width);
    
}



//横屏view
-(void)landscapeViewContent
{
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
