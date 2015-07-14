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
#import "UIImage+MJ.h"
#import "CityPickerView.h"
#import "ZCDatapickerView.h"
#import "UIBarButtonItem+DC.h"
@interface ZCPersonalInformationViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,ZCDatapickerViewDelegate>
//头像
@property(nonatomic,weak)UIImageView *photoView;
//点击 photoViewBtn
@property(nonatomic,weak)UIButton *photoViewBtn;
@property(nonatomic,weak)UIScrollView *scrollView;
@property(nonatomic,weak)UIView *genderView;
@property(nonatomic,weak)UIButton *genderButton;
@property(nonatomic,weak)UIPickerView *startCityPicker;
@property(nonatomic,weak)UIButton *birthdayButton;
@property(nonatomic,weak)UIView *datePicker;
@property(nonatomic,weak)UITextView *signatureTextView;
@property(nonatomic,weak)UITextField *nameTextField;
@property(nonatomic,copy)NSString *gender;
//时间濯
@property(nonatomic,assign) long time;
@property (nonatomic, assign, getter = isOpened1) BOOL opened1;
@property (nonatomic, assign, getter = isOpened2) BOOL opened2;

@property(nonatomic,weak)UIButton *ageNumLabel;

@end

@implementation ZCPersonalInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"修改个人信息";
//    
//    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
//    customLab.textAlignment=NSTextAlignmentCenter;
//    [customLab setTextColor:ZCColor(240, 208, 122)];
//    [customLab setText:@"修改个人资料"];
//    customLab.font = [UIFont boldSystemFontOfSize:20];
//    self.navigationItem.titleView = customLab;
    
    
    //返回
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barBtnItemWithNormalImageName:@"fanhui" hightImageName:@"fanhui" action:@selector(liftBthClick:) target:self];
    

    
    UIBarButtonItem *newBar= [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(chooseTheDetermine)];
    //改变UIBarButtonItem字体颜色
    [newBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor,nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem =newBar;

    
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selfViewClick)];
    [self.view addGestureRecognizer:tap];
    
    
    
    UIScrollView *scrollView=[[UIScrollView alloc] init];
    scrollView.frame=[UIScreen mainScreen].bounds;
    self.scrollView=scrollView;
    [self.view addSubview:scrollView];
    //self.scrollView.userInteractionEnabled=YES;
   
    self.view.backgroundColor=ZCColor(237, 237, 237);
    
    [self onlineData];
    
    
//    //性别
//    [self chooseGender];
    
    
    
    
    
    

}




//返回到上个界面
-(void)liftBthClick:(UIButton *)bth
{
    [self.navigationController popViewControllerAnimated:YES];
}





//网络请求
-(void)onlineData
{
    //加载圈圈
    [MBProgressHUD showMessage:@"加载中..."];
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
        if (responseObject[@"error_code"] ) {
            
            [ZCprompt initWithController:self andErrorCode:[NSString stringWithFormat:@"%@",responseObject[@"error_code"]]];
            
        }else
        {
            
            ZCLog(@"%@",responseObject);
            ZCPersonalData *personalData=[ZCPersonalData personalDataWithDict:responseObject];
            self.personalData=personalData;
            
            
            
            
            //跟换头像View
            [self changePhotoView];
            //名字
            [self personalName];

        }
        //移除圈圈
        [MBProgressHUD hideHUD];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ZCLog(@"%@",error);
        [MBProgressHUD hideHUD];
        [ZCprompt initWithController:self andErrorCode:[NSString stringWithFormat:@"%ld",(long)[operation.response statusCode]]];
    }];
    
    
}






