//
//  ZCFeedbackViewController.m
//  iGolf
//
//  Created by hh on 15/6/12.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCFeedbackViewController.h"
#import "ZCAccount.h"
#import "AFNetworking.h"
@interface ZCFeedbackViewController ()<UITextViewDelegate>
@property(nonatomic,weak)UITextView *textView;
@end

@implementation ZCFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title=@"意见反馈";
    
    //返回
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barBtnItemWithNormalImageName:@"fanhui" hightImageName:@"fanhui" action:@selector(liftBthClicktoback) target:self];
    
    
        UIBarButtonItem *newBar= [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(clickOnTheSubmit)];
        //改变UIBarButtonItem字体颜色
       // [newBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:ZCColor(240, 208, 122), UITextAttributeTextColor,nil] forState:UIControlStateNormal];
        self.navigationItem.rightBarButtonItem =newBar;

    
    
    
    self.view.backgroundColor=ZCColor(237, 237, 237);
    
    UITextView *textView=[[UITextView alloc] init];
    textView.backgroundColor=[UIColor whiteColor];
    textView.frame=CGRectMake(10, 30, SCREEN_WIDTH-20, 200);
    //textView.layer.borderWidth = 2.0;
    textView.delegate=self;
    textView.layer.cornerRadius = 6;
    textView.layer.masksToBounds = YES;
    textView.font=[UIFont  systemFontOfSize:18 ];
//    设置第一响应者
    [textView becomeFirstResponder];
    [self.view addSubview:textView];
    self.textView=textView;
    
    
}



//返回
-(void)liftBthClicktoback
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


//点击提交
-(void)clickOnTheSubmit
{
    
    //显示圈圈
    [MBProgressHUD showMessage:@"数据上传中"];
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
        // ZCLog(@"%@",[self.eventArray[indexPath.row] uuid]);
    params[@"token"]=account.token;
    params[@"content"]=self.textView.text;
    
    ///v1/matches/show.json  content
    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"feedbacks.json"];
    
    //    ZCLog(@"%@",url);
    //    ZCLog(@"%@",account.token);
    //    ZCLog(@"%@",self.uuid);
    
    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        ZCLog(@"%@",responseObject);
       
        if (responseObject[@"error_code"] ) {
            
            [ZCprompt initWithController:self andErrorCode:[NSString stringWithFormat:@"%@",responseObject[@"error_code"]]];
            
        }
        
       
        
        //隐藏圈圈
        [MBProgressHUD hideHUD];
        
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //隐藏圈圈
        [MBProgressHUD hideHUD];
        [ZCprompt initWithController:self andErrorCode:[NSString stringWithFormat:@"%ld",(long)[operation.response statusCode]]];
       
    }];
    
    

    
    

}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.location>=140)
    {
//        UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"您已输入140个字" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles: nil];
//        [alert show];
        ZCLog(@"dasdasdsad");
        return NO;
    }
    else
    {
        return YES;
    }
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
