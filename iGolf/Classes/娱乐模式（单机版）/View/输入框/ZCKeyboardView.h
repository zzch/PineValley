//
//  ZCKeyboardView.h
//  iGolf
//
//  Created by hh on 15/7/23.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZCKeyboardViewDelegate<NSObject>
@optional
- (void)keyboardViewConfirmThatTheInput:(NSString *)number;

@end
@interface ZCKeyboardView : UIView
@property(nonatomic,weak)id<ZCKeyboardViewDelegate> delegate;
@property(nonatomic,copy)NSString *imageStr;
@property(nonatomic,copy)NSString *name;
// 1为红色 2为黄色
@property(nonatomic,assign)int colorIndex;
@end
