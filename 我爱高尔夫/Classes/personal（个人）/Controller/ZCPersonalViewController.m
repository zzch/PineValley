//
//  ZCPersonalViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/4/8.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCPersonalViewController.h"
#import "ZCPersonalInformationViewController.h"
#import "AFNetworking.h"
#import "ZCAccount.h"
#import "ZCPersonalData.h"
#import "ZCPersonalURL.h"
#import "UIImageView+WebCache.h"
#import "ZCExitTableViewController.h"
#import "UIImage+MJ.h"
#import "ZCregisterViewController.h"
@interface ZCPersonalViewController ()<UIActionSheetDelegate,UIAlertViewDelegate>
//头像View
@property(nonatomic,weak)UIButton *headImageView;
//消息View
@property(nonatomic,weak)UIButton *settingsButton;
@property(nonatomic,strong)ZCPersonalData *personalData;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,weak)UILabel *moodLabel;
@property(nonatomic,weak)UIImageView *headImage;
@property(nonatomic,weak)NSString *imagePath;
@end

@implementation ZCPersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"suoyou_bj_02"]];
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    customLab.textAlignment=NSTextAlignmentCenter;
    [customLab setTextColor:ZCColor(240, 208, 122)];
    [customLab setText:@"我爱高尔夫"];
    customLab.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = customLab;

    
    
    [self onlineData];
    
    
    


}


//网络请求
-(void)onlineData
{

    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    self.name=account.nickname;
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    
    NSString *URL=[NSString stringWithFormat:@"%@%@",API,@"users/details.json"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"]=account.token;
    
   // params[parameter]=[NSString stringWithFormat:@"%@",value];
   // /v1/users/details.json
    [mgr GET:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        ZCLog(@"%@",responseObject);
        ZCPersonalData *personalData=[ZCPersonalData personalDataWithDict:responseObject];
        self.personalData=personalData;
        
        
        
        
        //创建图片View
        [self initImageView];
        
        //设置
        [self initSettingsButton];

        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ZCLog(@"%@",error);
    }];
  
 
}



