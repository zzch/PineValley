//
//  ZCTabbarViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/1/29.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCTabbarViewController.h"
#import "ZCStatisticalViewController.h"
#import "ZCPracticeViewController.h"
#import "ZCPersonalViewController.h"
#import "ZCAccount.h"
#import "ZCTabbarViewController.h"
#import "ZCregisterViewController.h"
#import "UIImage+MJ.h"
@interface ZCTabbarViewController ()

@end

@implementation ZCTabbarViewController


//初始化数据
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        UIImage *image = [UIImage imageNamed:@"tab_bj"];
        [self.tabBar setBackgroundImage:image];
        
        
       
        
        UITabBarItem *tabBarItem = [UITabBarItem appearance];
        // 設置普通狀態下的效果
        NSMutableDictionary *mdict = [NSMutableDictionary dictionary];
        mdict[NSForegroundColorAttributeName] =  ZCColor(240, 208, 122);
        [tabBarItem setTitleTextAttributes:mdict forState:UIControlStateSelected];
        mdict = nil;
        mdict[NSForegroundColorAttributeName] = ZCColor(164, 164, 164);
        [tabBarItem setTitleTextAttributes:mdict forState:UIControlStateNormal];
        
        
        
//            //先判断有无存储账号信息
//            NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//            NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
//            ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
//        
//            if (account) {//之前登陆成功
//                 ZCTabbarViewController *tabBarVc=[[ZCTabbarViewController alloc] init];
//        
//                 UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:practice];
//            }else
//            {// 之前没有登录成功
//                //设置跟控制器
//        
//                ZCregisterViewController *registerView=[[ZCregisterViewController alloc] init];
//        //        UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:registerView];
//                self.window.rootViewController=registerView;
//               
//            
//            }
//
//        
//        
        
        
//        self.tabBar.backgroundColor=ZCColor(44, 49, 54);
        //练习
        ZCPracticeViewController *practice=[[ZCPracticeViewController alloc] init];
        

        //创建导航控制器，并把练习界面设置成跟控制器
        
        
//        UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:practice];
       
//
//       UINavigationBar *bar = [UINavigationBar appearance];
//        [bar setBackgroundImage:[UIImage imageNamed:@"daohanglan"] forBarMetrics:UIBarMetricsDefault];
//        
//        bar.titleTextAttributes=@{UITextAttributeTextColor: [UIColor whiteColor],UITextAttributeFont : [UIFont boldSystemFontOfSize:18]};
        
       // [self.navigationController.navigationBarsetBackgroundImage:[UIImageimageNamed:@"bg.jpg"] forBarMetrics:UIBarMetricsDefault]
//        nav.navigationBar.backgroundColor=ZCColor(44, 49, 54);
        [self  addOneChildViewController:practice title:@"练习" imageName:@"tab_lianxi_iocn_mr" selectedImageName:@"tab_lianxi_iocn_xz"];
        
        //[self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        
        //统计
        ZCStatisticalViewController *statistical=[[ZCStatisticalViewController alloc] init];
//        UINavigationController *nav1=[[UINavigationController alloc] initWithRootViewController:statistical];
        [self addOneChildViewController:statistical title:@"统计" imageName:@"tab_tongji_iocn_mr" selectedImageName:@"tab_tongji_iocn_xz"];
        
        
        
        
        
        //个人
        ZCPersonalViewController *personal=[[ZCPersonalViewController alloc] init];
//        UINavigationController *nav2=[[UINavigationController alloc] initWithRootViewController:personal];
        [self addOneChildViewController:personal title:@"个人" imageName:@"tab_wo_iocn_mr" selectedImageName:@"tab_wo_iocn_xz"];
        
        //[UITabBar appearance].tintColor=
        
    }
    
    

    return  self;

}

//- (UIImage *)imageWithRenderingMode:(UIImageRenderingMode)renderingMode NS_AVAILABLE_IOS(7_0);




-(void)addOneChildViewController:(UIViewController *)childVc  title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
  // childVc.view.backgroundColor=
    
    
    childVc.tabBarItem.title=title;
    
    childVc.tabBarItem.image=[UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage=[UIImage imageModeAlwaysOriginal:selectedImageName];
    
    
   // [childVc.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    [self addChildViewController:childVc];
    
    
    
    // 2.包装一个导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];


}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
