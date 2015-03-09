//
//  ZCScorecarTableViewCell.m
//  我爱高尔夫
//
//  Created by hh on 15/2/4.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCScorecarTableViewCell.h"
#import "ZCFillViewController.h"
#import "ZCShowButton.h"
@interface ZCScorecarTableViewCell()
/*
 创建球洞
 */
@property(nonatomic,weak) UILabel *numberLabel;
/*
 标准杆label
 */
@property(nonatomic,weak) UILabel *parLabel;
/*
距离球洞位置
 */
@property(nonatomic,weak) UILabel *distanceLabel;
/*
 小P的Label
 */
@property(nonatomic,weak) UILabel *PLabel;
/*
 小Y的Label
 */
@property(nonatomic,weak) UILabel *YLabel;




/*
 加号图片
 */
@property(nonatomic,weak) UILabel *addImage;

/*
 显示值的按钮
 */
@property(nonatomic,weak) UILabel *showLabel;





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
@implementation ZCScorecarTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //创建球洞编号
        UILabel *numberLabel=[[UILabel alloc] init];
        [self.contentView addSubview:numberLabel];
//        ballLabel.text=@"A1";
        numberLabel.textAlignment=NSTextAlignmentCenter;
        //ballLabel.font=[UIFont fontWithName:@"Helvetica" size:20];
        numberLabel.font=[UIFont systemFontOfSize:30];
        self.numberLabel=numberLabel;
       
        //创建标准杆
        UILabel *parLabel=[[UILabel alloc] init];
        [self.contentView addSubview:parLabel];
       // poleCount.text=@"8";
        parLabel.textAlignment=NSTextAlignmentCenter;
        parLabel.font=[UIFont systemFontOfSize:21];
        self.parLabel=parLabel;
        //创建离球洞距离的Label
        UILabel *distanceLabel=[[UILabel alloc] init];
        [self.contentView addSubview:distanceLabel];
        distanceLabel.font=[UIFont systemFontOfSize:21];
        self.distanceLabel=distanceLabel;
        
        //创建小P label
        UILabel *PLabel=[[UILabel alloc] init];
        [self.contentView addSubview:PLabel];
        PLabel.text=@"P";
       // PLabel.backgroundColor=[UIColor blueColor];
        self.PLabel=PLabel;
        
        //创建小Y label
        UILabel *YLabel=[[UILabel alloc] init];
        [self.contentView addSubview:YLabel];
        YLabel.text=@"Y";
       // YLabel.backgroundColor=[UIColor blueColor];
        self.YLabel=YLabel;
        
        //创建可显示信息值的showLabel
        if (self.scorecard.score==nil) {
            
            //创建加号图片
            UILabel *addImage=[[UILabel alloc] init];
            [self.contentView addSubview:addImage];
             addImage.backgroundColor=[UIColor blueColor];
             self.addImage=addImage;
            
            addImage.text=@"+++++";
        }else{
        UILabel *showLabel=[[UILabel alloc] init];
        [self.contentView addSubview:showLabel];
        self.showLabel=showLabel;
        }
        
//        ZCShowButton *showLabel=[[ZCShowButton alloc] init];
//        [self.contentView addSubview:showLabel];
//        showLabel.scorecard=self.scorecard;
//        self.showLabel=showLabel;
//
        
     //   showLabel.backgroundColor=[UIColor redColor];
       
//        //创建可显示信息值的button
//        ZCShowButton *showButton=[[ZCShowButton alloc] init];
//        [self.contentView addSubview:showButton];
//       // showButton.backgroundColor=[UIColor redColor];
//        self.showButton=showButton;
//        showButton.scorecard=self.scorecard;
//         //ZCLog(@"000000%@",_scorecard.leftText);
//        [showButton addTarget:self action:@selector(addImageClick:) forControlEvents:UIControlEventTouchUpInside];
       
        
        
        
//        //创建加号图片
//        UIButton *addImage=[[UIButton alloc] init];
//        [self.contentView addSubview:addImage];
//        addImage.backgroundColor=[UIColor blueColor];
//        self.addImage=addImage;
//        [addImage setTitle:@"+++++" forState:UIControlStateNormal];
//        [addImage addTarget:self action:@selector(addImageClick:) forControlEvents:UIControlEventTouchUpInside];
        
