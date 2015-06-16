//
//  ZCAboutMeViewController.m
//  iGolf
//
//  Created by hh on 15/6/12.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//关于我们

#import "ZCAboutMeViewController.h"

@interface ZCAboutMeViewController ()

@end

@implementation ZCAboutMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
   
    self.navigationItem.title=@"关于我们";
    //返回
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barBtnItemWithNormalImageName:@"fanhui" hightImageName:@"fanhui" action:@selector(liftBthClick:) target:self];

    
    
    self.view.backgroundColor=ZCColor(237, 237, 237);
    UIScrollView *scrollView=[[UIScrollView alloc] init];
    scrollView.frame=[UIScreen mainScreen].bounds;
    scrollView.bounces=NO;
    [self.view addSubview:scrollView];
    
    UIImage *image1;
    if (SCREEN_WIDTH==320 ) {
        image1=[UIImage imageNamed:@"guwm_5s"];
    }else
    {
        image1=[UIImage imageNamed:@"gywm_61"];
    }
    
    
    scrollView.contentSize = CGSizeMake(0, image1.size.height+60);
    
    UIImageView *allImage=[[UIImageView alloc] init];
    allImage.frame=CGRectMake((self.view.frame.size.width-image1.size.width)/2, 0, image1.size.width, image1.size.height);
    allImage.image=image1;
    [scrollView addSubview:allImage];
    
}

//返回到上个界面
-(void)liftBthClick:(UIButton *)bth
{
    [self.navigationController popViewControllerAnimated:YES];
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
