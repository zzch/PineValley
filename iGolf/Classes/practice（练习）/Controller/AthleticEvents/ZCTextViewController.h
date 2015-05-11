//
//  ZCTextViewController.h
//  我爱高尔夫
//
//  Created by hh on 15/4/23.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZCTextViewController;
@protocol ZCTextViewDelegate<NSObject>
@optional
- (void)textViewDidClickedleftButton:(ZCTextViewController *)textViewController textViewTextStr:(NSString *)textStr;
@end

@interface ZCTextViewController : UIViewController
@property(nonatomic,weak)id<ZCTextViewDelegate> ZCdelegate;
@end
