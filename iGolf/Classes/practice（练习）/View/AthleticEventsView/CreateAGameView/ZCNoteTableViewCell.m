//
//  ZCNoteTableViewCell.m
//  我爱高尔夫
//
//  Created by hh on 15/4/23.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCNoteTableViewCell.h"
@interface ZCNoteTableViewCell()
@property(nonatomic,weak)UILabel *nameLabel;
@property(nonatomic,weak)UILabel *noteTextView;
@end
@implementation ZCNoteTableViewCell


+(instancetype)cellWithTable:(UITableView *)tableView
{
    static NSString *ID = @"ZCNoteTableViewCell";
    ZCNoteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZCNoteTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    return  cell;
    
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *nameLabel=[[UILabel alloc] init];
        nameLabel.text=@"比赛备注:";
        [self.contentView addSubview:nameLabel];
        self.nameLabel=nameLabel;
        
        UILabel *noteTextView=[[UILabel alloc] init];
        
        noteTextView.backgroundColor=[UIColor redColor];
        [noteTextView setNumberOfLines:0];
        [self.contentView addSubview:noteTextView];
        self.noteTextView=noteTextView;
    }
    
    return self;
    
}



-(void)setTextStr:(NSString *)textStr
{
    _textStr=textStr;
   self.noteTextView.text=self.textStr;

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
    CGFloat nameTextViewW=220;
    CGFloat nameTextViewH=self.frame.size.height;
    self.noteTextView.frame=CGRectMake(nameTextViewX, nameTextViewY, nameTextViewW, nameTextViewH);
    
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
