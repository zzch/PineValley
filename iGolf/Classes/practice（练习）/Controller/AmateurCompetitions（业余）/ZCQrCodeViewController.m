//
//  ZCQrCodeViewController.m
//  iGolf
//
//  Created by hh on 15/6/24.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//二维码

#import "ZCQrCodeViewController.h"
#import "QRCodeGenerator.h"
@interface ZCQrCodeViewController ()

@end

@implementation ZCQrCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"二维码";
    
    self.view.backgroundColor=ZCColor(237, 237, 237);
    
    
    //+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)size;
    
    
    UIImage *QrCode=[QRCodeGenerator qrImageForString:@"dasdsdasdasdddsdassda" imageSize:200];
    
    
    UIImageView *QrCodeImage=[[UIImageView alloc] init];
    QrCodeImage.frame=CGRectMake(0, 200, 200, 200);
    QrCodeImage.image= QrCode;
    [self.view addSubview:QrCodeImage];
    
    
    
    
    
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
