//
//  ZCpasswordViewController.m
//  iGolf
//
//  Created by hh on 15/5/14.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCpasswordViewController.h"
#import "ZCAccount.h"
#import "AFNetworking.h"
#import "UIBarButtonItem+DC.h"
#import "ZCprompt.h"
#import "ZCScorecardTableViewController.h"
#import "ZCToJoinTheGameTableViewController.h"
@interface ZCpasswordViewController ()
@property(nonatomic,strong)NSMutableArray *passLabelArray;
@property(nonatomic,weak)UITextField *hiddenTextField;
@end

@implementation ZCpasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"加入比赛";
    self.view.backgroundColor=ZCColor(237, 237, 237);
    
   

    [self addControls];
    
}




/**
 *  加载控件
 */
-(void)addControls
{
    CGFloat firstLable1W=SCREEN_WIDTH;
    CGFloat firstLable1H=25;
    CGFloat firstLable1X=0;
    CGFloat firstLable1Y=SCREEN_HEIGHT*0.04;
    UILabel *firstLable1=[[UILabel alloc] init];
    firstLable1.frame=CGRectMake(firstLable1X, firstLable1Y, firstLable1W, firstLable1H);
    firstLable1.text=@"您的比赛口令密码为以下4位数字";
    firstLable1.textAlignment=NSTextAlignmentCenter;
    firstLable1.textColor=ZCColor(85, 85, 85);
    [self.view addSubview:firstLable1];
    
    //设置影藏的TextField
    UITextField *hiddenTextField=[[UITextField alloc] init];
    hiddenTextField.hidden=YES;
    hiddenTextField.frame=firstLable1.frame;
    [self.view addSubview:hiddenTextField ];
    self.hiddenTextField=hiddenTextField;
    [hiddenTextField addTarget:self action:@selector(hiddenTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    hiddenTextField.keyboardType=UIKeyboardTypeNumberPad;
    //设置为第一响应者
    [_hiddenTextField becomeFirstResponder];
    
    UILabel *secondLabel=[[UILabel alloc] init];
    secondLabel.frame=CGRectMake(0, firstLable1Y+firstLable1H+7, firstLable1W, 25);
    secondLabel.textAlignment=NSTextAlignmentCenter;
    secondLabel.text=@"Ta输入后即可加入到您的比赛";
    secondLabel.textColor=ZCColor(85, 85, 85);
    [self.view addSubview:secondLabel];
    
    
    CGFloat view1X=0;
    CGFloat view1Y=secondLabel.frame.size.height+secondLabel.frame.origin.y+10;
    CGFloat view1W=SCREEN_WIDTH;
    CGFloat view1H=60;
    UIView *view1=[[UIView alloc] initWithFrame:CGRectMake(view1X, view1Y, view1W, view1H)];
    [self.view addSubview:view1];
    
    
    
    //宽高
    CGFloat  passLabelW=45;
    CGFloat  passLabelH=45;
    //间距
    CGFloat spacing=(SCREEN_WIDTH-(4*passLabelW))/5;
    
    self.passLabelArray =[NSMutableArray array];
    for (int index=0; index<4; index++) {
        UILabel *passTextField=[[UILabel alloc] init];
        
        passTextField.frame=CGRectMake(spacing+((passLabelW+spacing)*index), 0, passLabelW, passLabelH);
        [view1 addSubview:passTextField];
        
        [self.passLabelArray addObject:passTextField];
        //passTextField.backgroundColor=[UIColor redColor];
        passTextField.textAlignment=NSTextAlignmentCenter;
        
        passTextField.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"yqhy_mima"]];
        passTextField.font=[UIFont systemFontOfSize:25];
        passTextField.textColor=ZCColor(255, 150, 29);
       
    }
    
    
    }
    
    
-(void)hiddenTextFieldDidChange:(UITextField *)TextField
{
        NSString *passwordText=_hiddenTextField.text;// 当前输入的密码
    
    ZCLog(@"%@",passwordText);
    if (passwordText.length == _passLabelArray.count)
    {
        [TextField resignFirstResponder];// 输入完毕
        //密码验证
        [self passwordIsCorrect];
    }

   NSString *passwordChar;
    for (NSInteger i = 0; i < _passLabelArray.count; i++) {
        
        UITextField *textField = _passLabelArray[i];
        if (i<passwordText.length) {
            passwordChar = [passwordText substringWithRange:NSMakeRange(i, 1)];
            textField.text = passwordChar;
        }else
        {
        textField.text = nil;
        }
        
       
        

        
    }
    

}






//网络请求进行验证密码的正确性
-(void) passwordIsCorrect
{
    
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    params[@"password"]=self.hiddenTextField.text;
    // ZCLog(@"%@",[self.eventArray[indexPath.row] uuid]);
    params[@"token"]=account.token;
    
    ///v1/matches/show.json
    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"matches/verify.json"];
    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        ZCLog(@"%@",responseObject);
        ZCLog(@"%@",responseObject[@"message"]);
        if (responseObject[@"error_code"] ) {
            
            [ZCprompt prompt:self andErrorCode:[NSString stringWithFormat:@"%@",responseObject[@"error_code"]]];
            self.hiddenTextField.text=nil;
            [self hiddenTextFieldDidChange:nil];
            //设置为第一响应者
            [_hiddenTextField becomeFirstResponder];

            
        }else{
            
            
            ZCToJoinTheGameTableViewController *ToJoinTheGame=[[ZCToJoinTheGameTableViewController alloc] init];
            
            ToJoinTheGame.uuid=responseObject[@"uuid"];
            
            [self.navigationController pushViewController:ToJoinTheGame animated:YES];

        }
        
        
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
