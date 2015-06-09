//
//  ZCTotalGradeViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/4/16.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//总成绩

#import "ZCTotalGradeViewController.h"

#import "AppDelegate.h"
#import "ZCProfessionalLandscape.h"
#import "ZCResultsView.h"
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
    
    self.view.backgroundColor=ZCColor(237, 237, 237);
    
    self.navigationItem.title=@"总成绩";
    
    //返回
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barBtnItemWithNormalImageName:@"fanhui" hightImageName:@"fanhui" action:@selector(liftBthClick:) target:self];
    
    
    UIView *verticalScreenView=[[UIView alloc] initWithFrame: [ UIScreen mainScreen ].bounds];
        self.verticalScreenView=verticalScreenView;
         [self.view addSubview:verticalScreenView];

    [self addControls];
    
    
    
//    if ([[UIDevice currentDevice]orientation] == UIInterfaceOrientationLandscapeLeft){
//        
//        [self supportedInterfaceOrientations];
//        
//        self.verticalScreenView.hidden=YES;
//        self.landscapeView.hidden=NO;
////        
//       ZCProfessionalLandscape *landscapeView=[[ZCProfessionalLandscape alloc] init];
//       [self.view addSubview:landscapeView];
//        self.landscapeView=landscapeView;
////        
////        ZCLog(@"landscape left");
//    }
//    if ([[UIDevice currentDevice]orientation] == UIInterfaceOrientationLandscapeRight){
//        [self supportedInterfaceOrientations];
//        self.verticalScreenView.hidden=YES;
//        self.landscapeView.hidden=NO;
//        
//        
//        ZCProfessionalLandscape *landscapeView=[[ZCProfessionalLandscape alloc] init];
//        [self.view addSubview:landscapeView];
//        self.landscapeView=landscapeView;
//        ZCLog(@"landscape right");
//    }
//    if ([[UIDevice currentDevice]orientation] == UIInterfaceOrientationPortrait){
//        [self supportedInterfaceOrientations];
//        
//        self.verticalScreenView.hidden=NO;
//        self.landscapeView.hidden=YES;
//        
//        
//        UIView *verticalScreenView=[[UIView alloc] initWithFrame: [ UIScreen mainScreen ].bounds];
//        self.verticalScreenView=verticalScreenView;
//        [self.view addSubview:verticalScreenView];
//        
//        
//        [self addControls];
//        
//        
//    }
//
//    
    
    
}


