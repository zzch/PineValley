//
//  ZCCueTableViewCell.m
//  我爱高尔夫
//
//  Created by hh on 15/4/16.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCCueTableViewCell.h"
@interface ZCCueTableViewCell()
/**
 球杆的名字
 */
@property(nonatomic,weak)UILabel *nameLabel;

/**
 击球次数
 */
@property(nonatomic,weak)UILabel *ballNumberLabel;
/**
 平均距离
 */
@property(nonatomic,weak)UILabel *averageDistanceLabel;
/**
 最小码数数字
 */
@property(nonatomic,weak)UILabel *minLabel;
/**
 最小码数名字
 */
@property(nonatomic,weak)UILabel *minNameLabel;
/**
 小于的次数
 */
@property(nonatomic,weak)UILabel *lesLabel;
/**
 大于的次数
 */
@property(nonatomic,weak)UILabel *greateLabel;
/**
 最大码数数字
 */
@property(nonatomic,weak)UILabel *maxLabel;
/**
 最大码数名字
 */
@property(nonatomic,weak)UILabel *maxNameLabel;
/**
 平均值
 */
@property(nonatomic,weak)UILabel *averagLabel;
/**
 平均值名字
 */
@property(nonatomic,weak)UILabel *averagNameLabel;
/**
 图片
 */
@property(nonatomic,weak)UIView *imageview;

@end
@implementation ZCCueTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
   if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
   {
       
       
        self.selectionStyle = UITableViewCellSelectionStyleNone;
       
       //球杆的名字
       UILabel *nameLabel=[[UILabel alloc] init];
      // nameLabel.backgroundColor=[UIColor redColor];
       nameLabel.font=[UIFont systemFontOfSize:28];
       nameLabel.textAlignment=NSTextAlignmentCenter;
       [self.contentView addSubview:nameLabel];
       self.nameLabel=nameLabel;
       
       //击球次数
       UILabel * ballNumberLabel=[[UILabel alloc] init];
       ballNumberLabel.textColor=ZCColor(85, 85, 85);
       [self.contentView addSubview:ballNumberLabel];
       self.ballNumberLabel=ballNumberLabel;
       
       
       //平均距离
       UILabel * averageDistanceLabel=[[UILabel alloc] init];
       averageDistanceLabel.textColor=ZCColor(85, 85, 85);
       [self.contentView addSubview:averageDistanceLabel];
       self.averageDistanceLabel=averageDistanceLabel;

       //最小码数数字
       UILabel * minLabel=[[UILabel alloc] init];
       minLabel.textAlignment=NSTextAlignmentCenter;
       [self.contentView addSubview:minLabel];
       self.minLabel=minLabel;
       
       //最小码数名字显示
       UILabel * minNameLabel=[[UILabel alloc] init];
       minNameLabel.textColor=ZCColor(85, 85, 85);
       [self.contentView addSubview:minNameLabel];
       minNameLabel.text=@"min";
       minNameLabel.textAlignment=NSTextAlignmentCenter;
       minNameLabel.font=[UIFont systemFontOfSize:15];
       self.minNameLabel=minNameLabel;
       
       //小于的次数
       UILabel * lesLabel=[[UILabel alloc] init];
       lesLabel.textColor=ZCColor(85, 85, 85);
       [self.contentView addSubview:lesLabel];
       lesLabel.textAlignment=NSTextAlignmentCenter;
        self.lesLabel=lesLabel;
       
       //大于的次数
       UILabel * greateLabel=[[UILabel alloc] init];
       greateLabel.textColor=ZCColor(85, 85, 85);
       greateLabel.textAlignment=NSTextAlignmentCenter;
       [self.contentView addSubview:greateLabel];
       self.greateLabel=greateLabel;
       


       //最大码数数字
       UILabel * maxLabel=[[UILabel alloc] init];
       maxLabel.textColor=ZCColor(85, 85, 85);
       maxLabel.textAlignment=NSTextAlignmentCenter;
       [self.contentView addSubview:maxLabel];
       self.maxLabel=maxLabel;
       
       //最大码数名字显示
       UILabel * maxNameLabel=[[UILabel alloc] init];
       maxNameLabel.textColor=ZCColor(85, 85, 85);
       maxNameLabel.textAlignment=NSTextAlignmentCenter;
       [self.contentView addSubview:maxNameLabel];
       maxNameLabel.text=@"max";
       maxNameLabel.font=[UIFont systemFontOfSize:15];
       self.maxNameLabel=maxNameLabel;
       
        //横条图片
       UIView *imageview=[[UIView alloc] init];
       imageview.backgroundColor=ZCColor(212, 212, 212);
       [self.contentView addSubview:imageview];
       self.imageview=imageview;
       
       
       
       //平均值数字显示
       UILabel * averagLabel=[[UILabel alloc] init];
       averagLabel.backgroundColor=[UIColor blackColor];
       [self.contentView addSubview:averagLabel];
       averagLabel.textAlignment=NSTextAlignmentCenter;
       averagLabel.textColor=ZCColor(255, 150, 29);
       self.averagLabel=averagLabel;
       
       //平均值名字显示
       UILabel * averagNameLabel=[[UILabel alloc] init];
       averagNameLabel.textAlignment=NSTextAlignmentCenter;
       [self.contentView addSubview:averagNameLabel];
       averagNameLabel.text=@"平均";
       self.averagNameLabel=averagNameLabel;
       

       
   }
    return self;
}


