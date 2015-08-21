//
//  ZCRegisteredSuccessfullyViewController.m
//  iGolf
//
//  Created by hh on 15/7/8.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCRegisteredSuccessfullyViewController.h"
#import "ZCPracticeVController.h"
#import "ZCBindingViewController.h"
@interface ZCRegisteredSuccessfullyViewController ()

@end

@implementation ZCRegisteredSuccessfullyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *bjImage=[[UIImageView alloc] init];
    bjImage.frame=self.view.bounds;
    bjImage.image=[UIImage imageNamed:@"denglu_bj_shouye.jpg"];
    [self.view addSubview:bjImage];

    
    
    UIImageView *nameimageView=[[UIImageView alloc] init];
    CGFloat nameimageViewW=226;
    CGFloat nameimageViewH=59;
    CGFloat nameimageViewX=(SCREEN_WIDTH-nameimageViewW)/2;
    CGFloat nameimageViewY=SCREEN_HEIGHT*0.163;
    nameimageView.frame=CGRectMake(nameimageViewX, nameimageViewY, nameimageViewW, nameimageViewH);
    nameimageView.image=[UIImage imageNamed:@"wenzi_logo"];
    [self.view addSubview:nameimageView];
    
    
    UIImageView *successimageView=[[UIImageView alloc] init];
    CGFloat successimageViewW=71;
    CGFloat successimageViewH=71;
    CGFloat successimageViewX=(SCREEN_WIDTH-successimageViewW)/2;
    CGFloat successimageViewY=nameimageViewY+nameimageViewH+SCREEN_HEIGHT*0.08;
    successimageView.frame=CGRectMake(successimageViewX, successimageViewY, successimageViewW, successimageViewH);
    successimageView.image=[UIImage imageNamed:@"zhucechenggong"];
    [self.view addSubview:successimageView];
    
    UILabel *textLabel=[[UILabel alloc] init];
    CGFloat textLabelY=successimageViewY+successimageViewH+5;
    textLabel.frame=CGRectMake(0, textLabelY, SCREEN_WIDTH, 20);
    textLabel.text=@"注册成功";
    textLabel.textColor=[UIColor whiteColor];
    textLabel.font=[UIFont systemFontOfSize:14];
    textLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:textLabel];

    
    UILabel *textLabel2=[[UILabel alloc] init];
    CGFloat textLabel2Y=textLabelY+20+SCREEN_HEIGHT*0.142;
    textLabel2.frame=CGRectMake(0, textLabel2Y, SCREEN_WIDTH, 20);
    textLabel2.text=@"是否绑定手机号";
    textLabel2.textColor=ZCColor(237, 237, 237);
    textLabel2.font=[UIFont systemFontOfSize:20];
    textLabel2.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:textLabel2];
    
    
    UILabel *textLabel3=[[UILabel alloc] init];
    CGFloat textLabel3Y=textLabel2Y+20+5;
    textLabel3.frame=CGRectMake(0, textLabel3Y, SCREEN_WIDTH, 20);
    textLabel3.text=@"绑定后数据永久保存";
    textLabel3.textColor=ZCColor(237, 237, 237);
    textLabel3.font=[UIFont systemFontOfSize:12];
    textLabel3.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:textLabel3];
    
    
    CGFloat top = 25; // 顶端盖高度
    CGFloat bottom = 25 ; // 底端盖高度
    CGFloat left = 10; // 左端盖宽度
    CGFloat right = 10; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    UIImage *image1=[UIImage imageNamed:@"yijianzhuce_anniu" ];
    // 指定为拉伸模式，伸缩后重新赋值
    image1 = [image1 resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    
    
    UIButton *cancelBtn=[[UIButton alloc] init];
    CGFloat  cancelBtnX=46;
    CGFloat  cancelBtnY=textLabel3Y+20+15;
    CGFloat  cancelBtnW=(SCREEN_WIDTH-2*cancelBtnX-11)/2;
    CGFloat  cancelBtnH=45;
    cancelBtn.frame=CGRectMake(cancelBtnX, cancelBtnY, cancelBtnW, cancelBtnH);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setBackgroundImage:image1 forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(clickThecanCelBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    
   
    
    UIButton *determineBtn=[[UIButton alloc] init];
    CGFloat  determineBtnX=cancelBtnX+cancelBtnW+11;
    CGFloat  determineBtnY=cancelBtnY;
    CGFloat  determineBtnW=cancelBtnW;
    CGFloat  determineBtnH=45;
    determineBtn.frame=CGRectMake(determineBtnX, determineBtnY, determineBtnW, determineBtnH);
    [determineBtn setTitle:@"确定" forState:UIControlStateNormal];
    [determineBtn setBackgroundImage:image1 forState:UIControlStateNormal];
    [determineBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [determineBtn addTarget:self action:@selector(clickTheCandetermineBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:determineBtn];
    
    
}
//点击取消
-(void)clickThecanCelBtn
{
    ZCPracticeVController *vc=[[ZCPracticeVController alloc] init];
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:vc];
    
    UIWindow *dw=[[UIApplication sharedApplication].delegate window];

    dw.rootViewController=nav;
}

//点击确定
-(void)clickTheCandetermineBtn
{
    ZCBindingViewController *vc=[[ZCBindingViewController alloc] init];
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
