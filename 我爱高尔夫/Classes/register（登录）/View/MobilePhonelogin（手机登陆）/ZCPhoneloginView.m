//
//  ZCPhoneloginView.m
//  我爱高尔夫
//
//  Created by hh on 15/4/7.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCPhoneloginView.h"
#import "AFNetworking.h"
#import "ZCAccount.h"
#import "ZCTabbarViewController.h"
@interface ZCPhoneloginView()
//账号
@property(nonatomic,weak)UITextField *phoneAccount;
//密码
@property(nonatomic,weak)UITextField *phonePassword;
//忘记密码
@property(nonatomic,weak)UIButton *forgetBth;
//手机登陆
@property(nonatomic,weak)UIButton *phoneloginBth;
@end
@implementation ZCPhoneloginView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        //账号
        UITextField *phoneAccount=[[UITextField alloc] init];
        [phoneAccount setTextColor:[UIColor whiteColor]];
        [phoneAccount setBackground:[UIImage imageNamed:@"denglu_denglukuang"]];
        phoneAccount.placeholder=@"请输入您的手机号";
        //修改提示语的字体颜色
        [phoneAccount setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        [self addSubview:phoneAccount];
        self.phoneAccount=phoneAccount;
        
        
        
        //密码
        UITextField *phonePassword=[[UITextField alloc] init];
        [phonePassword setTextColor:[UIColor whiteColor]];
        //实现密文形式
        phonePassword.secureTextEntry=YES;
        phonePassword.placeholder=@"请输入您的密码";
        //修改提示语的字体颜色
        [phonePassword setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        [phonePassword setBackground:[UIImage imageNamed:@"denglu_denglukuang"]];
        [self addSubview:phonePassword];
        self.phonePassword=phonePassword;
        
        //忘记密码
        UIButton *forgetBth=[[UIButton alloc] init];
        [forgetBth setTitle:@"忘记密码" forState:UIControlStateNormal];
        [self addSubview:forgetBth];
        self.forgetBth=forgetBth;
        
        
        //登陆
        UIButton *phoneloginBth=[[UIButton alloc] init];
        [phoneloginBth setTitle:@"登陆" forState:UIControlStateNormal];
        [phoneloginBth setBackgroundImage:[UIImage imageNamed:@"denglu_anniu-1"] forState:UIControlStateNormal];
        [phoneloginBth setBackgroundImage:[UIImage imageNamed:@"denglu_anniu_anxia"] forState:UIControlStateHighlighted];
        [phoneloginBth addTarget:self action:@selector(clickphoneloginBth) forControlEvents:UIControlEventTouchUpInside];
        [phoneloginBth setBackgroundColor:ZCColor(105, 178, 138) ];
        phoneloginBth.enabled=NO;

        [self addSubview:phoneloginBth];
        self.phoneloginBth=phoneloginBth;
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChangelogin) name:UITextFieldTextDidChangeNotification object:self.phoneAccount];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChangelogin) name:UITextFieldTextDidChangeNotification object:self.phonePassword];

        
    }


    return self;
}

//监听文本框里的值  改变就调用
-(void)textChangelogin
{
    if (self.phoneAccount.text.length==11&&self.phonePassword.text.length>=6) {
        
        self.phoneloginBth.enabled=YES;
        [self.phoneloginBth setBackgroundImage:[UIImage imageNamed:@"denglu_anniu-1"] forState:UIControlStateNormal];
        [self.phoneloginBth setBackgroundImage:[UIImage imageNamed:@"denglu_anniu_anxia"] forState:UIControlStateHighlighted];
        
    }else
    {
        self.phoneloginBth.enabled=NO;
        [self.phoneloginBth setBackgroundColor:ZCColor(105, 178, 138) ];
    
    }

    
    
    
}


-(void)clickphoneloginBth
{
    // AFNetworking\AFN
    // 1.创建请求管理对象/v1/users/sign_in.json
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"users/sign_in.json"];
    //封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"phone"] = self.phoneAccount.text;
    params[@"password"]=self.phonePassword.text;
    //发送请求
    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        ZCLog(@"%@",responseObject);
        
        
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

        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ZCLog(@"%@",error);
    }];



}







-(void)layoutSubviews
{
    [super layoutSubviews];
    //账号
    CGFloat  phoneAccountX=SCREEN_WIDTH*0.031;
    CGFloat  phoneAccountY=5;
    CGFloat  phoneAccountW=SCREEN_WIDTH-(phoneAccountX*2);
    CGFloat  phoneAccountH=40.5;
    self.phoneAccount.frame=CGRectMake(phoneAccountX, phoneAccountY, phoneAccountW, phoneAccountH);

    
    //密码
    CGFloat  phonePasswordX=phoneAccountX;
    CGFloat  phonePasswordY=phoneAccountY+phoneAccountH+10;
    CGFloat  phonePasswordW=phoneAccountW;
    CGFloat  phonePasswordH=phoneAccountH;
    self.phonePassword.frame=CGRectMake(phonePasswordX, phonePasswordY, phonePasswordW, phonePasswordH);
    
    //忘记密码
    
    CGFloat  forgetBthY=phonePasswordY+phonePasswordH+15;
    CGFloat  forgetBthW=80;
    CGFloat  forgetBthH=20;
    CGFloat  forgetBthX=SCREEN_WIDTH-forgetBthW-10;
    self.forgetBth.frame=CGRectMake(forgetBthX, forgetBthY, forgetBthW, forgetBthH);

    
    //手机登陆
    CGFloat  phoneloginBthY=phonePasswordY+phonePasswordH+63;
    CGFloat  phoneloginBthW=phonePasswordW;
    CGFloat  phoneloginBthH=phonePasswordH;
    CGFloat  phoneloginBthX=phonePasswordX;
    self.phoneloginBth.frame=CGRectMake(phoneloginBthX, phoneloginBthY, phoneloginBthW, phoneloginBthH);
}
@end
