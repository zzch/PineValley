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
    self.view.backgroundColor=[UIColor whiteColor];
    
   
    
   
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    
    ZCEventUuidTool *tool=[ZCEventUuidTool sharedEventUuidTool];
    //tool.uuid=@"923e4a1c-3731-4d8a-8807-3c84bf813088";
    
    params[@"match_uuid"]=tool.uuid;
    
    params[@"token"]=account.token;
    ZCLog(@"%@",account.token);
    ///GET GET /v1/statistics/show.json
    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"matches/practice/statistics/simple"];
    
    mgr.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"text/plain",@"application/xhtml+xml",@"application/xml",@"application/json", nil];
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        ZCLog(@"%@",responseObject);
        
        ZCStatistical *statistical=[ZCStatistical statisticalWithDict:responseObject];
//        ZCLog(@"%@",statistical.score);
//        ZCLog(@"%@",statistical.scorecards.par);
//
        
        self.statistical=statistical;
        ZCLog(@"先执行吗");
        
        
        
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

//竖屏添加控件
-(void)addControls
{
    
    UIScrollView *scrollView=[[UIScrollView alloc] init];
    scrollView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    //scrollView.frame=  [ UIScreen mainScreen ].bounds ;
    self.scrollView=scrollView;
    [self.verticalScreenView addSubview:scrollView];

    // 增加额外的滚动区域(在顶部增加64的区域,在底部增加44的区域)
     self.scrollView.contentInset = UIEdgeInsetsMake(64, 0, 10, 0);
    
    // 设置一开始的滚动位置(往下滚动64)
    //self.scrollView.contentOffset = CGPointMake(0, -164);
    
    UILabel *nameLabel=[[UILabel alloc] init];
    nameLabel.frame=CGRectMake(20, 20, 130, 30);
    nameLabel.text=@"北京高尔夫球场";
    [self.scrollView addSubview:nameLabel];
    //时间
    UILabel *timeLabel=[[UILabel alloc] init];
    timeLabel.frame=CGRectMake(20, 60, 130, 30);
    timeLabel.text=@"2015年2月13号";
    [self.scrollView addSubview:timeLabel];
    //前九洞
    UIButton *beforeButton=[[UIButton alloc] init];
    beforeButton.backgroundColor=[UIColor redColor];
    beforeButton.frame=CGRectMake(SCREEN_WIDTH-(SCREEN_WIDTH-200), 30, 60, 40);
    [beforeButton setTitle:@"前九洞" forState:UIControlStateNormal];
    [self.scrollView addSubview:beforeButton];
    //后九洞
    UIButton *afterButton=[[UIButton alloc] init];
    afterButton.backgroundColor=[UIColor redColor];
    afterButton.frame=CGRectMake(SCREEN_WIDTH-(SCREEN_WIDTH-260), 30, 60, 40);
    [afterButton setTitle:@"后九洞" forState:UIControlStateNormal];
    [self.scrollView addSubview:afterButton];
    //计分页面前的名称
    UIView *nameScoringScrollView=[[UIView alloc] init];
    nameScoringScrollView.frame=CGRectMake(0, 80, 70, 250);
    [self.scrollView addSubview:nameScoringScrollView];
    self.nameScoringScrollView=nameScoringScrollView;
    for (int i=0; i<4; i++) {
        UILabel *nameScoringView=[[UILabel alloc] init];
        nameScoringView.frame=CGRectMake(0, i*(self.nameScoringScrollView.frame.size.height/4), self.nameScoringScrollView.frame.size.width, self.nameScoringScrollView.frame.size.height/4);
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
        nameScoringView.backgroundColor=[UIColor redColor];
        [self.nameScoringScrollView addSubview:nameScoringView];
    }
    
    //计分的ScrollView
    UIScrollView *scoringScrollView=[[UIScrollView alloc] init];
    scoringScrollView.frame=CGRectMake(70, 80, SCREEN_WIDTH-70, 250);
    [self.scrollView addSubview:scoringScrollView];
    self.scoringScrollView=scoringScrollView;
    //滚动的区域
    self.scoringScrollView.contentSize=CGSizeMake(2*(SCREEN_WIDTH-70), 0);
    //前九洞的view
    UIView *beforeScoringView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, scoringScrollView.frame.size.width, 250)];
    beforeScoringView.backgroundColor=[UIColor whiteColor];
    [self.scoringScrollView addSubview:beforeScoringView];
    
    self.beforeScoringView=beforeScoringView;
    [self addForBeforeScoringView];
   
    
    
    //后九洞的view
    UIView *afterScoringView=[[UIView alloc] initWithFrame:CGRectMake(scoringScrollView.frame.size.width, 0, scoringScrollView.frame.size.width, 250)];
    afterScoringView.backgroundColor=[UIColor blueColor];
    [self.scoringScrollView addSubview:afterScoringView];
    self.afterScoringView=afterScoringView;
    //添加后九的显示值
    [self addForAfterScoringView];
   
    
    
    //添加注释界面
    UIView *annotationView=[[UIView alloc] init];
    
    annotationView.frame=CGRectMake(0, 340, SCREEN_WIDTH, 40);
    [self.scrollView addSubview:annotationView];
    annotationView.backgroundColor=[UIColor redColor];
    self.annotationView=annotationView;
    //注释界面里面的内容
    [self annotationContent];
    
    //添加成绩的view
    UIView *resultsView=[[UIView alloc] init];
    resultsView.frame=CGRectMake(0, 390, SCREEN_WIDTH, 150);
    self.resultsView=resultsView;
    resultsView.backgroundColor=[UIColor blueColor];
    [self.scrollView addSubview:resultsView];
    //成绩内容
    [self resultsViewContent];
    
    
    //success rate 成功率View
    UIView *successRateView=[[UIView alloc] init];
    successRateView.frame=CGRectMake(0, 560, SCREEN_WIDTH, 400);
    self.successRateView=successRateView;
    successRateView.backgroundColor=[UIColor blueColor];
    [self.scrollView addSubview:successRateView];

    //成功率View里面的内容
    [self successRateViewContent];
    
    
    // 平均分View
    UIView *averageView=[[UIView alloc] init];
    averageView.frame=CGRectMake(0, 980, SCREEN_WIDTH, 150);
    self.averageView=averageView;
    averageView.backgroundColor=[UIColor blueColor];
    [self.scrollView addSubview:averageView];

    [self averageViewContent];
    
    
   
    
    // 球成绩界面的View
    UIView *ballScoresView=[[UIView alloc] init];
    ballScoresView.frame=CGRectMake(0, 1150, SCREEN_WIDTH, 350);
    self.ballScoresView=ballScoresView;
    ballScoresView.backgroundColor=[UIColor blueColor];
    [self.scrollView addSubview:ballScoresView];
    
    [self ballScoresViewContent];

    
    
    
}

