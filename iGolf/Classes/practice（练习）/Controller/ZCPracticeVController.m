//
//  ZCPracticeVController.m
//  我爱高尔夫
//
//  Created by hh on 15/5/7.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCPracticeVController.h"
#import "ZCQuickScoringTableViewController.h"
#import "AppDelegate.h"
#import "ZCEventUuidTool.h"
#import "ZCChooseThePitchVViewController.h"
#import "ZCStatisticalViewController.h"
#import "ZCPersonalViewController.h"
#import "UIImageView+WebCache.h"

#import "ZCSetupModeViewController.h"
@interface ZCPracticeVController ()

@end

@implementation ZCPracticeVController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
//    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
//        
//        
//        UINavigationBar *bar = [UINavigationBar appearance];
//
//        [bar setBarTintColor:[UIColor redColor]];
//        
//        [bar setTranslucent:NO];
//        
//    }
    
    
//    
//    AppDelegate *app=  (AppDelegate *)[UIApplication sharedApplication].delegate;
//    [app setAllowRotation:NO];
//    
//    
//    
//    if ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0) {
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//    }
//    
   
    self.navigationItem.title=@"我爱高尔夫";
     //[self setNeedsStatusBarAppearanceUpdate];
    
    //背景颜色suoyou_bj
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    
//    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
//    customLab.textAlignment=NSTextAlignmentCenter;
//    [customLab setTextColor:ZCColor(240, 208, 122)];
//    [customLab setText:@"选择记分卡"];
//    customLab.font = [UIFont boldSystemFontOfSize:20];
//    self.navigationItem.titleView = customLab;
    

//    UIImage *topimage;
//    if (SCREEN_HEIGHT==480) {
//        topimage=[UIImage imageNamed:@"shouye_4s"];
//    }else if (SCREEN_HEIGHT==568)
//    {
//    topimage=[UIImage imageNamed:@"bn_01"];
//    }else
//    {
//    topimage=[UIImage imageNamed:@"shouye_6"];
//    }
    
    
    
//    UIImageView *persinImage=[[UIImageView alloc] init];
//    
//    CGFloat  persinImageY=0;
//    CGFloat  persinImageW=SCREEN_WIDTH;
//    CGFloat  persinImageH=topimage.size.height;
//    CGFloat  persinImageX=0;
//    persinImage.frame=CGRectMake(persinImageX, persinImageY, persinImageW, persinImageH);
//    persinImage.image=topimage;
//    [self.view addSubview:persinImage];
//    persinImage.layer.cornerRadius=10;//设置圆角的半径为10
//    persinImage.layer.masksToBounds=YES;
    
    
    