//点击确定按钮
-(void)chooseTheDetermine
{
/////v1/users/update_nickname.json
    
    
    //加载圈圈
    [MBProgressHUD showMessage:@"上传中..."];
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    self.name=account.nickname;
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    
    NSString *URL=[NSString stringWithFormat:@"%@%@",API,@"users/update_profile.json"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
     params[@"token"]=account.token;
     params[@"nickname"]=self.nameTextField.text;
     params[@"gender"]=[NSString stringWithFormat:@"%@", self.gender];
     params[@"birthday"]=@(self.time);
     params[@"description"]=self.signatureTextView.text;
    
    [mgr PUT:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        ZCLog(@"%@",responseObject);
        
        
        if (responseObject[@"error_code"] ) {
            
            [ZCprompt initWithController:self andErrorCode:[NSString stringWithFormat:@"%@",responseObject[@"error_code"]]];
            
            [MBProgressHUD hideHUD];
            
        }else
        {

        
        if ([self.delegate respondsToSelector:@selector(ZCPersonalInformationViewController:andPersonImage:andSignatureTextView:andPersonName:)]) {
            
            [self.delegate ZCPersonalInformationViewController:self andPersonImage:self.photoView.image andSignatureTextView:self.signatureTextView.text andPersonName:self.nameTextField.text];
        }
        
        
        
        
        [self.navigationController popViewControllerAnimated:YES];

        [MBProgressHUD hideHUD];
        }
        
        [MBProgressHUD showSuccess:@"上传成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        ZCLog(@"%@",error);
        [MBProgressHUD hideHUD];
        
        
         [ZCprompt initWithController:self andErrorCode:[NSString stringWithFormat:@"%ld",(long)[operation.response statusCode]]];
    }];
    
    
    
    
    
    
    
    
    
    
//    //生日的URL
//    NSString *birthdayURL=[NSString stringWithFormat:@"%@%@",API,@"users/update_profile.json"];
//    
//    
//    //签名的URL
//    NSString *descriptionURL=[NSString stringWithFormat:@"%@%@",API,@"users/update_description.json"];
//    
//    //性别的URL
//    NSString *genderURL=[NSString stringWithFormat:@"%@%@",API,@"users/update_gender.json"];
//    //昵称的URL
//    NSString *nicknameURL=[NSString stringWithFormat:@"%@%@",API,@"users/update_nickname.json"];
//
//    
//    //跟新签名
//    [self withTheNewDataWithURL:descriptionURL parameter:@"description" value:self.signatureTextView.text];
//    //跟新昵称
//    [self withTheNewDataWithURL:nicknameURL parameter:@"nickname" value:self.nameTextField.text];
//    
//    //跟新生日
//    [self withTheNewDataWithURL:birthdayURL parameter:@"birthday" value:[NSString stringWithFormat:@"%ld", self.time]];
//    //跟新性别
//   [self withTheNewDataWithURL:genderURL parameter:@"gender" value:[NSString stringWithFormat:@"%@", self.gender]];
//    
//
//    
//    
    
    
}

//-(void)withTheNewDataWithURL:(NSString *)url parameter:(NSString *)parameter value:(NSString *)value
//{
//    
//    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
//    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
//    
//    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
//   
//    ZCLog(@"%@",account.token);
//    ZCLog(@"%@",value);
//    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"token"]=account.token;
//    
//    params[parameter]=[NSString stringWithFormat:@"%@",value];
//    
//    [mgr PUT:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        ZCLog(@"%@",responseObject);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        ZCLog(@"%@",error);
//        
//    }];
//
//
//}


//名字
-(void)personalName
{
    UILabel *nameLabel=[[UILabel alloc] init];
    CGFloat nameLabelX=10;
    CGFloat nameLabelY=self.photoViewBtn.frame.origin.y+self.photoViewBtn.frame.size.height;;
    CGFloat nameLabelW=60;
    CGFloat nameLabelH=40;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.text=@"名字";
    nameLabel.textColor=ZCColor(85, 85, 85);
    [self.scrollView addSubview:nameLabel];
    
    UITextField *nameTextField=[[UITextField alloc] init];
    CGFloat nameTextFieldX=0;
    CGFloat nameTextFieldY=nameLabelY+nameLabelH;
    CGFloat nameTextFieldW=SCREEN_WIDTH-(2*nameTextFieldX);
    CGFloat nameTextFieldH=51;
    
    nameTextField.frame=CGRectMake(nameTextFieldX, nameTextFieldY, nameTextFieldW, nameTextFieldH);
    
    [nameTextField addTarget:self action:@selector(nameTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
//    CGFloat top = 25; // 顶端盖高度
//    CGFloat bottom = 25 ; // 底端盖高度
//    CGFloat left = 10; // 左端盖宽度
//    CGFloat right = 10; // 右端盖宽度
//    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
//    UIImage *image1=[UIImage imageNamed:@"denglu_denglukuang" ];
//    // 指定为拉伸模式，伸缩后重新赋值
//    image1 = [image1 resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
//    [nameTextField setBackground:image1];
    nameTextField.background=[UIImage imageNamed:@"hang_bj_03"];
    //nameTextField.backgroundColor=[UIColor whiteColor];
    nameTextField.textColor=ZCColor(85, 85, 85);
    nameTextField.text=self.name;
    UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 10)];
    nameTextField.leftView = paddingView3;
    nameTextField.leftViewMode = UITextFieldViewModeAlways;
    
    [self.scrollView addSubview:nameTextField];
    
    self.nameTextField=nameTextField;
    
    //性别
    UILabel *genderLabel=[[UILabel alloc] init];
    CGFloat genderLabelX=10;
    CGFloat genderLabelY=nameTextFieldY+nameTextFieldH;
    CGFloat genderLabelW=60;
    CGFloat genderLabelH=40;
    genderLabel.frame=CGRectMake(genderLabelX, genderLabelY, genderLabelW, genderLabelH);
    genderLabel.text=@"性别";
    genderLabel.textColor=ZCColor(85, 85, 85);
    [self.scrollView addSubview:genderLabel];
    
    //选择性别
    UIButton *genderButton=[[UIButton alloc] init];
    CGFloat genderButtonX=0;
    CGFloat genderButtonY=genderLabelY+genderLabelH;
    CGFloat genderButtonW=SCREEN_WIDTH-(2*genderButtonX);
    CGFloat genderButtonH=51;
    [genderButton setBackgroundImage:[UIImage imageNamed:@"hang_bj_03"] forState:UIControlStateNormal];
   
    genderButton.frame=CGRectMake(genderButtonX, genderButtonY, genderButtonW, genderButtonH);
    self.gender=@"1";
    [genderButton addTarget:self action:@selector(chickGenderButton) forControlEvents:UIControlEventTouchUpInside];
    
    
//    CGFloat top = 25; // 顶端盖高度
//    CGFloat bottom = 25 ; // 底端盖高度
//    CGFloat left = 10; // 左端盖宽度
//    CGFloat right = 10; // 右端盖宽度
//    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
//    UIImage *image2=[UIImage imageNamed:@"grxx_anniu_bj" ];
//    // 指定为拉伸模式，伸缩后重新赋值
//    image2 = [image2 resizableImageWithCapInsets:UIEdgeInsetsMake(25,25,10,10) resizingMode:UIImageResizingModeStretch];
//    [genderButton setBackgroundImage:image2 forState:UIControlStateNormal];
    //genderButton.backgroundColor=[UIColor redColor];
    genderButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    //让button的里的内容从左往右移动10像素
    genderButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [genderButton setTitleColor:ZCColor(85, 85, 85) forState:UIControlStateNormal];
    
    if (![self.personalData.gender isKindOfClass:[NSNull class]]) {
        
        if ([[NSString stringWithFormat:@"%@",self.personalData.gender] isEqual:@"1"]) {
            [genderButton setTitle:@"男" forState:UIControlStateNormal];
        }else
        {
        [genderButton setTitle:@"女" forState:UIControlStateNormal];
        }
        
        
        
        
        
    }
    
    [self.scrollView addSubview:genderButton];
    self.genderButton=genderButton;
    
//    
//    UIView *genderView=[[UIView alloc] init];
//    genderView.hidden=YES;
//    CGFloat genderViewX=0;
//    CGFloat genderViewY=genderButtonY+genderButtonH;
//    CGFloat genderViewW=SCREEN_WIDTH;
//    CGFloat genderViewH=50;
//    genderView.frame=CGRectMake(genderViewX, genderViewY, genderViewW, genderViewH);
//    genderView.backgroundColor=[UIColor yellowColor];
//    [self.scrollView addSubview:genderView];
//    self.genderView=genderView;
    
    //生日
    UILabel *birthdayLabel=[[UILabel alloc] init];
    CGFloat birthdayLabelY=genderButtonY+genderButtonH;
    CGFloat birthdayLabelX=10;
    
    CGFloat birthdayLabelW=60;
    CGFloat birthdayLabelH=40;
    birthdayLabel.frame=CGRectMake(birthdayLabelX, birthdayLabelY, birthdayLabelW, birthdayLabelH);
    birthdayLabel.text=@"生日";
    birthdayLabel.textColor=ZCColor(85, 85, 85);
    [self.scrollView addSubview:birthdayLabel];
    
    
    //选择生日
    UIButton *birthdayButton=[[UIButton alloc] init];
    CGFloat birthdayButtonX=0;
    CGFloat birthdayButtonY=birthdayLabelY+birthdayLabelH;
    CGFloat birthdayButtonW=SCREEN_WIDTH-(2*birthdayButtonX);
    CGFloat birthdayButtonH=51;
    birthdayButton.frame=CGRectMake(birthdayButtonX, birthdayButtonY, birthdayButtonW, birthdayButtonH);
    [birthdayButton setBackgroundImage:[UIImage imageNamed:@"hang_bj_03"] forState:UIControlStateNormal];
    
//    UIImage *image3=[UIImage imageNamed:@"grxx_anniu_bj" ];
//    // 指定为拉伸模式，伸缩后重新赋值
//    image3 = [image3 resizableImageWithCapInsets:UIEdgeInsetsMake(25,25,10,10) resizingMode:UIImageResizingModeStretch];
   // [birthdayButton setBackgroundImage:image2 forState:UIControlStateNormal];
    
    
    [birthdayButton addTarget:self action:@selector(chickBirthdayButton) forControlEvents:UIControlEventTouchUpInside];
   // birthdayButton.backgroundColor=[UIColor blueColor];
    //时间卓转成想要的时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"yyyy-MM-dd "];
    NSDate *confromTimesp=[NSDate dateWithTimeIntervalSince1970:self.personalData.birthday];
    NSString *confromTimespStr=[fmt stringFromDate:confromTimesp];
    
    
    [birthdayButton setTitle:confromTimespStr forState:UIControlStateNormal];
    [birthdayButton setTitleColor:ZCColor(85, 85, 85) forState:UIControlStateNormal];
        //居左
    birthdayButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    //让button的里的内容从左往右移动10像素
    birthdayButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [self.scrollView addSubview:birthdayButton];
    self.birthdayButton=birthdayButton;
    
    
//    // 获取用户通过UIDatePicker设置的日期和时间
//    NSDate *selected = [datePicker date];
//    // 创建一个日期格式器
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    // 为日期格式器设置格式字符串
//    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
//    // 使用日期格式器格式化日期、时间
//    NSString *destDateString = [dateFormatter stringFromDate:selected];
//    
//    [self.birthdayButton setTitle:destDateString forState:UIControlStateNormal];
//
    
    
  
    
    //年龄
    UILabel *ageLabel=[[UILabel alloc] init];
    CGFloat ageLabelY=birthdayButtonY+birthdayButtonH;
    CGFloat ageLabelX=10;
    CGFloat ageLabelW=60;
    CGFloat ageLabelH=40;
    ageLabel.frame=CGRectMake(ageLabelX, ageLabelY, ageLabelW, ageLabelH);
    ageLabel.text=@"年龄";
    ageLabel.textColor=ZCColor(85, 85, 85);
    [self.scrollView addSubview:ageLabel];
    
    
   
    
    
    
    
    UIButton *ageNumLabel=[[UIButton alloc] init];
    CGFloat ageNumLabelY=ageLabelY+ageLabelH;
    CGFloat ageNumLabelX=0;
    
    CGFloat ageNumLabelW=SCREEN_WIDTH-(2*ageNumLabelX);
    CGFloat ageNumLabelH=51;
    ageNumLabel.frame=CGRectMake(ageNumLabelX, ageNumLabelY, ageNumLabelW, ageNumLabelH);
    [ageNumLabel setBackgroundImage:[UIImage imageNamed:@"hang_bj_03"] forState:UIControlStateNormal];
   // ageNumLabel.text=@"24";
    
//    UIImage *image4=[UIImage imageNamed:@"grxx_anniu_bj" ];
//    // 指定为拉伸模式，伸缩后重新赋值
//    image4 = [image4 resizableImageWithCapInsets:UIEdgeInsetsMake(25,25,10,10) resizingMode:UIImageResizingModeStretch];
    //[ageNumLabel setBackgroundImage:image2 forState:UIControlStateNormal];
    //[ageNumLabel setBackgroundImage:image4 forState:UIControlStateNormal];
    ageNumLabel.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    //让button的里的内容从左往右移动10像素
   
    ageNumLabel.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [ageNumLabel setTitleColor:ZCColor(85, 85, 85) forState:UIControlStateNormal];
    
    [self.scrollView addSubview:ageNumLabel];
    self.ageNumLabel=ageNumLabel;
    
   
    
    
    // 为日期格式器设置格式字符串
    [fmt setDateFormat:@"yyyy"];
    // 使用日期格式器格式化日期、时间
    NSString *person = [fmt stringFromDate:confromTimesp];
    
    int age=[person intValue];
    
    
    // 获取用户通过UIDatePicker设置的日期和时间
    NSDate *nowDate = [NSDate date];
    // 创建一个日期格式器
    NSDateFormatter *nowDateFormatter = [[NSDateFormatter alloc] init];
    // 为日期格式器设置格式字符串
    [nowDateFormatter setDateFormat:@"yyyy"];
    // 使用日期格式器格式化日期、时间
    NSString *nowDateString = [nowDateFormatter stringFromDate:nowDate];
    
    int now=[nowDateString intValue];
    
    
    if (now-age>0) {
        [self.ageNumLabel setTitle:[NSString stringWithFormat:@"%d",now-age] forState:UIControlStateNormal];
    }else if (now-age>85)
    {
    [self.ageNumLabel setTitle:@"85" forState:UIControlStateNormal];
    }
    
    else
    {
    [self.ageNumLabel setTitle:@"0" forState:UIControlStateNormal];
    }
    
    
    

    
    
    
//    //地区
//    
//    UILabel *addressLabel=[[UILabel alloc] init];
//    CGFloat addressLabelY=ageNumLabelY+ageNumLabelH;
//    CGFloat addressLabelX=10;
//    
//    CGFloat addressLabelW=60;
//    CGFloat addressLabelH=40;
//    addressLabel.frame=CGRectMake(addressLabelX, addressLabelY, addressLabelW, addressLabelH);
//    addressLabel.text=@"地区";
//    [self.scrollView addSubview:addressLabel];
//    
    
//    //显示地区
//    UIButton *addressButton=[[UIButton alloc] init];
//    CGFloat addressButtonX=10;
//    CGFloat addressButtonY=addressLabelY+addressLabelH;
//    CGFloat addressButtonW=SCREEN_WIDTH-(2*addressButtonX);
//    CGFloat addressButtonH=40;
//    addressButton.frame=CGRectMake(addressButtonX, addressButtonY, addressButtonW, addressButtonH);
//    [addressButton addTarget:self action:@selector(chickAddressButton) forControlEvents:UIControlEventTouchUpInside];
//    addressButton.backgroundColor=[UIColor blueColor];
//   [addressButton setTitle:[NSString stringWithFormat:@"%@",self.personalData.portrait] forState:UIControlStateNormal];
//    [self.scrollView addSubview:addressButton];
//
    
    
    
    //签名
    
    UILabel *signatureLabel=[[UILabel alloc] init];
    CGFloat signatureLabelY=ageNumLabelY+ageNumLabelH;
    CGFloat signatureLabelX=10;
    CGFloat signatureLabelW=60;
    CGFloat signatureLabelH=40;
    signatureLabel.frame=CGRectMake(signatureLabelX, signatureLabelY, signatureLabelW, signatureLabelH);
    signatureLabel.text=@"签名";
    signatureLabel.textColor=ZCColor(85, 85, 85);
    [self.scrollView addSubview:signatureLabel];

    
    //输入签名
    
    UITextView *signatureTextView=[[UITextView alloc] init];
    CGFloat signatureTextFieldX=0;
    CGFloat signatureTextFieldY=signatureLabelY+signatureLabelH;
    CGFloat signatureTextFieldW=SCREEN_WIDTH-(2*signatureTextFieldX);
    CGFloat signatureTextFieldH=70;
    signatureTextView.frame=CGRectMake(signatureTextFieldX, signatureTextFieldY, signatureTextFieldW, signatureTextFieldH);
    
    
    
//    UIImage *image5=[UIImage imageNamed:@"grxx_qianming_bj" ];
//    // 指定为拉伸模式，伸缩后重新赋值
//    image5 = [image5 resizableImageWithCapInsets:UIEdgeInsetsMake(25,25,10,10) resizingMode:UIImageResizingModeStretch];

    //signatureTextView.
    signatureTextView.backgroundColor=[UIColor whiteColor];
   // signatureTextView.backgroundColor=[UIColor colorWithPatternImage:image4];
    
    if (![self.personalData.desc isKindOfClass:[NSNull class]]) {
        signatureTextView.text=[NSString stringWithFormat:@"%@",self.personalData.desc];
    }
    
    signatureTextView.textColor=ZCColor(85, 85, 85);
    [self.scrollView addSubview:signatureTextView];
    self.signatureTextView=signatureTextView;
    
    self.scrollView.contentSize = CGSizeMake(0,signatureTextFieldY+signatureTextFieldH+70 );
}





//监听  限制文字
-(void)nameTextFieldDidChange:(UITextField *)TextField
{
    if (TextField.text.length > 14 && TextField.text.length!=1){
        self.nameTextField.text = [TextField.text substringToIndex:14];
        
    }
    
}


////chickAddressButton
//-(void)chickAddressButton
//{
//    
//    if (!_startCityPicker.superview) {
//        _startCityPicker = [[CityPickerView alloc] initWithFrame:CGRectZero section:3];
//       // _startCityPicker.isSelectDetail = YES;
//        _startCityPicker.backgroundColor = [UIColor grayColor];
//        _startCityPicker.delegate = self;
//        [self.view.window addSubview:_startCityPicker];
//    }
//}

//点击选择生日
-(void)chickBirthdayButton
{
    if (self.opened1==NO) {
        //显示生日
        ZCDatapickerView *datePicker=[[ZCDatapickerView alloc] init];
        self.opened1=YES;
        datePicker.delegate=self;
       
        
        CGFloat datePickerY=self.birthdayButton.frame.size.height+self.birthdayButton.frame.origin.y;
        CGFloat datePickerX=0;
        
        CGFloat datePickerW=SCREEN_WIDTH;
        CGFloat datePickerH=300;
        datePicker.frame=CGRectMake(datePickerX, datePickerY, datePickerW, datePickerH);
        
        [self.scrollView addSubview:datePicker];
        self.datePicker=datePicker;


    }else
    {
    [self.datePicker removeFromSuperview];
        self.opened1=NO;
    }
    
    

}

//点击性别
-(void)chickGenderButton
{
    if (self.opened2==NO) {
        
    
        UIView *genderView=[[UIView alloc] init];
        //genderView.hidden=YES;
        self.opened2=YES;
        CGFloat genderViewX=0;
    CGFloat genderViewY=self.genderButton.frame.size.height+self.genderButton.frame.origin.y;///genderButtonY+genderButtonH;
        CGFloat genderViewW=SCREEN_WIDTH;
        CGFloat genderViewH=50;
        genderView.frame=CGRectMake(genderViewX, genderViewY, genderViewW, genderViewH);
        genderView.backgroundColor=[UIColor whiteColor];
        [self.scrollView addSubview:genderView];
        self.genderView=genderView;
        
        UIButton *manBtn=[[UIButton alloc] init];
        CGFloat  manBtnW=30;
        CGFloat  manBtnH=30;
        CGFloat  manBtnX=(SCREEN_WIDTH-60)/3;
        CGFloat  manBtnY=(genderViewH-manBtnH)*0.5;
        manBtn.frame=CGRectMake(manBtnX, manBtnY, manBtnW, manBtnH);
        [manBtn setTitle:@"男" forState:UIControlStateNormal];
        [manBtn setTitleColor:ZCColor(255, 150, 29) forState:UIControlStateNormal];
        [manBtn addTarget:self action:@selector(chooseTheMan) forControlEvents:UIControlEventTouchUpInside];
        [genderView addSubview:manBtn];
        
        UIButton *womanBtn=[[UIButton alloc] init];
        CGFloat  womanBtnW=30;
        CGFloat  womanBtnH=30;
        CGFloat  womanBtnX=manBtnX+manBtnW+ manBtnX;
        CGFloat  womanBtnY=(genderViewH-manBtnH)*0.5;
        womanBtn.frame=CGRectMake(womanBtnX, womanBtnY, womanBtnW, womanBtnH);
        [womanBtn setTitle:@"女" forState:UIControlStateNormal];
        [womanBtn setTitleColor:ZCColor(255, 150, 29) forState:UIControlStateNormal];
        [womanBtn addTarget:self action:@selector(chooseTheWoman) forControlEvents:UIControlEventTouchUpInside];
        [genderView addSubview:womanBtn];

        
    }else{
        [self.genderView removeFromSuperview];
        self.opened2=NO;
    }
}

//选择男
-(void)chooseTheMan
{
    self.gender=@"1";
    [self.genderButton setTitle:@"男" forState:UIControlStateNormal];
    
    [self.genderView removeFromSuperview];
    self.opened2=NO;
}
//选择女
-(void)chooseTheWoman
{
   self.gender=@"2";
    [self.genderButton setTitle:@"女" forState:UIControlStateNormal];
    [self.genderView removeFromSuperview];
    self.opened2=NO;
}


//跟换头像
-(void)changePhotoView
{
    UIButton *photoViewBtn=[[UIButton alloc] init];
    CGFloat photoViewBtnX=0;
    CGFloat photoViewBtnY=20;
    CGFloat photoViewBtnW=SCREEN_WIDTH-(2*photoViewBtnX);
    CGFloat photoViewBtnH=82;
    photoViewBtn.frame=CGRectMake(photoViewBtnX, photoViewBtnY, photoViewBtnW, photoViewBtnH);
    
    
//    CGFloat top = 25; // 顶端盖高度
//    CGFloat bottom = 25 ; // 底端盖高度
//    CGFloat left = 10; // 左端盖宽度
//    CGFloat right = 10; // 右端盖宽度
//    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
//    UIImage *image=[UIImage imageNamed:@"grxx_ghtx_bj" ];
//    // 指定为拉伸模式，伸缩后重新赋值
//    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
//    [photoViewBtn setBackgroundImage:image forState:UIControlStateNormal];
//
    
    UIImage *image=[UIImage imageNamed:@"hang_bj_03" ];
    // 指定为拉伸模式，伸缩后重新赋值
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(25,25,10,10) resizingMode:UIImageResizingModeStretch];

    //[photoViewBtn setBackgroundColor:[UIColor whiteColor]];
    [photoViewBtn setBackgroundImage:image forState:UIControlStateNormal];
    [photoViewBtn addTarget:self action:@selector(clickphotoViewBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:photoViewBtn];
    self.photoViewBtn=photoViewBtn;
    
    
    //头像
    UIImageView *photoView=[[UIImageView alloc] init];
    CGFloat photoViewX=10;
    CGFloat photoViewW=60;
    CGFloat photoViewH=60;
    CGFloat photoViewY=(photoViewBtnH-photoViewH)*0.5;
    photoView.frame=CGRectMake(photoViewX, photoViewY, photoViewW, photoViewH);
    photoView.layer.masksToBounds = YES;
    photoView.layer.cornerRadius = 30;
    photoView.image=self.personalImage;
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
    photoLabel.textColor=ZCColor(85, 85, 85);
    [photoViewBtn addSubview:photoLabel];
    

    
    //向右箭头
    UIImageView *rightImageView=[[UIImageView alloc] init];
    
    CGFloat rightImageViewW=10;
    CGFloat rightImageViewH=17;
    CGFloat rightImageViewY=(photoViewBtnH-rightImageViewH)*0.5;
    CGFloat rightImageViewX=photoViewBtnW-rightImageViewW-10;
    rightImageView.frame=CGRectMake(rightImageViewX, rightImageViewY, rightImageViewW, rightImageViewH);
    rightImageView.image=[UIImage imageNamed:@"icon_arrow3"];
    
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
            // [pick setAllowsEditing:YES];
             pick.delegate=self;
             pick.allowsEditing = YES;
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
                   [pick setAllowsEditing:YES];
                  // 3. 展现
                  [self presentViewController:pick animated:YES completion:nil];
               }else{
                   ZCLog(@"相ce不可用");
        
                   // [FXJDyTool showAlertViewWithMessage:@"相册不可用" delegate:self];
                }
    }
}



