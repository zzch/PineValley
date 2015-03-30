//
//  ZCregisterViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/2/5.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCregisterViewController.h"
#import "AFNetworking.h"
#import "ZCAccount.h"
#import "ZCTabbarViewController.h"
#import "SVProgressHUD.h"
@interface ZCregisterViewController ()

@end

@implementation ZCregisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.navigationItem.title=@"我爱高尔夫";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    //添加一键注册 按钮
    UIButton *keyButton=[[UIButton alloc] init];
    keyButton.backgroundColor=[UIColor grayColor];
    keyButton.frame=CGRectMake(100, 160, 200, 80);
    [keyButton setTitle:@"一键注册" forState:UIControlStateNormal];
    [keyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:keyButton];
    [keyButton addTarget:self action:@selector(clickKeyButton) forControlEvents:UIControlEventTouchUpInside];
    
   
}
//点击一键注册，注册账号
-(void)clickKeyButton
{
   [SVProgressHUD show];
    
    // AFNetworking\AFN
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mar=[AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"users/sign_up_simple"];
    //发送请求
    [mar POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
         NSLog(@"%@",responseObject);
        
        // 先将字典转为模型
        ZCAccount *account=[ZCAccount accountWithDict:responseObject];
        // 存储模型数据
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
        [NSKeyedArchiver archiveRootObject:account toFile:file];
        
        //去首页
        self.view.window.rootViewController = [[ZCTabbarViewController alloc] init];
        
        [SVProgressHUD dismiss];
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
         NSLog(@"请求失败%@",error);
        [SVProgressHUD dismiss];
    }];

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
