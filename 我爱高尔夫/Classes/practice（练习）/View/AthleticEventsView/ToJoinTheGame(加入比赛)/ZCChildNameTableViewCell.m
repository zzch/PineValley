//
//  ZCChildNameTableViewCell.m
//  我爱高尔夫
//
//  Created by hh on 15/4/27.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCChildNameTableViewCell.h"
@interface ZCChildNameTableViewCell()
@property(nonatomic,weak)UILabel *numberLabel;
@property(nonatomic,weak)UILabel *nameLabel;
@end
@implementation ZCChildNameTableViewCell



+(instancetype)cellWithTable:(UITableView *)tableView
{
    static NSString *ID = @"ZCChildNameTableViewCell";
    ZCChildNameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZCChildNameTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    return  cell;
    
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *numberLabel=[[UILabel alloc] init];
        numberLabel.text=@"前几";
        [self.contentView addSubview:numberLabel];
        self.numberLabel=numberLabel;
        
        UILabel *nameLabel=[[UILabel alloc] init];
        nameLabel.backgroundColor=[UIColor redColor];
        [self.contentView addSubview:nameLabel];
        self.nameLabel=nameLabel;
    }
    
    return self;
    
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
   
    
    CGFloat numberLabelX=10;
    CGFloat numberLabelY=0;
    CGFloat numberLabelW=100;
    CGFloat numberLabelH=self.frame.size.height;
    self.numberLabel.frame=CGRectMake(numberLabelX, numberLabelY, numberLabelW, numberLabelH);
    
    
    
    CGFloat nameLabelW=100;
    CGFloat nameLabelX=self.frame.size.width-nameLabelW-20;
    CGFloat nameLabelY=0;
    
    CGFloat nameLabelH=self.frame.size.height;
    self.nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    
}


-(void)setNameStr:(NSString *)nameStr
{
    _nameStr=nameStr;
    self.numberLabel.text=nameStr;
}


-(void)setChildName:(NSString *)childName
{
    _childName=childName;
    self.nameLabel.text=childName;
    

}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
