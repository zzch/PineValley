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

#import "ZCAKeyToRegisterView.h"
#import "ZCPhoneloginView.h"
#import "ZCRegisteredViewController.h"
#import "ZCForgetViewController.h"
#import "ZCLandingViewController.h"
#import "ZCRegisteredSuccessfullyViewController.h"
@interface ZCregisterViewController ()<ZCPhoneloginViewDelegate>
@property(nonatomic,assign,getter=isOpen) BOOL bKeyBoardHide;
@end

@implementation ZCregisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
   
    
    
    UIImageView *bjImage=[[UIImageView alloc] init];
    bjImage.frame=self.view.bounds;
    bjImage.image=[UIImage imageNamed:@"dengluye_bj"];
    [self.view addSubview:bjImage];
     
    
    UIImageView *nameimageView=[[UIImageView alloc] init];
    CGFloat nameimageViewW=226;
    CGFloat nameimageViewH=59;
    CGFloat nameimageViewX=(SCREEN_WIDTH-nameimageViewW)/2;
    CGFloat nameimageViewY=SCREEN_HEIGHT*0.163;
    nameimageView.frame=CGRectMake(nameimageViewX, nameimageViewY, nameimageViewW, nameimageViewH);
    nameimageView.image=[UIImage imageNamed:@"wenzi_logo"];
    [self.view addSubview:nameimageView];
    
    
    
    //一键注册
    CGFloat registerX=SCREEN_WIDTH*0.14;
    CGFloat registerY=nameimageViewY+SCREEN_HEIGHT*0.45;
    CGFloat registerW=SCREEN_WIDTH-2*registerX;
    CGFloat registerH=45;
    ZCAKeyToRegisterView *Register=[[ZCAKeyToRegisterView alloc] initWithFrame:CGRectMake(registerX, registerY, registerW, registerH)];
    [self.view addSubview:Register];
    
    //描述文字
    UILabel *describeLabel=[[UILabel alloc] init];
    CGFloat textLabelY=registerY+registerH+SCREEN_HEIGHT*0.0351;
    describeLabel.frame=CGRectMake(0, textLabelY, SCREEN_WIDTH, 20);
    describeLabel.text=@"已经有我爱高尔夫账户了?";
    describeLabel.font=[UIFont systemFontOfSize:14];
    describeLabel.textColor=ZCColor(170, 170, 170);
    describeLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:describeLabel];
    
    
    
    //手机登陆
    UIButton *landingBtn=[[UIButton alloc] init];
    CGFloat landingBtnX=registerX;
    CGFloat landingBtnY=textLabelY+20+10;
    CGFloat landingBtnW=registerW;
    CGFloat landingBtnH=registerH;
    landingBtn.frame=CGRectMake(landingBtnX, landingBtnY, landingBtnW, landingBtnH);
    [landingBtn setTitle:@"登录" forState:UIControlStateNormal];
    
    [landingBtn setTitleColor:ZCColor(170, 170, 170) forState:UIControlStateNormal];
    
    UIImage *image2=[UIImage imageNamed:@"denglu_bj" ];
    // 指定为拉伸模式，伸缩后重新赋值
    image2 = [image2 resizableImageWithCapInsets:UIEdgeInsetsMake(25,25,10,10) resizingMode:UIImageResizingModeStretch];
    [landingBtn setBackgroundImage:image2 forState:UIControlStateNormal];

    
    
    
    [landingBtn addTarget:self action:@selector(clickTheLandingBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:landingBtn];
//    //denglu_fgx
//    UIImageView *bjImage=[[UIImageView alloc] init];
//    
//    bjImage.image=[UIImage imageNamed:@"denglu_xian"];
//    //登陆landing
//    CGFloat landingButtonY=phoneRegisterY+phoneRegisterH+45;
//    CGFloat landingButtonW=SCREEN_WIDTH-20;
//    CGFloat landingButtonH=0.5;
//    CGFloat landingButtonX=10;
//    bjImage.frame=CGRectMake(landingButtonX, landingButtonY, landingButtonW,landingButtonH );
//    
//        [self.view addSubview:bjImage];
//    
//    
//    UILabel *denglu=[[UILabel alloc] init];
//    CGFloat dengluY=phoneRegisterY+phoneRegisterH+38;
//    CGFloat dengluW=50;
//    CGFloat dengluH=15;
//    CGFloat dengluX=(SCREEN_WIDTH-dengluW)*0.5;
//    denglu.frame=CGRectMake(dengluX, dengluY, dengluW, dengluH);
//    denglu.text=@"登录";
//    denglu.textColor=ZCColor(102, 102, 102);
//    denglu.textAlignment=NSTextAlignmentCenter;
//    [self.view addSubview:denglu];
//    
//    //登陆界面
//    ZCPhoneloginView *phoneloginView=[[ZCPhoneloginView alloc] init];
//    
//    CGFloat phoneloginViewY=landingButtonY+landingButtonH+60;
//    CGFloat phoneloginViewW=SCREEN_WIDTH;
//    CGFloat phoneloginViewH=SCREEN_HEIGHT*0.352;
//    CGFloat phoneloginViewX=0;
//
//    phoneloginView.frame=CGRectMake(phoneloginViewX, phoneloginViewY, phoneloginViewW, phoneloginViewH);
//    
//    phoneloginView.delegate=self;
//    [self.view addSubview:phoneloginView];
//    
//    
//    
//    
//    //监听通知中心
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
//    
}


