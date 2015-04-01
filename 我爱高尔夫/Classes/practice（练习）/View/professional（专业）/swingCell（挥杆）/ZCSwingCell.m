//
//  ZCSwingCell.m
//  我爱高尔夫
//
//  Created by hh on 15/4/1.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCSwingCell.h"
@interface ZCSwingCell()
@property(nonatomic,weak) UIView *valueView;
@property(nonatomic,weak) UILabel *distanceLable;
@property(nonatomic,weak) UILabel *addLabel;

@end
@implementation ZCSwingCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        int a=0;
//        if (a) {
//            
//      
//        UIView *valueView=[[UIView alloc] init];
//        valueView.frame=[UIScreen mainScreen].bounds;
//        self.valueView=valueView;
//        [self.contentView addSubview:valueView];
//        
//        
//        
//        UILabel *distanceLable=[[UILabel alloc] init];
//        distanceLable.frame=CGRectMake(10, 0, 60, self.frame.size.height);
//        self.distanceLable=distanceLable;
//        [valueView addSubview:distanceLable];
//        }
        //如果没值显示加号
        UILabel *addLabel=[[UILabel alloc] init];
        
        addLabel.text=@"+++++++++++++";
        [self addSubview:addLabel];
        self.addLabel=addLabel;
        
    }

    return self;

}


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.addLabel.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