//设置
-(void)initSettingsButton
{
    UIButton *settingsButton=[[UIButton alloc] init];
    CGFloat top = 25; // 顶端盖高度
    CGFloat bottom = 25 ; // 底端盖高度
    CGFloat left = 10; // 左端盖宽度
    CGFloat right = 10; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    UIImage *image=[UIImage imageNamed:@"beijing" ];
    // 指定为拉伸模式，伸缩后重新赋值
   image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    
   [settingsButton setBackgroundImage:image forState:UIControlStateNormal];
    CGFloat settingsButtonX=10;
    CGFloat settingsButtonY=self.headImageView.frame.size.height+15;
    CGFloat settingsButtonW=SCREEN_WIDTH-(2*settingsButtonX);
    CGFloat settingsButtonH=60;
    settingsButton.frame=CGRectMake(settingsButtonX, settingsButtonY, settingsButtonW, settingsButtonH);
    [settingsButton addTarget:self action:@selector(clicksettingsButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settingsButton];
    self.settingsButton=settingsButton;
    
    
    UIImageView *image1=[[UIImageView alloc] init];
    CGFloat imageX=10;
    
    CGFloat imageW=28;
    CGFloat imageH=28;
    CGFloat imageY=(settingsButtonH-imageH)*0.5;
    image1.frame=CGRectMake(imageX, imageY, imageW, imageH);
    //image1.image=[UIImage imageNamed:@"shezhi_iocn"];
    [settingsButton addSubview:image1];
    
    //设置
    UILabel *settingsLabel=[[UILabel alloc] init];
    CGFloat settingsLabelX=0;//imageW+imageX+15;
    CGFloat settingsLabelW=SCREEN_WIDTH;
    CGFloat settingsLabelH=30;
    CGFloat settingsLabelY=(settingsButtonH-imageH)*0.5;
    settingsLabel.frame=CGRectMake(settingsLabelX, settingsLabelY, settingsLabelW, settingsLabelH);
    settingsLabel.text=@"退出登录";
    settingsLabel.textColor=ZCColor(240, 208, 122);
    settingsLabel.textAlignment=NSTextAlignmentCenter;
    [settingsButton addSubview:settingsLabel];
    

    //向右箭头
    UIImageView *rightImageView=[[UIImageView alloc] init];
    
    CGFloat rightImageViewW=10;
    CGFloat rightImageViewH=17;
    CGFloat rightImageViewY=(settingsButtonH-rightImageViewH)*0.5;
    CGFloat rightImageViewX=settingsButtonW-rightImageViewW-10;
    rightImageView.frame=CGRectMake(rightImageViewX, rightImageViewY, rightImageViewW, rightImageViewH);
    rightImageView.image=[UIImage imageNamed:@"lsjfk_xiayibu_iocn"];
    
    [settingsButton addSubview:rightImageView];
}

//图片下载
-(void)imageData
{
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    
    NSString *URL=[NSString stringWithFormat:@"%@%@",API,@"users/portrait.json"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"]=account.token;
    [mgr GET:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        ZCLog(@"%@",responseObject);
        if ([responseObject[@"user"][@"portrait"]  isKindOfClass:[NSNull class]]) {
            
            self.headImage.image=[UIImage imageNamed:@"touxiang"];
            
        }else{
        NSString *str=responseObject[@"user"][@"portrait"][@"url"];
        NSURL *url=[NSURL URLWithString:str];
        //[self.headImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"20141118042246536.jpg"]];
            [self.headImage sd_setImageWithURL:url placeholderImage:nil];
            
            [self.headImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"touxiang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
                
                
//                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
//                self.imagePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:@"ImageFile"];
//                [[NSFileManager defaultManager] createDirectoryAtPath:self.imagePath withIntermediateDirectories:YES attributes:nil error:nil];
//                
//                NSData *data;
//                if (UIImagePNGRepresentation(image)) {
//                    data=UIImagePNGRepresentation(image);
//                }else
//                {
//                    data=UIImageJPEGRepresentation(image, 1.0);
//                }
//                
//                [data writeToFile:self.imagePath atomically:YES];

            }];
        
        
        // 存储模型数据
//        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//        NSString *file = [doc stringByAppendingPathComponent:@"image.jpg"];
//        [NSKeyedArchiver archiveRootObject:self.headImage.image toFile:file];
            
            
            
          //  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
           // NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"ImageFile"];
            
           // self.imagePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:@"ImageFile"];
            // 保存文件的名称
            //创建ImageFile的文件夹
          //  [[NSFileManager defaultManager] createDirectoryAtPath:self.imagePath withIntermediateDirectories:YES attributes:nil error:nil];
           // self.imagePath=[filePath stringByAppendingPathComponent:@"image.png"];
            //[UIImagePNGRepresentation(self.headImage.image)writeToFile: filePath    atomically:YES]; // 保存成功会返回YES
            //把图片转成NSData保存到沙盒文件下
            //UIImage *image2=[UIImage imageNamed:@"wo-xuanzhong" ];
//            NSData *data;
//            if (UIImagePNGRepresentation(self.headImage.image)) {
//                data=UIImagePNGRepresentation(self.headImage.image);
//            }else
//            {
//            data=UIImageJPEGRepresentation(self.headImage.image, 1.0);
//            }
            //保存
           // [[NSFileManager defaultManager] createFileAtPath:self.imagePath contents:data attributes:nil];
            
           // [data writeToFile:self.imagePath atomically:YES];

            
        }
ZCLog(@"网络下的载 ");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}

//头部图片View wo_bj
-(void)initImageView
{
    UIButton *headImageView=[[UIButton alloc] init];
    headImageView.userInteractionEnabled=YES;
    CGFloat headImageViewX=0;
    CGFloat headImageViewY=0;
    CGFloat headImageViewW=SCREEN_WIDTH;
    
    CGFloat headImageViewH=180;
    
    [headImageView addTarget:self action:@selector(clickRightButton) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    if (SCREEN_HEIGHT==667) {
        headImageViewH=229;
        
        headImageView.frame=CGRectMake(headImageViewX, headImageViewY, headImageViewW, headImageViewH);
        headImageView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"wo_bj"]];

    }else if (SCREEN_HEIGHT==736)
    {
    headImageViewH=250;
        headImageView.frame=CGRectMake(headImageViewX, headImageViewY, headImageViewW, headImageViewH);
        headImageView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"wo_bj"]];

        
    }else{
    headImageView.frame=CGRectMake(headImageViewX, headImageViewY, headImageViewW, headImageViewH);
        headImageView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bjtu"]];
    }
    [self.view addSubview:headImageView];
    self.headImageView=headImageView;
    
    
    
    UIImageView *headImage=[[UIImageView alloc] init];
    // 下载图片
   // NSURL *url=[NSURL URLWithString:self.personalData.portrait.url];
    //headImage.image set
    
   // headImage.image=[UIImage imageNamed:@"20141118042246536.jpg"];
    CGFloat headImageW=75;
    CGFloat headImageH=75;
    CGFloat headImageX=(SCREEN_WIDTH-headImageW)*0.5;
    CGFloat headImageY=21;
   
    headImage.frame=CGRectMake(headImageX, headImageY, headImageW, headImageH);
    headImage.layer.masksToBounds = YES;
    headImage.layer.cornerRadius = 37.5;
    [headImageView addSubview:headImage];
    self.headImage=headImage;
    [self imageData];
    
    
    
//    NSData *data = [NSData dataWithContentsOfFile:self.imagePath];
//    if (data) {
//        headImage.image=[UIImage imageWithData:data];
//        ZCLog(@"沙盒取出");
//    }else
//    {
//     [self imageData];
//        
//    }
    
    
    
