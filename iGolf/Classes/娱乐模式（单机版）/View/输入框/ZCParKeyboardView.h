//
//  ZCParKeyboardView.h
//  iGolf
//
//  Created by hh on 15/7/27.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ZCParKeyboardViewDelegate<NSObject>
@optional
- (void)ParKeyboardViewConfirmThatTheInput:(NSString *)number;

@end

@interface ZCParKeyboardView : UIView
@property(nonatomic,weak)id<ZCParKeyboardViewDelegate> delegate;

@end
