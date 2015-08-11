//
//  ZCHistoricalRecordCell.m
//  iGolf
//
//  Created by hh on 15/8/7.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCHistoricalRecordCell.h"
@interface ZCHistoricalRecordCell()
@property(nonatomic,weak)UILabel *typeImageView;
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
        
        
        UILabel *typeImageView=[[UILabel alloc] init];
        typeImageView.backgroundColor=[UIColor redColor];
        [self.contentView addSubview:typeImageView];
        self.typeImageView=typeImageView;
        
        UILabel *timeLabel=[[UILabel alloc] init];
        timeLabel.text=@"+23asdasdasd";
        [self.contentView addSubview:timeLabel];
        self.timeLabel=timeLabel;
        
        UILabel *parLabel=[[UILabel alloc] init];
        [self.contentView addSubview:parLabel];
        self.parLabel=parLabel;
        
        UIImageView *moneyImage=[[UIImageView alloc] init];
        moneyImage.backgroundColor=[UIColor redColor];
        [self.contentView addSubview:moneyImage];
        self.moneyImage=moneyImage;
        
        UILabel *scoreLabel=[[UILabel alloc] init];
        scoreLabel.text=@"+23";
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
        self.typeImageView.text=@"比洞赛";
    }else if (historicalRecordModel.type==2)
    {
    self.typeImageView.text=@"斗地主";
    }else
    {
    self.typeImageView.text=@"拉斯维加斯";
    }
    
      NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
     [dateformatter setDateFormat:@"yyyy年MM月dd日"];
     NSString *  locationString=[dateformatter stringFromDate:historicalRecordModel.played_at];
    self.timeLabel.text=locationString;
    
    self.parLabel.text=[NSString stringWithFormat:@"%ld/18",historicalRecordModel.count];
    self.scoreLabel.text=[NSString stringWithFormat:@"%ld",(long)historicalRecordModel.earned];

}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    CGFloat typeImageViewX=10;
    CGFloat typeImageViewY=0;
    CGFloat typeImageViewW=90;
    CGFloat typeImageViewH=90;
    self.typeImageView.frame=CGRectMake(typeImageViewX, typeImageViewY, typeImageViewW, typeImageViewH);
    
    CGFloat timeLabelX=typeImageViewX+typeImageViewW+10;
    CGFloat timeLabelY=10;
    CGFloat timeLabelW=100;
    CGFloat timeLabelH=20;
    self.timeLabel.frame=CGRectMake(timeLabelX, timeLabelY, timeLabelW, timeLabelH);
    
    CGFloat parLabelX=timeLabelX;
    CGFloat parLabelY=timeLabelY+timeLabelH+10;
    CGFloat parLabelW=60;
    CGFloat parLabelH=20;
    self.parLabel.frame=CGRectMake(parLabelX, parLabelY, parLabelW, parLabelH);
    
    CGFloat moneyImageX=self.frame.size.width-100;
    CGFloat moneyImageW=20;
    CGFloat moneyImageH=20;
    CGFloat moneyImageY=(self.frame.size.height-moneyImageH)/2;
    self.moneyImage.frame=CGRectMake(moneyImageX, moneyImageY, moneyImageW, moneyImageH);
    
    CGFloat scoreLabelX=moneyImageX+moneyImageW+5;
    CGFloat scoreLabelW=40;
    CGFloat scoreLabelH=40;
    CGFloat scoreLabelY=(self.frame.size.height-scoreLabelH)/2;
    self.scoreLabel.frame=CGRectMake(scoreLabelX, scoreLabelY, scoreLabelW, scoreLabelH);
    
}

@end
