//
//  ZCFillViewController.h
//  我爱高尔夫
//
//  Created by hh on 15/2/4.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZCFillViewController,ZCscorecard;
@protocol ZCZCFillViewControllerDelegate<NSObject>
@optional
- (void)ZCZCFillViewController:(ZCFillViewController *)FillViewController didSaveScorecardt:(ZCscorecard *)scorecard;
@end
@interface ZCFillViewController : UIViewController
@property(nonatomic,weak) id<ZCZCFillViewControllerDelegate>delegate;


@property(nonatomic,strong) ZCscorecard *scorecard;

@end