//点击登陆按钮
-(void)clickTheLandingBtn
{
    ZCLandingViewController *vc=[[ZCLandingViewController alloc] init];
    //ZCRegisteredSuccessfullyViewController *vc=[[ZCRegisteredSuccessfullyViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    //影藏状态栏
    //  [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    self.navigationController.navigationBarHidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    //影藏状态栏
    // [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    self.navigationController.navigationBarHidden=NO;
}


//代理方法
-(void)ZCPhoneloginViewIsClick:(UIButton *)sender
{

    ZCForgetViewController  *ForgetViewControlle=[[ZCForgetViewController alloc] init];
    [self.navigationController pushViewController:ForgetViewControlle animated:YES];
    
}




//-(void)keyboardWillHide:(NSNotification *)notification
//{
//    NSLog(@"*-----HideKeyBoard");
//    //self.bKeyBoardHide = YES;
//}
//-(void)keyboardWillShow:(NSNotification *)notification
//{
//    NSLog(@"*-----ShowKeyBoard");
//    //self.bKeyBoardHide = NO;
//}



//- (void)keyboardDidChangeFrame:(NSNotification *)noti
//{
//    //改变window的背景颜色
//    //    self.view.window.backgroundColor = self.tableView.backgroundColor;
//    
//    if (SCREEN_HEIGHT==480) {
//        CGRect frame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//        
//        //键盘实时y
//        CGFloat keyY = frame.origin.y;
//        
//        CGFloat screenH = [[UIScreen mainScreen] bounds].size.height;
//        
//        CGFloat keyDuration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
//        
//        [UIView animateWithDuration:keyDuration animations:^{
//            self.view.transform = CGAffineTransformMakeTranslation(0, keyY - screenH );
//        }];
//        
//
//    }else
//    {
//        
//        
//        if (self.bKeyBoardHide==NO) {
//            self.view.transform = CGAffineTransformMakeTranslation(0,-100 );
//            //        [UIView animateWithDuration:keyDuration animations:^{
//            //            self.view.transform = CGAffineTransformMakeTranslation(0, -40 );
//            //        }];
//            self.bKeyBoardHide = YES;
//            
//        }else
//        {
//            self.bKeyBoardHide = NO;
//            self.view.transform = CGAffineTransformMakeTranslation(0,0 );
//            
//        }
//
//        
//        
//    }
//    
//    
//    
//    
//    
//   }
//
//
//
//
////结束编辑事件  （退出键盘）
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    //     self.bKeyBoardHide = NO;
//    [self.view endEditing:YES];
//}
//
//- (void)dealloc
//{
//    [[NSNotificationCenter defaultCenter]  removeObserver:self];
//}
//
//
//
////点击登陆
//-(void)clicklandingButton
//{
//
//}
//
//
//
//
////手机注册跳转
//-(void)clickphoneRegister
//{
//    ZCRegisteredViewController *registeredViewController=[[ZCRegisteredViewController alloc] init];
//    
//    [self.navigationController pushViewController:registeredViewController animated:YES ];
//    
//}
//



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
