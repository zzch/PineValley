//
//  ZCResultsViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/4/21.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCResultsViewController.h"
#import "ZCAccount.h"
#import "AFNetworking.h"
#import "ZCResultsModel.h"
#import "ZCEventUuidTool.h"
#import "UIBarButtonItem+DC.h"
@interface ZCResultsViewController ()
@property(nonatomic,weak)UIScrollView *scrollView;
@property(nonatomic,strong)ZCResultsModel *resultsModel;
@end

@implementation ZCResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title=@"分析结果";
//    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
//    customLab.textAlignment=NSTextAlignmentCenter;
//    [customLab setTextColor:ZCColor(240, 208, 122)];
//    [customLab setText:@"分析结果"];
//    customLab.font = [UIFont boldSystemFontOfSize:20];
//    self.navigationItem.titleView = customLab;

    
    //返回
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barBtnItemWithNormalImageName:@"suoyou_fanhui" hightImageName:@"ffanhui_anxia" action:@selector(liftBthClick:) target:self];
    //背景颜色suoyou_bj
    self.view.backgroundColor=ZCColor(237, 237, 237);
    
    [self onlineData];
    
    
}



//返回到上个界面
-(void)liftBthClick:(UIButton *)bth
{
    [self.navigationController popViewControllerAnimated:YES];
}



//网络加载
-(void)onlineData
{
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
    
    ZCEventUuidTool *tool=[ZCEventUuidTool sharedEventUuidTool];
    if ([tool.type isEqual:@"1"]) {
         params[@"matches_count"]=self.numberStr;
    }else if ([tool.type isEqual:@"2"])
    {
       
        params[@"date_begin"]=[NSString stringWithFormat:@"%@",self.timeDict[@"startTime"]];
        params[@"date_end"]=[NSString stringWithFormat:@"%@",self.timeDict[@"endTime"]];
    }else if ([tool.type isEqual:@"3"])
    {
    params[@"venue_uuid"]=self.uuid;
    }
    
    
   
    params[@"token"]=account.token;//POST /v1/statistics/customize.json
    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"statistics/customize.json"];
    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        ZCLog(@"%@",[responseObject[@"finished_count"] class]);
        
        if ([responseObject[@"finished_count"] intValue] ==0) {
            //ZCLog(@"11111");
            UILabel *label1=[[UILabel alloc] init];
            label1.text=@"您没有数据，请添加完整场次数据";
            label1.textColor=ZCColor(85, 85, 85);
            label1.font=[UIFont systemFontOfSize:15];
            label1.textAlignment=NSTextAlignmentCenter;
            
            label1.frame=self.view.bounds;
            [self.view addSubview:label1];
            
        }else
        {
            
            ZCResultsModel *resultsModel=[ZCResultsModel resultsModelWithDict:responseObject];
            self.resultsModel=resultsModel;

            [self addControls];

        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}

