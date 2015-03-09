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
        resultsView.backgroundColor=[UIColor redColor];
        self.resultsView=resultsView;
        
        //成绩左
        UILabel *penaltiesLabel=[[UILabel alloc] initWithFrame:CGRectMake(40, 40, 40, 40)];
        [resultsView addSubview:penaltiesLabel];
        penaltiesLabel.backgroundColor=[UIColor whiteColor];
        penaltiesLabel.textColor=[UIColor blackColor];
        self.penaltiesLabel=penaltiesLabel;
        //总杆数
        UILabel *scoreLabel=[[UILabel alloc] initWithFrame:CGRectMake(80, 10, 40, 50)];
       // scoreLabel.backgroundColor=[UIColor blackColor];
        scoreLabel.textColor=[UIColor blackColor];
        
        [resultsView addSubview:scoreLabel];
        self.scoreLabel=scoreLabel;
        
        //推杆数 成绩右
        UILabel *puttsLabel=[[UILabel alloc] initWithFrame:CGRectMake(130, 40, 40, 30)];
        puttsLabel.backgroundColor=[UIColor whiteColor];
        puttsLabel.textColor=[UIColor blackColor];
        [resultsView addSubview:puttsLabel];
        self.puttsLabel=puttsLabel;
        
        //开杆距离
        UILabel *driving_distance_label=[[UILabel alloc] init];
        [self addSubview:driving_distance_label];
        driving_distance_label.backgroundColor=[UIColor blueColor];
        driving_distance_label.textColor=[UIColor blackColor];
        //driving_distance_label.text=@"dasdsad";
        self.driving_distance_label=driving_distance_label;
        //求道
        UILabel *directionLabel=[[UILabel alloc] init];
        directionLabel.backgroundColor=[UIColor blueColor];
        directionLabel.textColor=[UIColor  blackColor];
        //fairwayLabel.text=self.scorecard.fairwayText;
        [self addSubview:directionLabel];
        self.directionLabel=directionLabel;
        /**
         * 开杆距离前图片
         */

        UIImageView *drivingImage=[[UIImageView alloc] init];
        [self addSubview:drivingImage];
        drivingImage.backgroundColor=[UIColor blueColor];
        drivingImage.image=[UIImage imageNamed:@"qiugan"];
        self.drivingImage=drivingImage;
        
        
        /**
         * 求道方向前图片
         */

        UIImageView *directionImage=[[UIImageView alloc] init];
        [self addSubview:directionImage];
        //drivingImage.backgroundColor=[UIColor blackColor];
        directionImage.image=[UIImage imageNamed:@"you"];
        self.directionImage=directionImage;
        
        /**
         * 向右箭头前图片
         */
        
        UIImageView *rightImage=[[UIImageView alloc] init];
        [self addSubview:rightImage];
        //drivingImage.backgroundColor=[UIColor blackColor];
        rightImage.image=[UIImage imageNamed:@"navigationbar_back_highlighted"];
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
    self.directionLabel.text=[NSString stringWithFormat:@"%@",scorecard.direction];

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
    self.resultsView.frame=CGRectMake(0, 0, self.frame.size.width-40, 70);
    
   // distanceLabel的frame
    self.drivingImage.frame=CGRectMake(10, 70, 15, 15);
    
    //求道frame
    self.driving_distance_label.frame=CGRectMake(30, 70, 40, 30);
    //求道方向前图片
     self.directionImage.frame=CGRectMake(70, 70, 20, 20);
    //求道的值frame
    self.directionLabel.frame=CGRectMake(100, 70, 50, 30);

    //向右箭头的图片
     self.rightImage.frame=CGRectMake(self.frame.size.width-30, 20, 40, 30);

}


@end
