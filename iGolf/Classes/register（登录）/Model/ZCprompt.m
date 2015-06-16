//
//  ZCprompt.m
//  我爱高尔夫
//
//  Created by hh on 15/5/4.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCprompt.h"
#import "ZCregisterViewController.h"
@interface ZCprompt()<UIAlertViewDelegate>
@property(nonatomic,weak)id viewController;
@property(nonatomic,copy)NSString *errorCode;
@end
@implementation ZCprompt


+(void)initWithController:(id)viewController  andErrorCode:(NSString *)errorCode
{
    
  ZCprompt * view= [[self alloc] initWithFrame:[UIScreen mainScreen].bounds andErrorCode:errorCode];
    // UIWindow *wd = [[UIApplication sharedApplication].delegate window];
    
    UIWindow *wd = [[[UIApplication sharedApplication] windows] lastObject];
    [wd addSubview:view];

}

+ (void)prompt:(id )viewController andErrorCode:(NSString *)errorCode
{
   
    //ZCLog(@"%i",[errorCode isEqualToString:@"20305"]);
    
    // [[self alloc] alert:@"未注册过的用户"];
//    if ([errorCode isEqualToString:@"10001"]) {
//       [[self alloc] controller:viewController alert:@"无效的球场"];
//    }else if ([errorCode isEqualToString:@"10002"])
//    {
//    [[self alloc] controller:viewController alert:@"数据未找到"];
//    }else if ([errorCode isEqualToString:@"10003"])
//    {
//        [[self alloc] controller:viewController alert:@"访问非当前用户数据"];
//    }else if ([errorCode isEqualToString:@"10004"])
//    {
//        [[self alloc] controller:viewController alert:@"API不存在"];
//    }else if ([errorCode isEqualToString:@"20101"])
//    {
//        [[self alloc] controller:viewController alert:@"无效的球场"];
//    }else if ([errorCode isEqualToString:@"20102"])
//    {
//        [[self alloc] controller:viewController alert:@"专业记分方式无法修改记分卡"];
//    }else if ([errorCode isEqualToString:@"20103"])
//    {
//        [[self alloc] controller:viewController alert:@"简单记分方式无法修改击球记录"];
//    }else if ([errorCode isEqualToString:@"20301"])
//    {
//        [[self alloc] controller:viewController alert:@"请求验证码过于频繁"];
//    }else if ([errorCode isEqualToString:@"20302"])
//    {
//        [[self alloc] controller:viewController alert:@"未注册过的用户"];
//    }else if ([errorCode isEqualToString:@"20303"])
//    {
//        [[self alloc] controller:viewController alert:@"用户重复注册"];
//    }else if ([errorCode isEqualToString:@"20304"])
//    {
//        [[self alloc] controller:viewController alert:@"无效的验证码"];
//    }else if ([errorCode isEqualToString:@"20305"])
//    {
//        [[self alloc] controller:viewController alert:@"无效的用户状态"];
//    }else if ([errorCode isEqualToString:@"20306"])
//    {
//        [[self alloc] controller:viewController alert:@"无效的密码"];
//    }else if ([errorCode isEqualToString:@"20307"])
//    {
//        [[self alloc] controller:viewController alert:@"无效的昵称"];
//    }else if ([errorCode isEqualToString:@"20308"])
//    {
//        [[self alloc] controller:viewController alert:@"无效的性别"];
//    }else if ([errorCode isEqualToString:@"20309"])
//    {
//        [[self alloc] controller:viewController alert:@"无效的确认密码"];
//    }else if ([errorCode isEqualToString:@"20310"])
//    {
//        [[self alloc] controller:viewController alert:@"无效的原密码"];
//    }else if ([errorCode isEqualToString:@"20111"])
//    {
//    [[self alloc] controller:viewController alert:@"重复进洞击球"];
//    }else if ([errorCode isEqualToString:@"20110"])
//    {
//        [[self alloc] controller:viewController alert:@"没有进洞击球"];
//    }else if ([errorCode isEqualToString:@"20113"])
//    {
//        [[self alloc] controller:viewController alert:@"比赛口令错误"];
//    }else if ([errorCode isEqualToString:@"20107"])
//    {
//        [[self alloc] controller:viewController alert:@"用户重复参加赛事"];
//    }else if ([errorCode isEqualToString:@"20303"])
//    {
//        [[self alloc] controller:viewController alert:@"用户重复注册"];
//    }else if ([errorCode isEqualToString:@"20301"])
//    {
//        [[self alloc] controller:viewController alert:@"用户频繁操作"];
//    }else if ([errorCode isEqualToString:@"20315"])
//    {
//        [[self alloc] controller:viewController alert:@"用户一天请求已经达到15次"];
//    }else if ([errorCode isEqualToString:@"20316"])
//    {
//        [[self alloc] controller:viewController alert:@"您已经是会员了"];
//    }else if ([errorCode isEqualToString:@"401"])
//    {
//       [[self alloc] controller:viewController alert:@"您已在别处登录，请重新登录"];
//    }
//









    //return [self alloc ;
   
    
}



