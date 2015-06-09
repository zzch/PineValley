//
//  ZCProfessionalLandscape.m
//  我爱高尔夫
//
//  Created by hh on 15/4/17.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCProfessionalLandscape.h"
@interface ZCProfessionalLandscape()
@property(nonatomic,weak)UIScrollView *landscapeScrollView;
//名字的View

@property(nonatomic,weak)UIView *nameView;
//计分页面View
@property(nonatomic,weak)UIView *ScoringScrollView;
//注释界面
@property(nonatomic,weak)UIView *annotationView;
//成绩内容
@property(nonatomic,weak)UIView *resultsView;
@property(nonatomic,weak)UIView *nameView2;

@property(nonatomic,weak)UIView *piecewiseView;
//分段界面里的
@property(nonatomic,weak)UIView *downView;

@end
@implementation ZCProfessionalLandscape

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
        
        self.landscapeScrollView.contentSize = CGSizeMake(0, 1360);
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
    
    
    //分段成绩
    UIView *piecewiseView=[[UIView alloc] init];
    piecewiseView.frame=CGRectMake(0, resultsView.frame.size.height+resultsView.frame.origin.y+15, SCREEN_WIDTH, 150);
    self.piecewiseView=piecewiseView;
   // piecewiseView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jstj_kaiqiujili_beijing"]];
    [self.landscapeScrollView addSubview:piecewiseView];
    
    //分段里面的内容
    [self piecewiseViewViewContent];

    
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
    self.downView=downView;
    
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
       // bjView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jstj_chengji_zjx"]];
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
        
        
        
   }
    
}





//-(void)setProfessionalScorecardModel:(ZCProfessionalScorecardModel *)professionalScorecardModel
//{
//    _professionalScorecardModel=professionalScorecardModel;
//    
//    //计分赋值
//    for (int index=0; index<self.nameView2.subviews.count; index++) {
//        UIView *holeView=self.nameView2.subviews[index];
//        for (int i=0; i<holeView.subviews.count; i++) {
//            UILabel *holeLabel=holeView.subviews[1];
//            
//            
//            if (index>=0&&index<9) {
//                
//                
//                holeLabel.text=[NSString stringWithFormat:@"%d",index+1];
//            }else if(index==9)
//            {
//                holeLabel.text=@"前九";
//            }
//            else if (index>9&&index<19)
//            {
//                holeLabel.text=[NSString stringWithFormat:@"%d",index-1];
//            }else if (index==19)
//            {
//                holeLabel.text=@"IN";
//            }else if (index==20)
//            {
//                holeLabel.text=@"TOT";
//            }else if (index>20&&index<42)
//            {
//                
//                
//                holeLabel.text=[NSString stringWithFormat:@"%@",self.professionalScorecardModel.par[index-21]];
//            }else if (index>=42&&index<63)
//            {
//                if ( [self.professionalScorecardModel.score[index-42]  isKindOfClass:[NSNull class]]) {
//                    holeLabel.text=@"";
//                }else{
//                    holeLabel.text=[NSString stringWithFormat:@"%@",self.professionalScorecardModel.score[index-42]];
//                }
//                
//                //holeLabel.text=[NSString stringWithFormat:@"%d",index];
//            }else if (index>=63&&index<84)
//            {
//                
//                if ( [self.professionalScorecardModel.status[index-63]  isKindOfClass:[NSNull class]]) {
//                    holeLabel.text=@"";
//                }else{
//                    holeLabel.text=[NSString stringWithFormat:@"%@",self.professionalScorecardModel.status[index-63]];
//                }
//                
//                
//            }
//            
//            
//        }
//        
//    }
//    
//
//
//}
//

-(void)setTotalModel:(NSDictionary *)totalModel
{
    _totalModel=totalModel;
    
    
    //resultsView赋值
    for (int i=0; i<self.resultsView.subviews.count; i++) {
        
        UIView *resultsView1=self.resultsView.subviews[i];
        
        for (int j=0; j<resultsView1.subviews.count; j++) {
            
            UIView *resultsView2=resultsView1.subviews[0];
            for (int f=0; f<resultsView2.subviews.count; f++) {
                UILabel *name1=resultsView2.subviews[0];
                UILabel *name2=resultsView2.subviews[1];
                
                if (i==0) {
                    name1.text=[NSString stringWithFormat:@"%@",self.totalModel[@"score"]];
                    name2.text=@"成绩";
                    
                }else if (i==1)
                {
                    name1.text=[NSString stringWithFormat:@"%@",self.totalModel[@"net"]];
                    name2.text=@"净杆";
                    
                    
                }else if (i==2)
                {
                    name1.text=[NSString stringWithFormat:@"%@",self.totalModel[@"putts"]];
                    name2.text=@"推杆";
                    
                }else if (i==3)
                {
                    name1.text=[NSString stringWithFormat:@"%@",self.totalModel[@"penalties"]];
                    name2.text=@"罚杆";
                    
                }
                
            }
            
        }
        
    }
    

//分段界面
    
    for (int n=0; n<self.downView.subviews.count; n++) {
       
        
        UIView *downView1=self.downView.subviews[n];
        
        for (int m=0; m<downView1.subviews.count; m++) {
            
            UIView *downView2=downView1.subviews[0];
            for (int f=0; f<downView2.subviews.count; f++) {
                UILabel *name1=downView2.subviews[0];
                UILabel *name2=downView2.subviews[1];
                
                if (n==0) {
                    name1.text=[NSString stringWithFormat:@"%@",self.totalModel[@"front_6_score"]];
                    name2.text=@"前六";
                    
                }else if (n==1)
                {
                    name1.text=[NSString stringWithFormat:@"%@",self.totalModel[@"middle_6_score"]];
                    name2.text=@"中六";
                    
                    
                }else if (n==2)
                {
                    name1.text=[NSString stringWithFormat:@"%@",self.totalModel[@"last_6_score"]];
                    name2.text=@"后六";
                    
                }
            }
            
        }
        
    }


}

@end
