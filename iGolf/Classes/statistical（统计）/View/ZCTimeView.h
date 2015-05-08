//
//  ZCTimeView.h
//  我爱高尔夫
//
//  Created by hh on 15/4/20.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZCTimeView;
@protocol ZCTimeDelegate<NSObject>
@optional
- (void)timeViewDidClickedButton:(ZCTimeView *)headerView startTime:(long)startTime  andEndTime:(long)endTime;
@end

@interface ZCTimeView : UIView
@property (nonatomic, weak) id<ZCTimeDelegate> delegate;
@end
