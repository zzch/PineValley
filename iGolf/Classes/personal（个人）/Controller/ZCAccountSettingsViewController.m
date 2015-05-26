//
//  ZCAccountSettingsViewController.m
//  iGolf
//
//  Created by hh on 15/5/25.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCAccountSettingsViewController.h"
#import "ZCMobilePhoneViewController.h"
#import "ZCAccount.h"
@interface ZCAccountSettingsViewController ()

@end

@implementation ZCAccountSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=ZCColor(237, 237, 237);
    self.navigationItem.title=@"设置";
    
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES) lastObject];
    NSString *file=[doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    ZCLog(@"--------%@",account.uuid);
    
    UIButton *photoNumberBtn=[[UIButton alloc] init];
    CGFloat  photoNumberBtnX=0;
    CGFloat  photoNumberBtnY=25;
    CGFloat  photoNumberBtnW=SCREEN_WIDTH;
    CGFloat  photoNumberBtnH=50;
    photoNumberBtn.frame=CGRectMake(photoNumberBtnX, photoNumberBtnY, photoNumberBtnW, photoNumberBtnH);
    photoNumberBtn.backgroundColor=[UIColor whiteColor];
    [photoNumberBtn addTarget:self action:@selector(clickThephotoNumberBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:photoNumberBtn];
    [self addChildControls:photoNumberBtn andText:@"手机号" andOther:[NSString stringWithFormat:@"%@",account.phone]];
    
    
    
    
    UIButton *accountPassword=[[UIButton alloc] init];
    CGFloat  accountPasswordX=0;
    CGFloat  accountPasswordY=photoNumberBtnY+photoNumberBtnH+25;
    CGFloat  accountPasswordW=SCREEN_WIDTH;
    CGFloat  accountPasswordH=50;
    accountPassword.frame=CGRectMake(accountPasswordX, accountPasswordY, accountPasswordW, accountPasswordH);
    accountPassword.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:accountPassword];
    [self addChildControls:accountPassword andText:@"账号密码" andOther:nil];
    
}



-(void)addChildControls:(UIButton *)Button andText:(NSString *)text andOther:(NSString *)str
{
    //设置
    UILabel *settingsLabel=[[UILabel alloc] init];
    CGFloat settingsLabelX=10;//imageW+imageX+15;
    CGFloat settingsLabelW=SCREEN_WIDTH*0.3;
    CGFloat settingsLabelH=30;
    CGFloat settingsLabelY=(Button.frame.size.height-settingsLabelH)*0.5;
    settingsLabel.frame=CGRectMake(settingsLabelX, settingsLabelY, settingsLabelW, settingsLabelH);
    settingsLabel.text=text;
    settingsLabel.textColor=ZCColor(85, 85, 85);
    //settingsLabel.textAlignment=NSTextAlignmentCenter;
    [Button addSubview:settingsLabel];
    
    //中间的Label
    UILabel *nuberLabel=[[UILabel alloc] init];
    
    CGFloat nuberLabelW=SCREEN_WIDTH*0.5;
    CGFloat nuberLabelX=SCREEN_WIDTH-nuberLabelW-30;//imageW+imageX+15;
    CGFloat nuberLabelH=30;
    CGFloat nuberLabelY=(Button.frame.size.height-settingsLabelH)*0.5;
    nuberLabel.frame=CGRectMake(nuberLabelX, nuberLabelY, nuberLabelW, nuberLabelH);
    nuberLabel.text=str;
    nuberLabel.textAlignment=NSTextAlignmentRight;
    [Button addSubview:nuberLabel];
    
    //向右箭头
    UIImageView *rightImageView=[[UIImageView alloc] init];
    
    CGFloat rightImageViewW=10;
    CGFloat rightImageViewH=17;
    CGFloat rightImageViewY=(Button.frame.size.height-rightImageViewH)*0.5;
    CGFloat rightImageViewX=SCREEN_WIDTH-rightImageViewW-10;
    rightImageView.frame=CGRectMake(rightImageViewX, rightImageViewY, rightImageViewW, rightImageViewH);
    rightImageView.image=[UIImage imageNamed:@"icon_arrow3"];
    
    [Button addSubview:rightImageView];
    
    
    
}


-(void)setPhoneNumber:(NSString *)phoneNumber
{   _phoneNumber=phoneNumber;
    
    
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES) lastObject];
    NSString *file=[doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    account.phone=phoneNumber;
    
    //删除文件
    [[NSFileManager defaultManager] removeItemAtPath:file error:nil];
    
    
    //存储
    [NSKeyedArchiver archiveRootObject:account toFile:file];
    
    
    
    [self viewDidLoad];
}


//点击手机号
-(void)clickThephotoNumberBtn
{

    ZCMobilePhoneViewController *MobilePhone=[[ZCMobilePhoneViewController alloc] init];
    [self.navigationController pushViewController:MobilePhone animated:YES];

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
