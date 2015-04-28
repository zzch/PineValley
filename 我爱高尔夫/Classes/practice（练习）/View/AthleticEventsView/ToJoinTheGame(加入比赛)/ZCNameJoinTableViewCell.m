//
//  ZCNameJoinTableViewCell.m
//  我爱高尔夫
//
//  Created by hh on 15/4/27.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCNameJoinTableViewCell.h"
@interface ZCNameJoinTableViewCell()
@property(nonatomic,weak)UILabel *nameLabel;
@property(nonatomic,weak)UILabel *nameTextView;
@end
@implementation ZCNameJoinTableViewCell

+(instancetype)cellWithTable:(UITableView *)tableView
{
    static NSString *ID = @"ZCNameJoinTableViewCell";
    ZCNameJoinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZCNameJoinTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    return  cell;
    
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *nameLabel=[[UILabel alloc] init];
        nameLabel.text=@"比赛名称:";
        [self.contentView addSubview:nameLabel];
        self.nameLabel=nameLabel;
        
        UILabel *nameTextView=[[UILabel alloc] init];
        nameTextView.backgroundColor=[UIColor redColor];
        [self.contentView addSubview:nameTextView];
        self.nameTextView=nameTextView;
    }
    
    return self;
    
}



-(void)setName:(NSString *)name
{
    _name=name;
    self.nameTextView.text=name;

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat nameLabelX=10;
    CGFloat nameLabelY=0;
    CGFloat nameLabelW=100;
    CGFloat nameLabelH=self.frame.size.height;
    self.nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    CGFloat nameTextViewX=nameLabelX+nameLabelW+10;
    CGFloat nameTextViewY=0;
    CGFloat nameTextViewW=SCREEN_WIDTH-nameLabelX-10;
    CGFloat nameTextViewH=self.frame.size.height;
    self.nameTextView.frame=CGRectMake(nameTextViewX, nameTextViewY, nameTextViewW, nameTextViewH);
    
    
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
