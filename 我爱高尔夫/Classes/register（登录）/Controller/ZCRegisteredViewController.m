//
//  ZCRegisteredViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/4/7.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCRegisteredViewController.h"
#import "AFNetworking.h"
#import "ZCAccount.h"
#import "ZCTabbarViewController.h"
#import "AppDelegate.h"
@interface ZCRegisteredViewController ()
@property(nonatomic,weak)UIButton *getButton;
@property(nonatomic,weak)UITextField *phoneAccount;
@property(nonatomic,weak)UITextField *phonePassword;
@property(nonatomic,weak)UIButton *phoneloginBth;
@property(nonatomic,weak)UITextField *confirmPassword;
@property(nonatomic,weak)UITextField *verificationCode;
@end

@implementation ZCRegisteredViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"suoyou_bj"]];
    
    
    //账号
    UITextField *phoneAccount=[[UITextField alloc] init];
    //账号
    CGFloat  phoneAccountX=SCREEN_WIDTH*0.031;
    CGFloat  phoneAccountY=35;
    CGFloat  phoneAccountW=SCREEN_WIDTH-(phoneAccountX*2);
    CGFloat  phoneAccountH=40.5;
    phoneAccount.frame=CGRectMake(phoneAccountX, phoneAccountY, phoneAccountW, phoneAccountH);
    //设置键盘为数字键盘
    phoneAccount.keyboardType=UIKeyboardTypeNumberPad;
    [phoneAccount setTextColor:[UIColor whiteColor]];
    [phoneAccount setBackground:[UIImage imageNamed:@"denglu_denglukuang"]];
    
    phoneAccount.placeholder=@"请输入您的手机号";
    //修改提示语的字体颜色
    [phoneAccount setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:phoneAccount];
    self.phoneAccount=phoneAccount;
    
    
    
    //密码
    UITextField *phonePassword=[[UITextField alloc] init];
    CGFloat  phonePasswordX=phoneAccountX;
    CGFloat  phonePasswordY=phoneAccountY+phoneAccountH+20;
    CGFloat  phonePasswordW=phoneAccountW;
    CGFloat  phonePasswordH=phoneAccountH;
    phonePassword.frame=CGRectMake(phonePasswordX, phonePasswordY, phonePasswordW, phonePasswordH);
    
    [phonePassword setTextColor:[UIColor whiteColor]];
    //实现密文形式
    phonePassword.secureTextEntry=YES;
    phonePassword.placeholder=@"至少输入6位的密码";
    //修改提示语的字体颜色
    [phonePassword setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    [phonePassword setBackground:[UIImage imageNamed:@"denglu_denglukuang"]];
    [self.view addSubview:phonePassword];
    self.phonePassword=phonePassword;
    
    
    //确认密码
    //密码
    UITextField *confirmPassword=[[UITextField alloc] init];
    CGFloat  confirmPasswordX=phonePasswordX;
    CGFloat  confirmPasswordY=phonePasswordY+phonePasswordH+20;
    CGFloat  confirmPasswordW=phoneAccountW;
    CGFloat  confirmPasswordH=phoneAccountH;
    confirmPassword.frame=CGRectMake(confirmPasswordX, confirmPasswordY, confirmPasswordW, confirmPasswordH);
    confirmPassword.placeholder=@"请再一次输入密码";
    //修改提示语的字体颜色
    [confirmPassword setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [confirmPassword setTextColor:[UIColor whiteColor]];
    //实现密文形式
    confirmPassword.secureTextEntry=YES;
    
    [confirmPassword setBackground:[UIImage imageNamed:@"denglu_denglukuang"]];
    [self.view addSubview:confirmPassword];
    self.confirmPassword=confirmPassword;

    
    
    

    //验证码
    UITextField *verificationCode=[[UITextField alloc] init];
    //设置键盘为数字键盘
    verificationCode.keyboardType=UIKeyboardTypeNumberPad;
    [verificationCode setTextColor:[UIColor whiteColor]];
    CGFloat verificationCodeX=confirmPasswordX;
    CGFloat verificationCodeY=confirmPasswordY+confirmPasswordH+20;
    CGFloat verificationCodeW=SCREEN_WIDTH*0.59;
    CGFloat verificationCodeH=phonePasswordH;
    verificationCode.frame=CGRectMake(verificationCodeX, verificationCodeY, verificationCodeW, verificationCodeH);
    verificationCode.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"denglu_denglukuang"]];
    verificationCode.placeholder=@"请输入验证码";
    //修改提示语的字体颜色
    [verificationCode setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.verificationCode=verificationCode;
    [self.view addSubview:verificationCode];
    
    
    //获取验证码
    UIButton *getButton=[[UIButton alloc] init];
    [getButton setBackgroundImage:[UIImage imageNamed:@"zhuce_yanzhengma_anniu"] forState:UIControlStateNormal];
    CGFloat  getButtonX=verificationCodeX+verificationCodeW+10;
    CGFloat  getButtonY=verificationCodeY;
    CGFloat  getButtonW=SCREEN_WIDTH*0.3;
    CGFloat  getButtonH=verificationCodeH;
    getButton.frame=CGRectMake(getButtonX, getButtonY, getButtonW, getButtonH);
    [getButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getButton addTarget:self action:@selector(clickgetButton) forControlEvents:UIControlEventTouchUpInside];
    self.getButton=getButton;
    [self.view addSubview:getButton];
    
    
    
    
    //提交
    UIButton *phoneloginBth=[[UIButton alloc] init];
    phoneloginBth.enabled=NO;
    CGFloat  phoneloginBthY=verificationCodeY+verificationCodeH+45;
    CGFloat  phoneloginBthW=phonePasswordW;
    CGFloat  phoneloginBthH=phonePasswordH;
    CGFloat  phoneloginBthX=verificationCodeX;
    phoneloginBth.frame=CGRectMake(phoneloginBthX, phoneloginBthY, phoneloginBthW, phoneloginBthH);
    
    
    [phoneloginBth setTitle:@"提交" forState:UIControlStateNormal];
    [phoneloginBth setBackgroundColor:ZCColor(105, 178, 138) ];
    [phoneloginBth addTarget:self action:@selector(clickphoneloginBth) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:phoneloginBth];
    self.phoneloginBth=phoneloginBth;
    
    
    
    
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.phoneAccount];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.phonePassword];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.confirmPassword];
    
}

