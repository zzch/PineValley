//
//  ZCAnalysisViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/4/20.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCAnalysisViewController.h"
#import "ZCNumberView.h"
#import "ZCTimeView.h"
#import "ZCStadiumView.h"
#import "ZCResultsViewController.h"
#import "ZCEventUuidTool.h"
@interface ZCAnalysisViewController ()<ZCNumberDelegate,ZCTimeDelegate,ZCStadiumDelegate>
@property(nonatomic,weak)UIButton *firstButton;
@property(nonatomic,weak)UIButton *secondButton;
@property(nonatomic,weak)UIButton *thirdButton;
@property(nonatomic,weak)UILabel *titleLabel;
@property(nonatomic,weak)ZCNumberView *numberView;
@property(nonatomic,weak)ZCTimeView *timeView;
@property(nonatomic,weak)ZCStadiumView *stadiumView;
@end

@implementation ZCAnalysisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor brownColor];
    [self addControls];
    
}


//加载控件
-(void)addControls
{
    UIButton *firstButton=[[UIButton alloc] init];
    CGFloat firstButtonX=0;
    CGFloat firstButtonY=0;
    CGFloat firstButtonW=SCREEN_WIDTH/3;
    CGFloat firstButtonH=40;
    firstButton.frame=CGRectMake(firstButtonX, firstButtonY, firstButtonW, firstButtonH);
    [firstButton setTitle:@"按场次" forState:UIControlStateNormal];
    
    [firstButton setBackgroundColor:[UIColor redColor]];
    [firstButton addTarget:self action:@selector(clickFirstButton) forControlEvents:UIControlEventTouchUpInside];
    self.firstButton=firstButton;
    [self.view addSubview:firstButton];
    
    UIButton *secondButton=[[UIButton alloc] init];
    CGFloat secondButtonX=firstButtonW;
    CGFloat secondButtonY=0;
    CGFloat secondButtonW=firstButtonW;
    CGFloat secondButtonH=firstButtonH;
    secondButton.frame=CGRectMake(secondButtonX, secondButtonY, secondButtonW, secondButtonH);
    [secondButton setTitle:@"按时间" forState:UIControlStateNormal];
    [secondButton addTarget:self action:@selector(clickSecondButton) forControlEvents:UIControlEventTouchUpInside];
    self.secondButton=secondButton;
    [self.view addSubview:secondButton];
    
    
    UIButton *thirdButton=[[UIButton alloc] init];
    CGFloat thirdButtonX=secondButtonX+secondButtonW;
    CGFloat thirdButtonY=0;
    CGFloat thirdButtonW=firstButtonW;
    CGFloat thirdButtonH=firstButtonH;
    thirdButton.frame=CGRectMake(thirdButtonX, thirdButtonY, thirdButtonW, thirdButtonH);
    [thirdButton setTitle:@"按比赛" forState:UIControlStateNormal];
    [thirdButton addTarget:self action:@selector(clickThirdButton) forControlEvents:UIControlEventTouchUpInside];
     self.thirdButton=thirdButton;
    [self.view addSubview:thirdButton];
    
    
    //添加文字提示语言
    UILabel *titleLabel=[[UILabel alloc] init];
    CGFloat titleLabelX=0;
    CGFloat titleLabelY=firstButtonY+firstButtonH+10;
    CGFloat titleLabelW=SCREEN_WIDTH;
    CGFloat titleLabelH=20;
    titleLabel.frame=CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    titleLabel.text=@"所有统计数据将基于您有完整记分场次计算";
    titleLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    self.titleLabel=titleLabel;
    
    
    //按场次
    ZCNumberView *numberView=[[ZCNumberView alloc] init];
    CGFloat numberViewX=0;
    CGFloat numberViewY=titleLabelY+titleLabelH;
    CGFloat numberViewW=SCREEN_WIDTH;
    CGFloat numberViewH=SCREEN_HEIGHT-numberViewY;
    numberView.frame=CGRectMake(numberViewX, numberViewY, numberViewW, numberViewH);
    numberView.delegate=self;
    self.numberView=numberView;
    [self.view addSubview:numberView];


}

