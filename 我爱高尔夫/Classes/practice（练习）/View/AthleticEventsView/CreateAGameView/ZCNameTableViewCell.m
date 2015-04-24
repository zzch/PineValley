//
//  ZCNameTableViewCell.m
//  我爱高尔夫
//
//  Created by hh on 15/4/23.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCNameTableViewCell.h"
@interface ZCNameTableViewCell()
@property(nonatomic,weak)UILabel *nameLabel;

@end
@implementation ZCNameTableViewCell


+(instancetype)cellWithTable:(UITableView *)tableView
{
    static NSString *ID = @"ZCNameTableViewCell";
    ZCNameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZCNameTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
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
        
        UITextField *nameTextView=[[UITextField alloc] init];
        nameTextView.backgroundColor=[UIColor redColor];
        [self.contentView addSubview:nameTextView];
        self.nameTextView=nameTextView;
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
