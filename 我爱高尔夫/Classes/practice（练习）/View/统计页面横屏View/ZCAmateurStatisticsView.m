//
//  ZCAmateurStatisticsView.m
//  我爱高尔夫
//
//  Created by hh on 15/3/15.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCAmateurStatisticsView.h"
@interface ZCAmateurStatisticsView()
@property(nonatomic,weak)UIScrollView *landscapeScrollView;
//名字的View

@property(nonatomic,weak)UIView *nameView;
//计分页面View
@property(nonatomic,weak)UIView *ScoringScrollView;
//注释界面
@property(nonatomic,weak)UIView *annotationView;
//成绩内容
@property(nonatomic,weak)UIView *resultsView;
//成功率界面
@property(nonatomic,weak)UIView *successRateView;
//平均分界面的View
@property(nonatomic,weak)UIView *averageView;
//球成绩界面的View  ball scores
@property(nonatomic,weak)UIView *ballScoresView;

@property(nonatomic,weak)UIView *nameView2;


@property(nonatomic,weak)ZCAmateurStatisticsView *StatisticsView;




@end
                                   

@implementation ZCAmateurStatisticsView

//+(instancetype)amateurStatisticsView:(ZCStatistical *)statistical
//{
//    ZCAmateurStatisticsView *statisticsView=[[ZCAmateurStatisticsView alloc] init];
//    statisticsView.statistical=statistical;
//    statisticsView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//    ZCLog(@"现执行");
//    return statisticsView;
//}
//+initWithStatistical:(ZCStatistical *)statistical
//
//{
//    ZCAmateurStatisticsView *StatisticsView= [[ZCAmateurStatisticsView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//   // self.StatisticsView=StatisticsView;
//    StatisticsView.statistical=statistical;
//    return StatisticsView;
//    
//}


-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor=ZCColor(23, 25, 28);
      UIScrollView *landscapeScrollView=[[UIScrollView alloc] init];
        
        landscapeScrollView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.landscapeScrollView=landscapeScrollView;
        [self addSubview:landscapeScrollView];
       
         //self.scrollView.frame=CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_WIDTH);
        // 增加额外的滚动区域(在顶部增加64的区域,在底部增加44的区域)
       // self.landscapeScrollView.contentInset = UIEdgeInsetsMake(30, 0, 10, 0);
       // self.landscapeScrollView.contentSize = CGSizeMake(80, SCREEN_HEIGHT+1000);
        //添加控件
       // ZCLog(@"%f",SCREEN_WIDTH);
        [self addLandscapeControls];
        
       self.landscapeScrollView.contentSize = CGSizeMake(0, self.ballScoresView.frame.origin.y+360);
    }
    return self;
}