- (void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


//监听文本框改变时调用
-(void)textChange
{
    if (self.phoneAccount.text.length==11&&self.phonePassword.text.length>=6&&self.confirmPassword.text.length==self.phonePassword.text.length) {
        self.phoneloginBth.enabled=YES;
         [self.phoneloginBth setBackgroundImage:[UIImage imageNamed:@"denglu_anniu-1"] forState:UIControlStateNormal];
        [self.phoneloginBth setBackgroundImage:[UIImage imageNamed:@"denglu_anniu_anxia"] forState:UIControlStateHighlighted];
    }else
    {
    self.phoneloginBth.enabled=NO;
       [self.phoneloginBth setBackgroundColor:ZCColor(105, 178, 138) ];
    }
//   self.phoneloginBth.enabled = (self.phoneAccount.text.length && self.phonePassword.text.length);
}


//点击提交按钮
-(void)clickphoneloginBth
{
    
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"users/sign_up.json"];
    //封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"phone"] = self.phoneAccount.text;
    params[@"password"]=self.phonePassword.text;
    params[@"password_confirmation"]=self.confirmPassword.text;
    params[@"verification_code"]=self.verificationCode.text;
    //发送请求/v1/users/sign_up.json

    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        ZCLog(@"%@",responseObject);
       // NSString * responseObject[@"error_code"]
        if (responseObject[@"error_code"] ) {
            ZCLog(@"异常了 ");
        }else{
            
            
            // 先将字典转为模型
      ZCAccount *account=[ZCAccount accountWithDict:responseObject];
            // 存储模型数据
       NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
       [NSKeyedArchiver archiveRootObject:account toFile:file];
            
            ZCLog(@"%@",account.token);
        
            
      UIWindow *wd = [[UIApplication sharedApplication].delegate window];
            //去首页
       wd.rootViewController = [[ZCTabbarViewController alloc] init];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
   
}



//发送验证码
-(void)clickgetButton
{

    ZCLog(@"%@",self.phonePassword.text);
    
    
    
    
    
    ///v1/verification_code/send.json
    
    // AFNetworking\AFN
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mar=[AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"verification_code/send.json"];
    //封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"phone"] = self.phoneAccount.text;
    params[@"type"]=@"sign_up";
    //发送请求
    [mar GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
          NSLog(@"error code %ld",[operation.response statusCode]);
       //开始倒计时
        [self startTheCountdown];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求失败%@",error);
        //[SVProgressHUD dismiss];
    }];
    

    
    

}



//开始倒计时
-(void)startTheCountdown
{
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [_getButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                _getButton.userInteractionEnabled = YES;
                //_getButton.backgroundColor = kNaviBgColor;
                
            });
        }else{
            //            int minutes = timeout / 60;
            //            int seconds = timeout % 60;
            int seconds = timeout;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSLog(@"____%@",strTime);
                [_getButton setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
                _getButton.userInteractionEnabled = NO;
                //l_timeButton.backgroundColor = kSourceColor;
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
    
    


}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
