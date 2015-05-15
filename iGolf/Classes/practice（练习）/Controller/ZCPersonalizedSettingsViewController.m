//
//  ZCPersonalizedSettingsViewController.m
//  iGolf
//
//  Created by hh on 15/5/13.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//个性化设置

#import "ZCPersonalizedSettingsViewController.h"
#import "ZCAccount.h"
#import "AFNetworking.h"
#import "ZCInvitationViewController.h"
@interface ZCPersonalizedSettingsViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,weak)UIButton *imageButton;
@property(nonatomic,assign,getter=isOpen) BOOL bKeyBoardHide;
@property(nonatomic,weak)UITextField *nameTextField;
@property(nonatomic,assign)int index;
@property(nonatomic,weak)UIImage *chooseImage;
@end

@implementation ZCPersonalizedSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    //监听通知中心
   
    
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
    
    UILabel *fiestLabel=[[UILabel alloc] init];
    
    CGFloat fiestLabelX=0;
    CGFloat fiestLabelY=SCREEN_HEIGHT*0.0176;
    CGFloat fiestLabelW=SCREEN_WIDTH;
    CGFloat fiestLabelH=25;
    fiestLabel.frame=CGRectMake(fiestLabelX, fiestLabelY, fiestLabelW, fiestLabelH);
    fiestLabel.textAlignment=NSTextAlignmentCenter;
    fiestLabel.text=@"第一步  上传头像";
    [self.view addSubview:fiestLabel ];
    
    
    UIButton *imageButton=[[UIButton alloc] init];
    CGFloat imageButtonW=90;
    CGFloat imageButtonH=90;
    CGFloat imageButtonX=(SCREEN_WIDTH-imageButtonW)/2;
    CGFloat imageButtonY=(2*fiestLabelY)+fiestLabelH;
    imageButton.frame=CGRectMake(imageButtonX, imageButtonY, imageButtonW, imageButtonH);
    [imageButton addTarget:self action:@selector(clickTheImageButton) forControlEvents:UIControlEventTouchUpInside];
    imageButton.layer.masksToBounds = YES;
    imageButton.layer.cornerRadius = 45;

     [self.view addSubview:imageButton];
    self.imageButton=imageButton;
    
    
    UIView *xian1=[[UIView alloc] init];
    xian1.frame=CGRectMake(10, imageButtonY+imageButtonH+(SCREEN_HEIGHT*0.0176), SCREEN_WIDTH-20, 1);
    xian1.backgroundColor=[UIColor redColor];
    [self.view addSubview:xian1];
    
    
    
    
    UILabel *secondLabel=[[UILabel alloc] init];
    
    CGFloat secondLabelX=0;
    CGFloat secondLabelY=SCREEN_HEIGHT*0.0264+xian1.frame.size.height+xian1.frame.origin.y;
    CGFloat secondLabelW=SCREEN_WIDTH;
    CGFloat secondLabelH=25;
    secondLabel.frame=CGRectMake(secondLabelX, secondLabelY, secondLabelW, secondLabelH);
    secondLabel.textAlignment=NSTextAlignmentCenter;
    secondLabel.text=@"第二步  设置昵称";
    [self.view addSubview:secondLabel ];
    
    
    
    
    UILabel *nameLabel=[[UILabel alloc] init];
    CGFloat nameLabelX=15;
    CGFloat nameLabelY=secondLabelY+secondLabelH+15;
    CGFloat nameLabelW=SCREEN_WIDTH-30;
    CGFloat nameLabelH=20;

    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.text=@"给自己起个好听的名字:";
    [self.view addSubview:nameLabel];
    
    
    UITextField *nameTextField=[[UITextField alloc] init];
    CGFloat nameTextFieldX=nameLabelX;
    CGFloat nameTextFieldY=nameLabelY+nameLabelH+10;
    CGFloat nameTextFieldW=nameLabelW;
    CGFloat nameTextFieldH=35;
    nameTextField.frame=CGRectMake(nameTextFieldX, nameTextFieldY, nameTextFieldW, nameTextFieldH);
    nameTextField.backgroundColor=[UIColor redColor];
    [self.view addSubview:nameTextField];
    self.nameTextField=nameTextField;
    
    UIView *xian2=[[UIView alloc] init];
    xian2.frame=CGRectMake(10, nameTextFieldY+nameTextFieldH+(SCREEN_HEIGHT*0.04), SCREEN_WIDTH-20, 1);
    xian2.backgroundColor=[UIColor redColor];
    [self.view addSubview:xian2];
    
    
    
    
    UILabel *thirdLabel=[[UILabel alloc] init];
    
    CGFloat thirdLabelX=0;
    CGFloat thirdLabelY=SCREEN_HEIGHT*0.04+xian2.frame.size.height+xian2.frame.origin.y;
    CGFloat thirdLabelW=SCREEN_WIDTH;
    CGFloat thirdLabelH=25;
    thirdLabel.frame=CGRectMake(thirdLabelX, thirdLabelY, thirdLabelW, thirdLabelH);
    thirdLabel.textAlignment=NSTextAlignmentCenter;
    thirdLabel.text=@"第三步  设置性别";
    [self.view addSubview:thirdLabel ];
    
    
    UIButton *manBtn=[[UIButton alloc] init];
    manBtn.backgroundColor=[UIColor redColor];
    CGFloat manBtnW=100;
    CGFloat manBtnH=90;
    CGFloat manBtnX=(SCREEN_WIDTH-(2*manBtnW))/3;
    CGFloat manBtnY=thirdLabelY+thirdLabelH+SCREEN_HEIGHT*0.03;
    manBtn.frame=CGRectMake(manBtnX, manBtnY, manBtnW, manBtnH);
    [manBtn setTitle:@"男" forState:UIControlStateNormal];
    [manBtn addTarget:self action:@selector(clickTheManBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:manBtn];
    
    
    
    UIButton *wonamBtn=[[UIButton alloc] init];
    wonamBtn.backgroundColor=[UIColor redColor];
    CGFloat wonamBtnW=100;
    CGFloat wonamBtnH=90;
    CGFloat wonamBtnX=(2*manBtnX)+manBtnW;
    CGFloat wonamBtnY=manBtnY;
    wonamBtn.frame=CGRectMake(wonamBtnX, wonamBtnY, wonamBtnW, wonamBtnH);
    [wonamBtn setTitle:@"女" forState:UIControlStateNormal];
   
    [wonamBtn addTarget:self action:@selector(clickTheWonamBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wonamBtn];

    
    
    
    UIButton *startBtn=[[UIButton alloc] init];
    CGFloat startBtnX=0;
    CGFloat startBtnY=SCREEN_HEIGHT-104;
    CGFloat startBtnW=SCREEN_WIDTH;
    CGFloat startBtnH=50;
    startBtn.frame=CGRectMake(startBtnX, startBtnY, startBtnW, startBtnH);
    startBtn.backgroundColor=[UIColor blueColor];
    [startBtn setTitle:@"保存" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(clickTheStartBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    
    
}

//选择男
-(void)clickTheManBtn:(UIButton *)button
{
    self.index=1;
}


//选择女
-(void)clickTheWonamBtn:(UIButton *)button
{
    self.index=2;
}



//点击照片
-(void)clickTheImageButton
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选取",nil];
    [sheet showInView:self.view];

}




/**
 *  UIActionSheet 代理方法
 */

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
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
            ZCLog(@"相ji不可用");
            
        }
        
        
    }else if(buttonIndex == 1){
        
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            // 1. 实例化
            UIImagePickerController *pick = [[UIImagePickerController alloc] init];
            pick.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            // 2. 设置代理
            pick.delegate = self;
            
            // 3. 展现
            [self presentViewController:pick animated:YES completion:nil];
            
            
            
        }else{
            ZCLog(@"相ce不可用");
            
            // [FXJDyTool showAlertViewWithMessage:@"相册不可用" delegate:self];
        }
    }


}




