//
//  ZCStatisticalViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/4/17.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCStatisticalViewController.h"
#import "ZCAccount.h"
#import "AFNetworking.h"
#import "ZCHomePageStatistics.h"
#import "ZCGraphicsView.h"
#import "ZCAnalysisViewController.h"
#import "MBProgressHUD+NJ.h"
@interface ZCStatisticalViewController ()
@property(nonatomic,strong)ZCHomePageStatistics *homePageStatistics;
@property(nonatomic,weak)UIScrollView *scrollView;
@end

@implementation ZCStatisticalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //背景颜色suoyou_bj
    self.view.backgroundColor=ZCColor(237, 237, 237);
    self.navigationItem.title=@"统计";
//    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
//    customLab.textAlignment=NSTextAlignmentCenter;
//    [customLab setTextColor:ZCColor(240, 208, 122)];
//    [customLab setText:@"统计"];
//    customLab.font = [UIFont boldSystemFontOfSize:20];
//    self.navigationItem.titleView = customLab;
    
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc] initWithTitle:@"分析" style:UIBarButtonItemStyleDone target:self action:@selector(clickRight)];
    //改变UIBarButtonItem字体颜色
    [rightButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:ZCColor(240, 208, 122), UITextAttributeTextColor,nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem =rightButton;
    
    
    
    //网络加载
    [self onlineData];
    
}

//点击右边
-(void)clickRight
{
    ZCAnalysisViewController *analysisViewController=[[ZCAnalysisViewController alloc] init];
    analysisViewController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:analysisViewController animated:YES];

}
//网络请求
-(void)onlineData
{
    [MBProgressHUD showMessage:@"加载中..."];
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
    
    
    params[@"token"]=account.token;
    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"statistics.json"];
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        ZCHomePageStatistics *homePageStatistics=[ZCHomePageStatistics homePageStatisticsWithDict:responseObject];
        self.homePageStatistics=homePageStatistics;
        //添加控件
        [self addControls];
        [MBProgressHUD hideHUD];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUD];
    }];


}


-(void)addControls
{
    
    UIScrollView *scrollView=[[UIScrollView alloc] init];
    scrollView.frame=[UIScreen mainScreen].bounds;
    self.scrollView=scrollView;
    [self.view addSubview:scrollView];
    
    
    
   //顶部View
    UIImageView *topView=[[UIImageView alloc] init];
    CGFloat topViewX=10;
    CGFloat topViewY=20;
    CGFloat topViewW=SCREEN_WIDTH-20;
    CGFloat topViewH=120;
    topView.frame=CGRectMake(topViewX, topViewY, topViewW, topViewH);
    //topView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"tj_kuang"]];
    topView.image=[UIImage imageNamed:@"tongji_bizhengti"];
    [self.scrollView addSubview:topView];
    
    [self topviewControls:topView];
    
   
    //中部View
    ZCGraphicsView *middleView=[[ZCGraphicsView alloc] init];
    //UIView *middleView=[[UIView alloc] init];
    //middleView.backgroundColor=[UIColor redColor];
    CGFloat middleViewX=0;
    CGFloat middleViewY=topViewY+topViewH+20;
    CGFloat middleViewW=SCREEN_WIDTH;
    CGFloat middleViewH=200;
    middleView.frame=CGRectMake(middleViewX, middleViewY, middleViewW, middleViewH);
    [self.scrollView addSubview:middleView];
    
    
    UILabel *scoreNumber=[[UILabel alloc] init];
    scoreNumber.frame=CGRectMake((middleView.frame.size.width-20)/2, (middleView.frame.size.height-13)/2-15, 20, 15);
    scoreNumber.textColor=ZCColor(255, 150, 29);
    if ([self.homePageStatistics.average_score isKindOfClass:[NSNull class]]) {
        scoreNumber.text=@"0";
    }else
    {
    scoreNumber.text=[NSString stringWithFormat:@"%@",self.homePageStatistics.average_score];
    }
    scoreNumber.font=[UIFont systemFontOfSize:13];
    [middleView addSubview:scoreNumber];
    scoreNumber.textAlignment=NSTextAlignmentCenter;
    
    UILabel *scoreName=[[UILabel alloc] init];
    scoreName.frame=CGRectMake((middleView.frame.size.width-20)/2-11, (middleView.frame.size.height-10)/2+5, 40, 15);
    scoreName.textColor=[UIColor whiteColor];
    scoreName.text=@"平均杆数";
    scoreName.font=[UIFont systemFontOfSize:10];
    //scoreName.textAlignment=NSTextAlignmentCenter;
    [middleView addSubview:scoreName];
    
    
    
    //底部View
    UIView *bottomView=[[UIView alloc] init];
    //bottomView.backgroundColor=[UIColor yellowColor];
    CGFloat bottomViewX=0;
    CGFloat bottomViewY=middleViewY+middleViewH+20;
    CGFloat bottomViewW=SCREEN_WIDTH;
    CGFloat bottomViewH=150;
    bottomView.frame=CGRectMake(bottomViewX, bottomViewY, bottomViewW, bottomViewH);
    [self.scrollView addSubview:bottomView];
    
    [self bottomviewControls:bottomView];


  self.scrollView.contentSize = CGSizeMake(0,bottomViewY+bottomViewH+160 );
}