//    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
//    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
//    ZCLog(@"%@",account.portrait);
//    
//    if ([account.portrait isKindOfClass:[NSNull class]]) {
//        
//        ZCLog(@"weisha");
//    }else{
//        
//        NSURL *url=[NSURL URLWithString:account.portrait];
//       // UIImageView *image=[[UIImageView alloc] init];
//        [persinImage sd_setImageWithURL:url  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            //照片保存到沙盒
//            NSString *path=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"personImage.png"];
//            ZCLog(@"%@",path);
//            
//            NSData *data=UIImagePNGRepresentation(image);
//            [data writeToFile:path atomically:YES];
//            ZCLog(@"图片已经保存好了 ");
//            
//        }];
//        
//        //照片保存到沙盒
//        NSString *path=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"personImage.png"];
//        ZCLog(@"%@",path);
//        
//        NSData *data=UIImagePNGRepresentation(image.image);
//        [data writeToFile:path atomically:YES];
//    }
    

    
    
    
    
    
//    UILabel *nameLabel=[[UILabel alloc] init];
//    CGFloat  nameLabelY=persinImageY+persinImageH+20;
//    CGFloat  nameLabelW=150;
//    CGFloat  nameLabelH=25;
//    CGFloat  nameLabelX=(SCREEN_WIDTH-nameLabelW)/2;
//    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
//    nameLabel.text=@"我 爱 高 尔 夫";
//    nameLabel.textColor=ZCColor(85, 85, 85);
//    nameLabel.textAlignment=NSTextAlignmentCenter;
//    [self.view addSubview:nameLabel];
//
    
    //竞技比赛
    UIButton *sportsCompetition=[[UIButton alloc] init];
    CGFloat sportsCompetitionX=7;
    CGFloat sportsCompetitionY=10;
    CGFloat sportsCompetitionW=SCREEN_WIDTH-16;
    CGFloat sportsCompetitionH=(SCREEN_HEIGHT-50)/4-15;
    sportsCompetition.frame=CGRectMake(sportsCompetitionX, sportsCompetitionY, sportsCompetitionW, sportsCompetitionH);
    [sportsCompetition setImage:[UIImage imageNamed:@"shouye_jingjibisai"] forState:UIControlStateNormal];
    
    [sportsCompetition addTarget:self action:@selector(clickThesportsCompetition) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sportsCompetition];
    
    //娱乐
    UIButton *entertainmentBtn=[[UIButton alloc] init];
    CGFloat entertainmentBtnX=sportsCompetitionX;
    CGFloat entertainmentBtnY=sportsCompetitionY+sportsCompetitionH+10;
    CGFloat entertainmentBtnW=sportsCompetitionW;
    CGFloat entertainmentBtnH=sportsCompetitionH;
    entertainmentBtn.frame=CGRectMake(entertainmentBtnX, entertainmentBtnY, entertainmentBtnW, entertainmentBtnH);
    [entertainmentBtn setImage:[UIImage imageNamed:@"shouye_yulemoshi"] forState:UIControlStateNormal];
    [entertainmentBtn addTarget:self action:@selector(clickTheBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:entertainmentBtn];

    
    
    
    //技术统计
    UIButton *technicalStatistics=[[UIButton alloc] init];
    CGFloat technicalStatisticsX=sportsCompetitionX;
    CGFloat technicalStatisticsY=entertainmentBtnY+entertainmentBtnH+10;
    CGFloat technicalStatisticsW=sportsCompetitionW;
    CGFloat technicalStatisticsH=sportsCompetitionH;
    technicalStatistics.frame=CGRectMake(technicalStatisticsX, technicalStatisticsY, technicalStatisticsW, technicalStatisticsH);
    [technicalStatistics setImage:[UIImage imageNamed:@"shouye_jishutongji"] forState:UIControlStateNormal];

    
    [technicalStatistics addTarget:self action:@selector(clickTheTechnicalStatistics) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:technicalStatistics];

    
    //个人中心
    UIButton *personalCenter=[[UIButton alloc] init];
    CGFloat personalCenterX=sportsCompetitionX;
    CGFloat personalCenterY=technicalStatisticsY+technicalStatisticsH+10;
    CGFloat personalCenterW=sportsCompetitionW;
    CGFloat personalCenterH=sportsCompetitionH;
    personalCenter.frame=CGRectMake(personalCenterX, personalCenterY, personalCenterW, personalCenterH);
    [personalCenter setImage:[UIImage imageNamed:@"shouye_gerenzhongxin"] forState:UIControlStateNormal];
    
    [personalCenter addTarget:self action:@selector(clickThePersonalCenter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:personalCenter];

    
    
    
    
    
}

-(void)clickTheBtn
{
    ZCSetupModeViewController *vc=[[ZCSetupModeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}



//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleDefault;
//}

//-(void)viewWillAppear:(BOOL)animated
//{
//    //影藏状态栏
//  //  [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
// self.navigationController.navigationBarHidden=YES;
//}
//-(void)viewWillDisappear:(BOOL)animated
//{
//    //影藏状态栏
//   // [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
//self.navigationController.navigationBarHidden=NO;
//}

//点击竞技比赛
-(void)clickThesportsCompetition
{
    ZCLog(@"1111111111111111111111111");

     ZCQuickScoringTableViewController *quickScoringTableViewController=[[ZCQuickScoringTableViewController alloc] init];

    
    [self.navigationController pushViewController:quickScoringTableViewController animated:YES];
    
    // [self presentModalViewController:nav animated:YES];
    

}


//点击技术统计
-(void)clickTheTechnicalStatistics
{

    ZCStatisticalViewController *statistical=[[ZCStatisticalViewController alloc] init];
    [self.navigationController pushViewController:statistical animated:YES];
    
}

//点击个人中心
-(void)clickThePersonalCenter
{
   ZCPersonalViewController *personal=[[ZCPersonalViewController alloc] init];
    [self.navigationController pushViewController:personal animated:YES];

}

//专业
-(void)clickTheprofessional
{
    ZCEventUuidTool *tool=[ZCEventUuidTool sharedEventUuidTool];
    tool.scoring=@"professional";
    
    tool.eventType=@"practice";
    ZCQuickScoringTableViewController *quickScoringTableViewController=[[ZCQuickScoringTableViewController alloc] init];
    quickScoringTableViewController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:quickScoringTableViewController animated:YES];

}


//简单
-(void)clickThePractice
{

    ZCEventUuidTool *tool=[ZCEventUuidTool sharedEventUuidTool];
    tool.scoring=@"simple";
    tool.eventType=@"practice";
    
    ZCQuickScoringTableViewController *quickScoringTableViewController=[[ZCQuickScoringTableViewController alloc] init];
    quickScoringTableViewController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:quickScoringTableViewController animated:YES];

}

//备用
- (void)clickEvent {
    
    
    ZCEventUuidTool *tool=[ZCEventUuidTool sharedEventUuidTool];
    tool.eventType=@"tournament";
    
    
//    ZCHistoryOfCompetitiveTableViewController *HistoryOfCompetitiveTableViewController=[[ZCHistoryOfCompetitiveTableViewController alloc] init];
//    HistoryOfCompetitiveTableViewController.hidesBottomBarWhenPushed=YES;
//    [self.navigationController pushViewController:HistoryOfCompetitiveTableViewController animated:YES];
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