//        BOOL baocun=YES;
//        if (baocun) {
//            addImage.hidden=YES;
//        }else
//        {
//            addImage.hidden=NO;
//        }
        
        
        
        
//        //成绩
//        
//        UIView *resultsView=[[UIView alloc] init];
//        [self.showLabel addSubview:resultsView];
//        resultsView.backgroundColor=[UIColor redColor];
//        self.resultsView=resultsView;
//        
//        //成绩左
//        UILabel *penaltiesLabel=[[UILabel alloc] initWithFrame:CGRectMake(40, 40, 40, 40)];
//        [resultsView addSubview:penaltiesLabel];
//        penaltiesLabel.backgroundColor=[UIColor whiteColor];
//        penaltiesLabel.textColor=[UIColor blackColor];
//        self.penaltiesLabel=penaltiesLabel;
//        //总杆数
//        UILabel *scoreLabel=[[UILabel alloc] initWithFrame:CGRectMake(80, 10, 40, 50)];
//        // scoreLabel.backgroundColor=[UIColor blackColor];
//        scoreLabel.textColor=[UIColor blackColor];
//        
//        [resultsView addSubview:scoreLabel];
//        self.scoreLabel=scoreLabel;
//        
//        //推杆数 成绩右
//        UILabel *puttsLabel=[[UILabel alloc] initWithFrame:CGRectMake(130, 40, 40, 30)];
//        puttsLabel.backgroundColor=[UIColor whiteColor];
//        puttsLabel.textColor=[UIColor blackColor];
//        [resultsView addSubview:puttsLabel];
//        self.puttsLabel=puttsLabel;
//        
//        //开杆距离
//        UILabel *driving_distance_label=[[UILabel alloc] init];
//        [self.showLabel addSubview:driving_distance_label];
//        driving_distance_label.backgroundColor=[UIColor blueColor];
//        driving_distance_label.textColor=[UIColor blackColor];
//        //driving_distance_label.text=@"dasdsad";
//        self.driving_distance_label=driving_distance_label;
//        //求道
//        UILabel *directionLabel=[[UILabel alloc] init];
//        directionLabel.backgroundColor=[UIColor blueColor];
//        directionLabel.textColor=[UIColor  blackColor];
//        //fairwayLabel.text=self.scorecard.fairwayText;
//        [self.showLabel addSubview:directionLabel];
//        self.directionLabel=directionLabel;
//        /**
//         * 开杆距离前图片
//         */
//        
//        UIImageView *drivingImage=[[UIImageView alloc] init];
//        [self.showLabel addSubview:drivingImage];
//        drivingImage.backgroundColor=[UIColor blueColor];
//        drivingImage.image=[UIImage imageNamed:@"qiugan"];
//        self.drivingImage=drivingImage;
//        
//        
//        /**
//         * 求道方向前图片
//         */
//        
//        UIImageView *directionImage=[[UIImageView alloc] init];
//        [self.showLabel addSubview:directionImage];
//        //drivingImage.backgroundColor=[UIColor blackColor];
//        directionImage.image=[UIImage imageNamed:@"you"];
//        self.directionImage=directionImage;
//        
//        /**
//         * 向右箭头前图片
//         */
//        
//        UIImageView *rightImage=[[UIImageView alloc] init];
//        [self.showLabel addSubview:rightImage];
//        //drivingImage.backgroundColor=[UIColor blackColor];
//        rightImage.image=[UIImage imageNamed:@"navigationbar_back_highlighted"];
//        self.rightImage=rightImage;
//        
//
        
        
    }

    return self;
}

////点击addImage
//-(void)addImageClick:(UIButton *)sender
//{
//    
//    
//   //创建代理，通知控制器+号被点击了
//    if ([self.delegate respondsToSelector:@selector(addImageDidClick:)]) {
//        [self.delegate addImageDidClick:sender];
//    }
//
//}

-(void)setScorecard:(ZCscorecard *)scorecard
{
    _scorecard=scorecard;
    
    if(self.scorecard.score)
    {
        if (self.addImage) {
            [self.addImage removeFromSuperview];
        }
        if (self.showLabel) {
            [self.showLabel removeFromSuperview];
        }
        //创建可显示的showLabel
        ZCShowButton *showLabel=[[ZCShowButton alloc] init];
        showLabel.scorecard=scorecard;
        [self.contentView addSubview:showLabel];
        //showLabel.backgroundColor=[UIColor redColor];
        self.showLabel=showLabel;
        
       
        
    }

    
    
    self.numberLabel.text=[NSString stringWithFormat:@"%@",scorecard.number];
    self.parLabel.text=[NSString stringWithFormat:@"%@",scorecard.par];
    self.distanceLabel.text=[NSString stringWithFormat:@"%@",scorecard.distance_from_hole_to_tee_box];
    
//
//    
//    self.scoreLabel.text=[NSString stringWithFormat:@"%@",scorecard.score];
//    self.puttsLabel.text=[NSString stringWithFormat:@"%@",scorecard.putts];
//    self.penaltiesLabel.text=[NSString stringWithFormat:@"%@",scorecard.penalties];
//    self.driving_distance_label.text=[NSString stringWithFormat:@"%@",scorecard.driving_distance];
//    self.directionLabel.text=[NSString stringWithFormat:@"%@",scorecard.direction];
//    
    
    
}
//-(void)setScorecard:(ZCScorecards *)scorecard
//{
//    _scorecard=scorecard;
//    
//     self.ballLabel.text=scorecard.number;

