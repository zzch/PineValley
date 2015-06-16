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
#import "ZCPracticeVController.h"
#import "AppDelegate.h"
#import "ZCprompt.h"
#import "UIBarButtonItem+DC.h"
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
    
    self.view.backgroundColor=ZCColor(237, 237, 237);
    
    
 
    self.navigationItem.title=@"手机注册";
    
    UIImage *bjimage=[UIImage imageNamed:@"shurukuang" ];
    // 指定为拉伸模式，伸缩后重新赋值
    bjimage = [bjimage resizableImageWithCapInsets:UIEdgeInsetsMake(25,25,10,10) resizingMode:UIImageResizingModeStretch];
    
    
    //账号
    UITextField *phoneAccount=[[UITextField alloc] init];
    //账号
    CGFloat  phoneAccountX=SCREEN_WIDTH*0.031;
    CGFloat  phoneAccountY=20;
    CGFloat  phoneAccountW=SCREEN_WIDTH-(phoneAccountX*2);
    CGFloat  phoneAccountH=40;
    phoneAccount.frame=CGRectMake(phoneAccountX, phoneAccountY, phoneAccountW, phoneAccountH);
    //设置键盘为数字键盘
    phoneAccount.keyboardType=UIKeyboardTypeNumberPad;
    //[phoneAccount setTextColor:[UIColor whiteColor]];
    [phoneAccount setBackground:bjimage];
    phoneAccount.textColor=ZCColor(85, 85, 85);
    phoneAccount.placeholder=@"  请输入您的手机号";
    //修改提示语的字体颜色
    [phoneAccount setValue:ZCColor(102, 102, 102) forKeyPath:@"_placeholderLabel.textColor"];
    phoneAccount.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:phoneAccount];
    self.phoneAccount=phoneAccount;
    
    
    
    //密码
    UITextField *phonePassword=[[UITextField alloc] init];
    CGFloat  phonePasswordX=phoneAccountX;
    CGFloat  phonePasswordY=phoneAccountY+phoneAccountH+20;
    CGFloat  phonePasswordW=phoneAccountW;
    CGFloat  phonePasswordH=phoneAccountH;
    phonePassword.frame=CGRectMake(phonePasswordX, phonePasswordY, phonePasswordW, phonePasswordH);
    
    [phonePassword setTextColor:ZCColor(85, 85, 85)];
    //实现密文形式
    phonePassword.secureTextEntry=YES;
    phonePassword.placeholder=@"  至少输入6位的密码";
    //修改提示语的字体颜色
    [phonePassword setValue:ZCColor(102, 102, 102) forKeyPath:@"_placeholderLabel.textColor"];
    
    [phonePassword setBackground:bjimage];
    phonePassword.font=[UIFont systemFontOfSize:14];
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
    confirmPassword.placeholder=@"  请再一次输入密码";
    //修改提示语的字体颜色
    [confirmPassword setValue:ZCColor(102, 102, 102) forKeyPath:@"_placeholderLabel.textColor"];
    [confirmPassword setTextColor:ZCColor(85, 85, 85)];
    //实现密文形式
    confirmPassword.secureTextEntry=YES;
    confirmPassword.font=[UIFont systemFontOfSize:14];
    [confirmPassword setBackground:bjimage];
    [self.view addSubview:confirmPassword];
    self.confirmPassword=confirmPassword;

    
    
    

    //验证码
    UITextField *verificationCode=[[UITextField alloc] init];
    //设置键盘为数字键盘
    verificationCode.keyboardType=UIKeyboardTypeNumberPad;
    [verificationCode setTextColor:ZCColor(85, 85, 85)];
    CGFloat verificationCodeX=confirmPasswordX;
    CGFloat verificationCodeY=confirmPasswordY+confirmPasswordH+20;
    CGFloat verificationCodeW=SCREEN_WIDTH*0.59;
    CGFloat verificationCodeH=phonePasswordH;
    verificationCode.frame=CGRectMake(verificationCodeX, verificationCodeY, verificationCodeW, verificationCodeH);
    verificationCode.background=bjimage;
    verificationCode.placeholder=@"  请输入验证码";
    //修改提示语的字体颜色
    [verificationCode setValue:ZCColor(102, 102, 102) forKeyPath:@"_placeholderLabel.textColor"];
    self.verificationCode=verificationCode;
    verificationCode.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:verificationCode];
    
    
    //获取验证码
    UIButton *getButton=[[UIButton alloc] init];
    [getButton setBackgroundImage:bjimage forState:UIControlStateNormal];
    CGFloat  getButtonX=verificationCodeX+verificationCodeW+10;
    CGFloat  getButtonY=verificationCodeY;
    CGFloat  getButtonW=SCREEN_WIDTH*0.3;
    CGFloat  getButtonH=verificationCodeH;
    getButton.frame=CGRectMake(getButtonX, getButtonY, getButtonW, getButtonH);
    [getButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getButton setTitleColor:ZCColor(85, 85, 85) forState:UIControlStateNormal];
    [getButton addTarget:self action:@selector(clickgetButton) forControlEvents:UIControlEventTouchUpInside];
    getButton.font=[UIFont systemFontOfSize:14];

    self.getButton=getButton;
    [self.view addSubview:getButton];
    
    
    
    
    //提交
    UIButton *phoneloginBth=[[UIButton alloc] init];
    phoneloginBth.enabled=NO;
    CGFloat  phoneloginBthY=verificationCodeY+verificationCodeH+25;
    CGFloat  phoneloginBthW=phonePasswordW;
    CGFloat  phoneloginBthH=40;
    CGFloat  phoneloginBthX=verificationCodeX;
    phoneloginBth.frame=CGRectMake(phoneloginBthX, phoneloginBthY, phoneloginBthW, phoneloginBthH);
    
    
    [phoneloginBth setTitle:@"提交" forState:UIControlStateNormal];
    [phoneloginBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    
    
    
    //图片拉伸
    UIImage *image2=[UIImage imageNamed:@"anniu_dianji" ];
    // 指定为拉伸模式，伸缩后重新赋值
    image2 = [image2 resizableImageWithCapInsets:UIEdgeInsetsMake(25,25,10,10) resizingMode:UIImageResizingModeStretch];
    [phoneloginBth setBackgroundImage:image2 forState:UIControlStateNormal];
    //[phoneloginBth setBackgroundColor:ZCColor(105, 178, 138) ];
    [phoneloginBth addTarget:self action:@selector(clickphoneloginBth) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:phoneloginBth];
    self.phoneloginBth=phoneloginBth;
    
    
    
    
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.phoneAccount];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.phonePassword];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.confirmPassword];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.verificationCode];
    
}