#pragma mark - 照片选择器代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //[self.photoView.image setImage:info[UIImagePickerControllerOriginalImage] forState:UIControlStateNormal];
    //self.photoView.image=info[UIImagePickerControllerOriginalImage];
    [self.imageButton setImage:info[UIImagePickerControllerOriginalImage] forState:UIControlStateNormal];
    self.chooseImage=info[UIImagePickerControllerOriginalImage];
    //ZCLog(@"%@",[self.photoView.image class]);
    // 关闭视图控制器
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // [self saveImage:info[UIImagePickerControllerOriginalImage] WithName:nil];
    //[self pictureUpload];
    
}



- (void)keyboardDidChangeFrame:(NSNotification *)noti
{
    //改变window的背景颜色
    //    self.view.window.backgroundColor = self.tableView.backgroundColor;
//    
//    CGRect frame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    
//    //键盘实时y
//    CGFloat keyY = frame.origin.y;
//  CGFloat keyDuration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
//    
//    CGFloat screenH = [[UIScreen mainScreen] bounds].size.height;
//    [UIView animateWithDuration:keyDuration animations:^{
//        self.view.transform = CGAffineTransformMakeTranslation(0, keyY - screenH );
//    }];

    
    
    if (self.bKeyBoardHide==NO) {
        self.view.transform = CGAffineTransformMakeTranslation(0,-40 );
//        [UIView animateWithDuration:keyDuration animations:^{
//            self.view.transform = CGAffineTransformMakeTranslation(0, -40 );
//        }];
        self.bKeyBoardHide = YES;

    }else
    {
        self.bKeyBoardHide = NO;
         self.view.transform = CGAffineTransformMakeTranslation(0,0 );
        
    }
    
}





//点击保存 上传网络
-(void)clickTheStartBtn
{

    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    

    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"users/update_portrait_and_nickname_and_gender.json"];
    
    NSData *imageData = UIImageJPEGRepresentation(self.chooseImage, 0.3);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"]=account.token;
    params[@"nickname"]=self.nameTextField.text;
    params[@"gender"]=@(self.index);

    
    NSMutableURLRequest *request = [mgr.requestSerializer multipartFormRequestWithMethod:@"PUT" URLString:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:imageData name:@"portrait" fileName:@"asd" mimeType:@"image/jpeg"];
    } error:nil];

    
    
    AFHTTPRequestOperation *requestOperation = [mgr HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        ZCLog(@"%@",responseObject);
        
        
        ZCInvitationViewController *InvitationViewController=[[ZCInvitationViewController alloc] init];
        
        InvitationViewController.isYes=NO;
        InvitationViewController.uuid=self.uuid;
        [self.navigationController pushViewController:InvitationViewController animated:YES];
        
        
        
        
        // success
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // failure
    }];
    
    // fire the request
    [requestOperation start];
    

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



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   
    
    [self.view endEditing:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