//添加横屏内容
-(void)addLandscapeControls
{
    //创建显示名字的View
    UIView *nameView=[[UIView alloc] init];
    CGFloat nameViewX=0;
    CGFloat nameViewY=0;
    CGFloat nameViewW=self.landscapeScrollView.frame.size.width;
    CGFloat nameViewH=60;
    nameView.frame=CGRectMake(nameViewX, nameViewY, nameViewW, nameViewH);
    [self.landscapeScrollView addSubview:nameView];
    self.nameView=nameView;
    
    //添加名字View里的内容
    [self nameViewControls];

    //计分页面
    UIView *ScoringScrollView=[[UIView alloc] init];
    CGFloat ScoringScrollViewX=0;
    CGFloat ScoringScrollViewY=nameViewH;
    CGFloat ScoringScrollViewW=self.landscapeScrollView.frame.size.width;
    CGFloat ScoringScrollViewH=202;
    ScoringScrollView.frame=CGRectMake(ScoringScrollViewX, ScoringScrollViewY, ScoringScrollViewW, ScoringScrollViewH);
    [self.landscapeScrollView addSubview:ScoringScrollView];
    self.ScoringScrollView=ScoringScrollView;
    
    [self ScoringScrollViewControls];
    
    
    
    //添加注释界面
    UIView *annotationView=[[UIView alloc] init];
    CGFloat annotationViewX=0;
    CGFloat annotationViewY=ScoringScrollViewY+ScoringScrollViewH;
    CGFloat annotationViewW=SCREEN_WIDTH;
    CGFloat annotationViewH=51;
    
    
    annotationView.frame=CGRectMake(annotationViewX, annotationViewY, annotationViewW, annotationViewH);

    annotationView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jstj_yihangbeijing"]];

    
    [self.landscapeScrollView addSubview:annotationView];
    
    self.annotationView=annotationView;
    //注释界面里面的内容
    [self annotationContent];
    
    
    //添加成绩的view
    UIView *resultsView=[[UIView alloc] init];
    CGFloat resultsViewX=annotationViewX;
    CGFloat resultsViewY=annotationViewY+annotationViewH+15;
    CGFloat resultsViewW=SCREEN_WIDTH;
    CGFloat resultsViewH=60;
    
    resultsView.frame=CGRectMake(resultsViewX, resultsViewY, resultsViewW, resultsViewH);
    self.resultsView=resultsView;
    resultsView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jstj_chengjibeijing"]];

    
    self.resultsView=resultsView;
    
    [self.landscapeScrollView addSubview:resultsView];
    //成绩内容
    [self resultsViewContent];
    
    
    
    //success rate 成功率View
    UIView *successRateView=[[UIView alloc] init];
    
    successRateView.frame=CGRectMake(0, resultsView.frame.size.height+resultsView.frame.origin.y+15, SCREEN_WIDTH, 400);
    self.successRateView=successRateView;
    successRateView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jstj_kaiqiujili_beijing"]];
    [self.landscapeScrollView addSubview:successRateView];
    self.successRateView=successRateView;
    
    //成功率View里面的内容
    [self successRateViewContent];
    


    // 平均分View
    UIView *averageView=[[UIView alloc] init];
    averageView.frame=CGRectMake(0, successRateView.frame.origin.y+successRateView.frame.size.height+15, SCREEN_WIDTH, 150);
    self.averageView=averageView;
    averageView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jstj_kaiqiujili_beijing"]];
    self.averageView=averageView;
   
    [self.landscapeScrollView addSubview:averageView];
    
    [self averageViewContent];
    
    
    
    
    // 球成绩界面的View
    UIView *ballScoresView=[[UIView alloc] init];
    ballScoresView.frame=CGRectMake(0, averageView.frame.size.height+averageView.frame.origin.y+15, SCREEN_WIDTH, 300);
    self.ballScoresView=ballScoresView;
    ballScoresView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jstj_kaiqiujili_beijing"]];
    self.ballScoresView=ballScoresView;
    
    [self.landscapeScrollView addSubview:ballScoresView];
    
    [self ballScoresViewContent];
    
    
    


    

}


