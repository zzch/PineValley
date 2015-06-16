//
//  ZCValidationViewController.m
//  iGolf
//
//  Created by hh on 15/5/26.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCValidationViewController.h"
#import "ZCAccount.h"
#import "AFNetworking.h"
#import "ZCAccountSettingsViewController.h"
#import "ZCAccountSettingsViewController.h"
@interface ZCValidationViewController ()
@property(nonatomic,weak)UITextField *validationText;
@property(nonatomic,weak)UITextField *passwordTextField;
@property(nonatomic,weak)UITextField *againPassword;
@property(nonatomic,weak)UIButton *submitButton;
@end

@implementation ZCValidationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor=ZCColor(237, 237, 237);
    self.navigationItem.title=@"验证手机号";
    //返回
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barBtnItemWithNormalImageName:@"fanhui" hightImageName:@"fanhui" action:@selector(liftBthClick:) target:self];

    
    UILabel *firstLabel=[[UILabel alloc] init];
    CGFloat firstLabelX=0;
    CGFloat firstLabelY=20;
    CGFloat firstLabelW=SCREEN_WIDTH;
    CGFloat firstLabelH=25;
    firstLabel.frame=CGRectMake(firstLabelX, firstLabelY, firstLabelW, firstLabelH);
    firstLabel.textAlignment=NSTextAlignmentCenter;
    firstLabel.text=[NSString stringWithFormat:@"请输入+86%@手机上的验证码",self.phoneNumber];
    firstLabel.font=[UIFont systemFontOfSize:15];
    firstLabel.textColor=ZCColor(102, 102, 102);
    [self.view addSubview:firstLabel];
    
    
    UIImage *image=[UIImage imageNamed:@"shurukuang" ];
    // 指定为拉伸模式，伸缩后重新赋值
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(10,10,10,10) resizingMode:UIImageResizingModeStretch];
    
    CGFloat validationTextY=firstLabelY+firstLabelH+16;
    CGFloat validationTextW=150;
    CGFloat validationTextH=60;
    CGFloat validationTextX=(SCREEN_WIDTH-validationTextW)/2;
    
    
    
    
    
   UITextField *validationText=[[UITextField alloc] init];
    validationText.frame=CGRectMake(validationTextX, validationTextY, validationTextW, validationTextH);
    validationText.font= [UIFont fontWithName:@"Arial" size:27.0f];
    validationText.background=image;
    validationText.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;//设置其输入内容竖直居中
    validationText.textAlignment=NSTextAlignmentCenter;
    validationText.keyboardType=UIKeyboardTypeNumberPad;
    [self.view addSubview:validationText];
    self.validationText=validationText;
    
    
    
    UILabel *secondLabel=[[UILabel alloc] init];
    CGFloat secondLabelX=0;
    CGFloat secondLabelY=validationTextY+validationTextH+20;
    CGFloat secondLabelW=SCREEN_WIDTH;
    CGFloat secondLabelH=25;
    secondLabel.frame=CGRectMake(secondLabelX, secondLabelY, secondLabelW, secondLabelH);
    secondLabel.textAlignment=NSTextAlignmentCenter;
    secondLabel.text=[NSString stringWithFormat:@"还差最后一步，请设置您的密码"];
    secondLabel.font=[UIFont systemFontOfSize:15];
    secondLabel.textColor=ZCColor(102, 102, 102);
    [self.view addSubview:secondLabel];

    
    UITextField *passwordTextField=[[UITextField alloc] init];
    CGFloat  passwordTextFieldX=10;
    CGFloat  passwordTextFieldY=secondLabelY+secondLabelH+20;
    CGFloat  passwordTextFieldW=SCREEN_WIDTH-20;
    CGFloat  passwordTextFieldH=40;
    passwordTextField.frame=CGRectMake(passwordTextFieldX, passwordTextFieldY, passwordTextFieldW, passwordTextFieldH);
    passwordTextField.placeholder=@"请设置密码";
    passwordTextField.background=image;
    passwordTextField.secureTextEntry=YES;
    [self.view addSubview:passwordTextField];
    self.passwordTextField=passwordTextField;
    
    
    
    UITextField *againPassword=[[UITextField alloc] init];
    CGFloat  againPasswordX=10;
    CGFloat  againPasswordY=passwordTextFieldY+passwordTextFieldH+20;
    CGFloat  againPasswordW=SCREEN_WIDTH-20;
    CGFloat  againPasswordH=40;
    againPassword.frame=CGRectMake(againPasswordX, againPasswordY, againPasswordW, againPasswordH);
    againPassword.placeholder=@"请再次输入密码";
    againPassword.background=image;