-(instancetype)initWithFrame:(CGRect)frame andErrorCode:(NSString *)errorCode;
{
    if (self=[super initWithFrame:frame]) {
       
        
        NSString *errorStr;
        if ([errorCode isEqualToString:@"10001"]) {
            errorStr=@"无效的球场";
        }else if ([errorCode isEqualToString:@"10002"])
        {
            errorStr=@"数据未找到";
            
        }else if ([errorCode isEqualToString:@"10003"])
        {
            errorStr=@"访问非当前用户数据";
            
        }else if ([errorCode isEqualToString:@"10004"])
        {
            errorStr=@"API不存在";
            
        }else if ([errorCode isEqualToString:@"20101"])
        {
            errorStr=@"无效的球场";
            
        }else if ([errorCode isEqualToString:@"20102"])
        {
            errorStr=@"专业记分方式无法修改记分卡";
            
        }else if ([errorCode isEqualToString:@"20103"])
        {
            errorStr=@"简单记分方式无法修改击球记录";
            
        }else if ([errorCode isEqualToString:@"20301"])
        {
            errorStr=@"请求验证码过于频繁";
            
        }else if ([errorCode isEqualToString:@"20302"])
        {
            errorStr=@"未注册过的用户";
            
        }else if ([errorCode isEqualToString:@"20303"])
        {
            errorStr=@"用户重复注册";
            
        }else if ([errorCode isEqualToString:@"20304"])
        {
            errorStr=@"无效的验证码";
            
        }else if ([errorCode isEqualToString:@"20305"])
        {
            errorStr=@"无效的用户状态";
            
        }else if ([errorCode isEqualToString:@"20306"])
        {
            errorStr=@"无效的密码";
            
        }else if ([errorCode isEqualToString:@"20307"])
        {
            errorStr=@"无效的昵称";
            
        }else if ([errorCode isEqualToString:@"20308"])
        {
            errorStr=@"无效的性别";
            
        }else if ([errorCode isEqualToString:@"20309"])
        {
            errorStr=@"无效的确认密码";
            
        }else if ([errorCode isEqualToString:@"20310"])
        {
            errorStr=@"无效的原密码";
            
        }else if ([errorCode isEqualToString:@"20111"])
        {
            errorStr=@"重复进洞击球";
            
        }else if ([errorCode isEqualToString:@"20110"])
        {
            errorStr=@"没有进洞击球";
            
        }else if ([errorCode isEqualToString:@"20113"])
        {
            errorStr=@"比赛口令错误";
            
        }else if ([errorCode isEqualToString:@"20107"])
        {
            errorStr=@"用户重复参加赛事";
            
        }else if ([errorCode isEqualToString:@"20303"])
        {
            errorStr=@"用户重复注册";
            
        }else if ([errorCode isEqualToString:@"20301"])
        {
            errorStr=@"用户频繁操作";
            
        }else if ([errorCode isEqualToString:@"20315"])
        {
            errorStr=@"用户一天请求已经达到15次";
            
        }else if ([errorCode isEqualToString:@"20316"])
        {
            errorStr=@"您已经是会员了";
            
        }else if ([errorCode isEqualToString:@"401"])
        {
            errorStr=@"您已在别处登录，请重新登录";
            
        }else if ([errorCode isEqualToString:@"0"])
        {
            errorStr=@"网络错误";
            
        }else
        {
         errorStr=errorCode;
        }
        

        
        
        self.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.4];
        self.errorCode=errorCode;
        
        UIView *alertView=[[UIView alloc] init];
        CGFloat alertViewW=250;
        CGFloat alertViewH=100;
        CGFloat alertViewX=(self.frame.size.width-alertViewW)/2;
        CGFloat alertViewY=(SCREEN_HEIGHT-alertViewH)/2;
        
        alertView.frame=CGRectMake(alertViewX, alertViewY, alertViewW, alertViewH);
        alertView.alpha=1.0;
        alertView.backgroundColor=[UIColor whiteColor];
        alertView.layer.cornerRadius=5;//设置圆角的半径为10
        alertView.layer.masksToBounds=YES;
        [self addSubview:alertView];
        
        
        UILabel *textLabel=[[UILabel alloc] init];
        CGFloat textLabelX=0;
        CGFloat textLabelY=0;
        CGFloat textLabelW=alertViewW;
        CGFloat textLabelH=alertViewH/2-0.5;
        textLabel.frame=CGRectMake(textLabelX, textLabelY, textLabelW, textLabelH);
        textLabel.text=errorStr;
        textLabel.textAlignment=NSTextAlignmentCenter;
        textLabel.font=[UIFont systemFontOfSize:15];
        [alertView addSubview:textLabel];
        
        UIView *bjView=[[UIView alloc] initWithFrame:CGRectMake(0, textLabelH, textLabelW, 0.5)];
        bjView.backgroundColor=ZCColor(224, 224, 224);
        [alertView addSubview:bjView];
        
        
        UIButton *determineBtn=[[UIButton alloc] init];
        CGFloat determineBtnX=0;
        CGFloat determineBtnY=textLabelH+0.5;
        CGFloat determineBtnW=textLabelW;
        CGFloat determineBtnH=textLabelH;
        determineBtn.frame=CGRectMake(determineBtnX, determineBtnY, determineBtnW, determineBtnH);
        [determineBtn setTitle:@"确定" forState:UIControlStateNormal];
        [determineBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [determineBtn addTarget:self action:@selector(clickThedetermineBtn) forControlEvents:UIControlEventTouchUpInside];
        [alertView addSubview:determineBtn];
        
    }
    return self;
   }