//前九洞的view

-(void)addForBeforeScoringView
{
    
    // 0.总列数(一行最多3列)
    int totalColumns = 10;
    
    // 1.数字的尺寸
    CGFloat appW = (self.beforeScoringView.frame.size.width-20)/10;
    CGFloat appH = (self.beforeScoringView.frame.size.height-8)/4;
    
    // 2.间隙 = (控制器view的宽度 - 3 * 应用宽度) / 4
    //CGFloat marginX = (self.view.frame.size.width - totalColumns * appW) / (totalColumns + 1);
    CGFloat marginX = 2;
    CGFloat marginY = 2;

    for (int index=0; index<40; index++) {
        UILabel *holesResult=[[UILabel alloc] init];
        
        // 3.2.计算框框的位置
        // 计算行号和列号
        int row = index / totalColumns;
        int col = index % totalColumns;
        // 计算x和y
        CGFloat appX = marginX + col * (appW + marginX);
        CGFloat appY = row * (appH + marginY);
        // 设置frame
        holesResult.frame = CGRectMake(appX, appY, appW, appH);
        [self.beforeScoringView addSubview:holesResult];
        holesResult.backgroundColor=[UIColor brownColor];
        
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
    CGFloat appW = (self.beforeScoringView.frame.size.width-22)/11;
    CGFloat appH = (self.beforeScoringView.frame.size.height-8)/4;
    
    // 2.间隙 = (控制器view的宽度 - 3 * 应用宽度) / 4
    //CGFloat marginX = (self.view.frame.size.width - totalColumns * appW) / (totalColumns + 1);
    CGFloat marginX = 2;
    CGFloat marginY = 2;
    
    for (int index=0; index<44; index++) {
        UILabel *holesResult=[[UILabel alloc] init];
        
        // 3.2.计算框框的位置
        // 计算行号和列号
        int row = index / totalColumns;
        int col = index % totalColumns;
        // 计算x和y
        CGFloat appX = marginX + col * (appW + marginX);
        CGFloat appY = row * (appH + marginY);
        // 设置frame
        holesResult.frame = CGRectMake(appX, appY, appW, appH);
        [self.afterScoringView addSubview:holesResult];
        holesResult.backgroundColor=[UIColor brownColor];
        
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
             holesResult.text=[NSString stringWithFormat:@"%@",self.statistical.scorecards.par[index-1]];
            
        }else if (index>=22&&index<33)
        {
            if ( [self.statistical.scorecards.score[index-12]  isKindOfClass:[NSNull class]]) {
                holesResult.text=@"";
            }else{
                holesResult.text=[NSString stringWithFormat:@"%@",self.statistical.scorecards.score[index-12]];
            }

        }else if(index>=33)
        {
            if ( [self.statistical.scorecards.status[index-23]  isKindOfClass:[NSNull class]]) {
                holesResult.text=@"";
            }else{
                holesResult.text=[NSString stringWithFormat:@"%@",self.statistical.scorecards.status[index-23]];
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
        
        imageView.frame=CGRectMake(0, 20, 10, 10);
        [tempview addSubview:imageView];
        UILabel *label=[[UILabel alloc] init];
       
        
        label.frame=CGRectMake(20, 15, 40, 20);
        [tempview addSubview:label];
        
        if (i==0) {
            imageView.backgroundColor=[UIColor whiteColor];
            label.text=@"信天翁";
            label.font=[UIFont systemFontOfSize:10];
            
        }else if (i==1)
        {
            imageView.backgroundColor=[UIColor blackColor];
            label.text=@"老鹰";
            label.font=[UIFont systemFontOfSize:10];
        
        }else if (i==2)
        {
            imageView.backgroundColor=[UIColor yellowColor];
            label.text=@"小鸟";
            label.font=[UIFont systemFontOfSize:10];
            
        }else if (i==3)
        {
            imageView.backgroundColor=[UIColor redColor];
            label.text=@"标准";
            label.font=[UIFont systemFontOfSize:10];
        }else if(i==4)
        {
            imageView.backgroundColor=[UIColor yellowColor];
            label.text=@"柏忌";
            label.font=[UIFont systemFontOfSize:10];
        }else if (i==5)
        {
            imageView.backgroundColor=[UIColor brownColor];
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
    CGFloat appW = (self.resultsView.frame.size.width-4)/2;
    CGFloat appH = (self.resultsView.frame.size.height-4)/2;
    
    // 2.间隙 = (控制器view的宽度 - 3 * 应用宽度) / 4
    //CGFloat marginX = (self.view.frame.size.width - totalColumns * appW) / (totalColumns + 1);
    CGFloat marginX = 2;
    CGFloat marginY = 2;
    
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
        resultsView1.backgroundColor=[UIColor brownColor];
        
        
        UILabel *resultsLabel1=[[UILabel alloc] init];
        resultsLabel1.frame=CGRectMake((resultsView1.frame.size.width-70)/2,(resultsView1.frame.size.height-30*2)/3 , 70, 30);
        resultsLabel1.textAlignment=NSTextAlignmentCenter;
        [resultsView1 addSubview:resultsLabel1];
        resultsLabel1.backgroundColor=[UIColor yellowColor];
        
        //创建下面文字
        UILabel *resultsLabel2=[[UILabel alloc] init];
        resultsLabel2.frame=CGRectMake((resultsView1.frame.size.width-70)/2,((resultsView1.frame.size.height-30*2)/3)*2+30 , 70, 30);
        resultsLabel2.textAlignment=NSTextAlignmentCenter;
        [resultsView1 addSubview:resultsLabel2];
        resultsLabel2.backgroundColor=[UIColor yellowColor];
        

        
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
    CGFloat appH = (self.successRateView.frame.size.height-14)/8;
    
    // 2.间隙 = (控制器view的宽度 - 3 * 应用宽度) / 4
    //CGFloat marginX = (self.view.frame.size.width - totalColumns * appW) / (totalColumns + 1);
    CGFloat marginX = 0;
    CGFloat marginY = 2;
    
    for (int index=0; index<8; index++) {
        UIView *successView=[[UIView alloc] init];
        
        // 3.2.计算框框的位置
        // 计算行号和列号
        int row = index / totalColumns;
        int col = index % totalColumns;
        // 计算x和y
        CGFloat appX = marginX + col * (appW + marginX);
        CGFloat appY = row * (appH + marginY);
        // 设置frame
        successView.frame = CGRectMake(appX, appY, appW, appH);
        [self.successRateView addSubview:successView];
        successView.backgroundColor=[UIColor brownColor];
        
        
        UILabel *successLabel1=[[UILabel alloc] init];
        successLabel1.frame=CGRectMake(10,0 , 140, successView.frame.size.height);
        successLabel1.textAlignment=NSTextAlignmentCenter;
        [successView addSubview:successLabel1];
        successLabel1.backgroundColor=[UIColor yellowColor];
        
        //创建下面文字
        UILabel *successLabel2=[[UILabel alloc] init];
        successLabel2.frame=CGRectMake(successView.frame.size.width-70,0 , 70, successView.frame.size.height);
        successLabel2.textAlignment=NSTextAlignmentCenter;
        [successView addSubview:successLabel2];
        successLabel2.backgroundColor=[UIColor yellowColor];
        
        
        if (index==0) {
            successLabel1.text=@"开球距离";
            successLabel2.text=[NSString stringWithFormat:@"%d",index];
        }else if (index==1)
        {
            successLabel1.text=@"开球成功率";
            successLabel2.text=[NSString stringWithFormat:@"%d",index];
        
        }else if (index==2)
        {
            successLabel1.text=@"标准杆上果岭率";
            successLabel2.text=[NSString stringWithFormat:@"%d",index];
        }else if (index==3)
        {
            successLabel1.text=@"救球成功率";
            successLabel2.text=[NSString stringWithFormat:@"%d",index];
        }else if (index==4)
        {
            successLabel1.text=@"反弹率";
            successLabel2.text=[NSString stringWithFormat:@"%d",index];
        }else if (index==5)
        {
            successLabel1.text=@"标准杆上果岭平均推杆数";
            successLabel2.text=[NSString stringWithFormat:@"%d",index];
        }else if (index==6)
        {
            successLabel1.text=@"开球距离";
            successLabel2.text=[NSString stringWithFormat:@"%d",index];
        }else if (index==7)
        {
            successLabel1.text=@"每洞平均推杆数";
            successLabel2.text=[NSString stringWithFormat:@"%d",index];
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
    CGFloat appH = (self.averageView.frame.size.height-6)/3;
    
    // 2.间隙 = (控制器view的宽度 - 3 * 应用宽度) / 4
    //CGFloat marginX = (self.view.frame.size.width - totalColumns * appW) / (totalColumns + 1);
    CGFloat marginX = 0;
    CGFloat marginY = 2;
    
    for (int index=0; index<3; index++) {
        UIView *averageView1=[[UIView alloc] init];
        
        // 3.2.计算框框的位置
        // 计算行号和列号
        int row = index / totalColumns;
        int col = index % totalColumns;
        // 计算x和y
        CGFloat appX = marginX + col * (appW + marginX);
        CGFloat appY = row * (appH + marginY);
        // 设置frame
        averageView1.frame = CGRectMake(appX, appY, appW, appH);
        [self.averageView addSubview:averageView1];
        averageView1.backgroundColor=[UIColor brownColor];
        
        
        UILabel *averageLabel1=[[UILabel alloc] init];
        averageLabel1.frame=CGRectMake(10,0 , 140, averageView1.frame.size.height);
        averageLabel1.textAlignment=NSTextAlignmentCenter;
        [averageView1 addSubview:averageLabel1];
        averageLabel1.backgroundColor=[UIColor yellowColor];
        
        //创建下面文字
        UILabel *averageLabel2=[[UILabel alloc] init];
        averageLabel2.frame=CGRectMake(averageView1.frame.size.width-70,0 , 70, averageView1.frame.size.height);
        averageLabel2.textAlignment=NSTextAlignmentCenter;
        [averageView1 addSubview:averageLabel2];
        averageLabel2.backgroundColor=[UIColor yellowColor];
        
        
        
        
        
        if (index==0) {
            averageLabel1.text=@"PAR3平均得分";
            averageLabel2.text=[NSString stringWithFormat:@"%d",index];
        }else if (index==1)
        {
            averageLabel1.text=@"PAR4平均得分";
            averageLabel2.text=[NSString stringWithFormat:@"%d",index];
            
        }else if (index==2)
        {
            averageLabel1.text=@"PAR5平均得分";
            averageLabel2.text=[NSString stringWithFormat:@"%d",index];
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
    CGFloat appH = (self.ballScoresView.frame.size.height-14)/7;
    
    // 2.间隙 = (控制器view的宽度 - 3 * 应用宽度) / 4
    //CGFloat marginX = (self.view.frame.size.width - totalColumns * appW) / (totalColumns + 1);
    CGFloat marginX = 0;
    CGFloat marginY = 2;
    
    for (int index=0; index<7; index++) {
        UIView *ballScoresView1=[[UIView alloc] init];
        
        // 3.2.计算框框的位置
        // 计算行号和列号
        int row = index / totalColumns;
        int col = index % totalColumns;
        // 计算x和y
        CGFloat appX = marginX + col * (appW + marginX);
        CGFloat appY = row * (appH + marginY);
        // 设置frame
        ballScoresView1.frame = CGRectMake(appX, appY, appW, appH);
        [self.ballScoresView addSubview:ballScoresView1];
        ballScoresView1.backgroundColor=[UIColor brownColor];
        
        
        UILabel *ballScoresLabel1=[[UILabel alloc] init];
        ballScoresLabel1.frame=CGRectMake(10,0 , 140, ballScoresView1.frame.size.height);
        ballScoresLabel1.textAlignment=NSTextAlignmentCenter;
        [ballScoresView1 addSubview:ballScoresLabel1];
        ballScoresLabel1.backgroundColor=[UIColor yellowColor];
        
        //创建下面文字
        UILabel *ballScoresLabel2=[[UILabel alloc] init];
        ballScoresLabel2.frame=CGRectMake(ballScoresView1.frame.size.width-70,0 , 70, ballScoresView1.frame.size.height);
        ballScoresLabel2.textAlignment=NSTextAlignmentCenter;
        [ballScoresView1 addSubview:ballScoresLabel2];
        ballScoresLabel2.backgroundColor=[UIColor yellowColor];
        
        
        
        
        
        if (index==0) {
            ballScoresLabel1.text=@"信天翁球";
            ballScoresLabel2.text=[NSString stringWithFormat:@"%d",index];
        }else if (index==1)
        {
            ballScoresLabel1.text=@"老鹰球";
            ballScoresLabel2.text=[NSString stringWithFormat:@"%d",index];
            
        }else if (index==2)
        {
            ballScoresLabel1.text=@"小鸟球";
            ballScoresLabel2.text=[NSString stringWithFormat:@"%d",index];
        }else if (index==3)
        {
            ballScoresLabel1.text=@"标准杆数";
            ballScoresLabel2.text=[NSString stringWithFormat:@"%d",index];
        }else if (index==4)
        {
            ballScoresLabel1.text=@"柏忌数";
            ballScoresLabel2.text=[NSString stringWithFormat:@"%d",index];
        }else if (index==5)
        {
            ballScoresLabel1.text=@"双柏忌数";
            ballScoresLabel2.text=[NSString stringWithFormat:@"%d",index];
        }else if (index==6)
        {
            ballScoresLabel1.text=@"三柏忌数及以上";
            ballScoresLabel2.text=[NSString stringWithFormat:@"%d",index];
        }
        

    }
    

 self.scrollView.contentSize = CGSizeMake(0, self.ballScoresView.frame.origin.y+360);
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
//            
//           //landscapeView.backgroundColor=[UIColor redColor];
          self.landscapeView=landscapeView;
//            
            
            
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
