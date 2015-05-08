//
//  ZCprompt.m
//  我爱高尔夫
//
//  Created by hh on 15/5/4.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCprompt.h"
@interface ZCprompt()<UIAlertViewDelegate>
@end
@implementation ZCprompt

+ (void)prompt:(id )viewController andErrorCode:(NSString *)errorCode
{
    //ZCLog(@"%i",[errorCode isEqualToString:@"20305"]);
    
    // [[self alloc] alert:@"未注册过的用户"];
    if ([errorCode isEqualToString:@"10001"]) {
        [[self alloc] alert:@"无效的球场"];
    }else if ([errorCode isEqualToString:@"10002"])
    {
    [[self alloc] alert:@"数据未找到"];
    }else if ([errorCode isEqualToString:@"10003"])
    {
        [[self alloc] alert:@"访问非当前用户数据"];
    }else if ([errorCode isEqualToString:@"10004"])
    {
        [[self alloc] alert:@"API不存在"];
    }else if ([errorCode isEqualToString:@"20101"])
    {
        [[self alloc] alert:@"无效的球场"];
    }else if ([errorCode isEqualToString:@"20102"])
    {
        [[self alloc] alert:@"专业记分方式无法修改记分卡"];
    }else if ([errorCode isEqualToString:@"20103"])
    {
        [[self alloc] alert:@"简单记分方式无法修改击球记录"];
    }else if ([errorCode isEqualToString:@"20301"])
    {
        [[self alloc] alert:@"请求验证码过于频繁"];
    }else if ([errorCode isEqualToString:@"20302"])
    {
        [[self alloc] alert:@"未注册过的用户"];
    }else if ([errorCode isEqualToString:@"20303"])
    {
        [[self alloc] alert:@"用户重复注册"];
    }else if ([errorCode isEqualToString:@"20304"])
    {
        [[self alloc] alert:@"无效的验证码"];
    }else if ([errorCode isEqualToString:@"20305"])
    {
        [[self alloc] alert:@"无效的用户状态"];
    }else if ([errorCode isEqualToString:@"20306"])
    {
        [[self alloc] alert:@"无效的密码"];
    }else if ([errorCode isEqualToString:@"20307"])
    {
        [[self alloc] alert:@"无效的昵称"];
    }else if ([errorCode isEqualToString:@"20308"])
    {
        [[self alloc] alert:@"无效的性别"];
    }else if ([errorCode isEqualToString:@"20309"])
    {
        [[self alloc] alert:@"无效的确认密码"];
    }else if ([errorCode isEqualToString:@"20310"])
    {
        [[self alloc] alert:@"无效的原密码"];
    }else if ([errorCode isEqualToString:@"20111"])
    {
    [[self alloc] alert:@"重复进洞击球"];
    }else if ([errorCode isEqualToString:@"20110"])
    {
        [[self alloc] alert:@"没有进洞击球"];
    }






   
    
}





-(void)alert:(NSString *)str
{
    // 弹框
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    
    // 设置对话框的类型
    alert.alertViewStyle = UIKeyboardTypeNumberPad;
    
    [alert show];
    
}

//#pragma mark - alertView的代理方法
///**
// *  点击了alertView上面的按钮就会调用这个方法
// *
// *  @param buttonIndex 按钮的索引,从0开始
// */
//
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == 0)
//    {
//        // [self.navigationController popViewControllerAnimated:YES];
//    }else
//    {
//       // [self deleteTheAccount];
//    }
//    
//    // 按钮的索引肯定不是0
//    
//}
//



@end