//时间代理
-(void)datapickerViewDelegate:(UIDatePicker *)datePicker
{
    // 获取用户通过UIDatePicker设置的日期和时间
    NSDate *selected = [datePicker date];
    // 创建一个日期格式器
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // 为日期格式器设置格式字符串
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    // 使用日期格式器格式化日期、时间
    NSString *destDateString = [dateFormatter stringFromDate:selected];
    
    [self.birthdayButton setTitle:destDateString forState:UIControlStateNormal];
    
    //吧时间变成时间濯
     long time=(long)[selected timeIntervalSince1970];
     self.time=time;
    
    
    
    
    // 为日期格式器设置格式字符串
    [dateFormatter setDateFormat:@"yyyy"];
    // 使用日期格式器格式化日期、时间
    NSString *person = [dateFormatter stringFromDate:selected];
    
    int age=[person intValue];
    
    
    // 获取用户通过UIDatePicker设置的日期和时间
    NSDate *nowDate = [NSDate date];
    // 创建一个日期格式器
    NSDateFormatter *nowDateFormatter = [[NSDateFormatter alloc] init];
    // 为日期格式器设置格式字符串
    [nowDateFormatter setDateFormat:@"yyyy"];
    // 使用日期格式器格式化日期、时间
    NSString *nowDateString = [dateFormatter stringFromDate:nowDate];
    
    int now=[nowDateString intValue];
    
    
    if (now-age>0 &&now-age<85) {
        [self.ageNumLabel setTitle:[NSString stringWithFormat:@"%d",now-age] forState:UIControlStateNormal];
    }else if (now-age>85)
    {
        [self.ageNumLabel setTitle:@"85" forState:UIControlStateNormal];
    }
    
    else
    {
        [self.ageNumLabel setTitle:@"0" forState:UIControlStateNormal];
    }
    

    
//    [self.ageNumLabel setTitle:[NSString stringWithFormat:@"%d",now-age] forState:UIControlStateNormal];
}



