//
//  ZCChangePhoneViewController.m
//  iGolf
//
//  Created by hh on 15/5/27.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCChangePhoneViewController.h"

@interface ZCChangePhoneViewController ()
@property(nonatomic,weak)UIButton *nextButton;
@property(nonatomic,weak)UITextField *phoneTextField;
@end

@implementation ZCChangePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"手机号";
    self.view.backgroundColor=ZCColor(237, 237, 237);
    
    
    UILabel *firstLabel=[[UILabel alloc] init];
    CGFloat  firstLabelX=0;
    CGFloat  firstLabelY=20;
    CGFloat  firstLabelW=SCREEN_WIDTH;
    CGFloat  firstLabelH=25;
    firstLabel.frame=CGRectMake(firstLabelX, firstLabelY, firstLabelW, firstLabelH);
    firstLabel.textAlignment=NSTextAlignmentCenter;
    firstLabel.text=@"更换手机号码,下次登录可以使用新手机号码登录。";
    firstLabel.textColor=ZCColor(102, 102, 102);
    firstLabel.font=[UIFont systemFontOfSize:12];
    [self.view addSubview:firstLabel];

    
    
    UILabel *secondLabel=[[UILabel alloc] init];
    CGFloat  secondLabelX=0;
    CGFloat  secondLabelY=firstLabelY+firstLabelH+5;
    CGFloat  secondLabelW=SCREEN_WIDTH;
    CGFloat  secondLabelH=25;
    secondLabel.frame=CGRectMake(secondLabelX, secondLabelY, secondLabelW, secondLabelH);
    secondLabel.textAlignment=NSTextAlignmentCenter;
    secondLabel.text=@"当前的手机号码为:";
    secondLabel.textColor=ZCColor(102, 102, 102);
    secondLabel.font=[UIFont systemFontOfSize:12];
    [self.view addSubview:secondLabel];

    UILabel *thirdLabel=[[UILabel alloc] init];
    CGFloat  thirdLabelX=0;
    CGFloat  thirdLabelY=secondLabelY+secondLabelH+5;
    CGFloat  thirdLabelW=SCREEN_WIDTH;
    CGFloat  thirdLabelH=25;
    thirdLabel.frame=CGRectMake(thirdLabelX, thirdLabelY, thirdLabelW, thirdLabelH);
    thirdLabel.textAlignment=NSTextAlignmentCenter;
    thirdLabel.text=self.phoneNumber;
    thirdLabel.textColor=ZCColor(102, 102, 102);
    thirdLabel.font=[UIFont systemFontOfSize:12];
    [self.view addSubview:thirdLabel];
    
    
    
    
    UIImage *image=[UIImage imageNamed:@"shurukuang" ];
    // 指定为拉伸模式，伸缩后重新赋值
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(10,10,10,10) resizingMode:UIImageResizingModeStretch];
    
    
    
    CGFloat  phoneLabelX=10;
    CGFloat  phoneLabelY=thirdLabelY+thirdLabelH+20;
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
    [nextButton addTarget:self action:@selector(clickTheChangeNextButton) forControlEvents:UIControlEventTouchUpInside];
    self.nextButton=nextButton;
    nextButton.layer.masksToBounds=YES;
    nextButton.layer.cornerRadius=5;//设置圆角的半径为5
    
    
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(phoneTextFieldTextChange) name:UITextFieldTextDidChangeNotification object:phoneTextField];
    

    
    
    
    
}



//点击下一步
-(void)clickTheChangeNextButton
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
