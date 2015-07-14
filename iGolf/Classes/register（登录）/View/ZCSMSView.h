//
//  ZCSMSView.h
//  iGolf
//
//  Created by hh on 15/7/9.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZCSMSView;
@protocol ZCSMSViewDelegate<NSObject>

@optional
-(void)clickTheSMSView:(ZCSMSView *)view;
@end
@interface ZCSMSView : UIView
@property(nonatomic,strong)id <ZCSMSViewDelegate>delegate;

@end
