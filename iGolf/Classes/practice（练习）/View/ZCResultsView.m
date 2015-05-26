//
//  ZCResultsView.m
//  iGolf
//
//  Created by hh on 15/5/18.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCResultsView.h"
@interface ZCResultsView()<UIScrollViewDelegate>
@property(nonatomic,strong)ZCStatisticalScorecard *scorecard;
@property(nonatomic,weak)UIScrollView *scoringScrollView;
@property(nonatomic,weak)UIButton *beforeButton;
@property(nonatomic,weak)UIButton *afterButton;
@property(nonatomic,weak)UIImageView *imageView;
@end
@implementation ZCResultsView


+(instancetype)initWithResultsViewWithFrame:(CGRect)frame andModel:(ZCStatisticalScorecard *)scorecard
{
    
    
    return [[self alloc] initWithFrame:frame andModel:scorecard];

}
-(instancetype)initWithFrame:(CGRect)frame andModel:(ZCStatisticalScorecard *)scorecard
{

    if (self=[super initWithFrame:frame]) {
        
       
        self.scorecard=scorecard;
        
        [self addControlsandModel];
        
        
    }

    return self;




}


-(void)addControlsandModel
{
    
    
    
    
    UIImageView *imageView=[[UIImageView alloc] init];
    imageView.image=[UIImage imageNamed:@"jstj_qianjiu"];
    imageView.frame=CGRectMake(SCREEN_WIDTH-(SCREEN_WIDTH-200), 0, 95, 25);
    imageView.userInteractionEnabled=YES;
    [self addSubview:imageView];
    self.imageView=imageView;
        //前九洞
        UIButton *beforeButton=[[UIButton alloc] init];
    
        beforeButton.frame=CGRectMake(0, 0, 47, 25);
        //[beforeButton setTitle:@"前九洞" forState:UIControlStateNormal];
        [beforeButton addTarget:self action:@selector(clickTheBeforeButton) forControlEvents:UIControlEventTouchUpInside];
        [self.imageView addSubview:beforeButton];
        self.beforeButton=beforeButton;
    
        //后九洞
        UIButton *afterButton=[[UIButton alloc] init];
    
        afterButton.frame=CGRectMake(47, 0, 48, 25);
       // [afterButton setTitle:@"后九洞" forState:UIControlStateNormal];
     [afterButton addTarget:self action:@selector(clickTheAfterButton) forControlEvents:UIControlEventTouchUpInside];
        [self.imageView addSubview:afterButton];
    self.afterButton=afterButton;
    
    
    
    //计分页面前的名称
    UIView *nameScoringScrollView=[[UIView alloc] init];
    CGFloat nameScoringScrollViewX=0;
    CGFloat nameScoringScrollViewY=60;
    CGFloat nameScoringScrollViewW=SCREEN_WIDTH*0.17;
    CGFloat nameScoringScrollViewH=202.5;
    
    nameScoringScrollView.frame=CGRectMake(nameScoringScrollViewX, nameScoringScrollViewY, nameScoringScrollViewW, nameScoringScrollViewH);
    nameScoringScrollView.backgroundColor=ZCColor(170, 170, 170);
    //nameScoringScrollView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"suoyou_bj_02"]];
    [self addSubview:nameScoringScrollView];
    
    //self.nameScoringScrollView=nameScoringScrollView;
    
    
    
    // 0.总列数(一行最多3列)
    int totalColumns = 1;
    
    // 1.数字的尺寸
    CGFloat appW = (nameScoringScrollView.frame.size.width-0)/1;
    CGFloat appH = (nameScoringScrollView.frame.size.height-2.5)/4;
    
    // 2.间隙 = (控制器view的宽度 - 3 * 应用宽度) / 4
    //CGFloat marginX = (self.view.frame.size.width - totalColumns * appW) / (totalColumns + 1);
    CGFloat marginX = 0;
    CGFloat marginY = 0.5;
    
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
        labelView.backgroundColor=[UIColor whiteColor];
        //holesResult.textColor=ZCColor(208, 210, 212);
        // [self.beforeScoringView addSubview:labelView];
        
        labelView.textColor=ZCColor(85, 85, 85);
        labelView.font=[UIFont systemFontOfSize:13];
        labelView.textAlignment=NSTextAlignmentCenter;
        //        nameScoringView.font=[UIFont font]
        
        [nameScoringScrollView addSubview:labelView];
        
        
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
    scoringScrollView.delegate=self;
    [self addSubview:scoringScrollView];
    self.scoringScrollView=scoringScrollView;
    //滚动的区域
    scoringScrollView.contentSize=CGSizeMake(2*scoringScrollViewW, 0);
    //前九洞的view
    UIView *beforeScoringView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, scoringScrollView.frame.size.width, scoringScrollView.frame.size.height)];
    beforeScoringView.backgroundColor=ZCColor(170, 170, 170);
    //beforeScoringView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jstj_yihangbeijing"]];
    [scoringScrollView addSubview:beforeScoringView];
    
   // self.beforeScoringView=beforeScoringView;
    [self addForBeforeScoringView:beforeScoringView ];
    
    
    
    //后九洞的view
    UIView *afterScoringView=[[UIView alloc] initWithFrame:CGRectMake(beforeScoringView.frame.size.width, 0, scoringScrollView.frame.size.width, scoringScrollView.frame.size.height)];
    
    afterScoringView.backgroundColor=ZCColor(170, 170, 170);
    [scoringScrollView addSubview:afterScoringView];
    //self.afterScoringView=afterScoringView;
    //添加后九的显示值
    [self addForAfterScoringView:afterScoringView];
    
    
    
    //添加注释界面
    UIView *annotationView=[[UIView alloc] init];
    CGFloat annotationViewX=nameScoringScrollViewX;
    CGFloat annotationViewY=nameScoringScrollViewY+nameScoringScrollViewH;
    CGFloat annotationViewW=SCREEN_WIDTH;
    CGFloat annotationViewH=51;
    
    
    annotationView.frame=CGRectMake(annotationViewX, annotationViewY, annotationViewW, annotationViewH);
    [self addSubview:annotationView];
    annotationView.backgroundColor=[UIColor whiteColor];
    //self.annotationView=annotationView;
    //注释界面里面的内容
    [self annotationContent:annotationView];



}



