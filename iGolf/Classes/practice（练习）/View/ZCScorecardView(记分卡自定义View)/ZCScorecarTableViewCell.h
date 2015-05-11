//
//  ZCScorecarTableViewCell.h
//  我爱高尔夫
//
//  Created by hh on 15/2/4.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZCscorecard;
@protocol ZCScorecarDelegate <NSObject>

@optional
-(void)addImageDidClick:(UIButton *)sender;

@end

@interface ZCScorecarTableViewCell : UITableViewCell

@property(nonatomic,weak)id<ZCScorecarDelegate>delegate;
//模型数据
@property (nonatomic, strong) ZCscorecard *scorecard;

@end