//    if (scorecard.save) {
//        [self.addImage removeFromSuperview];
//        //移除之前的button按钮
//        [self.showButton removeFromSuperview];
//        //创建可显示信息值的button
//        ZCShowButton *showButton=[[ZCShowButton alloc] init];
//        [self.contentView addSubview:showButton];
//        showButton.backgroundColor=[UIColor redColor];
//        self.showButton=showButton;
//        showButton.scorecard=self.scorecard;
//        //ZCLog(@"000000%@",_scorecard.leftText);
//        [showButton addTarget:self action:@selector(addImageClick:) forControlEvents:UIControlEventTouchUpInside];
//        

 //   }
    
    
   //ZCLog(@"11111111111111111%@",scorecard.leftText);
   
//}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //创建球洞ballLabel的frame
    CGFloat ballLabelX=0;
    CGFloat ballLabelY=0;
    CGFloat ballLabelW=150;
    CGFloat ballLabelH=self.frame.size.height-40;

    self.numberLabel.frame=CGRectMake(ballLabelX, ballLabelY, ballLabelW, ballLabelH);
    
    //parLabel的frame
    CGFloat parLabelX=10;
    CGFloat parLabelY=ballLabelH;
    CGFloat parLabelW=25;
    CGFloat parLabelH=40;
    
    self.parLabel.frame=CGRectMake(parLabelX, parLabelY, parLabelW, parLabelH);

    
    //小P得PLabel的frame
    CGFloat PLabelX=parLabelX+parLabelW;
    CGFloat PLabelY=ballLabelH+20;
    CGFloat PLabelW=15;
    CGFloat PLabelH=15;
    self.PLabel.frame=CGRectMake(PLabelX, PLabelY, PLabelW, PLabelH);
    //距离球洞的距离distanceLabel的frame
    
    CGFloat distanceLabelX=PLabelX+PLabelW+10;
    CGFloat distanceLabelY=parLabelY;
    CGFloat distanceLabelW=40;
    CGFloat distanceLabelH=40;
    self.distanceLabel.frame=CGRectMake(distanceLabelX, distanceLabelY, distanceLabelW, distanceLabelH);
    //小Y得YLabel的frame
    CGFloat YLabelX=distanceLabelX+distanceLabelW;
    CGFloat YLabelY=parLabelY+20;
    CGFloat YLabelW=15;
    CGFloat YLabelH=15;
    self.YLabel.frame=CGRectMake(YLabelX, YLabelY, YLabelW, YLabelH);
    
    //showButton的frame
    CGFloat showLabelX=ballLabelW;
    CGFloat showLabelY=ballLabelY;
    CGFloat showLabelW=self.frame.size.width-ballLabelW;
    CGFloat showLabelH=self.frame.size.height;
    self.showLabel.frame=CGRectMake(showLabelX, showLabelY, showLabelW, showLabelH);
    
    
    //addImage的frame
   // self.addImage.frame=self.showButton.bounds;
    
    //showButton的frame
    CGFloat addImageX=ballLabelW;
    CGFloat addImageY=ballLabelY;
    CGFloat addImageW=self.frame.size.width-ballLabelW;
    CGFloat addImageH=self.frame.size.height;
    self.addImage.frame=CGRectMake(addImageX, addImageY, addImageW, addImageH);
    
    
    
//    //成绩frame
//    self.resultsView.frame=CGRectMake(0, 0, self.frame.size.width-40, 70);
//    
//    // distanceLabel的frame
//    self.drivingImage.frame=CGRectMake(10, 70, 15, 15);
//    
//    //求道frame
//    self.driving_distance_label.frame=CGRectMake(30, 70, 40, 30);
//    //求道方向前图片
//    self.directionImage.frame=CGRectMake(70, 70, 20, 20);
//    //求道的值frame
//    self.directionLabel.frame=CGRectMake(100, 70, 50, 30);
//    
//    //向右箭头的图片
//    self.rightImage.frame=CGRectMake(self.frame.size.width-30, 20, 40, 30);
//    
//

}






- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

@end