//添加控件
-(void)addControls
{
    
    UIScrollView *scrollView=[[UIScrollView alloc] init];
    scrollView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    //scrollView.frame=  [ UIScreen mainScreen ].bounds ;
    self.scrollView=scrollView;
    [self.view addSubview:scrollView];
    
    
    
    
    UIView *topView=[[UIView alloc] init];
    CGFloat topViewX=0;
    CGFloat topViewY=0;
    CGFloat topViewW=SCREEN_WIDTH;
    CGFloat topViewH=50;
    topView.frame=CGRectMake(topViewX, topViewY, topViewW, topViewH);
    topView.backgroundColor=[UIColor whiteColor];
    [self.scrollView addSubview:topView];
    
    [self addChildControls:topView firstLabelStr:[NSString stringWithFormat:@"%@",self.name] secondLabelStr:[NSString stringWithFormat:@"完整场次%@场",self.resultsModel.finished_count]];
    //划线
    [self blackgroundLine:topView];
    
    UIView *topSecondView=[[UIView alloc] init];
    CGFloat topSecondViewX=topViewX;
    CGFloat topSecondViewY=topViewH;
    CGFloat topSecondViewW=SCREEN_WIDTH;
    CGFloat topSecondViewH=50;
    topSecondView.backgroundColor=[UIColor whiteColor];
    topSecondView.frame=CGRectMake(topSecondViewX, topSecondViewY, topSecondViewW, topSecondViewH);
    [self.scrollView addSubview:topSecondView];
    [self addChildControls:topSecondView firstLabelStr:@"平均杆数" secondLabelStr:[NSString stringWithFormat:@"%@",self.resultsModel.score]];
    //划线
    [self blackgroundLine:topSecondView];

    UIView *topThirdView=[[UIView alloc] init];
    CGFloat topThirdViewX=topViewX;
    CGFloat topThirdViewY=topSecondViewY+topSecondViewH;
    CGFloat topThirdViewW=SCREEN_WIDTH;
    CGFloat topThirdViewH=topViewH;
    topThirdView.frame=CGRectMake(topThirdViewX, topThirdViewY, topThirdViewW, topThirdViewH);
    topThirdView.backgroundColor=[UIColor whiteColor];
    [self.scrollView addSubview:topThirdView];
    [self addChildControls:topThirdView firstLabelStr:@"差点" secondLabelStr:[NSString stringWithFormat:@"%@",self.resultsModel.handicap]];
    //划线
    [self blackgroundLine:topThirdView];
    
    
    UIView *forthView=[[UIView alloc] init];
    CGFloat forthViewX=topViewX;
    CGFloat forthViewY=topThirdViewY+topThirdViewH+15;
    CGFloat forthViewW=SCREEN_WIDTH;
    CGFloat forthViewH=358;
    forthView.frame=CGRectMake(forthViewX, forthViewY, forthViewW, forthViewH);
    forthView.backgroundColor=ZCColor(170, 170, 170);
    [self.scrollView addSubview:forthView];
    //添加里面空间
    [self forthViewControls:forthView];
    
    
    UIView *fifthView=[[UIView alloc] init];
    CGFloat fifthViewX=topViewX;
    CGFloat fifthViewY=forthViewY+forthViewH+15;
    CGFloat fifthViewW=SCREEN_WIDTH;
    CGFloat fifthViewH=154;
    fifthView.frame=CGRectMake(fifthViewX, fifthViewY, fifthViewW, fifthViewH);
    fifthView.backgroundColor=ZCColor(170, 170, 170);
    [self.scrollView addSubview:fifthView];
    //添加里面空间
    [self fifthViewControls:fifthView];
    
    
    
    UIView *sixthView=[[UIView alloc] init];
    CGFloat sixthViewX=topViewX;
    CGFloat sixthViewY=fifthViewY+fifthViewH+15;
    CGFloat sixthViewW=SCREEN_WIDTH;
    CGFloat sixthViewH=307;
    sixthView.frame=CGRectMake(sixthViewX, sixthViewY, sixthViewW, sixthViewH);
    sixthView.backgroundColor=ZCColor(170, 170, 170);
    [self.scrollView addSubview:sixthView];
    //添加里面空间
    [self sixthViewControls:sixthView];

    self.scrollView.contentSize = CGSizeMake(0, sixthViewY+sixthViewH+60);
}

//背景线
-(void)blackgroundLine:(UIView*)view
{
    UIView *bjView=[[UIView alloc] init];
    bjView.frame=CGRectMake(0, view.frame.size.height-1, SCREEN_WIDTH, 1);
    bjView.backgroundColor=ZCColor(170, 170, 170);
    [view addSubview:bjView];
}


