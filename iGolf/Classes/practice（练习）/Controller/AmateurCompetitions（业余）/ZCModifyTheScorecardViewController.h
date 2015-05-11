//
//  ZCModifyTheScorecardViewController.h
//  我爱高尔夫
//
//  Created by hh on 15/3/26.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZCModifyTheScorecardViewController,ZCscorecard;
@protocol ZCModifyTheScorecardViewControllerDelegate<NSObject>
@optional
- (void)ZCZCFillViewController:(ZCModifyTheScorecardViewController *)modifyTheScorecardViewController didSaveScorecardt:(ZCscorecard *)scorecard;
@end

@interface ZCModifyTheScorecardViewController : UIViewController
@property(nonatomic,weak) id<ZCModifyTheScorecardViewControllerDelegate >delegate;


@property(nonatomic,strong) ZCscorecard *scorecard;
@end
