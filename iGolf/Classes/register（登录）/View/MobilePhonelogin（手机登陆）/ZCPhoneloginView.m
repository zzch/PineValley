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
#import "ZCPracticeVController.h"
#import "ZCprompt.h"
#import "UIImageView+WebCache.h"

@interface ZCPhoneloginView()
//账号
@property(nonatomic,weak)UITextField *phoneAccount;
//密码
@property(nonatomic,weak)UITextField *phonePassword;
//忘记密码
@property(nonatomic,weak)UIButton *forgetBth;
//手机登陆
@property(nonatomic,weak)UIButton *phoneloginBth;
@property(nonatomic,weak)UIImageView *image11;

@property(nonatomic,assign) BOOL isClick;
@end
@implementation ZCPhoneloginView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        
        
        
        
        UIImageView *image11=[[UIImageView alloc] init];
        
        image11.frame=CGRectMake(0, 0, 50, 50);
        [self addSubview:image11];
        self.image11=image11;
        
        
        
        
        UIImage *image1=[UIImage imageNamed:@"shurukuang" ];
        // 指定为拉伸模式，伸缩后重新赋值
        image1 = [image1 resizableImageWithCapInsets:UIEdgeInsetsMake(25,25,10,10) resizingMode:UIImageResizingModeStretch];
        
        
        //账号
        UITextField *phoneAccount=[[UITextField alloc] init];
        [phoneAccount setTextColor:ZCColor(85, 85, 85)];
        [phoneAccount setBackground:image1];
        phoneAccount.placeholder=@"  请输入您的手机号";
        //设置键盘为数字键盘
        phoneAccount.keyboardType=UIKeyboardTypeNumberPad;
        //修改提示语的字体颜色
        [phoneAccount setValue:ZCColor(102, 102, 102)
                    forKeyPath:@"_placeholderLabel.textColor"];
        phoneAccount.font=[UIFont systemFontOfSize:14];
        [self addSubview:phoneAccount];
        self.phoneAccount=phoneAccount;
        
        
        
        //密码
        UITextField *phonePassword=[[UITextField alloc] init];
        [phonePassword setTextColor:ZCColor(85, 85, 85)];
        //实现密文形式
        phonePassword.secureTextEntry=YES;
        phonePassword.placeholder=@"  请输入您的密码";
        //修改提示语的字体颜色
        [phonePassword setValue:ZCColor(102, 102, 102) forKeyPath:@"_placeholderLabel.textColor"];
        [phonePassword setBackground:image1];
         phonePassword.font=[UIFont systemFontOfSize:14];
        [self addSubview:phonePassword];
       
        self.phonePassword=phonePassword;
        
        //忘记密码
        UIButton *forgetBth=[[UIButton alloc] init];
        [forgetBth setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [forgetBth setTitleColor:ZCColor(102, 102, 102) forState:UIControlStateNormal];
        forgetBth.titleLabel.font=[UIFont systemFontOfSize:15];
        
        [forgetBth addTarget:self action:@selector(clickTheforgetBth) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:forgetBth];
        self.forgetBth=forgetBth;
        
        
        //登陆
        UIButton *phoneloginBth=[[UIButton alloc] init];
        [phoneloginBth setTitle:@"登录" forState:UIControlStateNormal];
        
        
        UIImage *image2=[UIImage imageNamed:@"anniu_dianji" ];
        // 指定为拉伸模式，伸缩后重新赋值
        image2 = [image2 resizableImageWithCapInsets:UIEdgeInsetsMake(25,25,10,10) resizingMode:UIImageResizingModeStretch];
        [phoneloginBth setBackgroundImage:image2 forState:UIControlStateNormal];

        [phoneloginBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
        [phoneloginBth addTarget:self action:@selector(clickphoneloginBth1) forControlEvents:UIControlEventTouchUpInside];
        
       // phoneloginBth.enabled=NO;

        [self addSubview:phoneloginBth];
        self.phoneloginBth=phoneloginBth;
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChangelogin) name:UITextFieldTextDidChangeNotification object:self.phoneAccount];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChangelogin) name:UITextFieldTextDidChangeNotification object:self.phonePassword];

        
    }


    return self;
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


//点击忘记密码
-(void)clickTheforgetBth
{

    if ([self.delegate respondsToSelector:@selector(ZCPhoneloginViewIsClick:)]) {
        [self .delegate ZCPhoneloginViewIsClick:nil];
    }
    
}