-(void)liftBthClick:(UIButton *)btn
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
    CGFloat nameLabelW=SCREEN_WIDTH*0.9;
    CGFloat nameLabelH=20;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.text=self.match.name;
    nameLabel.textColor=ZCColor(85, 85, 85);
    nameLabel.font=[UIFont systemFontOfSize:20];
    [nameView addSubview:nameLabel];

    
    
    
    CGFloat ResultsViewX=nameViewX;
    CGFloat ResultsViewY=nameViewH;
    CGFloat ResultsViewW=SCREEN_WIDTH;
    CGFloat ResultsViewH=310;
    ZCResultsView *ResultsView=[ZCResultsView initWithResultsViewWithFrame:CGRectMake(ResultsViewX, ResultsViewY, ResultsViewW, ResultsViewH) andModel:self.professionalScorecardModel  andTime:self.match.played_at];
    
    [self.scrollView addSubview:ResultsView];
    
    
    
    //添加成绩的view
    UIView *resultsView=[[UIView alloc] init];
    CGFloat resultsViewX=0;
    CGFloat resultsViewY=ResultsViewY+ResultsViewH+5;
    CGFloat resultsViewW=SCREEN_WIDTH;
    CGFloat resultsViewH=119;
    
    resultsView.frame=CGRectMake(resultsViewX, resultsViewY, resultsViewW, resultsViewH);
    self.resultsView=resultsView;
    resultsView.backgroundColor=ZCColor(170, 170, 170);
    [self.scrollView addSubview:resultsView];
    //成绩内容
    [self resultsViewContent];
    
    
    //分段成绩
    UIView *piecewiseView=[[UIView alloc] init];
    piecewiseView.frame=CGRectMake(0, resultsView.frame.size.height+resultsView.frame.origin.y+15, SCREEN_WIDTH, 130);
    self.piecewiseView=piecewiseView;
    piecewiseView.backgroundColor=[UIColor whiteColor];
    [self.scrollView addSubview:piecewiseView];
    
    //成功率View里面的内容
    [self piecewiseViewViewContent];
    
    self.scrollView.contentSize = CGSizeMake(0, self.piecewiseView.frame.origin.y+self.piecewiseView.frame.size.height+60);
    
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
        resultsView1.backgroundColor=[UIColor whiteColor];
        [self.resultsView addSubview:resultsView1];
        
        //创建2个view   一个放显示内容一个放1像素的背景
        UIView *resultsView2=[[UIView alloc] init];
        resultsView2.frame=CGRectMake(0, 0, resultsView1.frame.size.width-1, resultsView1.frame.size.height);
        [resultsView1 addSubview:resultsView2];
        //1像素的背景
        UIView *bjView=[[UIView alloc] init];
        bjView.frame=CGRectMake(resultsView1.frame.size.width-0.5, 15, 0.5, resultsView1.frame.size.height-30);
        bjView.backgroundColor=ZCColor(170, 170, 170);
        [resultsView1 addSubview:bjView];
        
        UILabel *resultsLabel1=[[UILabel alloc] init];
        resultsLabel1.frame=CGRectMake((resultsView2.frame.size.width-70)/2,(resultsView2.frame.size.height-20*2)/3 , 70, 20);
        resultsLabel1.textAlignment=NSTextAlignmentCenter;
        resultsLabel1.textColor=ZCColor(255, 150, 29);
        [resultsView2 addSubview:resultsLabel1];
        
        
        //创建下面文字
        UILabel *resultsLabel2=[[UILabel alloc] init];
        resultsLabel2.frame=CGRectMake((resultsView2.frame.size.width-70)/2,resultsLabel1.frame.size.height+resultsLabel1.frame.origin.y+5 , 70, 20);
        resultsLabel2.textAlignment=NSTextAlignmentCenter;
        resultsLabel2.textColor=ZCColor(85, 85, 85);
        [resultsView2 addSubview:resultsLabel2];
        
        
        
        //给每个内容赋值
        if (index==0) {
            
            if ([self _valueOrNil:self.totalModel[@"score"]]==nil) {
                resultsLabel1.text=@"-";
            }else{
            
            resultsLabel1.text=[NSString stringWithFormat:@"%@",self.totalModel[@"score"]];
            }
            resultsLabel2.text=@"成绩";
        }else if (index==1)
        {
            if ([self _valueOrNil:self.totalModel[@"net"]]==nil) {
                resultsLabel1.text=@"-";
            }else
            {

            resultsLabel1.text=[NSString stringWithFormat:@"%@",self.totalModel[@"net"]];
            }
            resultsLabel2.text=@"净杆";
            
        }else if (index==2)
        {
            
            if ([self _valueOrNil:self.totalModel[@"putts"]]==nil) {
                resultsLabel1.text=@"-";
            }else
            {
                
                resultsLabel1.text=[NSString stringWithFormat:@"%@",self.totalModel[@"putts"]];
            }

            resultsLabel2.text=@"推杆";
            
            
        }else
        {
            
            if ([self _valueOrNil:self.totalModel[@"penalties"]]==nil) {
                resultsLabel1.text=@"-";
            }else
            {
                
                resultsLabel1.text=[NSString stringWithFormat:@"%@",self.totalModel[@"penalties"]];
            }

            
            //resultsLabel1.text=[NSString stringWithFormat:@"%@",self.totalModel[@"penalties"]];
            resultsLabel2.text=@"罚杆";
            
            
        }
        
    }
}


- (id) _valueOrNil:(id)obj {
    if (!obj) {
        return nil;
    }
    if (obj == [NSNull null]) {
        return nil;
    }
    return obj;
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
    nameLabel.textColor=ZCColor(255, 150, 29);
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
        bjView.frame=CGRectMake(resultsView1.frame.size.width-1, 15, 1, resultsView1.frame.size.height-30);
        bjView.backgroundColor=ZCColor(170, 170, 170);
        [resultsView1 addSubview:bjView];
        
        UILabel *resultsLabel1=[[UILabel alloc] init];
        resultsLabel1.frame=CGRectMake((resultsView2.frame.size.width-70)/2,(resultsView2.frame.size.height-20*2)/3 , 70, 20);
        resultsLabel1.textAlignment=NSTextAlignmentCenter;
       resultsLabel1.font=  [UIFont fontWithName:@"Helvetica-Bold" size:15];
       // resultsLabel1.textColor=ZCColor(37, 176, 101);
        [resultsView2 addSubview:resultsLabel1];
        
        
        //创建下面文字
        UILabel *resultsLabel2=[[UILabel alloc] init];
        resultsLabel2.frame=CGRectMake((resultsView2.frame.size.width-70)/2,resultsLabel1.frame.size.height+resultsLabel1.frame.origin.y+5 , 70, 20);
        resultsLabel2.textAlignment=NSTextAlignmentCenter;
        resultsLabel2.textColor=ZCColor(121, 121, 121);
        [resultsView2 addSubview:resultsLabel2];
        
        
        
        //给每个内容赋值
        if (index==0) {
            
            if ([self _valueOrNil:self.totalModel[@"front_6_score"]]==nil) {
                resultsLabel1.text=@"-";
            }else
            {
            resultsLabel1.text=[NSString stringWithFormat:@"%@",self.totalModel[@"front_6_score"]];
            }
            resultsLabel2.text=@"前六";
        }else if (index==1)
        {
            
            if ([self _valueOrNil:self.totalModel[@"middle_6_score"]]==nil) {
                resultsLabel1.text=@"-";
            }else
            {
                resultsLabel1.text=[NSString stringWithFormat:@"%@",self.totalModel[@"middle_6_score"]];
            }

            
            //resultsLabel1.text=[NSString stringWithFormat:@"%@",self.totalModel[@"middle_6_score"]];
            resultsLabel2.text=@"中六";
            
        }else if (index==2)
        {
            
            if ([self _valueOrNil:self.totalModel[@"last_6_score"]]==nil) {
                resultsLabel1.text=@"-";
            }else{
            resultsLabel1.text=[NSString stringWithFormat:@"%@",self.totalModel[@"last_6_score"]];
            }
            resultsLabel2.text=@"后六";
            
            
        }

        

    }

}



