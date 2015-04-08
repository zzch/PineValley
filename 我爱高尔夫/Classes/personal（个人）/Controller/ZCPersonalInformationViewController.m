//
//  ZCPersonalInformationViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/4/8.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCPersonalInformationViewController.h"
#import "AFNetworking.h"
#import "ZCAccount.h"
@interface ZCPersonalInformationViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,weak)UIImageView *photoView;

@end

@implementation ZCPersonalInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //跟换头像View
    [self changePhotoView];
    //名字
    
    

}


//跟换头像
-(void)changePhotoView
{
    UIButton *photoViewBtn=[[UIButton alloc] init];
    CGFloat photoViewBtnX=10;
    CGFloat photoViewBtnY=20;
    CGFloat photoViewBtnW=SCREEN_WIDTH-(2*photoViewBtnX);
    CGFloat photoViewBtnH=72;
    photoViewBtn.frame=CGRectMake(photoViewBtnX, photoViewBtnY, photoViewBtnW, photoViewBtnH);
    [photoViewBtn addTarget:self action:@selector(clickphotoViewBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:photoViewBtn];
    
    
    //头像
    UIImageView *photoView=[[UIImageView alloc] init];
    CGFloat photoViewX=10;
    CGFloat photoViewW=60;
    CGFloat photoViewH=60;
    CGFloat photoViewY=(photoViewBtnH-photoViewH)*0.5;
    photoView.frame=CGRectMake(photoViewX, photoViewY, photoViewW, photoViewH);
    [photoViewBtn addSubview:photoView];
    self.photoView=photoView;
    
    
    //跟换头像提示
    UILabel *photoLabel=[[UILabel alloc] init];
    CGFloat photoLabelX=photoViewX+photoViewW+10;
    CGFloat photoLabelW=70;
    CGFloat photoLabelH=30;
    CGFloat photoLabelY=(photoViewBtnH-photoLabelH)*0.5;
    photoLabel.frame=CGRectMake(photoLabelX, photoLabelY, photoLabelW, photoLabelH);
    photoLabel.text=@"更换头像";
    [photoViewBtn addSubview:photoLabel];
    

    
    //向右箭头
    UIImageView *rightImageView=[[UIImageView alloc] init];
    
    CGFloat rightImageViewW=20;
    CGFloat rightImageViewH=30;
    CGFloat rightImageViewY=(photoViewBtnH-rightImageViewH)*0.5;
    CGFloat rightImageViewX=photoViewBtnW-rightImageViewW-10;
    rightImageView.frame=CGRectMake(rightImageViewX, rightImageViewY, rightImageViewW, rightImageViewH);
    rightImageView.image=[UIImage imageNamed:@"jfk_youjiantou"];
    
    [photoViewBtn addSubview:rightImageView];
}


//点击跟换头像
-(void)clickphotoViewBtn
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选取",nil];
    [sheet showInView:self.view];

}



- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        //拍照UIImagePickerControllerSourceTypeCamera
         if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
         {
             // 1. 实例化
             UIImagePickerController *pick = [[UIImagePickerController alloc] init];
             //类型
             pick.sourceType=UIImagePickerControllerSourceTypeCamera;
             pick.delegate=self;
             // 3. 展现
             [self presentViewController:pick animated:YES completion:nil];
         
         }else{
             
         
         }
        
    
    }else{
        
        
              if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                  // 1. 实例化
                  UIImagePickerController *pick = [[UIImagePickerController alloc] init];
                  pick.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
                  // 2. 设置代理
                  pick.delegate = self;
                  
                  // 3. 展现
                  [self presentViewController:pick animated:YES completion:nil];

       
        
               }else{
                   ZCLog(@"相机不可用");
        
                   // [FXJDyTool showAlertViewWithMessage:@"相册不可用" delegate:self];
                }
    }
}



#pragma mark - 照片选择器代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //[self.photoView.image setImage:info[UIImagePickerControllerOriginalImage] forState:UIControlStateNormal];
    self.photoView.image=info[UIImagePickerControllerOriginalImage];
    
    //ZCLog(@"%@",[self.photoView.image class]);
    // 关闭视图控制器
    [self dismissViewControllerAnimated:YES completion:nil];

   
    [self pictureUpload];

}

//上传
-(void)pictureUpload
{
    // 1.创建请求管理对象/v1/users/update_portrait.json
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"users/update_portrait.json"];
    //封装请求参数
    
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
     NSData *data= UIImageJPEGRepresentation(self.photoView.image, 0.7);
    params[@"portrait"] = data;
     params[@"token"]=account.token;
    //发送请求/v1/users/sign_up.json
    [mgr PUT:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        ZCLog(@"%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         ZCLog(@"%@",error);
        
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