- (void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}





//监听文本框改变时调用
-(void)textChange
{
    
    if (self.phoneAccount.text.length > 11 ){
        self.phoneAccount.text = [self.phoneAccount.text substringToIndex:11];
        
    }

    
    
    if (self.phoneAccount.text.length==11&&self.phonePassword.text.length>=6&&self.confirmPassword.text.length==self.phonePassword.text.length&&self.verificationCode.text.length==4) {
        self.phoneloginBth.enabled=YES;
         //[self.phoneloginBth setBackgroundImage:[UIImage imageNamed:@"denglu_anniu-1"] forState:UIControlStateNormal];
        //[self.phoneloginBth setBackgroundImage:[UIImage imageNamed:@"denglu_anniu_anxia"] forState:UIControlStateHighlighted];
        [self.phoneloginBth setTitleColor:ZCColor(85, 85, 85) forState:UIControlStateNormal];
        
    }else
    {
    self.phoneloginBth.enabled=NO;
      [self.phoneloginBth setTitleColor:ZCColor(85, 85, 85) forState:UIControlStateNormal];
    }
//   self.phoneloginBth.enabled = (self.phoneAccount.text.length && self.phonePassword.text.length);
}


//结束编辑事件  （退出键盘）
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //     self.bKeyBoardHide = NO;
    [self.view endEditing:YES];
}







//点击提交按钮
-(void)clickphoneloginBth
{
    
    [MBProgressHUD showMessage:@"注册中..."];
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
            
            [ZCprompt initWithController:self andErrorCode:[NSString stringWithFormat:@"%@",responseObject[@"error_code"]]];
            
             [MBProgressHUD hideHUD];
        }else{
            
            
            // 先将字典转为模型
      ZCAccount *account=[ZCAccount accountWithDict:responseObject];
            // 存储模型数据
       NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
       [NSKeyedArchiver archiveRootObject:account toFile:file];
            
            ZCLog(@"%@",account.token);
            
            
     ZCPracticeVController *tabBarVc=[[ZCPracticeVController alloc] init];
            UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:tabBarVc];
            
            
            [MBProgressHUD hideHUD];
            
            [MBProgressHUD showSuccess:@"注册成功"];
            
      UIWindow *wd = [[UIApplication sharedApplication].delegate window];
            //去首页
       wd.rootViewController =nav;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [ZCprompt initWithController:self andErrorCode:[NSString stringWithFormat:@"%ld",(long)[operation.response statusCode]]];
        

        
       //  NSLog(@"error code %d",[operation.response statusCode]);
        
//        if (operation ) {
//            
//           // [ZCprompt prompt:self andErrorCode:[NSString stringWithFormat:@"%@",responseObject[@"error_code"]]];
//        }
        
    }];
   
}

//手机号验证
- (BOOL)validateMobile:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
//发送验证码
-(void)clickgetButton
{

    ZCLog(@"%@",self.phonePassword.text );
    
    
    BOOL isPhone=[self validateMobile:self.phoneAccount.text];
    
    if (isPhone==NO) {
        ZCLog(@"手机号错误");
        [ZCprompt initWithController:self andErrorCode:@"手机号输入错误"];
    }else
    {
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
        
        if (responseObject[@"error_code"] ) {
            
            [ZCprompt initWithController:self andErrorCode:[NSString stringWithFormat:@"%@",responseObject[@"error_code"]]];
            
        }else
        {
        
       //开始倒计时
        [self startTheCountdown];
        
        [MBProgressHUD showSuccess:@"验证码已发送"];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求失败%@",error);
        //[SVProgressHUD dismiss];
        
        [ZCprompt initWithController:self andErrorCode:[NSString stringWithFormat:@"%ld",(long)[operation.response statusCode]]];
        

    }];
    

    
    }

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
