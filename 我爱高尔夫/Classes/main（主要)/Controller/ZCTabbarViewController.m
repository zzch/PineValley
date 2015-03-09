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
@interface ZCTabbarViewController ()

@end

@implementation ZCTabbarViewController


//初始化数据
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        
        //练习
        ZCPracticeViewController *practice=[[ZCPracticeViewController alloc] init];
        
        //创建导航控制器，并把练习界面设置成跟控制器
        UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:practice];
        [self  addOneChildViewController:nav title:@"练习" imageName:@"tabbar_home" selectedImageName:@"tabbar_message_center_selected"];
        
        
        
        //统计
        ZCStatisticalViewController *statistical=[[ZCStatisticalViewController alloc] init];
        UINavigationController *nav1=[[UINavigationController alloc] initWithRootViewController:statistical];
        [self addOneChildViewController:nav1 title:@"统计" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
        
        
        
        
        
        //个人
        ZCPersonalViewController *personal=[[ZCPersonalViewController alloc] init];
        UINavigationController *nav2=[[UINavigationController alloc] initWithRootViewController:personal];
        [self addOneChildViewController:nav2 title:@"个人" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
        
        
        
    }
    
    

    return  self;

}

-(void)addOneChildViewController:(UIViewController *)childVc  title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
  // childVc.view.backgroundColor=
    
    childVc.tabBarItem.title=title;
    childVc.tabBarItem.image=[UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage=[UIImage imageNamed:selectedImageName];
    
    [self addChildViewController:childVc];
    
    
    


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