//底部view
-(void)bottomviewControls:(UIView *)bottomView
{
    UIView *firstView=[[UIView alloc] init];
        CGFloat firstViewX=0;
    CGFloat firstViewY=0;
    CGFloat firstViewW=SCREEN_WIDTH/2;
    CGFloat firstViewH=bottomView.frame.size.height/3;
    firstView.frame=CGRectMake(firstViewX, firstViewY, firstViewW, firstViewH);
    [bottomView addSubview:firstView];
    
    [self addChildControls:firstView imageStr:@"jstj_xintianwen" numberStr:[NSString stringWithFormat:@"%@",self.homePageStatistics.double_eagle] nameStr:@"信天翁"];
    
    UIView *secendView=[[UIView alloc] init];
    
    CGFloat secendViewX=firstViewX;
    CGFloat secendViewY=firstViewY+firstViewH;
    CGFloat secendViewW=firstViewW;
    CGFloat secendViewH=firstViewH;
    secendView.frame=CGRectMake(secendViewX, secendViewY, secendViewW, secendViewH);
    [bottomView addSubview:secendView];
    
    [self addChildControls:secendView imageStr:@"jstj_laoying" numberStr:[NSString stringWithFormat:@"%@",self.homePageStatistics.eagle] nameStr:@"老鹰"];
    
    
    UIView *thirdView=[[UIView alloc] init];
    
    CGFloat thirdViewX=firstViewX;
    CGFloat thirdViewY=secendViewY+secendViewH;
    CGFloat thirdViewW=firstViewW;
    CGFloat thirdViewH=firstViewH;
    thirdView.frame=CGRectMake(thirdViewX, thirdViewY, thirdViewW, thirdViewH);
    [bottomView addSubview:thirdView];
    
    [self addChildControls:thirdView imageStr:@"jstj_xiaoniao" numberStr:[NSString stringWithFormat:@"%@",self.homePageStatistics.birdie] nameStr:@"小鸟"];
    
    
    UIView *fourthView=[[UIView alloc] init];
    
    CGFloat fourthViewX=bottomView.frame.size.width/2+20;
    CGFloat fourthViewY=firstViewY;
    CGFloat fourthViewW=firstViewW;
    CGFloat fourthViewH=firstViewH;
    fourthView.frame=CGRectMake(fourthViewX, fourthViewY, fourthViewW, fourthViewH);
    [bottomView addSubview:fourthView];
    [self addChildControls:fourthView imageStr:@"jstj_shuangboji" numberStr:[NSString stringWithFormat:@"%@",self.homePageStatistics.double_bogey] nameStr:@"双柏忌+"];
    
    
    
    UIView *fifthView=[[UIView alloc] init];
    
    CGFloat fifthViewX=fourthViewX;
    CGFloat fifthViewY=fourthViewY+fourthViewH;
    CGFloat fifthViewW=firstViewW;
    CGFloat fifthViewH=firstViewH;
    fifthView.frame=CGRectMake(fifthViewX, fifthViewY, fifthViewW, fifthViewH);
    [bottomView addSubview:fifthView];
    [self addChildControls:fifthView imageStr:@"jstj_biaozhungan" numberStr:[NSString stringWithFormat:@"%@",self.homePageStatistics.par] nameStr:@"标准"];
    
    
    
    
    UIView *sixthView=[[UIView alloc] init];
    
    CGFloat sixthViewX=fourthViewX;
    CGFloat sixthViewY=fifthViewY+fifthViewH;
    CGFloat sixthViewW=firstViewW;
    CGFloat sixthViewH=firstViewH;
    sixthView.frame=CGRectMake(sixthViewX, sixthViewY, sixthViewW, sixthViewH);
    [bottomView addSubview:sixthView];
    [self addChildControls:sixthView imageStr:@"jstj_boji" numberStr:[NSString stringWithFormat:@"%@",self.homePageStatistics.bogey] nameStr:@"柏忌"];
    


}