//第4个 View里的控件
-(void)forthViewControls:(UIView *)view
{
    
    // 0.总列数(一行最多3列)
    int totalColumns = 1;
    
    // 1.数字的尺寸
    CGFloat appW = SCREEN_WIDTH;
    CGFloat appH = (view.frame.size.height-8)/7;
    
    // 2.间隙 = (控制器view的宽度 - 3 * 应用宽度) / 4
    //CGFloat marginX = (self.view.frame.size.width - totalColumns * appW) / (totalColumns + 1);
    CGFloat marginX = 0;
    CGFloat marginY = 1;
    
    for (int index=0; index<7; index++) {
        UIButton *button=[[UIButton alloc] init];
       // [button setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"suoyou_bj_02"]]];
        // 3.2.计算框框的位置
        // 计算行号和列号
        int row = index / totalColumns;
        int col = index % totalColumns;
        // 计算x和y
        CGFloat appX = marginX + col * (appW + marginX);
        CGFloat appY = row * (appH + marginY)+marginY;
        // 设置frame
        button.frame = CGRectMake(appX, appY, appW, appH);
        [view addSubview:button];
        
        
        
        UILabel *Label1=[[UILabel alloc] init];
        Label1.frame=CGRectMake(10,0 , 190, button.frame.size.height);
        
        Label1.textColor=ZCColor(34, 34, 34);
        [button addSubview:Label1];
        
        [button setBackgroundColor:[UIColor whiteColor]];
        //创建下面文字
        UILabel *Label2=[[UILabel alloc] init];
       // Label2.frame=CGRectMake(button.frame.size.width-100,0 , 50, button.frame.size.height);
        
        
        Label2.frame=CGRectMake(button.frame.size.width-80,0 , 70, button.frame.size.height);
        
        Label2.textColor=ZCColor(34, 34, 34);
        Label2.textAlignment=NSTextAlignmentRight;
        [button addSubview:Label2];
        
//        UIImageView *rightImage=[[UIImageView alloc] init];
//        rightImage.frame=CGRectMake(Label2.frame.size.width+Label2.frame.origin.x, 0, 40, button.frame.size.height);
//        rightImage.image=[UIImage imageNamed:@"weizhi"];
//        [button addSubview:rightImage];
        
        
        
        
        if (index==0) {
            Label1.text=@"开球距离";
            Label2.text=[NSString stringWithFormat:@"%@",self.resultsModel.average_drive_length];
        }else if (index==1)
        {
            Label1.text=@"开球命中率";
            Label2.text=[NSString stringWithFormat:@"%@",self.resultsModel.drive_fairways_hit];
            
        }else if (index==2)
        {
            Label1.text=@"攻果岭率";
           Label2.text=[NSString stringWithFormat:@"%@",self.resultsModel.gir];
        }else if (index==3)
        {
            Label1.text=@"反弹率";
            Label2.text=[NSString stringWithFormat:@"%@",self.resultsModel.bounce];
        }else if (index==4)
        {
            Label1.text=@"优势转化率(小鸟球)";
            Label2.text=[NSString stringWithFormat:@"%@",self.resultsModel.advantage_transformation];
        }else if (index==5)
        {
            Label1.text=@"标准杆上果岭平均推杆数";
            Label2.text=[NSString stringWithFormat:@"%@",self.resultsModel.putts_per_gir];
        }else if (index==6)
        {
           Label1.text=@"平均推杆数";
            Label2.text=[NSString stringWithFormat:@"%@",self.resultsModel.putts];
        }
        
   }
    
    
    
}




//第5个 View里的控件
-(void)fifthViewControls:(UIView *)view
{
    
    // 0.总列数(一行最多3列)
    int totalColumns = 1;
    
    // 1.数字的尺寸
    CGFloat appW = SCREEN_WIDTH;
    CGFloat appH = (view.frame.size.height-4)/3;
    
    // 2.间隙 = (控制器view的宽度 - 3 * 应用宽度) / 4
    //CGFloat marginX = (self.view.frame.size.width - totalColumns * appW) / (totalColumns + 1);
    CGFloat marginX = 0;
    CGFloat marginY = 1;
    
    for (int index=0; index<3; index++) {
        UIButton *button=[[UIButton alloc] init];
        
        // 3.2.计算框框的位置
        // 计算行号和列号
        int row = index / totalColumns;
        int col = index % totalColumns;
        // 计算x和y
        CGFloat appX = marginX + col * (appW + marginX);
        CGFloat appY = row * (appH + marginY)+marginY;
        // 设置frame
        button.frame = CGRectMake(appX, appY, appW, appH);
        [view addSubview:button];
        
       [button setBackgroundColor:[UIColor whiteColor]];
        
        UILabel *Label1=[[UILabel alloc] init];
        Label1.frame=CGRectMake(10,0 , 190, button.frame.size.height);
        
        Label1.textColor=ZCColor(34, 34, 34);
        [button addSubview:Label1];
        
        
        //创建下面文字
        UILabel *Label2=[[UILabel alloc] init];
      //  Label2.frame=CGRectMake(button.frame.size.width-100,0 , 50, button.frame.size.height);
        Label2.frame=CGRectMake(button.frame.size.width-60,0 , 50, button.frame.size.height);
        Label2.textColor=ZCColor(34, 34, 34);
        Label2.textAlignment=NSTextAlignmentRight;
        [button addSubview:Label2];
        
//        UIImageView *rightImage=[[UIImageView alloc] init];
//        rightImage.frame=CGRectMake(Label2.frame.size.width+Label2.frame.origin.x, 0, 40, button.frame.size.height);
//        rightImage.image=[UIImage imageNamed:@"weizhi"];
//        [button addSubview:rightImage];
        
        
        
        
        if (index==0) {
            Label1.text=@"3杆洞";
            Label2.text=[NSString stringWithFormat:@"%@",self.resultsModel.score_par_3];
        }else if (index==1)
        {
            Label1.text=@"4杆洞";
             Label2.text=[NSString stringWithFormat:@"%@",self.resultsModel.score_par_4];
            
        }else if (index==2)
        {
            Label1.text=@"5杆洞";
             Label2.text=[NSString stringWithFormat:@"%@",self.resultsModel.score_par_5];
        }
    }
    
    
    
}

