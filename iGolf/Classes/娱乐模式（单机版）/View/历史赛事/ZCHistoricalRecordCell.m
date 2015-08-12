//
//  ZCHistoricalRecordCell.m
//  iGolf
//
//  Created by hh on 15/8/7.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCHistoricalRecordCell.h"
@interface ZCHistoricalRecordCell()
@property(nonatomic,weak)UIImageView *typeImageView;
@property(nonatomic,weak)UIImageView *payBJIamge;
@property(nonatomic,weak)UILabel *parLabel;
@property(nonatomic,weak)UILabel *timeLabel;
@property(nonatomic,weak)UIImageView *moneyImage;
@property(nonatomic,weak)UILabel *scoreLabel;
@end
@implementation ZCHistoricalRecordCell

+(instancetype)cellWithTable:(UITableView *)tableView
{
    static NSString *ID = @"ZCHistoricalRecordCell";
    ZCHistoricalRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZCHistoricalRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return  cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        UIImageView *typeImageView=[[UIImageView alloc] init];
        
        [self.contentView addSubview:typeImageView];
        self.typeImageView=typeImageView;
        
        UILabel *timeLabel=[[UILabel alloc] init];
        
        timeLabel.textColor=ZCColor(85, 85, 85);
        [self.contentView addSubview:timeLabel];
        self.timeLabel=timeLabel;
        
        
        UIImageView *payBJIamge=[[UIImageView alloc] init];
        self.payBJIamge=payBJIamge;
        payBJIamge.image=[UIImage imageNamed:@"jjbs_renshu_icon"];
        [self.contentView addSubview:payBJIamge];
        
        UILabel *parLabel=[[UILabel alloc] init];
        parLabel.textAlignment=NSTextAlignmentCenter;
        parLabel.textColor=ZCColor(85, 85, 85);
        [self.contentView addSubview:parLabel];
        self.parLabel=parLabel;
        
        UIImageView *moneyImage=[[UIImageView alloc] init];
        moneyImage.image=[UIImage imageNamed:@"jinbi"];
        [self.contentView addSubview:moneyImage];
        self.moneyImage=moneyImage;
        
        UILabel *scoreLabel=[[UILabel alloc] init];
        scoreLabel.font=[UIFont systemFontOfSize:25];
        scoreLabel.textColor=ZCColor(255, 150, 29);
        scoreLabel.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:scoreLabel];
        self.scoreLabel=scoreLabel;
        
    }
    return self;
}

-(void)setHistoricalRecordModel:(ZCHistoricalRecordModel *)historicalRecordModel
{
    _historicalRecordModel=historicalRecordModel;
    if (historicalRecordModel.type==1) {
        self.typeImageView.image=[UIImage imageNamed:@"bidongsai"];
    }else if (historicalRecordModel.type==2)
    {
    self.typeImageView.image=[UIImage imageNamed:@"doudizhu"];
    }else
    {
    self.typeImageView.image=[UIImage imageNamed:@"lswjs"];
    }
    
      NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
     [dateformatter setDateFormat:@"yyyy年MM月dd日"];
     NSString *  locationString=[dateformatter stringFromDate:historicalRecordModel.played_at];
    self.timeLabel.text=locationString;
    
    self.parLabel.text=[NSString stringWithFormat:@"%ld/18",historicalRecordModel.count];
    if (historicalRecordModel.earned>=0) {
        self.scoreLabel.text=[NSString stringWithFormat:@"+%ld",(long)historicalRecordModel.earned];
    }else{
        self.scoreLabel.text=[NSString stringWithFormat:@"%ld",(long)historicalRecordModel.earned];
    }

}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    CGFloat typeImageViewX=15;
    
    CGFloat typeImageViewW=75;
    CGFloat typeImageViewH=75;
    CGFloat typeImageViewY=(self.frame.size.height-typeImageViewH)/2;
    self.typeImageView.frame=CGRectMake(typeImageViewX, typeImageViewY, typeImageViewW, typeImageViewH);
    
    CGFloat timeLabelX=typeImageViewX+typeImageViewW+15;
    CGFloat timeLabelY=typeImageViewY+5;
    CGFloat timeLabelW=150;
    CGFloat timeLabelH=20;
    self.timeLabel.frame=CGRectMake(timeLabelX, timeLabelY, timeLabelW, timeLabelH);
    
    CGFloat parLabelX=timeLabelX;
    CGFloat parLabelY=timeLabelY+timeLabelH+22;
    CGFloat parLabelW=75;
    CGFloat parLabelH=20;
    self.payBJIamge.frame=CGRectMake(parLabelX, parLabelY, parLabelW, parLabelH);
    self.parLabel.frame=CGRectMake(parLabelX, parLabelY, parLabelW, parLabelH);
    
    
    CGFloat moneyImageW=18;
    CGFloat moneyImageH=17;
    CGFloat moneyImageX=self.frame.size.width-(self.frame.size.width*0.0818)-40;
    CGFloat moneyImageY=(self.frame.size.height-moneyImageH)/2;
    self.moneyImage.frame=CGRectMake(moneyImageX, moneyImageY, moneyImageW, moneyImageH);
    
    
    CGFloat scoreLabelW=40;
    CGFloat scoreLabelH=40;
    CGFloat scoreLabelY=(self.frame.size.height-scoreLabelH)/2;
    CGFloat scoreLabelX=SCREEN_WIDTH-scoreLabelW-(SCREEN_WIDTH*0.0312);
    self.scoreLabel.frame=CGRectMake(scoreLabelX, scoreLabelY, scoreLabelW, scoreLabelH);
    
}

@end
