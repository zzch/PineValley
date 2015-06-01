//
//  ZCShowButton.m
//  我爱高尔夫
//
//  Created by hh on 15/2/9.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCShowButton.h"
@interface ZCShowButton()
///*
// 成绩
// */
//@property(nonatomic,weak) UIButton *resultsView;
//
/*
 开杆距离
 */
@property(nonatomic,weak) UILabel *driving_distance_label;
/*
 求道方向
 */
@property(nonatomic,weak) UILabel *directionLabel;

/**
 * 罚杆数 成绩左
 */
@property (nonatomic, weak) UILabel *penaltiesLabel;
/**
 *  成绩中 总杆数
 */
@property (nonatomic, weak) UILabel *scoreLabel;
/**
 * 推杆数 成绩右
 */
@property (nonatomic, weak) UILabel *drivingNameLabel;
/**
 * 开杆距离前图片
 */
@property (nonatomic, weak) UIImageView *drivingImage;
/**
 * 求道方向前图片
 */
@property (nonatomic, weak) UIImageView *directionImage;

/**
 * 向右箭头图片
 */
@property (nonatomic, weak) UIImageView *rightImage;





@end
@implementation ZCShowButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
       // [self setBackgroundImage:[UIImage imageNamed:@"suoyou_bj_02"] forState:UIControlStateHighlighted];
//        //成绩
//        
//        UIButton *resultsView=[[UIButton alloc] init];
//        [self addSubview:resultsView];
//        self.resultsView=resultsView;
        
        //成绩左
        UILabel *penaltiesLabel=[[UILabel alloc] init];
        penaltiesLabel.text=@"成绩";
        [self addSubview:penaltiesLabel];
        penaltiesLabel.textColor=ZCColor(85, 85, 85);
        penaltiesLabel.font=[UIFont systemFontOfSize:19];
        penaltiesLabel.textAlignment=NSTextAlignmentCenter;
        self.penaltiesLabel=penaltiesLabel;
        
        
        //总杆数
        UILabel *scoreLabel=[[UILabel alloc] init];
       
        scoreLabel.textColor=ZCColor(255, 150, 29);
        scoreLabel.font=[UIFont fontWithName:@"Arial" size:30];
        scoreLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:scoreLabel];
        self.scoreLabel=scoreLabel;
        
        //开球
        UILabel *drivingNameLabel=[[UILabel alloc] init];
        drivingNameLabel.textColor=ZCColor(85, 85, 85);
        [self addSubview:drivingNameLabel];
        drivingNameLabel.text=@"开球";
        drivingNameLabel.font=[UIFont systemFontOfSize:19];
        drivingNameLabel.textAlignment=NSTextAlignmentCenter;
        self.drivingNameLabel=drivingNameLabel;
        
        //开杆距离
        UILabel *driving_distance_label=[[UILabel alloc] init];
        [self addSubview:driving_distance_label];
    
        driving_distance_label.textColor=ZCColor(255, 150, 29);
        //driving_distance_label.text=@"dasdsad";
        self.driving_distance_label=driving_distance_label;
//        //求道
//        UILabel *directionLabel=[[UILabel alloc] init];
//        
//        directionLabel.textColor=ZCColor(240, 208, 122);
//        //fairwayLabel.text=self.scorecard.fairwayText;
//        [self addSubview:directionLabel];
//        self.directionLabel=directionLabel;
//        /**
//         * 开杆距离前图片
//         */
//
//        UIImageView *drivingImage=[[UIImageView alloc] init];
//        [self addSubview:drivingImage];
//        
//        drivingImage.image=[UIImage imageNamed:@"jfk_qiugan"];
//        self.drivingImage=drivingImage;
//        
        
        /**
         * 求道方向前图片
         */

        UIImageView *directionImage=[[UIImageView alloc] init];
        [self addSubview:directionImage];
        
        
        self.directionImage=directionImage;
        
        /**
         * 向右箭头前图片
         */
        
        UIImageView *rightImage=[[UIImageView alloc] init];
        [self addSubview:rightImage];
        //drivingImage.backgroundColor=[UIColor blackColor];
        rightImage.image=[UIImage imageNamed:@"icon_arrow3"];
        self.rightImage=rightImage;


        
    }
    return self;
}

-(void)setScorecard:(ZCscorecard *)scorecard
{
    _scorecard=scorecard;
    
    if ([scorecard.score intValue]-[scorecard.par intValue]>=0&&[scorecard.score intValue]-[scorecard.par intValue]<2) {
        
        self.scoreLabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"dayu1"]];
        
    }else if ([scorecard.score intValue]-[scorecard.par intValue]>=2)
    {
    self.scoreLabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jfk_dayu2"]];
    }else if ([scorecard.score intValue]-[scorecard.par intValue]<0)
    {
    self.scoreLabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jfk_xiaoyu"]];
    }
    
    self.scoreLabel.text=[NSString stringWithFormat:@"%@",scorecard.score];
    
    
    
    //self.puttsLabel.text=[NSString stringWithFormat:@"%@",scorecard.putts];
   // self.penaltiesLabel.text=[NSString stringWithFormat:@"%@",scorecard.penalties];
    self.driving_distance_label.text=[NSString stringWithFormat:@"%@码",scorecard.driving_distance];
    
    if ([scorecard.direction isEqual:@"slice"] ||[scorecard.direction isEqual:@"右侧"]) {
        
        self.directionImage.image=[UIImage imageNamed:@"jfk_you_icon"];
        self.directionLabel.text=@"右侧";
    }else if ([scorecard.direction isEqual:@"pure"] ||[scorecard.direction isEqual:@"命中"])
    {
        self.directionImage.image=[UIImage imageNamed:@"jfk_zhong_icon"];
        self.directionLabel.text=@"命中";
    }else if ([scorecard.direction isEqual:@"hook"] ||[scorecard.direction isEqual:@"左侧"])
    {
        self.directionImage.image=[UIImage imageNamed:@"jfk_zuo_icon"];
        self.directionLabel.text=@"左侧";
    }
    
    

}