-(void)setCueMode:(ZCCueMode *)cueMode
{
    _cueMode=cueMode;
    
    
    
    self.nameLabel.text=[NSString stringWithFormat:@"%@",cueMode.name];
    
    self.ballNumberLabel.text=[NSString stringWithFormat:@"击球%@次",cueMode.uses];
    self.averageDistanceLabel.text=[NSString stringWithFormat:@"平均距离%@",cueMode.average_length];
    
    if ([self _valueOrNil:cueMode.minimum_length]==nil) {
        self.minLabel.text=@"-";
    }else
    {
    self.minLabel.text=[NSString stringWithFormat:@"%@",cueMode.minimum_length];
    }
    
    self.lesLabel.text=[NSString stringWithFormat:@"%@",cueMode.less_than_average_length];
    self.greateLabel.text=[NSString stringWithFormat:@"%@",cueMode.greater_than_average_length];
    
    if ([[NSString stringWithFormat:@"%@",cueMode.average_length]isEqual:@"0"] ) {
        self.averagLabel.hidden=YES;
        self.averagNameLabel.hidden=YES;
        self.lesLabel.hidden=YES;
        self.greateLabel.hidden=YES;
    }else{
    self.averagLabel.text=[NSString stringWithFormat:@"%@",cueMode.average_length];
    }
    
    
    if ([self _valueOrNil:cueMode.maximum_length]==nil) {
        self.maxLabel.text=@"-";
    }else{
    self.maxLabel.text=[NSString stringWithFormat:@"%@",cueMode.maximum_length];
    }
    
    
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

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat nameLabelX=0;
    CGFloat nameLabelY=0;
    CGFloat nameLabelW=SCREEN_WIDTH*0.15;
    CGFloat nameLabelH=self.frame.size.height;
    self.nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    CGFloat ballNumberLabelX=nameLabelW;
    CGFloat ballNumberLabelY=10;
    CGFloat ballNumberLabelW=80;
    CGFloat ballNumberLabelH=20;
    self.ballNumberLabel.frame=CGRectMake(ballNumberLabelX, ballNumberLabelY, ballNumberLabelW, ballNumberLabelH);
    // 平均距离
    CGFloat averageDistanceLabelX=ballNumberLabelX+ballNumberLabelW+10;
    CGFloat averageDistanceLabelY=ballNumberLabelY;
    CGFloat averageDistanceLabelW=130;
    CGFloat averageDistanceLabelH=ballNumberLabelH;
    self.averageDistanceLabel.frame=CGRectMake(averageDistanceLabelX, averageDistanceLabelY, averageDistanceLabelW, averageDistanceLabelH);
    
    // 最小码数数字
    CGFloat minLabelX=ballNumberLabelX;
    CGFloat minLabelY=ballNumberLabelY+ballNumberLabelH+15;
    CGFloat minLabelW=30;
    CGFloat minLabelH=30;
    self.minLabel.frame=CGRectMake(minLabelX, minLabelY, minLabelW, minLabelH);
    
    // 最小码数名字
    CGFloat minNameLabelX=ballNumberLabelX;
    CGFloat minNameLabelY=minLabelY+minLabelH+5;
    CGFloat minNameLabelW=30;
    CGFloat minNameLabelH=30;
    self.minNameLabel.frame=CGRectMake(minNameLabelX, minNameLabelY, minNameLabelW, minNameLabelH);
//    
    // 图片显示
    CGFloat imageViewX=minLabelX+minLabelW+10;
    CGFloat imageViewY=minLabelY+minLabelH*0.5;
    CGFloat imageViewW=SCREEN_WIDTH-imageViewX-(minLabelW*2);
    CGFloat imageViewH=8;
    self.imageview.frame=CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
//
    //平均
    CGFloat averagLabelW=SCREEN_WIDTH*0.18;
    CGFloat averagLabelH=35;
    CGFloat averagLabelX=imageViewX+((imageViewW-averagLabelW)*0.5);//(imageViewW-averagLabelW)*0.5;//imageViewX+((imageViewW-averagLabelW)*0.5);
    CGFloat averagLabelY=imageViewY-(averagLabelH-imageViewH)*0.5;//-averagLabelH*0.5;//minLabelY+(minLabelH*0.5);
    self.averagLabel.frame=CGRectMake(averagLabelX, averagLabelY, averagLabelW, averagLabelH);
//
//
    //平均名字
    CGFloat averagNameLabelW=40;
    CGFloat averagNameLabelH=30;
    CGFloat averagNameLabelX=averagLabelX;
    CGFloat averagNameLabelY=averagLabelY+averagLabelH+5;
    self.averagNameLabel.frame=CGRectMake(averagNameLabelX, averagNameLabelY, averagNameLabelW, averagNameLabelH);

    //小于
    CGFloat lesLabelW=averagLabelX-imageViewX;
    CGFloat lesLabelH=20;
    CGFloat lesLabelX=imageViewX;
    CGFloat lesLabelY=imageViewY-lesLabelH-5;
    self.lesLabel.frame=CGRectMake(lesLabelX, lesLabelY, lesLabelW, lesLabelH);
    
    //大于
    CGFloat greateLabelW=lesLabelW;
    CGFloat greateLabelH=lesLabelH;
    CGFloat greateLabelX=averagLabelX+averagLabelW;
    CGFloat greateLabelY=imageViewY-lesLabelH-5;
    self.greateLabel.frame=CGRectMake(greateLabelX, greateLabelY, greateLabelW, greateLabelH);

//
    //最大码数数字
    CGFloat maxLabelW=minLabelW;
    CGFloat maxLabelH=minLabelH;
    CGFloat maxLabelX=imageViewX+imageViewW+10;
    CGFloat maxLabelY=minLabelY;
    self.maxLabel.frame=CGRectMake(maxLabelX, maxLabelY, maxLabelW, maxLabelH);


    //最大码数数字名字
    CGFloat maxNameLabelW=minLabelW;
    CGFloat maxNameLabelH=minLabelH;
    CGFloat maxNameLabelX=maxLabelX;
    CGFloat maxNameLabelY=minNameLabelY;
    self.maxNameLabel.frame=CGRectMake(maxNameLabelX, maxNameLabelY, maxNameLabelW, maxNameLabelH);
    

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