//监听文本框里的值  改变就调用
-(void)textChangelogin
{
    
    if (self.phoneAccount.text.length > 11 ){
        self.phoneAccount.text = [self.phoneAccount.text substringToIndex:11];
        
    }

    
    
    
    if (self.phoneAccount.text.length==11&&self.phonePassword.text.length>=6) {
        
        self.isClick=YES;
       // [self.phoneloginBth setBackgroundImage:[UIImage imageNamed:@"denglu_anniu-1"] forState:UIControlStateNormal];
        //[self.phoneloginBth setBackgroundImage:[UIImage imageNamed:@"denglu_anniu_anxia"] forState:UIControlStateHighlighted];
       // [self.phoneloginBth setTitleColor:ZCColor(240, 208, 122) forState:UIControlStateNormal];
    }else
    {
        
        self.isClick=NO;
        //self.phoneloginBth.enabled=NO;
        //[self.phoneloginBth setBackgroundColor:ZCColor(105, 178, 138) ];
       // [self.phoneloginBth setTitleColor:ZCColor(136, 119, 73) forState:UIControlStateNormal];
    
    }

    
    
    
}


-(void)clickphoneloginBth1
{
    
    
    if (self.isClick==NO) {
        [MBProgressHUD showError:@"您输入的手机号或密码有误"];
    }else
    {
    
    
    BOOL isPhone=[self validateMobile:self.phoneAccount.text];
    if (isPhone==NO) {
        [ZCprompt initWithController:self andErrorCode:@"手机号输入错误"];
    }else
    {

    
    
    [MBProgressHUD showMessage:@"加载中..."];
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
        
        if (responseObject[@"error_code"] ) {
            
            [ZCprompt initWithController:self andErrorCode:[NSString stringWithFormat:@"%@",responseObject[@"error_code"]]];
           // [ZCprompt prompt:self andErrorCode:responseObject[@"error_code"]];
            
            [MBProgressHUD hideHUD];
        }else{

        
        
        
        
        // 先将字典转为模型
        ZCAccount *account=[ZCAccount accountWithDict:responseObject];
        // 存储模型数据
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
        [NSKeyedArchiver archiveRootObject:account toFile:file];
        
            
            if ([self _valueOrNil:responseObject[@"portrait"]]==nil) {
                ZCLog(@"不改执行的一步");
            }else
            {
                
                ZCLog(@"你有没有被执行");
               
                
               dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSURL *url=[NSURL URLWithString:responseObject[@"portrait"][@"url"]];
                   
                   NSData *data=[[NSData alloc] initWithContentsOfURL:url];
                   
                   
                   NSString *path=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"personImage.png"];

                   [data writeToFile:path atomically:YES];
               });
                
                
                
            }
            
            [MBProgressHUD hideHUD];
   
            [MBProgressHUD showSuccess:@"登录成功"];
            
            ZCPracticeVController *tabBarVc=[[ZCPracticeVController alloc] init];
            UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:tabBarVc];
            
            self.window.rootViewController=nav;
        
            
            
      //  account.
        //UIWindow *wd = [[UIApplication sharedApplication].delegate window];
        //去首页
       
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [ZCprompt initWithController:self andErrorCode:[NSString stringWithFormat:@"%ld",(long)[operation.response statusCode]]];
      
        
    }];

    }
    }

}

    
    
- (id) _valueOrNil:(id)obj {
    if (!obj) {
        return nil;
    }
    if (obj == [NSNull null]) {
        return nil;
    }
    return obj;
}






-(void)layoutSubviews
{
    [super layoutSubviews];
    //账号
    CGFloat  phoneAccountX=SCREEN_WIDTH*0.031;
    CGFloat  phoneAccountY=5;
    CGFloat  phoneAccountW=SCREEN_WIDTH-(phoneAccountX*2);
    CGFloat  phoneAccountH=40;
    self.phoneAccount.frame=CGRectMake(phoneAccountX, phoneAccountY, phoneAccountW, phoneAccountH);

    
    //密码
    CGFloat  phonePasswordX=phoneAccountX;
    CGFloat  phonePasswordY=phoneAccountY+phoneAccountH+15;
    CGFloat  phonePasswordW=phoneAccountW;
    CGFloat  phonePasswordH=phoneAccountH;
    self.phonePassword.frame=CGRectMake(phonePasswordX, phonePasswordY, phonePasswordW, phonePasswordH);
    
    //忘记密码
    
    CGFloat  forgetBthY=phonePasswordY+phonePasswordH+15;
    CGFloat  forgetBthW=80;
    CGFloat  forgetBthH=15;
    CGFloat  forgetBthX=SCREEN_WIDTH-forgetBthW-10;
    self.forgetBth.frame=CGRectMake(forgetBthX, forgetBthY, forgetBthW, forgetBthH);

    
    //手机登陆
    CGFloat  phoneloginBthY=forgetBthY+forgetBthH+25;
    CGFloat  phoneloginBthW=phonePasswordW;
    CGFloat  phoneloginBthH=40;
    CGFloat  phoneloginBthX=phonePasswordX;
    self.phoneloginBth.frame=CGRectMake(phoneloginBthX, phoneloginBthY, phoneloginBthW, phoneloginBthH);
}
@end
