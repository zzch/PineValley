//
//  ZCShowButton.m
//  我爱高尔夫
//
//  Created by hh on 15/2/9.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCShowButton.h"
@interface ZCShowButton()
/*
 成绩
 */
@property(nonatomic,weak) UIView *resultsView;

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
@property (nonatomic, weak) UILabel *puttsLabel;
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
        
        
        //成绩
        
        UIView *resultsView=[[UIView alloc] init];
        [self addSubview:resultsView];
        self.resultsView=resultsView;
        
        //成绩左
        UILabel *penaltiesLabel=[[UILabel alloc] init];
        [resultsView addSubview:penaltiesLabel];
        penaltiesLabel.textColor=ZCColor(208, 210, 212);
        self.penaltiesLabel=penaltiesLabel;
        //总杆数
        UILabel *scoreLabel=[[UILabel alloc] init];
       
        scoreLabel.textColor=ZCColor(208, 210, 212);
        scoreLabel.font=[UIFont fontWithName:@"Arial" size:49];
        scoreLabel.textAlignment=NSTextAlignmentCenter;
        [resultsView addSubview:scoreLabel];
        self.scoreLabel=scoreLabel;
        
        //推杆数 成绩右
        UILabel *puttsLabel=[[UILabel alloc] init];
        puttsLabel.textColor=ZCColor(208, 210, 212);
        [resultsView addSubview:puttsLabel];
        self.puttsLabel=puttsLabel;
        
        //开杆距离
        UILabel *driving_distance_label=[[UILabel alloc] init];
        [self addSubview:driving_distance_label];
    
        driving_distance_label.textColor=ZCColor(208, 210, 212);
        //driving_distance_label.text=@"dasdsad";
        self.driving_distance_label=driving_distance_label;
        //求道
        UILabel *directionLabel=[[UILabel alloc] init];
        
        directionLabel.textColor=ZCColor(208, 210, 212);
        //fairwayLabel.text=self.scorecard.fairwayText;
        [self addSubview:directionLabel];
        self.directionLabel=directionLabel;
        /**
         * 开杆距离前图片
         */

        UIImageView *drivingImage=[[UIImageView alloc] init];
        [self addSubview:drivingImage];
        
        drivingImage.image=[UIImage imageNamed:@"jfk_gaoerfuqiu"];
        self.drivingImage=drivingImage;
        
        
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
        rightImage.image=[UIImage imageNamed:@"jfk_youjiantou"];
        self.rightImage=rightImage;


        
    }
    return self;
}

-(void)setScorecard:(ZCscorecard *)scorecard
{
    _scorecard=scorecard;
    
    self.scoreLabel.text=[NSString stringWithFormat:@"%@",scorecard.score];
    self.puttsLabel.text=[NSString stringWithFormat:@"%@",scorecard.putts];
    self.penaltiesLabel.text=[NSString stringWithFormat:@"%@",scorecard.penalties];
    self.driving_distance_label.text=[NSString stringWithFormat:@"%@",scorecard.driving_distance];
    
    if ([scorecard.direction isEqual:@"slice"] ||[scorecard.direction isEqual:@"右侧"]) {
        
        self.directionImage.image=[UIImage imageNamed:@"jfk_hole_right"];
        self.directionLabel.text=@"右侧";
    }else if ([scorecard.direction isEqual:@"pure"] ||[scorecard.direction isEqual:@"命中"])
    {
        self.directionImage.image=[UIImage imageNamed:@"jfk_mingzhong"];
        self.directionLabel.text=@"命中";
    }else if ([scorecard.direction isEqual:@"hook"] ||[scorecard.direction isEqual:@"左侧"])
    {
        self.directionImage.image=[UIImage imageNamed:@"jfk_hole_left"];
        self.directionLabel.text=@"左侧";
    }
    
    

}

//-(void)setScorecard:(ZCScorecard *)scorecard
//{
//    _scorecard=scorecard;
//    

