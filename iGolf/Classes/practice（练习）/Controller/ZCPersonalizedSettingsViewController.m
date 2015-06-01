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
#import "MBProgressHUD+NJ.h"
@interface ZCPersonalizedSettingsViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,weak)UIButton *imageButton;
@property(nonatomic,assign,getter=isOpen) BOOL bKeyBoardHide;
@property(nonatomic,weak)UITextField *nameTextField;
@property(nonatomic,assign)int index;
@property(nonatomic,weak)UIImage *chooseImage;
@property(nonatomic,weak)UIButton *manBtn;
@property(nonatomic,weak)UIButton *wonamBtn;
@property(nonatomic,weak)UIButton *startBtn;
@end

@implementation ZCPersonalizedSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"个性化设置";
    
    //监听通知中心
   
    
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
    
    UILabel *fiestLabel=[[UILabel alloc] init];
    
    CGFloat fiestLabelX=0;
    CGFloat fiestLabelY=SCREEN_HEIGHT*0.0457;
    CGFloat fiestLabelW=SCREEN_WIDTH;
    CGFloat fiestLabelH=25;
    fiestLabel.frame=CGRectMake(fiestLabelX, fiestLabelY, fiestLabelW, fiestLabelH);
    fiestLabel.textAlignment=NSTextAlignmentCenter;
    fiestLabel.text=@"第一步  上传头像";
    [self.view addSubview:fiestLabel ];
    
    
    UIButton *imageButton=[[UIButton alloc] init];
    CGFloat imageButtonW=70;
    CGFloat imageButtonH=70;
    CGFloat imageButtonX=(SCREEN_WIDTH-imageButtonW)/2;
    CGFloat imageButtonY=fiestLabelY+fiestLabelH+SCREEN_HEIGHT*0.0176;
    imageButton.frame=CGRectMake(imageButtonX, imageButtonY, imageButtonW, imageButtonH);
    [imageButton addTarget:self action:@selector(clickTheImageButton) forControlEvents:UIControlEventTouchUpInside];
    imageButton.layer.masksToBounds = YES;
    imageButton.layer.cornerRadius = 35;
    [imageButton setImage:[UIImage imageNamed:@"gxhsz_touxiang"] forState:UIControlStateNormal];
     [self.view addSubview:imageButton];
    self.imageButton=imageButton;
    
    
    UIView *xian1=[[UIView alloc] init];
    xian1.frame=CGRectMake(10, imageButtonY+imageButtonH+(SCREEN_HEIGHT*0.0271), SCREEN_WIDTH-20, 1);
    xian1.backgroundColor=ZCColor(170, 170, 170);
    [self.view addSubview:xian1];
    
    
    
    
    UILabel *secondLabel=[[UILabel alloc] init];
    
    CGFloat secondLabelX=0;
    CGFloat secondLabelY=SCREEN_HEIGHT*0.0176+xian1.frame.size.height+xian1.frame.origin.y;
    CGFloat secondLabelW=SCREEN_WIDTH;
    CGFloat secondLabelH=25;
    secondLabel.frame=CGRectMake(secondLabelX, secondLabelY, secondLabelW, secondLabelH);
    secondLabel.textAlignment=NSTextAlignmentCenter;
    secondLabel.text=@"第二步  设置昵称";
    [self.view addSubview:secondLabel ];
    
    
    
    
    UILabel *nameLabel=[[UILabel alloc] init];
    CGFloat nameLabelX=15;
    CGFloat nameLabelY=secondLabelY+secondLabelH+SCREEN_HEIGHT*0.0132;
    CGFloat nameLabelW=SCREEN_WIDTH-30;
    CGFloat nameLabelH=20;

    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.text=@"给自己起个好听的名字:";
    [self.view addSubview:nameLabel];
    
    
   
    CGFloat nameTextFieldX=nameLabelX;
    CGFloat nameTextFieldY=nameLabelY+nameLabelH+10;
    CGFloat nameTextFieldW=nameLabelW;
    CGFloat nameTextFieldH=35;
   
    
    
    CGFloat top = 25; // 顶端盖高度
    CGFloat bottom = 25 ; // 底端盖高度
    CGFloat left = 10; // 左端盖宽度
    CGFloat right = 10; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    UIImage *image=[UIImage imageNamed:@"shurukuang" ];
    // 指定为拉伸模式，伸缩后重新赋值
    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
   // nameTextField.backgroundColor=[UIColor colorWithPatternImage:image];
    
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(nameTextFieldX, nameTextFieldY, nameTextFieldW, nameTextFieldH)];
    imageView.image=image;
    [self.view addSubview:imageView];
    
    
     UITextField *nameTextField=[[UITextField alloc] init];
     nameTextField.frame=CGRectMake(nameTextFieldX, nameTextFieldY, nameTextFieldW, nameTextFieldH);
    [self.view addSubview:nameTextField];
    self.nameTextField=nameTextField;
    [self.nameTextField addTarget:self action:@selector(whetherCanSaveClicks) forControlEvents:UIControlEventEditingChanged];

    
    UIView *xian2=[[UIView alloc] init];
    xian2.frame=CGRectMake(10, nameTextFieldY+nameTextFieldH+(SCREEN_HEIGHT*0.04), SCREEN_WIDTH-20, 1);
    xian2.backgroundColor=ZCColor(170, 170, 170);
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
    
    CGFloat manBtnW=133;
    CGFloat manBtnH=75;
    CGFloat manBtnX=(SCREEN_WIDTH-(2*manBtnW))/3;
    CGFloat manBtnY=thirdLabelY+thirdLabelH+SCREEN_HEIGHT*0.03;
    manBtn.frame=CGRectMake(manBtnX, manBtnY, manBtnW, manBtnH);
    [manBtn setImage:[UIImage imageNamed:@"gxhsz_nan"] forState:UIControlStateNormal];
    //[manBtn setTitle:@"男" forState:UIControlStateNormal];
    [manBtn addTarget:self action:@selector(clickTheManBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:manBtn];
    self.manBtn=manBtn;
    
    
    UIButton *wonamBtn=[[UIButton alloc] init];
    
    CGFloat wonamBtnW=133;
    CGFloat wonamBtnH=75;
    CGFloat wonamBtnX=(2*manBtnX)+manBtnW;
    CGFloat wonamBtnY=manBtnY;
    wonamBtn.frame=CGRectMake(wonamBtnX, wonamBtnY, wonamBtnW, wonamBtnH);
    [wonamBtn setImage:[UIImage imageNamed:@"gxhsz_nv"] forState:UIControlStateNormal];
    self.wonamBtn=wonamBtn;
   
    [wonamBtn addTarget:self action:@selector(clickTheWonamBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wonamBtn];

    
    
    
    UIButton *startBtn=[[UIButton alloc] init];
    CGFloat startBtnX=0;
    CGFloat startBtnY=SCREEN_HEIGHT-114;
    CGFloat startBtnW=SCREEN_WIDTH;
    CGFloat startBtnH=50;
    startBtn.frame=CGRectMake(startBtnX, startBtnY, startBtnW, startBtnH);
    startBtn.enabled=NO;
    startBtn.backgroundColor=ZCColor(100, 175, 102);
    [startBtn setTitle:@"保存" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(clickTheStartBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    self.startBtn=startBtn;
    
    
}

//选择男
-(void)clickTheManBtn:(UIButton *)button
{
    
    [self.manBtn setImage:[UIImage imageNamed:@"nan_xuanzhong"] forState:UIControlStateNormal];
    [self.wonamBtn setImage:[UIImage imageNamed:@"gxhsz_nv"] forState:UIControlStateNormal];
    self.index=1;
    
    
    
    [self whetherCanSaveClicks];
}


//选择女
-(void)clickTheWonamBtn:(UIButton *)button
{
    
    
    [self.manBtn setImage:[UIImage imageNamed:@"gxhsz_nan"] forState:UIControlStateNormal];
    [self.wonamBtn setImage:[UIImage imageNamed:@"nv_xuanzhong"] forState:UIControlStateNormal];
    self.index=2;
    
    
    [self whetherCanSaveClicks];
}


//判断保存按钮是否可以点击
-(void)whetherCanSaveClicks
{
    ZCLog(@"------%@",self.nameTextField.text);
    
        // [self.startBtn setBackgroundColor:[UIColor redColor]];
    if (self.index&&![self.nameTextField.text isEqual:@""]&&self.chooseImage) {
        
        self.startBtn.enabled=YES;
        //self.startBtn.backgroundColor=ZCColor(9, 133, 12);
        [self.startBtn setBackgroundColor:ZCColor(9, 133, 12)];
    }else{
        
        self.startBtn.enabled=NO;
        self.startBtn.backgroundColor=ZCColor(100, 175, 102);

           }

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
    [self whetherCanSaveClicks];
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

    //显示圈圈
    [MBProgressHUD showMessage:@"上传中..."];
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
        
        
        //隐藏圈圈
        [MBProgressHUD hideHUD];

        
        // success
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //隐藏圈圈
        [MBProgressHUD hideHUD];

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
