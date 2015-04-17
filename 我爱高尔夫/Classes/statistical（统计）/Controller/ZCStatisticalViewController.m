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
@interface ZCStatisticalViewController ()
@property(nonatomic,strong)ZCHomePageStatistics *homePageStatistics;
@end

@implementation ZCStatisticalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self onlineData];
    
}


//网络请求
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
    
    
    params[@"token"]=account.token;
    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"statistics.json"];
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        ZCHomePageStatistics *homePageStatistics=[ZCHomePageStatistics homePageStatisticsWithDict:responseObject];
        self.homePageStatistics=homePageStatistics;
        //添加控件
        [self addControls];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];


}


-(void)addControls
{
   //顶部View
    UIView *topView=[[UIView alloc] init];
    CGFloat topViewX=0;
    CGFloat topViewY=10;
    CGFloat topViewW=SCREEN_WIDTH;
    CGFloat topViewH=100;
    topView.frame=CGRectMake(topViewX, topViewY, topViewW, topViewH);
    [self.view addSubview:topView];
    
    [self topviewControls:topView];
    
    
    //中部View
    ZCGraphicsView *middleView=[[ZCGraphicsView alloc] init];
    //UIView *middleView=[[UIView alloc] init];
    middleView.backgroundColor=[UIColor redColor];
    CGFloat middleViewX=0;
    CGFloat middleViewY=topViewY+topViewH;
    CGFloat middleViewW=SCREEN_WIDTH;
    CGFloat middleViewH=250;
    middleView.frame=CGRectMake(middleViewX, middleViewY, middleViewW, middleViewH);
    [self.view addSubview:middleView];
    
    
    //底部View
    UIView *bottomView=[[UIView alloc] init];
    bottomView.backgroundColor=[UIColor yellowColor];
    CGFloat bottomViewX=0;
    CGFloat bottomViewY=middleViewY+middleViewH+20;
    CGFloat bottomViewW=SCREEN_WIDTH;
    CGFloat bottomViewH=150;
    bottomView.frame=CGRectMake(bottomViewX, bottomViewY, bottomViewW, bottomViewH);
    [self.view addSubview:bottomView];
    
    [self bottomviewControls:bottomView];


    
}


