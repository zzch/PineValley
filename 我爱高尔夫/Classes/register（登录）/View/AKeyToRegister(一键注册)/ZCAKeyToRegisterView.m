//
//  ZCAKeyToRegisterView.m
//  我爱高尔夫
//
//  Created by hh on 15/4/1.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCAKeyToRegisterView.h"
#import "AFNetworking.h"
#import "ZCAccount.h"
#import "ZCTabbarViewController.h"
#import "SVProgressHUD.h"
@implementation ZCAKeyToRegisterView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
        
        //添加一键注册 按钮
       
        self.backgroundColor=[UIColor grayColor];
       
        [self setTitle:@"一键注册" forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"denglu_anniu-1"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"denglu_anniu_anxia"] forState:UIControlStateHighlighted];
        
        
        [self addTarget:self action:@selector(clickKeyButton) forControlEvents:UIControlEventTouchUpInside];
        

        
        
        
        
    }
    return self;

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
        
         ZCLog(@"%@",account.token);
        
        //去首页
        self.window.rootViewController = [[ZCTabbarViewController alloc] init];
        
        [SVProgressHUD dismiss];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求失败%@",error);
        [SVProgressHUD dismiss];
    }];
    
}



@end