//    againPassword.keyboardType=UIKeyboardTypeASCIICapable;
    againPassword.secureTextEntry=YES;
    [self.view addSubview:againPassword];
    self.againPassword=againPassword;
    
    UIButton *submitButton=[[UIButton alloc] init];
    CGFloat submitButtonX=10;
    CGFloat submitButtonY=againPasswordY+againPasswordH+45;
    CGFloat submitButtonW=SCREEN_WIDTH-20;
    CGFloat submitButtonH=40;
    submitButton.frame=CGRectMake(submitButtonX, submitButtonY, submitButtonW, submitButtonH);
    
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(clickThesubmitButton) forControlEvents:UIControlEventTouchUpInside];
    submitButton.backgroundColor=ZCColor(100, 175, 102);
    submitButton.enabled=NO;
    [self.view addSubview:submitButton];
    self.submitButton=submitButton;
    submitButton.layer.masksToBounds=YES;
    submitButton.layer.cornerRadius=5;//设置圆角的半径为5
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(whetherCanClick) name:UITextFieldTextDidChangeNotification object:validationText];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(whetherCanClick) name:UITextFieldTextDidChangeNotification object:passwordTextField];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(whetherCanClick) name:UITextFieldTextDidChangeNotification object:againPassword];
    
    
    
    
}

//返回到上个界面
-(void)liftBthClick:(UIButton *)bth
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


//判断是否可以点击
-(void)whetherCanClick
{
   
    if (self.validationText.text.length==4&&self.passwordTextField.text.length>=6&&self.againPassword.text.length>=6) {
        
        if ([self.passwordTextField.text isEqual:self.againPassword.text]) {
            self.submitButton.enabled=YES;
            self.submitButton.backgroundColor=ZCColor(9, 133, 12);
        }
        
        
    }else{
     self.submitButton.backgroundColor=ZCColor(100, 175, 102);
    }
    
    
}


//点击提交按钮
-(void)clickThesubmitButton
{
    
    [MBProgressHUD showMessage:@"请稍后..."];
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"text/plain",@"application/xhtml+xml",@"application/xml",@"application/json", nil];
    
    //封装请求参数
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES) lastObject];
    NSString *file=[doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"phone"]=self.phoneNumber;
    params[@"password"]=self.passwordTextField.text;
    params[@"password_confirmation"]=self.againPassword.text;
    params[@"verification_code"]=self.validationText.text;
    params[@"token"]=account.token;
    
    
    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"users/upgrade.json"];
    
    [mgr PUT:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        ZCLog(@"%@",responseObject);
        
        
        if (responseObject[@"error_code"] ) {
            
            [ZCprompt initWithController:self andErrorCode:[NSString stringWithFormat:@"%@",responseObject[@"error_code"]]];
            
        }else
        {

            ZCAccountSettingsViewController *AccountSettingsViewController=[[ZCAccountSettingsViewController alloc] init];
            AccountSettingsViewController.phoneNumber=self.phoneNumber;
            [self.navigationController pushViewController:AccountSettingsViewController animated:YES];
        
//        for (id  Controller in self.navigationController.viewControllers) {
//            
//            if ([Controller isKindOfClass:[ZCAccountSettingsViewController class]]) {
//                ZCAccountSettingsViewController *controller=Controller;
//                controller.phoneNumber=self.phoneNumber;
//                [self.navigationController popToViewController:Controller animated:YES];
//                break;
//            }
           
  //      }
        
        
        }
        
        [MBProgressHUD hideHUD];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ZCLog(@"%@",error);
        [MBProgressHUD hideHUD];
        [ZCprompt initWithController:self andErrorCode:[NSString stringWithFormat:@"%ld",(long)[operation.response statusCode]]];
        

    }];
    
    

}








-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES ];
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
