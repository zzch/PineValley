//
//  ZCQuickScoringViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/1/29.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//选择球场控制器

#import "ZCQuickScoringViewController.h"
#import "ZCChooseThePitchVViewController.h"
#import "AFNetworking.h"
#import "ZCAccount.h"
#import "ZCEvent.h"
@interface ZCQuickScoringViewController ()
@property(nonatomic,strong)NSArray *eventArray;
@end

@implementation ZCQuickScoringViewController


-(NSArray *)eventArray
{
    if (_eventArray==nil) {
        _eventArray=[NSArray array];
    }
    return _eventArray;
}

//-viewdidappear
-(void)viewWillAppear:(BOOL)animated
{

   int a=1;
    if (a==1) {
        UITableView *tableVc=[[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        [self.view addSubview:tableVc];
    }
    
    ///v1/matches.json   page   接口
    
    //2.发送网络请求
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    
    mgr.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"text/plain",@"application/xhtml+xml",@"application/xml",@"application/json", nil];

    // 2.封装请求参数
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    //ZCLog(@"%@-------",account.token);
    // 说明服务器返回的JSON数据
    // mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"page"]=@"1";
    params[@"token"]=account.token;

    [mgr GET:@"http://augusta.aforeti.me/api/v1/matches.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        ZCLog(@"----%@",responseObject);
        
       // NSMutableArray *ev
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ZCLog(@"获取数据失败");
    }];

}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
   if(self)
   {
      
       self.hidesBottomBarWhenPushed=YES;
       self.navigationItem.title=@"快捷记分卡";
      UIBarButtonItem *newBar= [[UIBarButtonItem alloc] initWithTitle:@"新建" style:UIBarButtonItemStyleDone target:self action:@selector(chooseThePitch)];
       
       self.navigationItem.rightBarButtonItem =newBar;
      
       // 修改下一个界面返回按钮的文字
       self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
      
       
   }
    return self;
}
//点击新建跳转到选择球场页面
-(void)chooseThePitch
{
    ZCChooseThePitchVViewController *chooes=[[ZCChooseThePitchVViewController alloc] init];
    [self.navigationController pushViewController:chooes animated:YES];
    

}


- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    
    UILabel *seelabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 300, 350, 20)];

    seelabel.text=  @"您还没有记分卡，点击右上角新建按钮创建记分卡";
    seelabel.textColor=[UIColor blackColor];
    //seelabel.textAlignment=13;
    [self.view addSubview:seelabel];
    
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
