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

@end

@implementation ZCregisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"suoyou_bj"]];
    
    self.navigationItem.title=@"我爱高尔夫";
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
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
    [phoneRegister setBackgroundImage:[UIImage imageNamed:@"denglu_anniu-1"] forState:UIControlStateNormal];
    [phoneRegister setBackgroundImage:[UIImage imageNamed:@"denglu_anniu_anxia"] forState:UIControlStateHighlighted];
    [phoneRegister addTarget:self action:@selector(clickphoneRegister) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:phoneRegister];
    
    
    //登陆landing
    UIButton *landingButton=[[UIButton alloc] init];
    CGFloat landingButtonY=phoneRegisterY+phoneRegisterH+30;
    CGFloat landingButtonW=60;
    CGFloat landingButtonH=45;
    CGFloat landingButtonX=(SCREEN_WIDTH-landingButtonW)*0.5;
    landingButton.frame=CGRectMake(landingButtonX, landingButtonY, landingButtonW, landingButtonH);
    [landingButton addTarget:self action:@selector(clicklandingButton) forControlEvents:UIControlEventTouchUpInside];
    [landingButton setTitle:@"登陆" forState:UIControlStateNormal];
    [self.view addSubview:landingButton];
    
    
    //登陆界面
    ZCPhoneloginView *phoneloginView=[[ZCPhoneloginView alloc] init];
    
    CGFloat phoneloginViewY=landingButtonY+landingButtonH+40;
    CGFloat phoneloginViewW=SCREEN_WIDTH;
    CGFloat phoneloginViewH=SCREEN_HEIGHT*0.352;
    CGFloat phoneloginViewX=0;

    phoneloginView.frame=CGRectMake(phoneloginViewX, phoneloginViewY, phoneloginViewW, phoneloginViewH);
    [self.view addSubview:phoneloginView];
    
    
    
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
