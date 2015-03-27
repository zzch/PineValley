//
//  ZCScorecarTableViewCell.m
//  我爱高尔夫
//
//  Created by hh on 15/2/4.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCScorecarTableViewCell.h"

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
@property(nonatomic,weak) UIView *addImage;

/*
 显示值的按钮
 */
@property(nonatomic,weak) UILabel *showLabel;





/*
  左边view
 */
@property(nonatomic,weak) UIView *liftView;

/*
 中间view
 */
@property(nonatomic,weak) UIView *middleView;

@property(nonatomic,weak) UIImageView *image1;



@end
@implementation ZCScorecarTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //背景
         self.backgroundView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jifenka_yihangbeijing"]];
        
        //左边view
        UIView *liftView=[[UIView alloc] init];
        [self.contentView addSubview:liftView];
        self.liftView=liftView;
        
        //中间view
        UIView *middleView=[[UIView alloc] init];
        [self.contentView addSubview:middleView];
        self.middleView=middleView;
        self.middleView.backgroundColor=[UIColor blackColor];

        
        //创建球洞编号
        UILabel *numberLabel=[[UILabel alloc] init];
        [self.liftView addSubview:numberLabel];
        numberLabel.textAlignment=NSTextAlignmentCenter;
        //ballLabel.font=[UIFont fontWithName:@"Helvetica" size:20];
        
        numberLabel.font=[UIFont systemFontOfSize:30];
        numberLabel.textColor=ZCColor(208, 210, 212);
        self.numberLabel=numberLabel;
       
        //创建标准杆
        UILabel *parLabel=[[UILabel alloc] init];
        [self.liftView addSubview:parLabel];
        parLabel.textColor=ZCColor(208, 210, 212);
        parLabel.textAlignment=NSTextAlignmentCenter;
       // parLabel.font=[UIFont systemFontOfSize:26];
        parLabel.font=[UIFont fontWithName:@"Arial" size:26];
        self.parLabel=parLabel;
        //创建离球洞距离的Label
        UILabel *distanceLabel=[[UILabel alloc] init];
        [self.liftView addSubview:distanceLabel];
        distanceLabel.font=[UIFont systemFontOfSize:21];
        self.distanceLabel=distanceLabel;
        self.distanceLabel.font=[UIFont fontWithName:@"Arial" size:26];
        distanceLabel.textColor=ZCColor(208, 210, 212);
        //创建小P label
        UILabel *PLabel=[[UILabel alloc] init];
        [self.liftView addSubview:PLabel];
        PLabel.text=@"P";
        PLabel.textColor=ZCColor(208, 210, 212);
       // PLabel.backgroundColor=[UIColor blueColor];
        self.PLabel=PLabel;
        
        //创建小Y label
        UILabel *YLabel=[[UILabel alloc] init];
        [self.liftView addSubview:YLabel];
        YLabel.text=@"Y";
        YLabel.textColor=ZCColor(208, 210, 212);
       // YLabel.backgroundColor=[UIColor blueColor];
        self.YLabel=YLabel;
        
        //创建可显示信息值的showLabel
        if (self.scorecard.score==nil) {
            
            //创建加号图片
            
            UIView *addImage=[[UIView alloc] init];
            [self.contentView addSubview:addImage];
            UIColor *col=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jifenka_yihangbeijing"]];
            addImage.backgroundColor=col;
             self.addImage=addImage;
            
            
            UIImageView *image=[[UIImageView alloc] init];
            
                       image.image=[UIImage imageNamed:@"tiejia"];
             [self.addImage addSubview:image];
            self.image1=image;
            
           
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
    
    if ([scorecard.tee_box_color isEqual:@"red"]) {
        UIColor *col=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jfk_hong"]];
        self.numberLabel.backgroundColor=col;
        
    }else if ([scorecard.tee_box_color isEqual:@"white"])
    {
      UIColor *col=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jfk_bai"]];
        self.numberLabel.backgroundColor=col;
    }else if ([scorecard.tee_box_color isEqual:@"blue"])
    {
        UIColor *col=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jfk_lan"]];
        self.numberLabel.backgroundColor=col;

    }else if ([scorecard.tee_box_color isEqual:@"black"])
    {
        UIColor *col=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jfk_hei"]];
        self.numberLabel.backgroundColor=col;

    }else if ([scorecard.tee_box_color isEqual:@"gold"])
    {
        UIColor *col=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jfk_huang"]];
        self.numberLabel.backgroundColor=col;

    }
    
   
    
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
    
    //创建左边View的frame
    CGFloat liftViewX=0;
    CGFloat liftViewY=0;
    CGFloat liftViewW=self.frame.size.width*0.39;
    CGFloat liftViewH=self.frame.size.height;
    
    self.liftView.frame=CGRectMake(liftViewX, liftViewY, liftViewW, liftViewH);

    //创建中间的view
    
    CGFloat middleViewX=liftViewW;
    CGFloat middleViewY=0;
    CGFloat middleViewW=1;
    CGFloat middleViewH=self.frame.size.height;

    self.middleView.frame=CGRectMake(middleViewX, middleViewY, middleViewW, middleViewH);
    
    //创建球洞ballLabel的frame
    
    CGFloat ballLabelW=62;
    CGFloat ballLabelH=62;
    CGFloat ballLabelX=(self.liftView.frame.size.width-ballLabelW)*0.5;
    CGFloat ballLabelY=self.liftView.frame.size.height*0.152;

    self.numberLabel.frame=CGRectMake(ballLabelX, ballLabelY, ballLabelW, ballLabelH);
    
    //parLabel的frame
    CGFloat parLabelX=self.liftView.frame.size.width*0.192;
    CGFloat parLabelY=ballLabelY+ballLabelH+10;
    CGFloat parLabelW=22;
    CGFloat parLabelH=22;
    
    self.parLabel.frame=CGRectMake(parLabelX, parLabelY, parLabelW, parLabelH);

    
    //小P得PLabel的frame
    CGFloat PLabelX=parLabelX+parLabelW-3;
    CGFloat PLabelY=parLabelY+(parLabelH*0.5);
    CGFloat PLabelW=15;
    CGFloat PLabelH=15;
    self.PLabel.frame=CGRectMake(PLabelX, PLabelY, PLabelW, PLabelH);
    //距离球洞的距离distanceLabel的frame
    
    CGFloat distanceLabelX=PLabelX+PLabelW+5;
    CGFloat distanceLabelY=parLabelY;
    CGFloat distanceLabelW=45;
    CGFloat distanceLabelH=22;
    self.distanceLabel.frame=CGRectMake(distanceLabelX, distanceLabelY, distanceLabelW, distanceLabelH);
    //小Y得YLabel的frame
    CGFloat YLabelX=distanceLabelX+distanceLabelW;
    CGFloat YLabelY=distanceLabelY+(distanceLabelH*0.5);
    CGFloat YLabelW=15;
    CGFloat YLabelH=15;
    self.YLabel.frame=CGRectMake(YLabelX, YLabelY, YLabelW, YLabelH);
    
    //showButton的frame
    CGFloat showLabelX=middleViewX+middleViewW;
    CGFloat showLabelY=0;
    CGFloat showLabelW=self.frame.size.width-showLabelX;
    CGFloat showLabelH=self.frame.size.height;
    self.showLabel.frame=CGRectMake(showLabelX, showLabelY, showLabelW, showLabelH);
    
    
    //addImage的frame
   // self.addImage.frame=self.showButton.bounds;
    
    //showButton的frame
    CGFloat addImageX=middleViewX+middleViewW;
    CGFloat addImageY=0;
    CGFloat addImageW=self.frame.size.width-addImageX;
    CGFloat addImageH=self.frame.size.height;
    self.addImage.frame=CGRectMake(addImageX, addImageY, addImageW, addImageH);
    
    
    
    
    CGFloat  imageX=(self.addImage.frame.size.width-self.addImage.frame.size.width*0.117)*0.5;
    CGFloat  imageY=(self.addImage.frame.size.height-self.addImage.frame.size.height*0.24)*0.5;
    CGFloat  imageW=self.addImage.frame.size.width*0.117;
    CGFloat  imageH=self.addImage.frame.size.height*0.24;
    self.image1.frame=CGRectMake(imageX, imageY, imageW, imageH);

    
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
