//
//  ZCChooseThePitchVViewController.h
//  我爱高尔夫
//
//  Created by hh on 15/1/30.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZCChooseThePitchVViewController;
#import <CoreLocation/CoreLocation.h>
@protocol  ZCChooseThePitchDelegate<NSObject>
@optional
-(void)ZCChooseThePitchVViewController:(ZCChooseThePitchVViewController *)ChooseThePitchVViewController andUuid:(NSString *)uuid;
//
@end

@interface ZCChooseThePitchVViewController : UIViewController

@property(nonatomic,strong) id<ZCChooseThePitchDelegate> delegate;
@end
