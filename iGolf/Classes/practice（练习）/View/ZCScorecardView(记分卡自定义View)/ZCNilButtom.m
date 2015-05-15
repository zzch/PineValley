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
        fristLabel.textColor=ZCColor(240, 208, 122);
        self.fristLabel=fristLabel;
        
        
        UILabel *secondLabel=[[UILabel alloc] init];
        secondLabel.textColor=ZCColor(240, 208, 122);
        [self addSubview:secondLabel];
        self.secondLabel=secondLabel;
        
        
        UILabel *thirdLabel=[[UILabel alloc] init];
        thirdLabel.textColor=ZCColor(240, 208, 122);
        [self addSubview:thirdLabel];
        self.thirdLabel=thirdLabel;

        
        UILabel *fourthLabel=[[UILabel alloc] init];
        fourthLabel.textColor=ZCColor(240, 208, 122);
        [self addSubview:fourthLabel];
        self.fourthLabel=fourthLabel;

        
        
        UILabel *fifthLabel=[[UILabel alloc] init];
        fifthLabel.textColor=ZCColor(240, 208, 122);
        [self addSubview:fifthLabel];
        self.fifthLabel=fifthLabel;


        
        
        /**
         * 向右箭头前图片
         */
        
        UIImageView *rightImage=[[UIImageView alloc] init];
        [self addSubview:rightImage];
        //drivingImage.backgroundColor=[UIColor blackColor];
        rightImage.image=[UIImage imageNamed:@"lsjfk_xiayibu_iocn"];
        self.rightImage=rightImage;

        
        
    }
    return self;
}


-(void)setTee_boxes:(NSMutableArray *)tee_boxes
{
    _tee_boxes=tee_boxes;
   
    self.fristLabel.text=[NSString stringWithFormat:@"%@",[tee_boxes[0] distance_from_hole]];
    self.secondLabel.text=[NSString stringWithFormat:@"%@",[tee_boxes[1] distance_from_hole]];
    self.thirdLabel.text=[NSString stringWithFormat:@"%@",[tee_boxes[2] distance_from_hole]];    self.fourthLabel.text=[NSString stringWithFormat:@"%@",[tee_boxes[3] distance_from_hole]];
    self.fifthLabel.text=[NSString stringWithFormat:@"%@",[tee_boxes[4] distance_from_hole]];
}




-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat fristLabelX=8;
    CGFloat fristLabelW=(self.frame.size.width-60)/5;
    CGFloat fristLabelH=62;
    CGFloat fristLabelY=(self.frame.size.height-fristLabelH)/2;
    self.fristLabel.frame=CGRectMake(fristLabelX, fristLabelY, fristLabelW, fristLabelH);

    CGFloat secondLabelX=fristLabelX+fristLabelW+6;
    CGFloat secondLabelW=fristLabelW;
    CGFloat secondLabelH=fristLabelH;
    CGFloat secondLabelY=(self.frame.size.height-fristLabelH)/2;
    self.secondLabel.frame=CGRectMake(secondLabelX, secondLabelY, secondLabelW, secondLabelH);
    
    
    CGFloat thirdLabelX=secondLabelX+fristLabelW+6;
    CGFloat thirdLabelW=fristLabelW;
    CGFloat thirdLabelH=fristLabelH;
    CGFloat thirdLabelY=(self.frame.size.height-fristLabelH)/2;
    self.thirdLabel.frame=CGRectMake(thirdLabelX, thirdLabelY, thirdLabelW, thirdLabelH);
    
    
    
    CGFloat fourthLabelX=thirdLabelX+fristLabelW+6;
    CGFloat fourthLabelW=fristLabelW;
    CGFloat fourthLabelH=fristLabelH;
    CGFloat fourthLabelY=(self.frame.size.height-fristLabelH)/2;
    self.fourthLabel.frame=CGRectMake(fourthLabelX, fourthLabelY, fourthLabelW, fourthLabelH);
    
    
    CGFloat fifthLabelX=fourthLabelX+fristLabelW+6;
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