//    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *file = [doc stringByAppendingPathComponent:@"image.jpg"];
//    UIImage *image=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
//    
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
//    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"sms.gif"]];   // 保存文件的名称
//
    
//    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Docments"] stringByAppendingPathComponent:@"currentImage.png"];
    //UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:self.imagePath];
//    NSData *data = [NSData dataWithContentsOfFile:self.imagePath];
//    UIImage *savedImage = [[UIImage alloc] initWithData:data];
//    if (data==nil) {
//        [self imageData];
//    }else{
//        
//       // UIImage *myImg = [UIImage imageWithData:image];
//        self.headImage.image=savedImage;
//        
//        ZCLog(@"沙盒取得");
//    }
    
    //名字
    UILabel *nameLabel=[[UILabel alloc] init];
    nameLabel.text=self.name;
    nameLabel.textColor=[UIColor whiteColor];
    CGFloat nameLabelW=150;
    CGFloat nameLabelH=25;
    CGFloat nameLabelX=(SCREEN_WIDTH-nameLabelW)*0.5;
    CGFloat nameLabelY=headImageY+headImageH+13;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.textAlignment=NSTextAlignmentCenter;
    nameLabel.textColor=ZCColor(240, 208, 122);
    [headImageView addSubview:nameLabel];
    //self.nameLabel=nameLabel;
    
    //心情
    UILabel *moodLabel=[[UILabel alloc] init];
    moodLabel.text=[NSString stringWithFormat:@"%@",self.personalData.desc];
    //moodLabel.textColor=[UIColor whiteColor];
    CGFloat moodLabelW=300;
    CGFloat moodLabelH=25;
    CGFloat moodLabelX=(SCREEN_WIDTH-moodLabelW)*0.5;
    CGFloat moodLabelY=nameLabelY+nameLabelH+15;
    moodLabel.frame=CGRectMake(moodLabelX, moodLabelY, moodLabelW, moodLabelH);
    moodLabel.textColor=ZCColor(240, 208, 122);
    moodLabel.textAlignment=NSTextAlignmentCenter;
    [headImageView addSubview:moodLabel];
    self.moodLabel=moodLabel;
    
    
    //向右的小箭头
    UIButton *rightButton=[[UIButton alloc] init];
    CGFloat rightButtonW=10;
    CGFloat rightButtonH=17;
    CGFloat rightButtonX=SCREEN_WIDTH*0.84;
    CGFloat rightButtonY=(headImageViewH-rightButtonH)*0.5;
    rightButton.frame=CGRectMake(rightButtonX, rightButtonY, rightButtonW, rightButtonH);
    //[rightButton setTitle:@"1212" forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@"lsjfk_xiayibu_iocn"] forState:UIControlStateNormal];
    //[rightButton addTarget:self action:@selector(clickRightButton) forControlEvents:UIControlEventTouchUpInside];
    [headImageView addSubview:rightButton];

}



//点击设置按钮
-(void)clicksettingsButton
{
//    ZCExitTableViewController *exitTableViewController=[[ZCExitTableViewController alloc] init];
//   exitTableViewController.hidesBottomBarWhenPushed=YES;
//    [self.navigationController pushViewController:exitTableViewController animated:YES];
    
    
    
    
    
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"退出登录",nil];
    [sheet showInView:self.view];

}


-(void)clickRightButton
{
    ZCLog(@"1111");
//    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选取",nil];
//    [sheet showInView:self.view];
    
    ZCPersonalInformationViewController *PersonalInformation=[[ZCPersonalInformationViewController alloc] init];
    PersonalInformation.personalData=self.personalData;
    PersonalInformation.personalImage=self.headImage.image;
    PersonalInformation.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:PersonalInformation animated:YES];
    

}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
        ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
        if ([account.type isEqual:@"guest"]) {
            //提示
            [self alert];
            
        }else{
            //删除数据
            [self  deleteTheAccount];
            
        }
        
        
        
        
    }
    
}



//删除数据
-(void)deleteTheAccount
{
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    //删除文件
    [[NSFileManager defaultManager] removeItemAtPath:file error:nil];
    
    
    
    ZCregisterViewController *registerViewController=[[ZCregisterViewController alloc] init];
    
    
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:registerViewController];
    UIWindow *wd = [[UIApplication sharedApplication].delegate window];
    //去首页
    wd.rootViewController =nav;
    
}


-(void)alert
{
    // 弹框
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您当前未设置账号和密码请完善，否则您的数据将会丢失" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    // 设置对话框的类型
    alert.alertViewStyle = UIKeyboardTypeNumberPad;
    
    [alert show];
    
}

#pragma mark - alertView的代理方法
/**
 *  点击了alertView上面的按钮就会调用这个方法
 *
 *  @param buttonIndex 按钮的索引,从0开始
 */

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        ZCLog(@"2222");
        // [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        [self deleteTheAccount];
    }
    
    // 按钮的索引肯定不是0
    
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