//前九洞的view

-(void)addForBeforeScoringView:(UIView *)beforeScoringView
{
    
    // 0.总列数(一行最多3列)
    int totalColumns = 10;
    
    // 1.数字的尺寸
    CGFloat appW = (beforeScoringView.frame.size.width-5)/10;
    CGFloat appH = (beforeScoringView.frame.size.height-2.5)/4;
    
    // 2.间隙 = (控制器view的宽度 - 3 * 应用宽度) / 4
    //CGFloat marginX = (self.view.frame.size.width - totalColumns * appW) / (totalColumns + 1);
    CGFloat marginX = 0.5;
    CGFloat marginY = 0.5;
    
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
        labelView.backgroundColor=[UIColor whiteColor];
        //holesResult.textColor=ZCColor(208, 210, 212);
        [beforeScoringView addSubview:labelView];
        // UIView *bjView=[[UIView alloc] init];
        //bjView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"suoyou_bj_02"]];
        // bjView.frame=CGRectMake(0, 0, 1, labelView.frame.size.height);
        // [labelView addSubview:bjView];
        UILabel *holesResult=[[UILabel alloc] init];
        holesResult.frame=CGRectMake(0, 0, labelView.frame.size.width, labelView.frame.size.height);
        holesResult.textColor=ZCColor(85, 85, 85);
        holesResult.textAlignment=NSTextAlignmentCenter;
        holesResult.font=[UIFont systemFontOfSize:12];
        [labelView addSubview:holesResult];
        
        
        if (index<9) {
            holesResult.text=[NSString stringWithFormat:@"%d",index];
            
        }else if (index==9)
        {
            holesResult.text=@"前九";
            
        }else if (index>9&&index<20)
        {
            ZCStatisticalScorecard *statisticalScorecard=self.scorecard;
            //            ZCLog(@"%@",statisticalScorecard.par);
            //            ZCLog(@"%@",self.statistical.scorecards.par);
            
            if ([self _valueOrNil:statisticalScorecard.par[index-10]]==nil) {
                
            }else{
            
            holesResult.text=[NSString stringWithFormat:@"%@",statisticalScorecard.par[index-10]];
            }
            // holesResult.text=@"as";
            
        }else if (index>=20&&index<30)
        {
           
            if ([self _valueOrNil:self.scorecard.score[index-20]]==nil ) {
                holesResult.text=@"";
            }else{
                holesResult.text=[NSString stringWithFormat:@"%@",self.scorecard.score[index-20]];
                
                
                
                /***********************************************/
                //设置成绩背景色
                
                int score=[self.scorecard.score[index-20] intValue];
                int par=[self.scorecard.par[index-20] intValue];
                //  ZCLog(@"%d",score-par);
                
                if ((score-par)==-3 &&(score-par)==-4) {
                    labelView.backgroundColor=ZCColor(32, 66, 171);
                }else if ((score-par)==-2){
                    labelView.backgroundColor=ZCColor(92, 132, 208);
                }else if ((score-par)==-1)
                {
                    labelView.backgroundColor=ZCColor(173, 195, 243);
                }else if ((score-par)==0)
                {
                    
                    labelView.backgroundColor=ZCColor(212, 212, 212);
                }else if ((score-par)==1)
                {
                    labelView.backgroundColor=ZCColor(213, 181, 58);
                }else if ((score-par)>=2)
                {
                    labelView.backgroundColor=ZCColor(200, 141, 25);
                }
                
                /***********************************************/
                
                
                
                
                
                
            }
            
        }else if(index>=30)
        {
            if ([self _valueOrNil:self.scorecard.status[index-30]] ==nil) {
                holesResult.text=@"";
            }else{
                holesResult.text=[NSString stringWithFormat:@"%@",self.scorecard.status[index-30]];
            }
        }
    }
}