//底部view
-(void)bottomviewControls:(UIView *)bottomView
{
    UIView *firstView=[[UIView alloc] init];
    firstView.backgroundColor=[UIColor redColor];
    CGFloat firstViewX=40;
    CGFloat firstViewY=0;
    CGFloat firstViewW=120;
    CGFloat firstViewH=bottomView.frame.size.height/3;
    firstView.frame=CGRectMake(firstViewX, firstViewY, firstViewW, firstViewH);
    [bottomView addSubview:firstView];
    
    [self addChildControls:firstView imageStr:@"20141118042246536.jpg" numberStr:[NSString stringWithFormat:@"%@",self.homePageStatistics.double_eagle] nameStr:@"信天翁"];
    
    UIView *secendView=[[UIView alloc] init];
    secendView.backgroundColor=[UIColor blackColor];
    CGFloat secendViewX=firstViewX;
    CGFloat secendViewY=firstViewY+firstViewH;
    CGFloat secendViewW=firstViewW;
    CGFloat secendViewH=firstViewH;
    secendView.frame=CGRectMake(secendViewX, secendViewY, secendViewW, secendViewH);
    [bottomView addSubview:secendView];
    
    [self addChildControls:secendView imageStr:@"20141118042246536.jpg" numberStr:[NSString stringWithFormat:@"%@",self.homePageStatistics.eagle] nameStr:@"老鹰"];
    
    
    UIView *thirdView=[[UIView alloc] init];
    thirdView.backgroundColor=[UIColor brownColor];
    CGFloat thirdViewX=firstViewX;
    CGFloat thirdViewY=secendViewY+secendViewH;
    CGFloat thirdViewW=firstViewW;
    CGFloat thirdViewH=firstViewH;
    thirdView.frame=CGRectMake(thirdViewX, thirdViewY, thirdViewW, thirdViewH);
    [bottomView addSubview:thirdView];
    
    [self addChildControls:thirdView imageStr:@"20141118042246536.jpg" numberStr:[NSString stringWithFormat:@"%@",self.homePageStatistics.birdie] nameStr:@"小鸟"];
    
    
    UIView *fourthView=[[UIView alloc] init];
    fourthView.backgroundColor=[UIColor blackColor];
    CGFloat fourthViewX=bottomView.frame.size.width/2+20;
    CGFloat fourthViewY=firstViewY;
    CGFloat fourthViewW=firstViewW;
    CGFloat fourthViewH=firstViewH;
    fourthView.frame=CGRectMake(fourthViewX, fourthViewY, fourthViewW, fourthViewH);
    [bottomView addSubview:fourthView];
    [self addChildControls:fourthView imageStr:@"20141118042246536.jpg" numberStr:[NSString stringWithFormat:@"%@",self.homePageStatistics.double_bogey] nameStr:@"双柏忌+"];
    
    
    
    UIView *fifthView=[[UIView alloc] init];
    fifthView.backgroundColor=[UIColor redColor];
    CGFloat fifthViewX=fourthViewX;
    CGFloat fifthViewY=fourthViewY+fourthViewH;
    CGFloat fifthViewW=firstViewW;
    CGFloat fifthViewH=firstViewH;
    fifthView.frame=CGRectMake(fifthViewX, fifthViewY, fifthViewW, fifthViewH);
    [bottomView addSubview:fifthView];
    [self addChildControls:fifthView imageStr:@"20141118042246536.jpg" numberStr:[NSString stringWithFormat:@"%@",self.homePageStatistics.par] nameStr:@"标准"];
    
    
    
    
    UIView *sixthView=[[UIView alloc] init];
    sixthView.backgroundColor=[UIColor redColor];
    CGFloat sixthViewX=fourthViewX;
    CGFloat sixthViewY=fifthViewY+fifthViewH;
    CGFloat sixthViewW=firstViewW;
    CGFloat sixthViewH=firstViewH;
    sixthView.frame=CGRectMake(sixthViewX, sixthViewY, sixthViewW, sixthViewH);
    [bottomView addSubview:sixthView];
    [self addChildControls:sixthView imageStr:@"20141118042246536.jpg" numberStr:[NSString stringWithFormat:@"%@",self.homePageStatistics.bogey] nameStr:@"柏忌"];
    


}



//添加子控件
-(void)addChildControls:(UIView *)childView  imageStr:(NSString *)imageStr  numberStr:(NSString *)numberStr  nameStr:(NSString *)nameStr
{
    UIImageView *imageView=[[UIImageView alloc] init];
    CGFloat imageViewX=5;
    CGFloat imageViewW=30;
    CGFloat imageViewH=30;
    CGFloat imageViewY=(childView.frame.size.height-imageViewH)*0.5;
    imageView.frame=CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    imageView.image=[UIImage imageNamed:imageStr];
    [childView addSubview:imageView];
    
    
    UILabel *numberLabel=[[UILabel alloc ] init];
    CGFloat numberLabelX=imageViewX+imageViewW+10;
    CGFloat numberLabelW=60;
    CGFloat numberLabelH=20;
    CGFloat numberLabelY=5;
    numberLabel.frame=CGRectMake(numberLabelX, numberLabelY, numberLabelW, numberLabelH);
    numberLabel.text=numberStr;
    [childView addSubview:numberLabel];
    
    UILabel *nameLabel=[[UILabel alloc] init];
    CGFloat nameLabelX=numberLabelX+numberLabelW+10;
    CGFloat nameLabelW=60;
    CGFloat nameLabelH=20;
    CGFloat nameLabelY=numberLabelY;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.text=nameStr;
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
    numberLabel.text=number;
    numberLabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:numberLabel];
    
    
    UILabel *nameLabel=[[UILabel alloc] init];
    CGFloat nameLabelX=0;
    CGFloat nameLabelY=numberLabelH;
    CGFloat nameLabelW=view.frame.size.width;
    CGFloat nameLabelH=view.frame.size.height/2;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.text=name;
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