//添加子控件
-(void)addChildControls:(UIView *)childView  imageStr:(NSString *)imageStr  numberStr:(NSString *)numberStr  nameStr:(NSString *)nameStr
{
    UIImageView *imageView=[[UIImageView alloc] init];
    CGFloat imageViewX=35;
    CGFloat imageViewW=15;
    CGFloat imageViewH=15;
    CGFloat imageViewY=(childView.frame.size.height-imageViewH)*0.5;
    imageView.frame=CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    imageView.image=[UIImage imageNamed:imageStr];
    [childView addSubview:imageView];
    
    
    UILabel *numberLabel=[[UILabel alloc ] init];
    CGFloat numberLabelX=imageViewX+imageViewW+5;
    CGFloat numberLabelW=33;
    CGFloat numberLabelH=20;
    CGFloat numberLabelY=(childView.frame.size.height-numberLabelH)/2;
    numberLabel.frame=CGRectMake(numberLabelX, numberLabelY, numberLabelW, numberLabelH);
    //numberLabel.text=numberStr;
    numberLabel.textColor=[UIColor blackColor];
    [childView addSubview:numberLabel];
    if ([numberStr isEqual:@"<null>"]) {
         numberLabel.text=@"-";
    }else
    {
        
      CGFloat number  =[numberStr doubleValue];
        ZCLog(@"number=%f ",number*100);
        int number1=number*100 ;
    numberLabel.text=[NSString stringWithFormat:@"%d%%",number1];
    }
     numberLabel.font=[UIFont systemFontOfSize:15];
    
    
    
    
    
    
    UILabel *nameLabel=[[UILabel alloc] init];
    CGFloat nameLabelX=numberLabelX+numberLabelW;
    CGFloat nameLabelW=60;
    CGFloat nameLabelH=20;
    CGFloat nameLabelY=numberLabelY;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.textColor=ZCColor(60, 57, 78);
    nameLabel.text=nameStr;
    nameLabel.font=[UIFont systemFontOfSize:15];
    [childView addSubview:nameLabel];
    
    
 }



//顶部view
-(void)topviewControls:(UIView *)topview
{
    //差点
    UIView *almostView=[[UIView alloc] init];
    CGFloat almostViewX=0;
    CGFloat almostViewY=0;
    CGFloat almostViewW=topview.frame.size.width/2;
    CGFloat almostViewH=topview.frame.size.height/2;
    almostView.frame=CGRectMake(almostViewX, almostViewY, almostViewW, almostViewH);
    
    [topview addSubview:almostView];
    [self addModuleView:almostView numberLabel:[NSString stringWithFormat:@"%@",self.homePageStatistics.handicap] nameLabel:@"差点"];
    
    
    //排名ranking
    UIView *rankingView=[[UIView alloc] init];
    CGFloat rankingViewX=almostViewW;
    CGFloat rankingViewY=almostViewY;
    CGFloat rankingViewW=almostViewW;
    CGFloat rankingViewH=almostViewH;
    rankingView.frame=CGRectMake(rankingViewX, rankingViewY, rankingViewW, rankingViewH);
    [topview addSubview:rankingView];
    [self addModuleView:rankingView numberLabel:[NSString stringWithFormat:@"%@",self.homePageStatistics.rank] nameLabel:@"排名"];
    
    //最好成绩
    UIView *bestView=[[UIView alloc] init];
    CGFloat bestViewX=almostViewX;
    CGFloat bestViewY=almostViewH;
    CGFloat bestViewW=almostViewW;
    CGFloat bestViewH=almostViewH;
    bestView.frame=CGRectMake(bestViewX, bestViewY, bestViewW, bestViewH);
    [topview addSubview:bestView];
    [self addModuleView:bestView numberLabel:[NSString stringWithFormat:@"%@",self.homePageStatistics.best_score] nameLabel:@"最好成绩"];
    
    //总成绩场次
    UIView *totalNumberView=[[UIView alloc] init];
    CGFloat totalNumberViewX=rankingViewX;
    CGFloat totalNumberViewY=bestViewY;
    CGFloat totalNumberViewW=almostViewW;
    CGFloat totalNumberViewH=almostViewH;
    totalNumberView.frame=CGRectMake(totalNumberViewX, totalNumberViewY, totalNumberViewW, totalNumberViewH);
    [topview addSubview:totalNumberView];
    [self addModuleView:totalNumberView numberLabel:[NSString stringWithFormat:@"%@/%@",self.homePageStatistics.finished_matches_count,self.homePageStatistics.total_matches_count] nameLabel:@"完成计分/总场次"];

    
}


-(void)addModuleView:(UIView *)view numberLabel:(NSString*)number  nameLabel:(NSString *)name
{
    UILabel *numberLabel=[[UILabel alloc] init];
    CGFloat numberLabelX=0;
    CGFloat numberLabelY=0;
    CGFloat numberLabelW=view.frame.size.width;
    CGFloat numberLabelH=view.frame.size.height/2;
    numberLabel.frame=CGRectMake(numberLabelX, numberLabelY, numberLabelW, numberLabelH);
    
    if ([number isEqual:@"<null>"]) {
        numberLabel.text=@"0";
    }else
    {
    numberLabel.text=number;
    }
    numberLabel.textColor=ZCColor(255, 150, 29);
    numberLabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:numberLabel];
    
    
    UILabel *nameLabel=[[UILabel alloc] init];
    CGFloat nameLabelX=0;
    CGFloat nameLabelY=numberLabelH;
    CGFloat nameLabelW=view.frame.size.width;
    CGFloat nameLabelH=view.frame.size.height/2;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.text=name;
    nameLabel.textColor=ZCColor(85, 85, 85);
    nameLabel.textAlignment=NSTextAlignmentCenter;

    [view addSubview:nameLabel];
    

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
