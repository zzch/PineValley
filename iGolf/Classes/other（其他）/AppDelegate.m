//
//  AppDelegate.m
//  我爱高尔夫
//
//  Created by hh on 15/1/29.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "AppDelegate.h"
#import "ZCTabbarViewController.h"
#import "ZCregisterViewController.h"
#import "ZCAccount.h"
#import "ZCPracticeVController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
//屏幕转动
-(NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if (self.allowRotation) {
        return UIInterfaceOrientationMaskAll;
    }
    return UIInterfaceOrientationMaskPortrait;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //创建Window
    self.window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor whiteColor];
    if (is_IOS_7) { // 判断是否是IOS7
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

   
    
    
    //先判断有无存储账号信息
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];

    if (account) {//之前登陆成功
         ZCPracticeVController *tabBarVc=[[ZCPracticeVController alloc] init];
        UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:tabBarVc];
        
         self.window.rootViewController=nav;
    }else
    {// 之前没有登录成功
        //设置跟控制器
        
        ZCregisterViewController *registerView=[[ZCregisterViewController alloc] init];
        UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:registerView];
        self.window.rootViewController=nav;
       
    
    }
    
    
    //导航栏的背景颜色和字体
    
           UINavigationBar *bar = [UINavigationBar appearance];
    
    //bar.barTintColor = ZCColor(60, 57, 78);
      [bar setBackgroundImage:[UIImage imageNamed:@"daohanglan_bj_03"] forBarMetrics:UIBarMetricsDefault];
   // [bar setb]
    bar.tintColor=[UIColor whiteColor];
           bar.titleTextAttributes=@{UITextAttributeTextColor: [UIColor whiteColor],UITextAttributeFont : [UIFont boldSystemFontOfSize:18]};

  //  [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"biaoqianlan_bj"] forBarMetrics:UIBarMetricsDefault];
    
    
    // 4.显示window
    [self.window makeKeyAndVisible];

        return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
