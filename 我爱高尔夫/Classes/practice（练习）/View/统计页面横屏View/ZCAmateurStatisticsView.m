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
        
        ZCLog(@"%f",frame.size.width);
      UIScrollView *landscapeScrollView=[[UIScrollView alloc] init];
        
        landscapeScrollView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.landscapeScrollView=landscapeScrollView;
        [self addSubview:landscapeScrollView];
        landscapeScrollView.backgroundColor=[UIColor blueColor];
         //self.scrollView.frame=CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_WIDTH);
        // 增加额外的滚动区域(在顶部增加64的区域,在底部增加44的区域)
        self.landscapeScrollView.contentInset = UIEdgeInsetsMake(30, 0, 10, 0);
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
    self.nameView.backgroundColor=[UIColor blueColor];
    self.nameView.frame=CGRectMake(0, 55, self.landscapeScrollView.frame.size.width, 60);
    [self.landscapeScrollView addSubview:nameView];
    self.nameView=nameView;
    
    //添加名字View里的内容
    [self nameViewControls];

    //计分页面
    UIView *ScoringScrollView=[[UIView alloc] init];
    ScoringScrollView.frame=CGRectMake(0, 110, self.landscapeScrollView.frame.size.width, 150);
    [self.landscapeScrollView addSubview:ScoringScrollView];
    self.ScoringScrollView=ScoringScrollView;
    ScoringScrollView.backgroundColor=[UIColor yellowColor];
    [self ScoringScrollViewControls];
    
    
    
    //添加注释界面
    UIView *annotationView=[[UIView alloc] init];
    
    annotationView.frame=CGRectMake(0, 270, self.landscapeScrollView.frame.size.width, 40);
    [self.landscapeScrollView addSubview:annotationView];
    annotationView.backgroundColor=[UIColor redColor];
    self.annotationView=annotationView;
    //注释界面里面的内容
    [self annotationContent];
    
    
    //添加成绩的view
    UIView *resultsView=[[UIView alloc] init];
    resultsView.frame=CGRectMake(0, 320, self.landscapeScrollView.frame.size.width, 150);
    self.resultsView=resultsView;
    resultsView.backgroundColor=[UIColor blueColor];
    [self.landscapeScrollView addSubview:resultsView];
    //成绩内容
    [self resultsViewContent];
    
    
    
    //success rate 成功率View
    UIView *successRateView=[[UIView alloc] init];
    successRateView.frame=CGRectMake(0, 480, SCREEN_WIDTH, 400);
    self.successRateView=successRateView;
    successRateView.backgroundColor=[UIColor blueColor];
    [self.landscapeScrollView addSubview:successRateView];
    
    //成功率View里面的内容
    [self successRateViewContent];
    


    // 平均分View
    UIView *averageView=[[UIView alloc] init];
    averageView.frame=CGRectMake(0, 890, SCREEN_WIDTH, 150);
    self.averageView=averageView;
    averageView.backgroundColor=[UIColor blueColor];
    [self.landscapeScrollView addSubview:averageView];
    
    [self averageViewContent];
    
    
    
    
    // 球成绩界面的View
    UIView *ballScoresView=[[UIView alloc] init];
    ballScoresView.frame=CGRectMake(0, 1050, SCREEN_WIDTH, 350);
    self.ballScoresView=ballScoresView;
    ballScoresView.backgroundColor=[UIColor blueColor];
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



//计分界面
-(void)ScoringScrollViewControls
{
    UIView *nameView1=[[UIView alloc] init];
    nameView1.frame=CGRectMake(0, 0, 60, self.ScoringScrollView.frame.size.height);
    nameView1.backgroundColor=[UIColor redColor];
    [self.ScoringScrollView addSubview:nameView1];
    
    // 0.总列数(一行最多3列)
    int totalColumns1 = 1;
    
    // 1.数字的尺寸
    CGFloat appW1 = nameView1.frame.size.width;
    CGFloat appH1 = (nameView1.frame.size.height-8)/4;
    
    // 2.间隙 = (控制器view的宽度 - 3 * 应用宽度) / 4
    //CGFloat marginX = (self.view.frame.size.width - totalColumns * appW) / (totalColumns + 1);
    CGFloat marginX1 = 2;
    CGFloat marginY1 = 2;
    
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
        holesResult1.backgroundColor=[UIColor brownColor];
        holesResult1.font=[UIFont systemFontOfSize:10];

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
    nameView2.frame=CGRectMake(60, 0, self.ScoringScrollView.frame.size.width-60, self.ScoringScrollView.frame.size.height);
    nameView2.backgroundColor=[UIColor redColor];
    [self.ScoringScrollView addSubview:nameView2];
    self.nameView2=nameView2;
    
    
    // 0.总列数(一行最多3列)
    int totalColumns = 21;
    
    // 1.数字的尺寸
    CGFloat appW = (nameView2.frame.size.width-2*totalColumns)/totalColumns;
    CGFloat appH = (nameView2.frame.size.height-8)/4;
    
    // 2.间隙 = (控制器view的宽度 - 3 * 应用宽度) / 4
    //CGFloat marginX = (self.view.frame.size.width - totalColumns * appW) / (totalColumns + 1);
    CGFloat marginX = 2;
    CGFloat marginY = 2;
    
    for (int index=0; index<84; index++) {
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
        [nameView2 addSubview:holesResult];
        holesResult.backgroundColor=[UIColor brownColor];
        holesResult.font=[UIFont systemFontOfSize:10];
        
        
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
    nameLabel.frame=CGRectMake(30, 10, 130, 30);
    nameLabel.text=@"北京高尔夫球场";
    [self.nameView addSubview:nameLabel];
    nameLabel.backgroundColor=[UIColor redColor];
    //时间
    UILabel *timeLabel=[[UILabel alloc] init];
    timeLabel.frame=CGRectMake(30, 50, 130, 30);
    timeLabel.text=@"2015年2月13号";
    [self.nameView addSubview:timeLabel];
    timeLabel.backgroundColor=[UIColor redColor];
}

-(void)setStatistical:(ZCStatistical *)statistical
{
    _statistical=statistical;
    //计分赋值
    for (int index=0; index<self.nameView2.subviews.count; index++) {
        UILabel *holeLabel=self.nameView2.subviews[index];
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
    
    
    
    
    //resultsView赋值
    for (int i=0; i<self.resultsView.subviews.count; i++) {
        ZCLog(@"%lu",self.resultsView.subviews.count);
        
        UIView *resultsView1=self.resultsView.subviews[i];
        
        for (int j=0; j<resultsView1.subviews.count; j++) {
            ZCLog(@"%lu",resultsView1.subviews.count);
            UILabel *resultsLabel=resultsView1.subviews[j];
            
            if (i==0) {
                if (j==0) {
                    resultsLabel.text=[NSString stringWithFormat:@"%@",self.statistical.score];
                }else{
                resultsLabel.text=@"成绩";
                }
                
            }else if (i==1)
            {
                if (j==0) {
                    resultsLabel.text=[NSString stringWithFormat:@"%@",self.statistical.net];
                }else{
                    resultsLabel.text=@"净杆";
                }

                
            }else if (i==2)
            {
                if (j==0) {
                    resultsLabel.text=[NSString stringWithFormat:@"%@",self.statistical.putts];
                }else{
                    resultsLabel.text=@"推杆";
                }

            
            }else if (i==3)
            {
                if (j==0) {
                    resultsLabel.text=[NSString stringWithFormat:@"%@",self.statistical.penalties];
                }else{
                    resultsLabel.text=@"罚杆";
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
