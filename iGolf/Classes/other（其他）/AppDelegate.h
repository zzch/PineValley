//
//  AppDelegate.h
//  我爱高尔夫
//
//  Created by hh on 15/1/29.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UMAppKey @"55935a5767e58e8e5e0007db"
#define QQWithAppId @"1104542471"
#define QQWithAppKey @"EZPvuKkOZGXquYtb"
#define QQWithShareURL @"http://www.91year.com"

#define WXWithAppId @"wx52dca3261e63bc46"
#define WXWithAppSecret @"6bed365b25b5acc3fe569ff126782b4a"
#define WXWithShareURL @"http://www.baidu.com"


@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic, assign, getter = isSave) BOOL allowRotation;
@property (strong, nonatomic) UIWindow *window;


@end