//    //赋值
//    self.resultsLeft.text=scorecard.leftText;
//    self.resultsMiddle.text=scorecard.middleText;
//    self.resultsRight.text=scorecard.rightText;
//    self.distanceLabel.text=scorecard.distanceText;
//    //self.fairwayLabel.text=scorecard.fairwayText;
//    [self.fairwayLabel setText:scorecard.fairwayText];
  
//}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //成绩frame
    
    CGFloat resultsViewX=0;
    CGFloat resultsViewY=0;
    CGFloat resultsViewW=self.frame.size.width*0.86;
    CGFloat resultsViewH=self.frame.size.height*0.72;
    self.resultsView.frame=CGRectMake(resultsViewX, resultsViewY, resultsViewW, resultsViewH);
    /**
     * 开杆距离前图片
     */
    CGFloat drivingImageX=self.frame.size.width*0.123;
    CGFloat drivingImageY=resultsViewH+5;
    CGFloat drivingImageW=22;
    CGFloat drivingImageH=15;

    
    self.drivingImage.frame=CGRectMake(drivingImageX, drivingImageY, drivingImageW, drivingImageH);
    
    //求道frame
    CGFloat driving_distance_labelX=drivingImageX+drivingImageW+5;
    CGFloat driving_distance_labelY=drivingImageY-5;
    CGFloat driving_distance_labelW=50;
    CGFloat driving_distance_labelH=25;
    
    self.driving_distance_label.frame=CGRectMake(driving_distance_labelX, driving_distance_labelY, driving_distance_labelW, driving_distance_labelH);
    //求道方向前图片
    CGFloat directionImageX=driving_distance_labelX+driving_distance_labelW+25;
    CGFloat directionImageY=driving_distance_labelY;
    CGFloat directionImageW=25;
    CGFloat directionImageH=25;

    
     self.directionImage.frame=CGRectMake(directionImageX, directionImageY, directionImageW, directionImageH);
    //求道的值frame
    CGFloat directionLabelX=directionImageX+directionImageW+5;
    CGFloat directionLabelY=directionImageY;
    CGFloat directionLabelW=35;
    CGFloat directionLabelH=22;

    
    self.directionLabel.frame=CGRectMake(directionLabelX, directionLabelY, directionLabelW, directionLabelH);

    //向右箭头的图片
    CGFloat rightImageW=10;
    CGFloat rightImageH=17;
    CGFloat rightImageX=resultsViewW+10;
    CGFloat rightImageY=(self.frame.size.height-rightImageH)*0.5;
  

     self.rightImage.frame=CGRectMake(rightImageX, rightImageY, rightImageW, rightImageH);
    
    
    //总杆数的frame
    
    CGFloat scoreLabelW=70;
    CGFloat scoreLabelH=55;

    CGFloat scoreLabelX=(self.frame.size.width-scoreLabelW)*0.5;
    CGFloat scoreLabelY=self.resultsView.frame.size.height*0.20;
    
    
    self.scoreLabel.frame=CGRectMake(scoreLabelX, scoreLabelY, scoreLabelW, scoreLabelH);
    
    //成绩左的frame
    
    CGFloat penaltiesLabelW=15;
    CGFloat penaltiesLabelH=15;
    
    CGFloat penaltiesLabelX=scoreLabelX-10;
    CGFloat penaltiesLabelY=scoreLabelY+scoreLabelH-5;
    
    self.penaltiesLabel.frame=CGRectMake(penaltiesLabelX, penaltiesLabelY, penaltiesLabelW, penaltiesLabelH);
    
    
    //成绩右的frame
    CGFloat puttsLabelW=15;
    CGFloat puttsLabelH=15;
    
    CGFloat puttsLabelX=scoreLabelX+scoreLabelW;
    CGFloat puttsLabelY=scoreLabelY+scoreLabelH-5;

    
    self.puttsLabel.frame=CGRectMake(puttsLabelX, puttsLabelY, puttsLabelW, puttsLabelH);
    
}


@end