//平均分成绩界面内容
-(void)averageViewContent
{
    
    // 0.总列数(一行最多3列)
    int totalColumns = 1;
    
    // 1.数字的尺寸
    CGFloat appW = self.averageView.frame.size.width;
    CGFloat appH = (self.averageView.frame.size.height-0)/3;
    
    // 2.间隙 = (控制器view的宽度 - 3 * 应用宽度) / 4
    //CGFloat marginX = (self.view.frame.size.width - totalColumns * appW) / (totalColumns + 1);
    CGFloat marginX = 0;
    CGFloat marginY = 0;
    
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
        
        
        
        UILabel *averageLabel1=[[UILabel alloc] init];
        averageLabel1.frame=CGRectMake(10,0 , 140, averageView1.frame.size.height);
        
        averageLabel1.textColor=ZCColor(208, 210, 212);
        [averageView1 addSubview:averageLabel1];
        
        
        //创建下面文字
        UILabel *averageLabel2=[[UILabel alloc] init];
        averageLabel2.frame=CGRectMake(averageView1.frame.size.width-70,0 , 70, averageView1.frame.size.height);
        averageLabel2.textColor=ZCColor(37, 176, 101);
        [averageView1 addSubview:averageLabel2];
        
        
        
        
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
    CGFloat appH = (self.ballScoresView.frame.size.height)/6;
    
    // 2.间隙 = (控制器view的宽度 - 3 * 应用宽度) / 4
    //CGFloat marginX = (self.view.frame.size.width - totalColumns * appW) / (totalColumns + 1);
    CGFloat marginX = 0;
    CGFloat marginY = 0;
    
    for (int index=0; index<6; index++) {
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
        
        
        
        UILabel *ballScoresLabel1=[[UILabel alloc] init];
        ballScoresLabel1.frame=CGRectMake(10,0 , 140, ballScoresView1.frame.size.height);
        
        ballScoresLabel1.textColor=ZCColor(208, 210, 212);
        [ballScoresView1 addSubview:ballScoresLabel1];
        
        
        //创建下面文字
        UILabel *ballScoresLabel2=[[UILabel alloc] init];
        ballScoresLabel2.frame=CGRectMake(ballScoresView1.frame.size.width-70,0 , 70, ballScoresView1.frame.size.height);
        
        ballScoresLabel2.textColor=ZCColor(37, 176, 101);
        [ballScoresView1 addSubview:ballScoresLabel2];
        
        
        
        
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
    
}

//成功率里面的内容
-(void)successRateViewContent
{
    
    // 0.总列数(一行最多3列)
    int totalColumns = 1;
    
    // 1.数字的尺寸
    CGFloat appW = self.successRateView.frame.size.width;
    CGFloat appH = (self.successRateView.frame.size.height)/8;
    
    // 2.间隙 = (控制器view的宽度 - 3 * 应用宽度) / 4
    //CGFloat marginX = (self.view.frame.size.width - totalColumns * appW) / (totalColumns + 1);
    CGFloat marginX = 0;
    CGFloat marginY = 0;
    
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
        
        
        
        UILabel *successLabel1=[[UILabel alloc] init];
        successLabel1.frame=CGRectMake(10,0 , 200, successView.frame.size.height);
        successLabel1.textColor=ZCColor(208, 210, 212);
        [successView addSubview:successLabel1];
        
        //创建下面文字
        UILabel *successLabel2=[[UILabel alloc] init];
        successLabel2.frame=CGRectMake(successView.frame.size.width-70,0 , 70, successView.frame.size.height);
        
        successLabel2.textColor=ZCColor(37, 176, 101);
        [successView addSubview:successLabel2];
        
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






//成绩页面内容
-(void)resultsViewContent
{
    // 0.总列数(一行最多3列)
    int totalColumns = 4;
    
    // 1.数字的尺寸
    CGFloat appW = (self.resultsView.frame.size.width-0)/4;
    CGFloat appH = (self.resultsView.frame.size.height-0)/1;
    
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
        
     
        
        
        
        
//        
//        //给每个内容赋值
//        if (index==0) {
//            resultsLabel1.text=[NSString stringWithFormat:@"%d",index];
//            resultsLabel2.text=@"成绩";
//        }else if (index==1)
//        {
//            resultsLabel1.text=[NSString stringWithFormat:@"%d",index];
//            resultsLabel2.text=@"净杆";
//            
//        }else if (index==2)
//        {
//            resultsLabel1.text=[NSString stringWithFormat:@"%d",index];
//            resultsLabel2.text=@"推杆";
//            
//            
//        }else
//        {
//            resultsLabel1.text=[NSString stringWithFormat:@"%d",index];
//            resultsLabel2.text=@"罚杆";
//            
//            
//        }
        
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



//计分界面
-(void)ScoringScrollViewControls
{
    UIView *nameView1=[[UIView alloc] init];
    nameView1.frame=CGRectMake(0, 0, 70, self.ScoringScrollView.frame.size.height);
    nameView1.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jstj_yihangbeijing"]];
    [self.ScoringScrollView addSubview:nameView1];
    
    // 0.总列数(一行最多3列)
    int totalColumns1 = 1;
    
    // 1.数字的尺寸
    CGFloat appW1 = nameView1.frame.size.width;
    CGFloat appH1 = (nameView1.frame.size.height-0)/4;
    
    // 2.间隙 = (控制器view的宽度 - 3 * 应用宽度) / 4
    //CGFloat marginX = (self.view.frame.size.width - totalColumns * appW) / (totalColumns + 1);
    CGFloat marginX1 = 0;
    CGFloat marginY1 = 0;
    
    for (int i=0; i<4; i++) {
        UILabel *holesResult1=[[UILabel alloc] init];
        
        // 3.2.计算框框的位置
        // 计算行号和列号
        int row = i / totalColumns1;
        int col = i % totalColumns1;
        // 计算x和y
        CGFloat appX1 = marginX1 + col * (appW1 + marginX1);
        CGFloat appY1 = row * (appH1 + marginY1);
        // 设置frame
        holesResult1.frame = CGRectMake(appX1, appY1, appW1, appH1);
        [nameView1 addSubview:holesResult1];
        holesResult1.textColor=ZCColor(208, 210, 212);
        holesResult1.font=[UIFont systemFontOfSize:16];
        

        if (i==0) {
            holesResult1.text=@"洞";
        }else if (i==1)
        {
            holesResult1.text=@"标准杆";
        }else if (i==2)
        {
            holesResult1.text=@"成绩";
        }else
        {
            holesResult1.text=@"距标准杆";
            
        }
        holesResult1.textAlignment=NSTextAlignmentCenter;
    
    }
    
    
    
    
    
    
    
    
    UIView *nameView2=[[UIView alloc] init];
    CGFloat nameView2X=nameView1.frame.size.width;
    CGFloat nameView2Y=nameView1.frame.origin.y;
    CGFloat nameView2W=SCREEN_WIDTH-nameView2X;
    CGFloat nameView2H=nameView1.frame.size.height;
    nameView2.frame=CGRectMake(nameView2X, nameView2Y, nameView2W, nameView2H);
    nameView2.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jstj_yihangbeijing"]];
    
    [self.ScoringScrollView addSubview:nameView2];
    self.nameView2=nameView2;
    
    
    // 0.总列数(一行最多3列)
    int totalColumns = 21;
    
    // 1.数字的尺寸
    CGFloat appW = (nameView2.frame.size.width)/totalColumns;
    CGFloat appH = (nameView2.frame.size.height-0)/4;
    
    // 2.间隙 = (控制器view的宽度 - 3 * 应用宽度) / 4
    //CGFloat marginX = (self.view.frame.size.width - totalColumns * appW) / (totalColumns + 1);
    CGFloat marginX = 0;
    CGFloat marginY = 0;
    
    for (int index=0; index<84; index++) {
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
        [self.nameView2 addSubview:labelView];
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
        
        
//        if (index>=0&&index<10) {
//           holesResult.text=[NSString stringWithFormat:@"%d",index];
//        }else if(index==10)
//        {
//         holesResult.text=@"前九";
//        }
//        else if (index>10&&index<19)
//        {
//            holesResult.text=[NSString stringWithFormat:@"%d",index-1];
//        }else if (index==19)
//        {
//          holesResult.text=@"IN";
//        }else if (index==20)
//        {
//           holesResult.text=@"TOT";
//        }else if (index>20&&index<42)
//        {
//            ZCLog(@"%@",self.statistical.scorecards.par[index-21]);
//            
//          holesResult.text=self.statistical.scorecards.par[index-21];
//        }else if (index>=42&&index<63)
//        {
//        holesResult.text=[NSString stringWithFormat:@"%d",index];
//        }else if (index>=63&&index<84)
//        {
//           holesResult.text=@"成绩";
//        }
        
    }
}


-(void)nameViewControls
{
    UILabel *nameLabel=[[UILabel alloc] init];
    nameLabel.frame=CGRectMake(10, 15, 130, 30);
    nameLabel.text=@"北京高尔夫球场";
    nameLabel.textColor=ZCColor(208, 210, 212);
    [self.nameView addSubview:nameLabel];
    
    //时间
    UILabel *timeLabel=[[UILabel alloc] init];
    timeLabel.frame=CGRectMake(self.nameView.frame.size.width-180, 15, 150, 30);
    timeLabel.text=@"2015年2月13号";
    timeLabel.textColor=ZCColor(208, 210, 212);
    [self.nameView addSubview:timeLabel];
   
}

-(void)setStatistical:(ZCStatistical *)statistical
{
    _statistical=statistical;
    //计分赋值
    for (int index=0; index<self.nameView2.subviews.count; index++) {
        UIView *holeView=self.nameView2.subviews[index];
        for (int i=0; i<holeView.subviews.count; i++) {
            UILabel *holeLabel=holeView.subviews[1];
        
        ZCLog(@"%lu",self.nameView2.subviews.count);
        if (index>=0&&index<9) {
           
            
            holeLabel.text=[NSString stringWithFormat:@"%d",index+1];
        }else if(index==9)
        {
            holeLabel.text=@"前九";
        }
        else if (index>9&&index<19)
        {
            holeLabel.text=[NSString stringWithFormat:@"%d",index-1];
        }else if (index==19)
        {
            holeLabel.text=@"IN";
        }else if (index==20)
        {
            holeLabel.text=@"TOT";
        }else if (index>20&&index<42)
        {
            
            
            holeLabel.text=[NSString stringWithFormat:@"%@",self.statistical.scorecards.par[index-21]];
        }else if (index>=42&&index<63)
        {
            if ( [self.statistical.scorecards.score[index-42]  isKindOfClass:[NSNull class]]) {
                holeLabel.text=@"";
            }else{
                holeLabel.text=[NSString stringWithFormat:@"%@",self.statistical.scorecards.score[index-42]];
            }

            //holeLabel.text=[NSString stringWithFormat:@"%d",index];
        }else if (index>=63&&index<84)
        {
            
            if ( [self.statistical.scorecards.status[index-63]  isKindOfClass:[NSNull class]]) {
                holeLabel.text=@"";
            }else{
                holeLabel.text=[NSString stringWithFormat:@"%@",self.statistical.scorecards.status[index-63]];
            }

            
        }

        
    }
    
    }
    
    
    //resultsView赋值
    for (int i=0; i<self.resultsView.subviews.count; i++) {
        
        UIView *resultsView1=self.resultsView.subviews[i];
        
        for (int j=0; j<resultsView1.subviews.count; j++) {
            ZCLog(@"%lu",resultsView1.subviews.count);
            UIView *resultsView2=resultsView1.subviews[0];
            for (int f=0; f<resultsView2.subviews.count; f++) {
                UILabel *name1=resultsView2.subviews[0];
                UILabel *name2=resultsView2.subviews[1];
            
            if (i==0) {
                name1.text=[NSString stringWithFormat:@"%@",self.statistical.score];
                name2.text=@"成绩";
                
            }else if (i==1)
            {
                name1.text=[NSString stringWithFormat:@"%@",self.statistical.net];
                name2.text=@"净杆";
                
                
            }else if (i==2)
            {
                name1.text=[NSString stringWithFormat:@"%@",self.statistical.putts];
                name2.text=@"推杆";
                
            }else if (i==3)
            {
                name1.text=[NSString stringWithFormat:@"%@",self.statistical.penalties];
                name2.text=@"罚杆";
                
            }
            
        }
        
        }
        
    }
    
    
   
    
    
    
    
    
    
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    
    
}





//-(instancetype)initWithFrame:(CGRect)frame tatistical:(ZCStatistical*)tatistical
//{
//   self= [super initWithFrame:frame];
//    if (self) {
//        
//        self.statistical=tatistical;
//    }
//    return self;
//}
//
@end
