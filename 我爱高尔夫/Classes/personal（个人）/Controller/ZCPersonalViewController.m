//
//  ZCPersonalViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/1/29.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCPersonalViewController.h"

@interface ZCPersonalViewController ()

@end

@implementation ZCPersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"个人";
    // 修改下一个界面返回按钮的文字
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:nil action:nil];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"daohanglan"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.titleTextAttributes=@{UITextAttributeTextColor: [UIColor whiteColor],UITextAttributeFont : [UIFont boldSystemFontOfSize:18]};
    
    if ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
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
