//
//  ZCPasswordTableViewCell.m
//  我爱高尔夫
//
//  Created by hh on 15/4/23.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCPasswordTableViewCell.h"
@interface ZCPasswordTableViewCell()
@property(nonatomic,weak)UILabel *passwordNameLabel;

@end
@implementation ZCPasswordTableViewCell





+(instancetype)cellWithTable:(UITableView *)tableView
{
    static NSString *ID = @"ZCPasswordTableViewCell";
    ZCPasswordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZCPasswordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    return  cell;
    
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *passwordNameLabel=[[UILabel alloc] init];
        passwordNameLabel.text=@"创建密码:";
        [self.contentView addSubview:passwordNameLabel];
        self.passwordNameLabel=passwordNameLabel;
        
        UITextField *passwordTextView=[[UITextField alloc] init];
        passwordTextView.backgroundColor=[UIColor redColor];
        [self.contentView addSubview:passwordTextView];
        self.passwordTextView=passwordTextView;
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
    self.passwordNameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    CGFloat nameTextViewX=nameLabelX+nameLabelW+10;
    CGFloat nameTextViewY=0;
    CGFloat nameTextViewW=SCREEN_WIDTH-nameLabelX-10;
    CGFloat nameTextViewH=self.frame.size.height;
    self.passwordTextView.frame=CGRectMake(nameTextViewX, nameTextViewY, nameTextViewW, nameTextViewH);
    
    
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
