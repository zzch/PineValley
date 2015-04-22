//
//  ZCNumberView.h
//  我爱高尔夫
//
//  Created by hh on 15/4/20.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZCNumberView;
@protocol ZCNumberDelegate<NSObject>
@optional
- (void)numberViewDidClickedButton:(ZCNumberView *)headerView didClickButton:(UIButton *)button;
@end
@interface ZCNumberView : UIView
@property (nonatomic, weak) id<ZCNumberDelegate> delegate;
@end
