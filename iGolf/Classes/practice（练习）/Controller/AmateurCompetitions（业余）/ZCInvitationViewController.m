//
//  ZCInvitationViewController.m
//  iGolf
//
//  Created by hh on 15/5/14.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCInvitationViewController.h"
#import "ZCAccount.h"
#import "AFNetworking.h"
#import "UIBarButtonItem+DC.h"
#import "ZCScorecardTableViewController.h"
@interface ZCInvitationViewController ()
@property(nonatomic,strong)NSMutableArray *passLabelArray;
@property(nonatomic,copy) NSString *password;
@property(nonatomic,assign) long expired_at;
@end

@implementation ZCInvitationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor=ZCColor(237, 237, 237);
    
    //返回
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barBtnItemWithNormalImageName:@"suoyou_fanhui" hightImageName:@"ffanhui_anxia" action:@selector(liftBthClick:) target:self];
    

    
    
    
    //网络加载
    [self initDataOline];
    
}



//返回到上个界面
-(void)liftBthClick:(UIButton *)bth
{
    NSInteger index= self.navigationController.viewControllers.count;
   // ZCLog(@"%ld",self.isYes);
    
    
    if (self.isYes==YES) {
        ZCScorecardTableViewController *vc = self.navigationController.viewControllers[index-2];
        //ZCScorecardTableViewController *vc=[[ZCScorecardTableViewController alloc] init];
        [self.navigationController popToViewController:vc animated:YES
         ];

    }else
    {
        ZCScorecardTableViewController *vc = self.navigationController.viewControllers[index-3];
        //ZCScorecardTableViewController *vc=[[ZCScorecardTableViewController alloc] init];
        [self.navigationController popToViewController:vc animated:YES
         ];

    }
    
    
    
    
   // [self.navigationController popViewControllerAnimated:YES];
}




//网络加载
-(void)initDataOline
{

    
    
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    params[@"uuid"]=self.uuid;
    // ZCLog(@"%@",[self.eventArray[indexPath.row] uuid]);
    params[@"token"]=account.token;
    
    ///v1/matches/show.json
    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"matches/password.json"];
    
    
    
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        
        self.password=responseObject[@"password"];
        self.expired_at=[responseObject[@"expired_at"] longValue];
        
        
        [self addControls];
        ZCLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

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
    
   
    for (int index=0; index<4; index++) {
        UILabel *passLabel=[[UILabel alloc] init];
        
        passLabel.frame=CGRectMake(spacing+((passLabelW+spacing)*index), 0, passLabelW, passLabelH);
        [view1 addSubview:passLabel];
        
        
        passLabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"yqhy_mima"]];
;
        passLabel.textAlignment=NSTextAlignmentCenter;
        passLabel.font=[UIFont systemFontOfSize:25];
        passLabel.textColor=ZCColor(255, 150, 29);
        
        NSString *passwordChar;
        if (index < self.password.length)
            passwordChar = [self.password substringWithRange:NSMakeRange(index, 1)];
        passLabel.text = passwordChar;
        
    }
    
   
    
    
    
    
    
    
//    
//    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    [fmt setDateFormat:@"HH时mm分ss秒 "];
//    NSDate *confromTimesp=[NSDate dateWithTimeIntervalSince1970:self.expired_at];
//    NSString *confromTimespStr=[fmt stringFromDate:confromTimesp];
//    ZCLog(@"%@",confromTimespStr);
//    
//    
//    CGFloat thirdLableW=SCREEN_WIDTH;
//    CGFloat thirdLableH=25;
//    CGFloat thirdLableX=0;
//    CGFloat thirdLableY=view1Y+view1H+20;
//    UILabel *thirdLable=[[UILabel alloc] init];
//    thirdLable.frame=CGRectMake(thirdLableX, thirdLableY, thirdLableW, thirdLableH);
//    thirdLable.text=[NSString stringWithFormat:@"口令密码有效期到%@",confromTimespStr];
//    thirdLable.textAlignment=NSTextAlignmentCenter;
//    thirdLable.textColor=ZCColor(85, 85, 85);
//    [self.view addSubview:thirdLable];
//    
//    
//    UILabel *forthLabel=[[UILabel alloc] init];
//    forthLabel.frame=CGRectMake(0, thirdLableY+thirdLableH+3, firstLable1W, 25);
//    forthLabel.textAlignment=NSTextAlignmentCenter;
//    forthLabel.text=@"过期后可继续获取新口令密码";
//    forthLabel.textColor=ZCColor(85, 85, 85);
//    [self.view addSubview:forthLabel];
//    
    
    
    
    
    
    UIView *xianView=[[UIView alloc] init];
    xianView.frame=CGRectMake(20, view1Y+view1H+20, SCREEN_WIDTH-40, 1);
    xianView.backgroundColor=ZCColor(170, 170, 170);
    [self.view addSubview:xianView];
    
    
    
    
    UIImageView *firstImageView=[[UIImageView alloc] init];
    CGFloat firstImageViewW=254;
    CGFloat firstImageViewH=102;
    CGFloat firstImageViewX=(SCREEN_WIDTH-firstImageViewW)/2;
    CGFloat firstImageViewY=xianView.frame.origin.y+20;
    firstImageView.frame=CGRectMake(firstImageViewX, firstImageViewY, firstImageViewW, firstImageViewH);
    
    firstImageView.image=[UIImage imageNamed:@"yqhy_jiaru"];
    [self.view addSubview:firstImageView];
    
    
    
    
    
    UIImageView *secondImageView=[[UIImageView alloc] init];
    CGFloat secondImageViewW=254;
    CGFloat secondImageViewH=102;
    CGFloat secondImageViewX=(SCREEN_WIDTH-firstImageViewW)/2;
    CGFloat secondImageViewY=firstImageViewY+firstImageViewH+10;
    secondImageView.frame=CGRectMake(secondImageViewX, secondImageViewY, secondImageViewW, secondImageViewH);
    
    secondImageView.image=[UIImage imageNamed:@"yqhy_yiqibisai"];
    [self.view addSubview:secondImageView];
    
    
    

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
