//
//  ZCSMSView.m
//  iGolf
//
//  Created by hh on 15/7/9.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCSMSView.h"
@interface ZCSMSView()
@property(nonatomic,weak)UITextField *phoneAccount;
@property(nonatomic,weak)UITextField *verificationCode;

@property(nonatomic,weak)UIButton *getButton;
@property(nonatomic,weak)UIButton *phoneloginBth;
@end
@implementation ZCSMSView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        
        UIImage *bjimage=[ZCTool imagePullLitre:@"shurukuang"];
        
        //账号
        UITextField *phoneAccount=[[UITextField alloc] init];
       
        //设置键盘为数字键盘
        phoneAccount.keyboardType=UIKeyboardTypeNumberPad;
        //[phoneAccount setTextColor:[UIColor whiteColor]];
        [phoneAccount setBackground:bjimage];
        phoneAccount.textColor=ZCColor(85, 85, 85);
        phoneAccount.placeholder=@"请输入您的手机号";
        //修改提示语的字体颜色
        [phoneAccount setValue:ZCColor(102, 102, 102) forKeyPath:@"_placeholderLabel.textColor"];
        phoneAccount.font=[UIFont systemFontOfSize:14];
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 10)];
        phoneAccount.leftView = paddingView;
        phoneAccount.leftViewMode = UITextFieldViewModeAlways;
        [self addSubview:phoneAccount];
        self.phoneAccount=phoneAccount;
        
        
        
        
        //验证码
        UITextField *verificationCode=[[UITextField alloc] init];
        //设置键盘为数字键盘
        verificationCode.keyboardType=UIKeyboardTypeNumberPad;
        [verificationCode setTextColor:ZCColor(85, 85, 85)];
        verificationCode.background=bjimage;
        verificationCode.placeholder=@"请输入验证码";
        //修改提示语的字体颜色
        [verificationCode setValue:ZCColor(102, 102, 102) forKeyPath:@"_placeholderLabel.textColor"];
        self.verificationCode=verificationCode;
        verificationCode.font=[UIFont systemFontOfSize:14];
        
        UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 10)];
        verificationCode.leftView = paddingView1;
        verificationCode.leftViewMode = UITextFieldViewModeAlways;
        [self addSubview:verificationCode];
        
        
        //获取验证码
        UIButton *getButton=[[UIButton alloc] init];
        [getButton setBackgroundImage:bjimage forState:UIControlStateNormal];
        [getButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [getButton setTitleColor:ZCColor(85, 85, 85) forState:UIControlStateNormal];
        [getButton addTarget:self action:@selector(clickgetButton) forControlEvents:UIControlEventTouchUpInside];
        getButton.titleLabel.font=[UIFont systemFontOfSize:14];
        
        self.getButton=getButton;
        [self addSubview:getButton];
        

        
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

        
        
    }
    return self;

}

//点击登陆
-(void)clickphoneloginBth1
{
    if ([self.delegate respondsToSelector:@selector(clickTheSMSView:)]) {
        [self.delegate clickTheSMSView:self];
    }
}



//发送验证码
-(void)clickgetButton
{
    
    //ZCLog(@"%@",self.phonePassword.text );
    
    
    BOOL isPhone=[ZCTool validateMobile:self.phoneAccount.text];
    
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
            [MBProgressHUD hideHUD];
            
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




-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    //账号
    CGFloat  phoneAccountX=SCREEN_WIDTH*0.031;
    CGFloat  phoneAccountY=5;
    CGFloat  phoneAccountW=SCREEN_WIDTH-(phoneAccountX*2);
    CGFloat  phoneAccountH=40;
    self.phoneAccount.frame=CGRectMake(phoneAccountX, phoneAccountY, phoneAccountW, phoneAccountH);
    
    
    CGFloat verificationCodeX=phoneAccountX;
    CGFloat verificationCodeY=phoneAccountY+phoneAccountH+15;
    CGFloat verificationCodeW=SCREEN_WIDTH*0.59;
    CGFloat verificationCodeH=phoneAccountH;
   self.verificationCode.frame=CGRectMake(verificationCodeX, verificationCodeY, verificationCodeW, verificationCodeH);
    
    
    CGFloat  getButtonW=SCREEN_WIDTH*0.3;
    CGFloat  getButtonX=phoneAccountX+phoneAccountW-getButtonW;
    CGFloat  getButtonY=verificationCodeY;
    CGFloat  getButtonH=verificationCodeH;
    self.getButton.frame=CGRectMake(getButtonX, getButtonY, getButtonW, getButtonH);


    //手机登陆
   // CGFloat  phoneloginBthY=getButtonY+getButtonH+40;
    CGFloat  phoneloginBthW=phoneAccountW;
    CGFloat  phoneloginBthH=40;
    CGFloat  phoneloginBthX=phoneAccountX;
    CGFloat  phoneloginBthY=self.frame.size.height-phoneloginBthH-5;
    self.phoneloginBth.frame=CGRectMake(phoneloginBthX, phoneloginBthY, phoneloginBthW, phoneloginBthH);

}

@end
