//
//  ZCModelTableViewCell.m
//  我爱高尔夫
//
//  Created by hh on 15/4/23.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCModelTableViewCell.h"
@interface ZCModelTableViewCell()
@property(nonatomic,weak)UILabel *modelLabel;
@property(nonatomic,weak)UILabel *modelType;
@end

@implementation ZCModelTableViewCell


+(instancetype)cellWithTable:(UITableView *)tableView
{
    static NSString *ID = @"ZCModelTableViewCell";
    ZCModelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZCModelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    return  cell;
    
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *modelLabel=[[UILabel alloc] init];
        modelLabel.text=@"竞技模式:";
        [self.contentView addSubview:modelLabel];
        self.modelLabel=modelLabel;
        
        UILabel *modelType=[[UILabel alloc] init];
        modelType.text=@"比杆赛";
        [self.contentView addSubview:modelType];
        self.modelType=modelType;
    }
    
    return self;
    
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat nameLabelX=10;
    CGFloat nameLabelY=0;
    CGFloat nameLabelW=100;
    CGFloat nameLabelH=self.frame.size.height;
    self.modelLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    CGFloat nameTextViewX=nameLabelX+nameLabelW+10;
    CGFloat nameTextViewY=0;
    CGFloat nameTextViewW=SCREEN_WIDTH-nameLabelX-10;
    CGFloat nameTextViewH=self.frame.size.height;
    self.modelType.frame=CGRectMake(nameTextViewX, nameTextViewY, nameTextViewW, nameTextViewH);
    
    
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