//点击按场次
-(void)clickFirstButton
{
    [self.firstButton setBackgroundColor:[UIColor redColor]];
    [self.secondButton setBackgroundColor:[UIColor brownColor]];
    [self.thirdButton setBackgroundColor:[UIColor brownColor]];
    
    
        self.numberView.hidden=NO;
        self.timeView.hidden=YES;
        self.stadiumView.hidden=YES;
   
    

}
//点击按时间
-(void)clickSecondButton
{
    [self.firstButton setBackgroundColor:[UIColor brownColor]];
    [self.secondButton setBackgroundColor:[UIColor redColor]];
    [self.thirdButton setBackgroundColor:[UIColor brownColor]];
    
    
    if (self.timeView==nil) {
        ZCTimeView *timeView=[[ZCTimeView alloc] init];
//        CGFloat numberViewX=0;
//        CGFloat numberViewY=self.titleLabel.frame.origin.y+self.titleLabel.frame.size.height;
//        CGFloat numberViewW=SCREEN_WIDTH;
//        CGFloat numberViewH=SCREEN_HEIGHT-numberViewY;
//        timeView.frame=CGRectMake(numberViewX, numberViewY, numberViewW, numberViewH);
        timeView.frame=self.numberView.frame;
        timeView.delegate=self;
        self.timeView=timeView;
        [self.view addSubview:timeView];
        ZCLog(@"22222");
    }else
    {
        self.numberView.hidden=YES;
        self.timeView.hidden=NO;
        self.stadiumView.hidden=YES;
    }

}
//点击按比赛
-(void)clickThirdButton
{
    [self.firstButton setBackgroundColor:[UIColor brownColor]];
    [self.secondButton setBackgroundColor:[UIColor brownColor]];
    [self.thirdButton setBackgroundColor:[UIColor redColor]];
    
    
    
    if (self.stadiumView==nil) {
        ZCStadiumView *stadiumView=[[ZCStadiumView alloc] init];
//        CGFloat numberViewX=0;
//        CGFloat numberViewY=self.titleLabel.frame.origin.y+self.titleLabel.frame.size.height;
//        CGFloat numberViewW=SCREEN_WIDTH;
//        CGFloat numberViewH=SCREEN_HEIGHT-numberViewY;
//        stadiumView.frame=CGRectMake(numberViewX, numberViewY, numberViewW, numberViewH);
        stadiumView.frame=self.numberView.frame;
        self.stadiumView=stadiumView;
        stadiumView.delegater=self;
        [self.view addSubview:stadiumView];
        
        ZCLog(@"333333");
    }else
    {
        self.numberView.hidden=YES;
        self.timeView.hidden=YES;
        self.stadiumView.hidden=NO;
    }



}


//点击numberView 上的按钮 后调用的代理方法
-(void)numberViewDidClickedButton:(ZCNumberView *)headerView didClickButton:(UIButton *)button
{
    ZCEventUuidTool *tool=[ZCEventUuidTool sharedEventUuidTool];
    tool.type=@"1";
    
    
    ZCResultsViewController *resultsViewController=[[ZCResultsViewController alloc] init];
    if (button.tag==4005) {
        resultsViewController.numberStr=@"5";
        resultsViewController.name=@"最近5场";
    }else if (button.tag==4010)
    {
    resultsViewController.numberStr=@"10";
        resultsViewController.name=@"最近10场";
    }else if (button.tag==4030)
    {
    resultsViewController.numberStr=@"30";
        resultsViewController.name=@"最近30场";
    }else if (button.tag==4050)
    {
        resultsViewController.numberStr=@"50";
        resultsViewController.name=@"最近50场";
    
    }else if (button.tag==4100)
    {
    resultsViewController.numberStr=@"100";
        resultsViewController.name=@"最近100场";
    }else if (button.tag==4101)
    {
    resultsViewController.numberStr=@"all";
        resultsViewController.name=@"全部场次";
    }
    
    [self.navigationController pushViewController:resultsViewController animated:YES];

}

//time页面的代理
-(void)timeViewDidClickedButton:(ZCTimeView *)headerView startTime:(long)startTime andEndTime:(long)endTime
{
    ZCEventUuidTool *tool=[ZCEventUuidTool sharedEventUuidTool];
    tool.type=@"2";
    
    ZCResultsViewController *resultsViewController=[[ZCResultsViewController alloc] init];
    NSMutableDictionary *timeDict = [NSMutableDictionary dictionary];
    
    timeDict[@"startTime"]=[NSString stringWithFormat:@"%ld",startTime];
    timeDict[@"endTime"]=[NSString stringWithFormat:@"%ld",endTime];
    
    
   
    
    //时间卓转成想要的格式
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"yyyy-MM-dd "];
    NSDate *confromTimesp=[NSDate dateWithTimeIntervalSince1970:startTime];
    NSString *confromTimespStr=[fmt stringFromDate:confromTimesp];
    
    NSDate *endconfromTimesp=[NSDate dateWithTimeIntervalSince1970:endTime];
    NSString *endconfromTimespStr=[fmt stringFromDate:endconfromTimesp];

    
    
    
    resultsViewController.name=[NSString stringWithFormat:@"%@至%@",confromTimespStr,endconfromTimespStr];
    resultsViewController.timeDict=timeDict;
    [self.navigationController pushViewController:resultsViewController animated:YES];
}

//按比赛代理
-(void)StadiumViewDidClickedcell:(ZCStadiumView *)headerView uuidStr:(NSString *)uuid andName:(NSString *)name
{

    ZCEventUuidTool *tool=[ZCEventUuidTool sharedEventUuidTool];
    tool.type=@"3";
    
    ZCResultsViewController *resultsViewController=[[ZCResultsViewController alloc] init];
   
    
    
    
    resultsViewController.name=name;
    resultsViewController.uuid=uuid;
    [self.navigationController pushViewController:resultsViewController animated:YES];

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