////视图消失时调用
//
//-(void)viewWillDisappear:(BOOL)animated
//{
//    
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
//    //[self.startButton removeFromSuperview];
//}
//
//-(void)viewWillAppear:(BOOL)animated
//{
//    AppDelegate *app=  (AppDelegate *)[UIApplication sharedApplication].delegate;
//    [app setAllowRotation:YES];
//    
//}
//
//
//
//- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
//    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
//    
//    
//    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
//    {
//        
//        ZCLog(@"---%f",SCREEN_WIDTH);
//        self.verticalScreenView.hidden=YES;
//        self.landscapeView.hidden=NO;
//        
//        //         if (self.landscapeView==nil) {
//        //             ZCAmateurStatisticsView *landscapeView=[[ZCAmateurStatisticsView alloc] init];
//        //             [self.view addSubview:landscapeView];
//        //             self.landscapeView=landscapeView;
//        //
//        //         }else
//        //         {
//        //             [self.landscapeView removeFromSuperview];
//        //
//        //             ZCAmateurStatisticsView *landscapeView=[[ZCAmateurStatisticsView alloc] init];
//        //             [self.view addSubview:landscapeView];
//        //             self.landscapeView=landscapeView;
//        //
//        //
//        //         }
//        //
//        //
//        
//        
//        
//        
//    }else if (toInterfaceOrientation == UIInterfaceOrientationPortrait)
//    {
//        self.verticalScreenView.hidden=NO;
//        self.landscapeView.hidden=YES;
//        NSLog(@"书屏将要旋转了?");
//        
//    }
//    
//    
//    ZCLog(@"%ld",toInterfaceOrientation);
//    
//    
//    
//    
//}
//
//- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
//    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
//    NSLog(@"如果让我旋转,我已经旋转完了!");
//    
//    
//    
//    
//    
//    
//    if ([[UIDevice currentDevice]orientation] == UIInterfaceOrientationLandscapeLeft||[[UIDevice currentDevice]orientation] == UIInterfaceOrientationLandscapeRight){
//        
//        [self supportedInterfaceOrientations];
//        
//        
//        //
//        //        self.verticalScreenView.hidden=YES;
//        //        self.landscapeView.hidden=NO;
//        
//        if (self.landscapeView==nil) {
//            ZCProfessionalLandscape *landscapeView=[[ZCProfessionalLandscape alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//           
//            [self.view addSubview:landscapeView];
//            //传值
//            landscapeView.professionalScorecardModel=self.professionalScorecardModel;
//            landscapeView.totalModel=self.totalModel;
//            
//            self.landscapeView=landscapeView;
//            
//        }else
//        {
//            [self.landscapeView removeFromSuperview];
//            
//            ZCProfessionalLandscape *landscapeView=[[ZCProfessionalLandscape alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//            
//            
//            //传值
//            landscapeView.professionalScorecardModel=self.professionalScorecardModel;
//            landscapeView.totalModel=self.totalModel;
//
//            [self.view addSubview:landscapeView];
//            
//            self.landscapeView=landscapeView;
//            
//            
//            
//        }
//        
//        
//        
//        
//    }
//    if ([[UIDevice currentDevice]orientation] == UIInterfaceOrientationPortrait){
//        [self supportedInterfaceOrientations];
//        
//                      self.verticalScreenView.hidden=NO;
//                       self.landscapeView.hidden=YES;
//        
//        
//    }
//    
//    
//    
//    // ZCLog(@"%f",self.view.frame.size.width);
//    
//}
//
//
//



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
