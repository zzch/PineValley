//
//  ZCMobilePhoneViewController.m
//  iGolf
//
//  Created by hh on 15/5/25.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCMobilePhoneViewController.h"
#import "ZCAccount.h"
#import "AFNetworking.h"
#import "ZCValidationViewController.h"
#import "ZCprompt.h"
@interface ZCMobilePhoneViewController ()<UIAlertViewDelegate>
@property(nonatomic,weak)UIButton *nextButton;
@property(nonatomic,weak)UITextField *phoneTextField;

@end

@implementation ZCMobilePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"手机号";
    self.view.backgroundColor=ZCColor(237, 237, 237);
    
    
    //返回
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barBtnItemWithNormalImageName:@"fanhui" hightImageName:@"fanhui" action:@selector(liftBthClick:) target:self];
    
    UILabel *firstLabel=[[UILabel alloc] init];
    CGFloat  firstLabelX=0;
    CGFloat  firstLabelY=25;
    CGFloat  firstLabelW=SCREEN_WIDTH;
    CGFloat  firstLabelH=25;
    firstLabel.frame=CGRectMake(firstLabelX, firstLabelY, firstLabelW, firstLabelH);
    firstLabel.textAlignment=NSTextAlignmentCenter;
    firstLabel.text=@"其他用户无权查看您的手机号码";
    firstLabel.textColor=ZCColor(102, 102, 102);
    [self.view addSubview:firstLabel];
    
    UILabel *secondLabel=[[UILabel alloc] init];
    CGFloat  secondLabelX=0;
    CGFloat  secondLabelY=firstLabelY+firstLabelH+10;
    CGFloat  secondLabelW=SCREEN_WIDTH;
    CGFloat  secondLabelH=25;
    secondLabel.frame=CGRectMake(secondLabelX, secondLabelY, secondLabelW, secondLabelH);
    secondLabel.textAlignment=NSTextAlignmentCenter;
    secondLabel.text=@"绑定后可以用手机号码进行登录";
    secondLabel.textColor=ZCColor(102, 102, 102);
    [self.view addSubview:secondLabel];
    
    
    
    
    UIImage *image=[UIImage imageNamed:@"shurukuang" ];
    // 指定为拉伸模式，伸缩后重新赋值
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(10,10,10,10) resizingMode:UIImageResizingModeStretch];
    
    
    
    
    CGFloat  phoneLabelX=10;
    CGFloat  phoneLabelY=secondLabelY+secondLabelH+20;
    CGFloat  phoneLabelW=60;
    CGFloat  phoneLabelH=40;
    
    UIImageView *bjImage=[[UIImageView alloc] init];
    bjImage.frame=CGRectMake(phoneLabelX, phoneLabelY, phoneLabelW, phoneLabelH);
    bjImage.image=image;
    [self.view addSubview:bjImage];
   // phoneLabel.backgroundColor=[UIColor colorWithPatternImage:image];
    UILabel *phoneLabel=[[UILabel alloc] init];
    phoneLabel.frame=CGRectMake(phoneLabelX, phoneLabelY, phoneLabelW, phoneLabelH);
    phoneLabel.text=@"+86";
    phoneLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:phoneLabel];
    
    
    
    CGFloat  phoneTextFieldX=phoneLabelX+phoneLabelW+5;
    CGFloat  phoneTextFieldY=phoneLabelY;
    CGFloat  phoneTextFieldW=SCREEN_WIDTH-phoneTextFieldX-10;
    CGFloat  phoneTextFieldH=40;
    
    
    UIImageView *bjImage2=[[UIImageView alloc] init];
    bjImage2.frame=CGRectMake(phoneTextFieldX, phoneTextFieldY, phoneTextFieldW, phoneTextFieldH);
    bjImage2.image=image;
    [self.view addSubview:bjImage2];
    
    
    UITextField *phoneTextField=[[UITextField alloc] init];
    
    
    phoneTextField.frame=CGRectMake(phoneTextFieldX, phoneTextFieldY, phoneTextFieldW, phoneTextFieldH);
    //phoneTextField.backgroundColor=[UIColor colorWithPatternImage:image];
    phoneTextField.keyboardType=UIKeyboardTypeNumberPad;
     phoneTextField.placeholder=@"请输入手机号";
    [self.view addSubview:phoneTextField];
    self.phoneTextField=phoneTextField;
    
    
    UIButton *nextButton=[[UIButton alloc] init];
    
    
    CGFloat   nextButtonY=phoneTextFieldY+phoneTextFieldH+45;
    
    CGFloat   nextButtonH=40;
    CGFloat   nextButtonX=10;
    CGFloat   nextButtonW=SCREEN_WIDTH-20;
    nextButton.frame=CGRectMake(nextButtonX, nextButtonY, nextButtonW, nextButtonH);
    nextButton.enabled=NO;
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    nextButton.backgroundColor=ZCColor(100, 175, 102);
    [self.view addSubview:nextButton];
    [nextButton addTarget:self action:@selector(clickThenextButton) forControlEvents:UIControlEventTouchUpInside];
    self.nextButton=nextButton;
    nextButton.layer.masksToBounds=YES;
    nextButton.layer.cornerRadius=5;//设置圆角的半径为5

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(phoneTextFieldTextChange) name:UITextFieldTextDidChangeNotification object:phoneTextField];
    
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