#pragma mark - 照片选择器代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //[self.photoView.image setImage:info[UIImagePickerControllerOriginalImage] forState:UIControlStateNormal];
    //整个图片
  //  self.photoView.image=info[UIImagePickerControllerOriginalImage];
    //裁剪后的图片
     self.photoView.image=info[UIImagePickerControllerEditedImage];
    
    //ZCLog(@"%@",[self.photoView.image class]);
    // 关闭视图控制器
    [self dismissViewControllerAnimated:YES completion:nil];

   // [self saveImage:info[UIImagePickerControllerOriginalImage] WithName:nil];
    [self pictureUpload];

}
////保存图片
//-(void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName
//{
//    NSData* imageData = UIImagePNGRepresentation(tempImage);
////    　　NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
////    　　NSString* documentsDirectory = [paths objectAtIndex:0];
////    　　// Now we get the full path to the file
////    　　NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
////    　　// and then we write it out
////    　　[imageData writeToFile:fullPathToFile atomically:NO];
//    
//    
//    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *file = [doc stringByAppendingPathComponent:@"imageData.data"];
//    [NSKeyedArchiver archiveRootObject:imageData toFile:file];
//    
//
//}
//
//上传
-(void)pictureUpload
{
//    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *file = [doc stringByAppendingPathComponent:@"imageData.data"];
//    UIImage *im=[NSKeyedUnarchiver unarchiveObjectWithFile:file];AfarHTTPSessionManager

    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
       ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    
  //  NSString *file1 = [doc stringByAppendingPathComponent:@"imageData.data"];
    
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"users/update_portrait.json"];
    
     NSData *imageData = UIImageJPEGRepresentation(self.photoView.image, 0.5);
     NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"]=account.token;
    
     //NSMutableURLRequest *request = [mgr.requestSerializer multipartFormRequestWithMethod:@"PUT" URLString:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
         
   //  }];
    
    
    
     NSMutableURLRequest *request = [mgr.requestSerializer multipartFormRequestWithMethod:@"PUT" URLString:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
         
         [formData appendPartWithFileData:imageData name:@"portrait" fileName:@"asd" mimeType:@"image/jpeg"];
     } error:nil];
    
    
    
    
