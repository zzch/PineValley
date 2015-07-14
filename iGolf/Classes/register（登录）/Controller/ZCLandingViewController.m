//
//  ZCLandingViewController.m
//  iGolf
//
//  Created by hh on 15/7/8.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCLandingViewController.h"
#import "ZCPhoneloginView.h"
#import "ZCForgetViewController.h"
#import "ZCSMSView.h"
@interface ZCLandingViewController ()<ZCPhoneloginViewDelegate,ZCSMSViewDelegate>
@property(nonatomic,weak)ZCPhoneloginView *phoneView;
@property(nonatomic,weak)ZCSMSView *SMSView;
@property(nonatomic,weak)UIButton *changeButton;
@property (nonatomic, assign, getter = isOpened) BOOL opened;
@end

@implementation ZCLandingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=ZCColor(237, 237, 237);
    self.navigationItem.title=@"登录";
    
    [self addControls];
    
}


//添加控件
-(void)addControls
{
    ZCPhoneloginView *phoneView=[[ZCPhoneloginView alloc] init];
    CGFloat phoneViewX=0;
    CGFloat phoneViewY=45;
    CGFloat phoneViewW=SCREEN_WIDTH;
    CGFloat phoneViewH=200;
    phoneView.frame=CGRectMake(phoneViewX, phoneViewY, phoneViewW, phoneViewH);
    phoneView.delegate=self;
    [self.view addSubview:phoneView];
    self.phoneView=phoneView;
    
    
    
    UIButton *changeButton=[[UIButton alloc] init];
    CGFloat changeButtonX=10;
    CGFloat changeButtonY=phoneViewY+phoneViewH+10;
    CGFloat changeButtonW=SCREEN_WIDTH-2*changeButtonX;
    CGFloat changeButtonH=40;
    changeButton.frame=CGRectMake(changeButtonX, changeButtonY, changeButtonW, changeButtonH);
    [changeButton setTitle:@"短信验证码登录" forState:UIControlStateNormal];
    //UIImage *image=[ZCTool imagePullLitre:@"anniu_dianji"];
    [changeButton setBackgroundImage:[ZCTool imagePullLitre:@"mimadenglu"] forState:UIControlStateNormal];
    [changeButton addTarget:self action:@selector(clickTheChangeButton) forControlEvents:UIControlEventTouchUpInside];
    [changeButton setTitleColor:ZCColor(9, 133, 12) forState:UIControlStateNormal];
    [self.view addSubview:changeButton];
    self.changeButton=changeButton;

}

//点击跟换模式
-(void)clickTheChangeButton
{
    self.opened=!self.opened;
    if (self.opened) {
        
   
    if (_SMSView==nil) {
        ZCSMSView *SMSView=[[ZCSMSView alloc] init];
        CGFloat SMSViewX=0;
        CGFloat SMSViewY=45;
        CGFloat SMSViewW=SCREEN_WIDTH;
        CGFloat SMSViewH=200;
        SMSView.frame=CGRectMake(SMSViewX, SMSViewY, SMSViewW, SMSViewH);
        SMSView.delegate=self;
        [self.view addSubview:SMSView];
        self.SMSView=SMSView;
        self.phoneView.hidden=YES;
        self.SMSView.hidden=NO;
        [self.changeButton setTitle:@"密码登录" forState:UIControlStateNormal];
        
    }else
    {
     self.phoneView.hidden=YES;
     self.SMSView.hidden=NO;
     [self.changeButton setTitle:@"密码登录" forState:UIControlStateNormal];
    }
    }else
      {
    self.phoneView.hidden=NO;
    self.SMSView.hidden=YES;
    [self.changeButton setTitle:@"短信验证码登录" forState:UIControlStateNormal];
      }


}


//代理方法
-(void)ZCPhoneloginViewIsClick:(UIButton *)sender
{
    
    ZCForgetViewController  *ForgetViewControlle=[[ZCForgetViewController alloc] init];
    [self.navigationController pushViewController:ForgetViewControlle animated:YES];
    
}


//SMSView代理方法
-(void)clickTheSMSView:(ZCSMSView *)view
{

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
