//
//  ZCChangethePasswordViewController.m
//  iGolf
//
//  Created by hh on 15/5/27.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCChangethePasswordViewController.h"
#import "ZCAccount.h"
#import "AFNetworking.h"
#import "ZCprompt.h"
@interface ZCChangethePasswordViewController ()
@property(nonatomic,weak)UITextField *originalPassword;
@property(nonatomic,weak)UITextField *settingPassword;
@property(nonatomic,weak)UITextField *againPassword;
@property(nonatomic,weak)UIButton *submitButton;
@end

@implementation ZCChangethePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.navigationItem.title=@"账号密码";
    self.view.backgroundColor=ZCColor(237, 237, 237);
    
    
    UIImage *image=[UIImage imageNamed:@"shurukuang" ];
    // 指定为拉伸模式，伸缩后重新赋值
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(10,10,10,10) resizingMode:UIImageResizingModeStretch];
    
    
    UITextField *originalPassword=[[UITextField alloc] init];
    CGFloat originalPasswordX=10;
    CGFloat originalPasswordY=30;
    CGFloat originalPasswordW=SCREEN_WIDTH-(2*originalPasswordX);
    CGFloat originalPasswordH=40;
    
    originalPassword.frame=CGRectMake(originalPasswordX, originalPasswordY, originalPasswordW, originalPasswordH);
    originalPassword.background=image;
    originalPassword.placeholder=@"请输入当前密码";
    originalPassword.keyboardType=UIKeyboardAppearanceDefault;
    originalPassword.secureTextEntry=YES;
    [self.view addSubview:originalPassword];
    self.originalPassword=originalPassword;
    
    
    
    
    UITextField *settingPassword=[[UITextField alloc] init];
    CGFloat settingPasswordX=10;
    CGFloat settingPasswordY=originalPasswordY+originalPasswordH+21;
    CGFloat settingPasswordW=SCREEN_WIDTH-(2*originalPasswordX);
    CGFloat settingPasswordH=40;
    
    settingPassword.frame=CGRectMake(settingPasswordX, settingPasswordY, settingPasswordW, settingPasswordH);
    settingPassword.background=image;
    settingPassword.placeholder=@"请设置密码";
    settingPassword.secureTextEntry=YES;
    [self.view addSubview:settingPassword];
    self.settingPassword=settingPassword;
    
    
    
    UITextField *againPassword=[[UITextField alloc] init];
    CGFloat againPasswordX=10;
    CGFloat againPasswordY=settingPasswordY+settingPasswordH+21;
    CGFloat againPasswordW=SCREEN_WIDTH-(2*originalPasswordX);
    CGFloat againPasswordH=40;
    
    againPassword.frame=CGRectMake(againPasswordX, againPasswordY, againPasswordW, againPasswordH);
    againPassword.background=image;
    againPassword.placeholder=@"请再次输入";
    againPassword.secureTextEntry=YES;
    [self.view addSubview:againPassword];
    self.againPassword=againPassword;

    
    
    
    
    UIButton *submitButton=[[UIButton alloc] init];
    
    
    CGFloat   submitButtonY=againPasswordY+againPasswordH+45;
    
    CGFloat   submitButtonH=40;
    CGFloat   submitButtonX=10;
    CGFloat   submitButtonW=SCREEN_WIDTH-20;
    submitButton.frame=CGRectMake(submitButtonX, submitButtonY, submitButtonW, submitButtonH);
    submitButton.enabled=NO;
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    submitButton.backgroundColor=ZCColor(100, 175, 102);
    [self.view addSubview:submitButton];
    [submitButton addTarget:self action:@selector(clickTheSubmitButton) forControlEvents:UIControlEventTouchUpInside];
   // self.nextButton=nextButton;
    submitButton.layer.masksToBounds=YES;
    submitButton.layer.cornerRadius=5;//设置圆角的半径为5
    self.submitButton=submitButton;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextFieldTextChange) name:UITextFieldTextDidChangeNotification object:againPassword];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextFieldTextChange) name:UITextFieldTextDidChangeNotification object:settingPassword];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextFieldTextChange) name:UITextFieldTextDidChangeNotification object:originalPassword];
    
    
}

//监听内容改变
-(void)TextFieldTextChange
{
    if (self.originalPassword.text.length>=6&&self.settingPassword.text.length>=6&&self.againPassword.text.length>=6) {
        self.submitButton.enabled=YES;
        [self.submitButton setBackgroundColor:ZCColor(9, 133, 12)];
    }else
    {
    
        self.submitButton.enabled=NO;
        [self.submitButton setBackgroundColor:ZCColor(100, 175, 102)];

    }

}




- (void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


//点击提交
-(void)clickTheSubmitButton
{
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"text/plain",@"application/xhtml+xml",@"application/xml",@"application/json", nil];
    
    //封装请求参数
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES) lastObject];
    NSString *file=[doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"original_password"]=self.originalPassword.text;
    params[@"password"]=self.settingPassword.text;
    params[@"password_confirmation"]=self.againPassword.text;
    
    params[@"token"]=account.token;
    
    
    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"users/update_password.json"];


    [mgr PUT:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        ZCLog(@"%@",responseObject);
        if (responseObject[@"error_code"]) {
            [ZCprompt prompt:self andErrorCode:[NSString stringWithFormat:@"%@",responseObject[@"error_code"]]];
        }else
        {
            [self.navigationController popViewControllerAnimated:YES];
        
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        ZCLog(@"%@",error);
        
    }];
    

}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];

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