//后九洞数值显示

-(void)addForAfterScoringView:(UIView *)afterScoringView
{
    
    // 0.总列数(一行最多3列)
    int totalColumns = 11;
    
    // 1.数字的尺寸
    CGFloat appW = (afterScoringView.frame.size.width-7)/11;
    CGFloat appH = (afterScoringView.frame.size.height-2.5)/4;
    
    // 2.间隙 = (控制器view的宽度 - 3 * 应用宽度) / 4
    //CGFloat marginX = (self.view.frame.size.width - totalColumns * appW) / (totalColumns + 1);
    CGFloat marginX = 0.5;
    CGFloat marginY = 0.5;
    
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
        [afterScoringView addSubview:labelView];
        labelView.backgroundColor=[UIColor whiteColor];
        labelView.textColor=ZCColor(85, 85, 85);
        labelView.textAlignment=NSTextAlignmentCenter;
        labelView.font=[UIFont systemFontOfSize:11];
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
            if ([self _valueOrNil:self.scorecard.par[index-1]]==nil) {
                
            }else{
            labelView.text=[NSString stringWithFormat:@"%@",self.scorecard.par[index-1]];
            }
        }else if (index>=22&&index<33)
        {
            if ( [self _valueOrNil:self.scorecard.score[index-12] ] ==nil) {
                labelView.text=@"";
            }else{
                labelView.text=[NSString stringWithFormat:@"%@",self.scorecard.score[index-12]];
    /***********************************************/
        //设置成绩背景色
                
                int score=[self.scorecard.score[index-12] intValue];
                int par=[self.scorecard.par[index-12] intValue];
              //  ZCLog(@"%d",score-par);
                
                if ((score-par)==-3 &&(score-par)==-4) {
                    labelView.backgroundColor=ZCColor(32, 66, 171);
                }else if ((score-par)==-2){
                labelView.backgroundColor=ZCColor(92, 132, 208);
                }else if ((score-par)==-1)
                {
                labelView.backgroundColor=ZCColor(173, 195, 243);
                }else if ((score-par)==0)
                {
                    
                 labelView.backgroundColor=ZCColor(212, 212, 212);
                }else if ((score-par)==1)
                {
                labelView.backgroundColor=ZCColor(213, 181, 58);
                }else if ((score-par)>=2)
                {
                    labelView.backgroundColor=ZCColor(200, 141, 25);
                }
                
    /***********************************************/
            }
            
        }else if(index>=33)
       {
            if ( [self _valueOrNil:self.scorecard.status[index-23]]==nil) {
                labelView.text=@"";
            }else{
                labelView.text=[NSString stringWithFormat:@"%@",self.scorecard.status[index-23]];
            }
            
        }
    }
}

//注释界面里面的内容
-(void)annotationContent:(UIView *)annotationView
{
    for (int i=0; i<6; i++) {
        UIView *tempview=[[UIView alloc] init];
        tempview.frame=CGRectMake(i*(SCREEN_WIDTH/6),0, SCREEN_WIDTH/6, 60);
        [annotationView addSubview:tempview];
        
        UIImageView *imageView=[[UIImageView alloc] init];
        
        imageView.frame=CGRectMake(5, 20, 10, 10);
        [tempview addSubview:imageView];
        UILabel *label=[[UILabel alloc] init];
        
        
        label.frame=CGRectMake(20, 15, 40, 20);
        label.textColor=ZCColor(85, 85, 85);
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



/**
 *  当scrollView正在滚动就会调用
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    CGFloat scrollW = scrollView.frame.size.width;

    int page = (scrollView.contentOffset.x + scrollW * 0.5) / scrollW;
    
    
    if (page==0) {
//        self.afterButton.backgroundColor=[UIColor redColor];
//        self.beforeButton.backgroundColor=[UIColor blueColor];
        
         self.imageView.image=[UIImage imageNamed:@"jstj_qianjiu"];
    }else
    {
       self.imageView.image=[UIImage imageNamed:@"jstj_houjiu"];    }


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


//点击后九洞
-(void)clickTheAfterButton
{
    self.imageView.image=[UIImage imageNamed:@"jstj_houjiu"];
    
//    self.afterButton.backgroundColor=[UIColor blueColor];
//    self.beforeButton.backgroundColor=[UIColor redColor];
    self.scoringScrollView.contentOffset=CGPointMake(self.scoringScrollView.frame.size.width, 0);

}

-(void)clickTheBeforeButton
{
     self.imageView.image=[UIImage imageNamed:@"jstj_qianjiu"];
//    self.afterButton.backgroundColor=[UIColor redColor];
//    self.beforeButton.backgroundColor=[UIColor blueColor];
    self.scoringScrollView.contentOffset=CGPointMake(0, 0);

}

@end
