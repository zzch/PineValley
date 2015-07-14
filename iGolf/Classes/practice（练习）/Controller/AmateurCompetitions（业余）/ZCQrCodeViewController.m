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
    
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager]
    ;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    
    params[@"token"]=account.token;
    params[@"match_uuid"]=self.uuid;
    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"players/invite_caddie.json"];
    [mgr PUT:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        ZCLog(@"%@",responseObject);
        
        UIImage *QrCode=[QRCodeGenerator qrImageForString:[NSString stringWithFormat:@"%@",responseObject[@"url"]] imageSize:200];
        
        
        UIImageView *QrCodeImage=[[UIImageView alloc] init];
        QrCodeImage.frame=CGRectMake(0, 200, 200, 200);
        QrCodeImage.image= QrCode;
        [self.view addSubview:QrCodeImage];

        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
    
    
    
    
    
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