//点击确定
-(void)clickThedetermineBtn
{

    if ([self.errorCode isEqual:@"401"]) {
        
        
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
        //删除文件
        [[NSFileManager defaultManager] removeItemAtPath:file error:nil];
        
        NSString *path=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"personImage.png"];
        
        //删除文件
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        
        UIWindow *wd = [[UIApplication sharedApplication].delegate window];
        ZCregisterViewController *registerView=[[ZCregisterViewController alloc] init];
        UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:registerView];
        wd.rootViewController=nav;
        
       [self removeFromSuperview];
    }else
    {
        [self removeFromSuperview];
    
    }
    
  
}




//-(void)controller:(id)viewController  alert:(NSString *)str
//{
//    // 弹框
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    
//    // 设置对话框的类型
//    alert.alertViewStyle = UIKeyboardTypeNumberPad;
//    
//    [alert show];
//    
//}

#pragma mark - alertView的代理方法
/**
 *  点击了alertView上面的按钮就会调用这个方法
 *
 *  @param buttonIndex 按钮的索引,从0开始
 */



//-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
//{
//    ZCLog(@"dasdasdasd");
//
//}
//
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == 0)
//    {
//        // [self.navigationController popViewControllerAnimated:YES];
//        ZCLog(@"adsasdasd");
//    }else
//    {
//        ZCLog(@"adsasdasd");
//
//       // [self deleteTheAccount];
//    }
//    
//    // 按钮的索引肯定不是0
//    
//}

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self removeFromSuperview];
//
//}


@end