//第6个 View里的控件
-(void)sixthViewControls:(UIView *)view
{
    
    // 0.总列数(一行最多3列)
    int totalColumns = 1;
    
    // 1.数字的尺寸
    CGFloat appW = SCREEN_WIDTH;
    CGFloat appH = (view.frame.size.height-7)/6;
    
    // 2.间隙 = (控制器view的宽度 - 3 * 应用宽度) / 4
    //CGFloat marginX = (self.view.frame.size.width - totalColumns * appW) / (totalColumns + 1);
    CGFloat marginX = 0;
    CGFloat marginY = 1;
    
    for (int index=0; index<6; index++) {
        UIButton *button=[[UIButton alloc] init];
        
        // 3.2.计算框框的位置
        // 计算行号和列号
        int row = index / totalColumns;
        int col = index % totalColumns;
        // 计算x和y
        CGFloat appX = marginX + col * (appW + marginX);
        CGFloat appY = row * (appH + marginY)+marginY;
        // 设置frame
        button.frame = CGRectMake(appX, appY, appW, appH);
        [view addSubview:button];
        
        [button setBackgroundColor:[UIColor whiteColor]];
        
        UILabel *Label1=[[UILabel alloc] init];
        Label1.frame=CGRectMake(10,0 , 190, button.frame.size.height);
        
        Label1.textColor=ZCColor(34, 34, 34);
        [button addSubview:Label1];
        
        
        //创建下面文字
        UILabel *Label2=[[UILabel alloc] init];
       // Label2.frame=CGRectMake(button.frame.size.width-100,0 , 50, button.frame.size.height);
        Label2.frame=CGRectMake(button.frame.size.width-60,0 , 50, button.frame.size.height);
        
        Label2.textColor=ZCColor(34, 34, 34);
        Label2.textAlignment=NSTextAlignmentRight;
        [button addSubview:Label2];
        
//        UIImageView *rightImage=[[UIImageView alloc] init];
//        rightImage.frame=CGRectMake(Label2.frame.size.width+Label2.frame.origin.x, 0, 40, button.frame.size.height);
//        rightImage.image=[UIImage imageNamed:@"weizhi"];
//        [button addSubview:rightImage];
//        
        
        
        
        if (index==0) {
            Label1.text=@"信天翁球";
            Label2.text=[NSString stringWithFormat:@"%@",self.resultsModel.double_eagle];
        }else if (index==1)
        {
            Label1.text=@"老鹰球";
           Label2.text=[NSString stringWithFormat:@"%@",self.resultsModel.eagle];
            
        }else if (index==2)
        {
            Label1.text=@"小鸟球";
            Label2.text=[NSString stringWithFormat:@"%@",self.resultsModel.birdie];
        }else if (index==3)
        {
            Label1.text=@"标准杆数";
             Label2.text=[NSString stringWithFormat:@"%@",self.resultsModel.par];
        }else if (index==4)
        {
            Label1.text=@"柏忌数";
            Label2.text=[NSString stringWithFormat:@"%@",self.resultsModel.bogey];
        }else if (index==5)
        {
            Label1.text=@"双柏忌+";
            Label2.text=[NSString stringWithFormat:@"%@",self.resultsModel.double_bogey];
        }
    }
    
    
    
}



//添加子控件
-(void)addChildControls:(UIView *)view firstLabelStr:(NSString *)firstStr secondLabelStr:(NSString *)secondStr
{
    UILabel *firstLabel=[[UILabel alloc] init];
    CGFloat firstLabelX=10;
    CGFloat firstLabelY=0;
    CGFloat firstLabelW=300;
    CGFloat firstLabelH=view.frame.size.height;
    firstLabel.frame=CGRectMake(firstLabelX, firstLabelY, firstLabelW, firstLabelH);
    firstLabel.text=firstStr;
    firstLabel.textColor=ZCColor(34, 34, 34);
    [view addSubview:firstLabel];
    
    
    
    UILabel *secondLabel=[[UILabel alloc] init];
    
    CGFloat secondLabelY=0;
    CGFloat secondLabelW=100;
    CGFloat secondLabelH=view.frame.size.height;
    CGFloat secondLabelX=SCREEN_WIDTH-secondLabelW-10;
    secondLabel.frame=CGRectMake(secondLabelX, secondLabelY, secondLabelW, secondLabelH);
    secondLabel.text=secondStr;
    secondLabel.textColor=ZCColor(34, 34, 34);
    secondLabel.textAlignment=NSTextAlignmentRight;
    [view addSubview:secondLabel];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