//    NSMutableURLRequest *request = [mgr.requestSerializer
//                                    multipartFormRequestWithMethod:@"PUT" URLString:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        [formData appendPartWithFileData:imageData name:@"portrait" fileName:file1 mimeType:@"image/jpeg"];
//    }];
//    
//    // 'PUT' and 'POST' convenience methods auto-run, but HTTPRequestOperationWithRequest just
//    // sets up the request. you're responsible for firing it.
    AFHTTPRequestOperation *requestOperation = [mgr HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        
        
        //保存照片到沙盒
        NSString *path=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"personImage.png"];
        NSData *data=UIImagePNGRepresentation(self.photoView.image);
        [data writeToFile:path atomically:YES];
        
        
        ZCLog(@"%@",responseObject);
        // success
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // failure
    }];
    
    // fire the request
    [requestOperation start];
    
    
    
    
    
    
    
    
    
    
    
}


////点击屏幕
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    //if (self.datePicker) {
//        [self.datePicker removeFromSuperview];
//   // }
//}

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self.datePicker removeFromSuperview];
//    
//}

-(void)selfViewClick
{
   [self.datePicker removeFromSuperview];
    [self.view endEditing:YES];
}

//结束编辑事件  （退出键盘）
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //     self.bKeyBoardHide = NO;
    [self.view endEditing:YES];
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