-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    
    
    
    //成绩左的frame
    
    CGFloat penaltiesLabelW=40;
    CGFloat penaltiesLabelH=15;
    
    CGFloat penaltiesLabelX=self.frame.size.width*0.0125;//self.frame.size.width*0.0625;
    CGFloat penaltiesLabelY=(self.frame.size.height-penaltiesLabelH)/2;
    
    self.penaltiesLabel.frame=CGRectMake(penaltiesLabelX, penaltiesLabelY, penaltiesLabelW, penaltiesLabelH);
    
    
    
    //总杆数的frame
    
    CGFloat scoreLabelW=50;
    CGFloat scoreLabelH=50;
    
    CGFloat scoreLabelX=penaltiesLabelX+penaltiesLabelW+self.frame.size.width*0.0625;
    CGFloat scoreLabelY=(self.frame.size.height-scoreLabelH)/2;
    
    
    self.scoreLabel.frame=CGRectMake(scoreLabelX, scoreLabelY, scoreLabelW, scoreLabelH);
    
    
//开球drivingNameLabel
    
    
    CGFloat drivingNameLabelW=penaltiesLabelW;
    CGFloat drivingNameLabelH=penaltiesLabelH;
    
    CGFloat drivingNameLabelX=scoreLabelX+scoreLabelW+self.frame.size.width*0.0625;
    CGFloat drivingNameLabelY=penaltiesLabelY;
    
    self.drivingNameLabel.frame=CGRectMake(drivingNameLabelX, drivingNameLabelY, drivingNameLabelW, drivingNameLabelH);
    
    
    
    
    
    //求道方向前图片
    CGFloat directionImageX=drivingNameLabelX+drivingNameLabelW+25;
    CGFloat directionImageY=(self.frame.size.height-60)/2;
    CGFloat directionImageW=25;
    CGFloat directionImageH=25;
    
    
    self.directionImage.frame=CGRectMake(directionImageX, directionImageY, directionImageW, directionImageH);

    
    
    //求道frame
    CGFloat driving_distance_labelX=directionImageX-10;
    CGFloat driving_distance_labelY=directionImageY+directionImageH+10;
    CGFloat driving_distance_labelW=50;
    CGFloat driving_distance_labelH=25;
    
    self.driving_distance_label.frame=CGRectMake(driving_distance_labelX, driving_distance_labelY, driving_distance_labelW, driving_distance_labelH);
    
    
//    //成绩frame
//    
//    CGFloat resultsViewX=0;
//    CGFloat resultsViewY=0;
//    CGFloat resultsViewW=self.frame.size.width*0.86;
//    CGFloat resultsViewH=self.frame.size.height*0.72;
//    self.resultsView.frame=CGRectMake(resultsViewX, resultsViewY, resultsViewW, resultsViewH);
//    /**
//     * 开杆距离前图片
//     */
//    CGFloat drivingImageX=self.frame.size.width*0.123;
//    CGFloat drivingImageY=resultsViewH+5;
//    CGFloat drivingImageW=22;
//    CGFloat drivingImageH=15;
//
//    
//    self.drivingImage.frame=CGRectMake(drivingImageX, drivingImageY, drivingImageW, drivingImageH);
//    
//    
//       //求道的值frame
//    CGFloat directionLabelX=directionImageX+directionImageW+5;
//    CGFloat directionLabelY=directionImageY;
//    CGFloat directionLabelW=35;
//    CGFloat directionLabelH=22;
//
//    
//    self.directionLabel.frame=CGRectMake(directionLabelX, directionLabelY, directionLabelW, directionLabelH);
//
    //向右箭头的图片
    CGFloat rightImageW=10;
    CGFloat rightImageH=17;
    CGFloat rightImageX=self.frame.size.width-rightImageW-10;
    CGFloat rightImageY=(self.frame.size.height-rightImageH)*0.5;
  

     self.rightImage.frame=CGRectMake(rightImageX, rightImageY, rightImageW, rightImageH);
    
    
    
    
//    //成绩右的frame
//    CGFloat puttsLabelW=20;
//    CGFloat puttsLabelH=15;
//    
//    CGFloat puttsLabelX=scoreLabelX+scoreLabelW;
//    CGFloat puttsLabelY=scoreLabelY+scoreLabelH-5;
//
//    
//    self.puttsLabel.frame=CGRectMake(puttsLabelX, puttsLabelY, puttsLabelW, puttsLabelH);
    
}


@end
