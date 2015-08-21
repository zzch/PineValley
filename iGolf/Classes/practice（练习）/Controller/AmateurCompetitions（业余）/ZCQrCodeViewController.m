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
@property(nonatomic,weak)UIImageView *QrCodeImage;
@end

@implementation ZCQrCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"球童";
    
    self.view.backgroundColor=ZCColor(237, 237, 237);
    
    
    UIImageView *QrCodeImage=[[UIImageView alloc] init];
    QrCodeImage.frame=CGRectMake((SCREEN_WIDTH-200)/2, 50, 200, 200);
    [self.view addSubview:QrCodeImage];
    self.QrCodeImage=QrCodeImage;

    
    
    UILabel *textLabel1=[[UILabel alloc] init];
    textLabel1.text=@"球童使用微信扫描二维码";
    textLabel1.frame=CGRectMake(0, 300, SCREEN_WIDTH, 20);
    textLabel1.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:textLabel1];
    
    UILabel *textLabel2=[[UILabel alloc] init];
    textLabel2.text=@"为您记录本场比赛成绩";
    textLabel2.frame=CGRectMake(0, 320, SCREEN_WIDTH, 20);
    textLabel2.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:textLabel2];
    
    //+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)size;
    
    
    
    
    
    [self networkRequestData];
    
    
}


//网络请求
-(void)networkRequestData
{
    
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
        
        
        self.QrCodeImage.image= QrCode;
        
        
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