//返回到上个界面
-(void)liftBthClick:(UIButton *)bth
{
    [self.navigationController popViewControllerAnimated:YES];
}

//点击下一步
-(void)clickThenextButton
{
    [self myAlertViewAccording:self.phoneTextField.text];
}

-(void)myAlertViewAccording:(NSString *)str
{
    
    BOOL isPhone=[self validateMobile:str];
    
    if (isPhone==NO) {
         [ZCprompt initWithController:self andErrorCode:@"您输入的手机号格式不正确"];
    }else
    {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认手机号码" message:[NSString stringWithFormat:@"我们将发送验证码短信到这个号码+86%@",str] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"好", nil];
    [alert show];
    }
}

#pragma mark - alertView的代理方法
/**
 *  点击了alertView上面的按钮就会调用这个方法
 *
 *  @param buttonIndex 按钮的索引,从0开始
 */

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
       // [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        [self sendVerificationCode];
    }
    
    // 按钮的索引肯定不是0
    
}

//发送验证码
-(void)sendVerificationCode
{
    [MBProgressHUD showMessage:@"请稍后"];
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    
    
    //封装请求参数
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES) lastObject];
    NSString *file=[doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"phone"]=self.phoneTextField.text;
    
    params[@"token"]=account.token;
    
    
    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"verification_code/upgrade.json"];
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        ZCLog(@"%@",responseObject);
        
        if (responseObject[@"error_code"] )
        {
        [ZCprompt initWithController:self andErrorCode:[NSString stringWithFormat:@"%@",responseObject[@"error_code"]]];
            
            [MBProgressHUD hideHUD];
        }else{
        
        
        ZCValidationViewController *validationViewController=[[ZCValidationViewController alloc] init];
        
        validationViewController.phoneNumber=self.phoneTextField.text;
        [self.navigationController pushViewController:validationViewController animated:YES];
            
            [MBProgressHUD hideHUD];
            
            [MBProgressHUD showSuccess:@"验证码已发送"];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         [MBProgressHUD hideHUD];
         [ZCprompt initWithController:self andErrorCode:[NSString stringWithFormat:@"%ld",(long)[operation.response statusCode]]];
        
}];
    

}


//监听手机号输入位数是否正确
-(void)phoneTextFieldTextChange
{
    if (self.phoneTextField.text.length==11) {
         self.nextButton.enabled=YES;
        self.nextButton.backgroundColor=ZCColor(9, 133, 12);
    }else
    {
     self.nextButton.enabled=NO;
        self.nextButton.backgroundColor=ZCColor(100, 175, 102);
    }
    
   
}

- (void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//结束编辑事件  （退出键盘）
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //     self.bKeyBoardHide = NO;
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
