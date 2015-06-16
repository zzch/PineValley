//
//  ZCNilButtom.m
//  iGolf
//
//  Created by hh on 15/5/12.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCNilButtom.h"
@interface ZCNilButtom()
@property(nonatomic,weak)UILabel *fristLabel;
@property(nonatomic,weak)UILabel *secondLabel;
@property(nonatomic,weak)UILabel *thirdLabel;
@property(nonatomic,weak)UILabel *fourthLabel;
@property(nonatomic,weak)UILabel *fifthLabel;


/**
 * 向右箭头图片
 */
@property (nonatomic, weak) UIImageView *rightImage;
@end
@implementation ZCNilButtom


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        UILabel *fristLabel=[[UILabel alloc] init];
        
        [self addSubview:fristLabel];
        fristLabel.textColor=[UIColor whiteColor];
        fristLabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"hong_mr"]];
         fristLabel.textAlignment=NSTextAlignmentCenter;
        self.fristLabel=fristLabel;
        
        
        UILabel *secondLabel=[[UILabel alloc] init];
        //secondLabel.textColor=ZCColor(240, 208, 122);
        secondLabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bai_mr"]];
         secondLabel.textAlignment=NSTextAlignmentCenter;
        secondLabel.hidden=YES;
        [self addSubview:secondLabel];
        self.secondLabel=secondLabel;
        
        
        UILabel *thirdLabel=[[UILabel alloc] init];
        thirdLabel.hidden=YES;
        thirdLabel.textColor=[UIColor whiteColor];
         thirdLabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"lan_mr"]];
         thirdLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:thirdLabel];
        self.thirdLabel=thirdLabel;

        
        UILabel *fourthLabel=[[UILabel alloc] init];
        fourthLabel.textColor=[UIColor whiteColor];
       fourthLabel.hidden=YES;
        fourthLabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"hei_mr"]];
         fourthLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:fourthLabel];
        self.fourthLabel=fourthLabel;

        
        
        UILabel *fifthLabel=[[UILabel alloc] init];
         fifthLabel.hidden=YES;
        fifthLabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jin_mr"]];
        fifthLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:fifthLabel];
        self.fifthLabel=fifthLabel;


        
        
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


-(void)setTee_boxes:(NSMutableArray *)tee_boxes
{
    
    ZCLog(@"%@",tee_boxes);
    _tee_boxes=tee_boxes;
   
    self.fristLabel.text=[NSString stringWithFormat:@"%@",[tee_boxes[0] distance_from_hole]];
    
    if (tee_boxes.count>=2) {
        self.secondLabel.hidden=NO;
        self.secondLabel.text=[NSString stringWithFormat:@"%@",[tee_boxes[1] distance_from_hole]];
    }

    
    
    if (tee_boxes.count>=3) {
        self.thirdLabel.hidden=NO;
       self.thirdLabel.text=[NSString stringWithFormat:@"%@",[tee_boxes[2] distance_from_hole]];
    }
   
    
    
    if (tee_boxes.count>=4) {
        self.fourthLabel.hidden=NO;
      self.fourthLabel.text=[NSString stringWithFormat:@"%@",[tee_boxes[3] distance_from_hole]];
    }
    
    
    
    if (tee_boxes.count>=5) {
        self.fifthLabel.hidden=NO;
        self.fifthLabel.text=[NSString stringWithFormat:@"%@",[tee_boxes[4] distance_from_hole]];
    }
    
    
}




-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat mager=(self.frame.size.width-20-5*37.5)/5;
    CGFloat fristLabelX=0;
    CGFloat fristLabelW=37.5;
    CGFloat fristLabelH=37;
    CGFloat fristLabelY=(self.frame.size.height-fristLabelH)/2;
    self.fristLabel.frame=CGRectMake(fristLabelX, fristLabelY, fristLabelW, fristLabelH);

    CGFloat secondLabelX=fristLabelX+fristLabelW+mager;
    CGFloat secondLabelW=fristLabelW;
    CGFloat secondLabelH=fristLabelH;
    CGFloat secondLabelY=(self.frame.size.height-fristLabelH)/2;
    self.secondLabel.frame=CGRectMake(secondLabelX, secondLabelY, secondLabelW, secondLabelH);
    
    
    CGFloat thirdLabelX=secondLabelX+fristLabelW+mager;
    CGFloat thirdLabelW=fristLabelW;
    CGFloat thirdLabelH=fristLabelH;
    CGFloat thirdLabelY=(self.frame.size.height-fristLabelH)/2;
    self.thirdLabel.frame=CGRectMake(thirdLabelX, thirdLabelY, thirdLabelW, thirdLabelH);
    
    
    
    CGFloat fourthLabelX=thirdLabelX+fristLabelW+mager;
    CGFloat fourthLabelW=fristLabelW;
    CGFloat fourthLabelH=fristLabelH;
    CGFloat fourthLabelY=(self.frame.size.height-fristLabelH)/2;
    self.fourthLabel.frame=CGRectMake(fourthLabelX, fourthLabelY, fourthLabelW, fourthLabelH);
    
    
    CGFloat fifthLabelX=fourthLabelX+fristLabelW+mager;
    CGFloat fifthLabelW=fristLabelW;
    CGFloat fifthLabelH=fristLabelH;
    CGFloat fifthLabelY=(self.frame.size.height-fristLabelH)/2;
    self.fifthLabel.frame=CGRectMake(fifthLabelX, fifthLabelY, fifthLabelW, fifthLabelH);
   
    
    
    
    //向右箭头的图片
    CGFloat rightImageW=10;
    CGFloat rightImageH=17;
    CGFloat rightImageX=self.frame.size.width-rightImageW-10;
    CGFloat rightImageY=(self.frame.size.height-rightImageH)*0.5;
    
    
    self.rightImage.frame=CGRectMake(rightImageX, rightImageY, rightImageW, rightImageH);
}



@end
