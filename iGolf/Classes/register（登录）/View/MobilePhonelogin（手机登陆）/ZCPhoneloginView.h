//
//  ZCPhoneloginView.h
//  我爱高尔夫
//
//  Created by hh on 15/4/7.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ZCPhoneloginViewDelegate <NSObject>

@optional
-(void)ZCPhoneloginViewIsClick:(UIButton *)sender;

@end


@interface ZCPhoneloginView : UIView

@property(nonatomic,strong) id<ZCPhoneloginViewDelegate>delegate;


@end
