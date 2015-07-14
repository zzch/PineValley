//
//  AppDelegate.m
//  我爱高尔夫
//
//  Created by   on 15/1/29.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "AppDelegate.h"
#import "ZCTabbarViewController.h"
#import "ZCregisterViewController.h"
#import "ZCAccount.h"
#import "ZCPracticeVController.h"
#import "ZCGuideViewController.h"

#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaHandler.h"

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
    //调用友盟
    [self  callToShare];
    
    //创建Window
    self.window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor whiteColor];
    
    
    
    
    
    
    if (is_IOS_7) { // 判断是否是IOS7
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

   
    
    
    NSString *key = @"CFBundleVersion";
    
    // 取出沙盒中存储的上次使用软件的版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults stringForKey:key];

    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    
    
    if ([currentVersion isEqualToString:lastVersion]) {
        // 显示状态栏
       // application.statusBarHidden = NO;
        
        //先判断有无存储账号信息
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
        ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
        
        if (account) {//之前登陆成功
            
            //ZCTabbarViewController *tabbar=[[ZCTabbarViewController alloc] init];
            
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

        
        
        
    } else { // 新版本
        self.window.rootViewController = [[ZCGuideViewController alloc] init];
        // 存储新版本
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
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


//调用友盟
-(void)callToShare
{
    // Override point for customization after application launch.
    
    [UMSocialData setAppKey:UMAppKey];
    //设置分享到QQ/Qzone的应用Id，和分享url 链接
    [UMSocialQQHandler setQQWithAppId:QQWithAppId appKey:QQWithAppKey url:QQWithShareURL];
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:WXWithAppId appSecret:WXWithAppSecret url:WXWithShareURL];
    
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。若在新浪后台设置我们的回调地址，“http://sns.whalecloud.com/sina2/callback”，这里可以传nil
    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://ilovegolfclub.com"];
    
    //由于苹果审核政策需求，建议大家对未安装客户端平台进行隐藏，在设置QQ、微信AppID之后调用下面的方法
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]];


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
