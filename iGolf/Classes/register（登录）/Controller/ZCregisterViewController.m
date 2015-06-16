//
//  ZCregisterViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/2/5.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCregisterViewController.h"
#import "AFNetworking.h"
#import "ZCAccount.h"
#import "ZCTabbarViewController.h"
#import "SVProgressHUD.h"
#import "ZCAKeyToRegisterView.h"
#import "ZCPhoneloginView.h"
#import "ZCRegisteredViewController.h"
@interface ZCregisterViewController ()
@property(nonatomic,assign,getter=isOpen) BOOL bKeyBoardHide;
@end

@implementation ZCregisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    
    
    self.view.backgroundColor=ZCColor(237, 237, 237);
   // self.navigationController.title=@"我爱高尔夫";
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    customLab.textAlignment=NSTextAlignmentCenter;
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:@"我爱高尔夫"];
    customLab.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = customLab;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    //一键注册
    CGFloat registerX=SCREEN_WIDTH*0.031;
    CGFloat registerY=SCREEN_HEIGHT*0.0484;
    CGFloat registerW=SCREEN_WIDTH-2*registerX;
    CGFloat registerH=40;
    ZCAKeyToRegisterView *Register=[[ZCAKeyToRegisterView alloc] initWithFrame:CGRectMake(registerX, registerY, registerW, registerH)];
    [self.view addSubview:Register];
    
    
    //手机注册
    UIButton *phoneRegister=[[UIButton alloc] init];
    CGFloat phoneRegisterX=registerX;
    CGFloat phoneRegisterY=registerY+registerH+14;
    CGFloat phoneRegisterW=registerW;
    CGFloat phoneRegisterH=registerH;
    phoneRegister.frame=CGRectMake(phoneRegisterX, phoneRegisterY, phoneRegisterW, phoneRegisterH);
    [phoneRegister setTitle:@"手机注册" forState:UIControlStateNormal];
    
    [phoneRegister setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIImage *image2=[UIImage imageNamed:@"anniu_dianji" ];
    // 指定为拉伸模式，伸缩后重新赋值
    image2 = [image2 resizableImageWithCapInsets:UIEdgeInsetsMake(25,25,10,10) resizingMode:UIImageResizingModeStretch];
    [phoneRegister setBackgroundImage:image2 forState:UIControlStateNormal];

    
    
    
    [phoneRegister addTarget:self action:@selector(clickphoneRegister) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:phoneRegister];
    //denglu_fgx
    UIImageView *bjImage=[[UIImageView alloc] init];
    
    bjImage.image=[UIImage imageNamed:@"denglu_xian"];
    //登陆landing
    CGFloat landingButtonY=phoneRegisterY+phoneRegisterH+45;
    CGFloat landingButtonW=SCREEN_WIDTH-20;
    CGFloat landingButtonH=0.5;
    CGFloat landingButtonX=10;
    bjImage.frame=CGRectMake(landingButtonX, landingButtonY, landingButtonW,landingButtonH );
    
        [self.view addSubview:bjImage];
    
    
    UILabel *denglu=[[UILabel alloc] init];
    CGFloat dengluY=phoneRegisterY+phoneRegisterH+38;
    CGFloat dengluW=50;
    CGFloat dengluH=15;
    CGFloat dengluX=(SCREEN_WIDTH-dengluW)*0.5;
    denglu.frame=CGRectMake(dengluX, dengluY, dengluW, dengluH);
    denglu.text=@"登录";
    denglu.textColor=ZCColor(102, 102, 102);
    denglu.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:denglu];
    
    //登陆界面
    ZCPhoneloginView *phoneloginView=[[ZCPhoneloginView alloc] init];
    
    CGFloat phoneloginViewY=landingButtonY+landingButtonH+60;
    CGFloat phoneloginViewW=SCREEN_WIDTH;
    CGFloat phoneloginViewH=SCREEN_HEIGHT*0.352;
    CGFloat phoneloginViewX=0;

    phoneloginView.frame=CGRectMake(phoneloginViewX, phoneloginViewY, phoneloginViewW, phoneloginViewH);
    [self.view addSubview:phoneloginView];
    
    
    
    
    //监听通知中心
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}


-(void)keyboardWillHide:(NSNotification *)notification
{
    NSLog(@"*-----HideKeyBoard");
    //self.bKeyBoardHide = YES;
}
-(void)keyboardWillShow:(NSNotification *)notification
{
    NSLog(@"*-----ShowKeyBoard");
    //self.bKeyBoardHide = NO;
}



- (void)keyboardDidChangeFrame:(NSNotification *)noti
{
    //改变window的背景颜色
    //    self.view.window.backgroundColor = self.tableView.backgroundColor;
    
    if (SCREEN_HEIGHT==480) {
        CGRect frame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        
        //键盘实时y
        CGFloat keyY = frame.origin.y;
        
        CGFloat screenH = [[UIScreen mainScreen] bounds].size.height;
        
        CGFloat keyDuration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
        
        [UIView animateWithDuration:keyDuration animations:^{
            self.view.transform = CGAffineTransformMakeTranslation(0, keyY - screenH );
        }];
        

    }else
    {
        
        
        if (self.bKeyBoardHide==NO) {
            self.view.transform = CGAffineTransformMakeTranslation(0,-100 );
            //        [UIView animateWithDuration:keyDuration animations:^{
            //            self.view.transform = CGAffineTransformMakeTranslation(0, -40 );
            //        }];
            self.bKeyBoardHide = YES;
            
        }else
        {
            self.bKeyBoardHide = NO;
            self.view.transform = CGAffineTransformMakeTranslation(0,0 );
            
        }

        
        
    }
    
    
    
    
    
   }




//结束编辑事件  （退出键盘）
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //     self.bKeyBoardHide = NO;
    [self.view endEditing:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]  removeObserver:self];
}



//点击登陆
-(void)clicklandingButton
{

}




//手机注册跳转
-(void)clickphoneRegister
{
    ZCRegisteredViewController *registeredViewController=[[ZCRegisteredViewController alloc] init];
    
    [self.navigationController pushViewController:registeredViewController animated:YES ];
    
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
