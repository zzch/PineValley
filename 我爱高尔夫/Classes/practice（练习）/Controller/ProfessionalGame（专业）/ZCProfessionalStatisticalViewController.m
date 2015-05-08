//
//  ZCProfessionalStatisticalViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/4/13.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCProfessionalStatisticalViewController.h"
#import "AFNetworking.h"
#import "ZCAccount.h"
#import "ZCEventUuidTool.h"
#import "ZCProfessionalStatisticalModel.h"
#import "ZCAverageViewController.h"
#import "ZCPushRodViewController.h"
#import "ZCBunkersViewController.h"
#import "ZCWedgeViewController.h"
#import "ZCGreenViewController.h"
#import "ZCFairwayViewController.h"
#import "ZCKickOffViewController.h"
#import "ZCRodNumberViewController.h"
#import "ZCCueTableViewController.h"
#import "ZCCueMode.h"
#import "ZCTotalGradeViewController.h"
#import "UIBarButtonItem+DC.h"
#import "MBProgressHUD+NJ.h"
@interface ZCProfessionalStatisticalViewController ()
@property(nonatomic,weak)UIScrollView *scrollView;
@property(nonatomic,strong)ZCProfessionalStatisticalModel *professionalStatisticalModel;
@end

@implementation ZCProfessionalStatisticalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"suoyou_bj_02"]];
    
    
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    customLab.textAlignment=NSTextAlignmentCenter;
    [customLab setTextColor:ZCColor(240, 208, 122)];
    [customLab setText:@"快捷记分卡"];
    customLab.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = customLab;
    
    
    //返回
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barBtnItemWithNormalImageName:@"suoyou_fanhui" hightImageName:@"ffanhui_anxia" action:@selector(liftBthClick:) target:self];
    
    
    
    //网络加载
    [self online];
    
    
    
    
}

//返回到上个界面
-(void)liftBthClick:(UIButton *)bth
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)online
{
    
    [MBProgressHUD showMessage:@"加载中..."];
    
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    //params[@"scorecard_uuid"]=self.scorecard.uuid;
    // ZCLog(@"%@",[self.eventArray[indexPath.row] uuid]);
    ZCEventUuidTool *tool=[ZCEventUuidTool sharedEventUuidTool];
    params[@"token"]=account.token;
    params[@"match_uuid"]=tool.uuid;
    ZCLog(@"%@",account.token);
    ZCLog(@"%@",tool.uuid);
    ///v1/matches/practice/statistics/professional.json
    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"matches/practice/statistics/professional.json"];
    ZCLog(@"%@",url);
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        ZCProfessionalStatisticalModel *professionalStatisticalModel=[ZCProfessionalStatisticalModel professionalStatisticalModelWithDict:responseObject];
        
        self.professionalStatisticalModel=professionalStatisticalModel;
        
        
        //加载控件
        [self addControls];
        
        [MBProgressHUD hideHUD];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         ZCLog(@"%@",error);
        [MBProgressHUD hideHUD];
        
        
    }];

//http://123.57.210.52/api/v1/matches/practice/statistics/professional.json?&match_uuid=0be52c98-fb71-4437-a41c-6aaa8dc9e17f&token=j9h6VVq328ccYWn78phb8w

    
}




//添加控件
-(void)addControls
{
    
    UIScrollView *scrollView=[[UIScrollView alloc] init];
    scrollView.frame=[UIScreen mainScreen].bounds;
    self.scrollView=scrollView;
    [self.view addSubview:scrollView];
    
    

    
    
    //总成绩
    UIButton *totalGradeBtn=[[UIButton alloc] init];
   
    CGFloat totalGradeBtnX=0;
    CGFloat totalGradeBtnY=0;
    CGFloat totalGradeBtnW=SCREEN_WIDTH;
    CGFloat totalGradeBtnH=140;
    totalGradeBtn.frame=CGRectMake(totalGradeBtnX, totalGradeBtnY, totalGradeBtnW, totalGradeBtnH);
    //监听点击
   // [totalGradeBtn addTarget:self action:@selector(clicktotalGradeBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.scrollView addSubview:totalGradeBtn];
    //添加背景线
    [self blackgroundLine:totalGradeBtn];
    NSDictionary *total= self.professionalStatisticalModel.item_01;
    //总成绩里面的内容
    [self addContent:totalGradeBtn imageView:@"zongganshu" nameLabel:@"总成绩" firstLabel:[NSString stringWithFormat:@"%@",total[@"score"]] secondLabel:[NSString stringWithFormat:@"%@",total[@"putts"]] thirdLabel:[NSString stringWithFormat:@"%@",total[@"net"]] firstNameLabel:@"总杆" secondNameLabel:@"净杆" thirdNameLabel:@"推杆"];
    
    
    //平均杆
    UIButton *averageBtn=[[UIButton alloc] init];
    
    CGFloat averageBtnX=totalGradeBtnX;
    CGFloat averageBtnY=totalGradeBtnY+totalGradeBtnH+10;
    CGFloat averageBtnW=totalGradeBtnW;
    CGFloat averageBtnH=totalGradeBtnH;
    averageBtn.frame=CGRectMake(averageBtnX, averageBtnY, averageBtnW, averageBtnH);
    [self.scrollView addSubview:averageBtn];
    
    //添加背景线
    [self blackgroundLine:averageBtn];

//    //监听点击
//    [averageBtn addTarget:self action:@selector(clickaverageBtn) forControlEvents:UIControlEventTouchUpInside];
    
    NSDictionary *average= self.professionalStatisticalModel.item_02;
    //平均杆里内容
    [self addContent:averageBtn imageView:@"pingjunganshu" nameLabel:@"平均杆数" firstLabel:[NSString stringWithFormat:@"%@",average[@"average_score_par_3"]] secondLabel:[NSString stringWithFormat:@"%@",average[@"average_score_par_4"]] thirdLabel:[NSString stringWithFormat:@"%@",average[@"average_score_par_5"]] firstNameLabel:@"3杆洞" secondNameLabel:@"4杆洞" thirdNameLabel:@"5杆洞"];
    
    
    //推杆
    UIButton *pushRodBtn=[[UIButton alloc] init];
    
    CGFloat pushRodBtnX=totalGradeBtnX;
    CGFloat pushRodBtnY=averageBtnY+averageBtnH+10;
    CGFloat pushRodBtnW=totalGradeBtnW;
    CGFloat pushRodBtnH=totalGradeBtnH;
    pushRodBtn.frame=CGRectMake(pushRodBtnX, pushRodBtnY, pushRodBtnW, pushRodBtnH);
    [self.scrollView addSubview:pushRodBtn];
    
    //添加背景线
    [self blackgroundLine:pushRodBtn];

    //监听点击
   // [pushRodBtn addTarget:self action:@selector(clickpushRodBtn) forControlEvents:UIControlEventTouchUpInside];

    
    NSDictionary *pushRod= self.professionalStatisticalModel.item_03;
    //推杆里内容
    [self addContent:pushRodBtn imageView:@"tuigan" nameLabel:@"推杆" firstLabel:[NSString stringWithFormat:@"%@",pushRod[@"average_putts"]] secondLabel:[NSString stringWithFormat:@"%@",pushRod[@"putts_per_gir"]] thirdLabel:[NSString stringWithFormat:@"%@",pushRod[@"putts_per_non_gir"]] firstNameLabel:@"平均/洞" secondNameLabel:@"标准杆" thirdNameLabel:@"大于标准杆"];
    
    
    
    
    //沙坑
    UIButton *bunkersBtn=[[UIButton alloc] init];
    
    CGFloat bunkersBtnX=totalGradeBtnX;
    CGFloat bunkersBtnY=pushRodBtnY+pushRodBtnH+10;
    CGFloat bunkersBtnW=totalGradeBtnW;
    CGFloat bunkersBtnH=totalGradeBtnH;
    bunkersBtn.frame=CGRectMake(bunkersBtnX, bunkersBtnY, bunkersBtnW, bunkersBtnH);
    [self.scrollView addSubview:bunkersBtn];
    //添加背景线
    [self blackgroundLine:bunkersBtn];

    
    
    //监听点击
   // [bunkersBtn addTarget:self action:@selector(clickbunkersBtn) forControlEvents:UIControlEventTouchUpInside];
    
    NSDictionary *bunkers= self.professionalStatisticalModel.item_04;
    
    //推杆里内容
    [self addContent:bunkersBtn imageView:@"shakeng" nameLabel:@"沙坑(40码)" firstLabel:[NSString stringWithFormat:@"%@",bunkers[@"sand_saves"]] secondLabel:[NSString stringWithFormat:@"%@",bunkers[@"bunker_shots"]] thirdLabel:[NSString stringWithFormat:@"%@",bunkers[@"sand_saves_percentage"]] firstNameLabel:@"沙坑救球" secondNameLabel:@"进入次数" thirdNameLabel:@"成功率"];
    
    
    
    
    
    //切杆
    UIButton *wedgeBtn=[[UIButton alloc] init];
    
    CGFloat wedgeBtnX=totalGradeBtnX;
    CGFloat wedgeBtnY=bunkersBtnY+bunkersBtnH+10;
    CGFloat wedgeBtnW=totalGradeBtnW;
    CGFloat wedgeBtnH=totalGradeBtnH;
    wedgeBtn.frame=CGRectMake(wedgeBtnX, wedgeBtnY, wedgeBtnW, wedgeBtnH);
    [self.scrollView addSubview:wedgeBtn];
    
    //添加背景线
    [self blackgroundLine:wedgeBtn];

    //监听点击
   // [wedgeBtn addTarget:self action:@selector(clickwedgeBtn) forControlEvents:UIControlEventTouchUpInside];
    
    //切杆里内容
    NSDictionary *wedge= self.professionalStatisticalModel.item_05;
    //ZCLog(@"%@",wedge);
    [self addContent:wedgeBtn imageView:@"qiegan" nameLabel:@"切杆" firstLabel:[NSString stringWithFormat:@"%@",wedge[@"up_and_downs_count"]] secondLabel:[NSString stringWithFormat:@"%@",wedge[@"shots_within_100"]] thirdLabel:[NSString stringWithFormat:@"%@",wedge[@"up_and_downs_percentage"]] firstNameLabel:@"一切一推" secondNameLabel:@"次数" thirdNameLabel:@"成功率"];
    
    
    
    
    //攻果岭
    UIButton *greenBtn=[[UIButton alloc] init];
   
    CGFloat greenBtnX=totalGradeBtnX;
    CGFloat greenBtnY=wedgeBtnY+wedgeBtnH+10;
    CGFloat greenBtnW=totalGradeBtnW;
    CGFloat greenBtnH=totalGradeBtnH;
    greenBtn.frame=CGRectMake(greenBtnX, greenBtnY, greenBtnW, greenBtnH);
    [self.scrollView addSubview:greenBtn];
    //添加背景线
    [self blackgroundLine:greenBtn];

    //点击监听
    //[greenBtn addTarget:self action:@selector(clickBreenBtn) forControlEvents:UIControlEventTouchUpInside];
    
    //攻果岭
    NSDictionary *green= self.professionalStatisticalModel.item_06;
    [self addContent:greenBtn imageView:@"gongguoling" nameLabel:@"攻果岭" firstLabel:[NSString stringWithFormat:@"%@",green[@"gir_percentage"]] secondLabel:[NSString stringWithFormat:@"%@",green[@"non_gir_percentage"]] thirdLabel:nil firstNameLabel:@"命中" secondNameLabel:@"未命中" thirdNameLabel:nil];
    
    
    //球道命中
    UIButton *fairwayBtn=[[UIButton alloc] init];
    
    CGFloat fairwayBtnX=totalGradeBtnX;
    CGFloat fairwayBtnY=greenBtnY+greenBtnH+10;
    CGFloat fairwayBtnW=totalGradeBtnW;
    CGFloat fairwayBtnH=totalGradeBtnH;
    fairwayBtn.frame=CGRectMake(fairwayBtnX, fairwayBtnY, fairwayBtnW, fairwayBtnH);
    [self.scrollView addSubview:fairwayBtn];
    
    //添加背景线
    [self blackgroundLine:fairwayBtn];

    //点击监听
    //[fairwayBtn addTarget:self action:@selector(clickFairwayBtn) forControlEvents:UIControlEventTouchUpInside];
    
    //球道命中
    NSDictionary *fairway= self.professionalStatisticalModel.item_07;
    ZCLog(@"%@",fairway);
    [self addContent:fairwayBtn imageView:@"qiudao" nameLabel:@"球道命中" firstLabel:[NSString stringWithFormat:@"%@",fairway[@"drive_fairways_hit"]] secondLabel:[NSString stringWithFormat:@"%@",fairway[@"drive_left_roughs_hit"]] thirdLabel:[NSString stringWithFormat:@"%@",fairway[@"drive_right_roughs_hit"]] firstNameLabel:@"命中" secondNameLabel:@"左侧" thirdNameLabel:@"右侧"];
    

    
    
    
    //开球
    UIButton *kickOffBtn=[[UIButton alloc] init];
    
    CGFloat kickOffBtnX=totalGradeBtnX;
    CGFloat kickOffBtnY=fairwayBtnY+fairwayBtnH+10;
    CGFloat kickOffBtnW=totalGradeBtnW;
    CGFloat kickOffBtnH=totalGradeBtnH;
    kickOffBtn.frame=CGRectMake(kickOffBtnX, kickOffBtnY, kickOffBtnW, kickOffBtnH);
    [self.scrollView addSubview:kickOffBtn];
    //添加背景线
    [self blackgroundLine:kickOffBtn];

    
    //点击监听
    //[kickOffBtn addTarget:self action:@selector(clickkickOffBtn) forControlEvents:UIControlEventTouchUpInside];
    //开球
    NSDictionary *kickOff= self.professionalStatisticalModel.item_08;
    [self addContent:kickOffBtn imageView:@"kaiqiu" nameLabel:@"开球" firstLabel:[NSString stringWithFormat:@"%@",kickOff[@"longest_drive_length"]] secondLabel:[NSString stringWithFormat:@"%@",kickOff[@"average_drive_length"]] thirdLabel:[NSString stringWithFormat:@"%@",kickOff[@"good_drives"]] firstNameLabel:@"最远max" secondNameLabel:@"平均" thirdNameLabel:@"max/2"];
    
    
    //杆数
    UIButton *rodNumberBtn=[[UIButton alloc] init];
    
    CGFloat rodNumberBtnX=totalGradeBtnX;
    CGFloat rodNumberBtnY=kickOffBtnY+kickOffBtnH+10;
    CGFloat rodNumberBtnW=totalGradeBtnW;
    CGFloat rodNumberBtnH=totalGradeBtnH;
    rodNumberBtn.frame=CGRectMake(rodNumberBtnX, rodNumberBtnY, rodNumberBtnW, rodNumberBtnH);
    [self.scrollView addSubview:rodNumberBtn];
    //添加背景线
    [self blackgroundLine:rodNumberBtn];

    //点击监听
    //[rodNumberBtn addTarget:self action:@selector(clickRodNumberBtn) forControlEvents:UIControlEventTouchUpInside];
    
    //杆数
    NSDictionary *rodNumber= self.professionalStatisticalModel.item_09;
    [self addContent:rodNumberBtn imageView:@"80" nameLabel:@"杆数" firstLabel:[NSString stringWithFormat:@"%@",rodNumber[@"birdie"]] secondLabel:[NSString stringWithFormat:@"%@",rodNumber[@"par"]] thirdLabel:[NSString stringWithFormat:@"%@",rodNumber[@"bogey"]] firstNameLabel:@"小鸟" secondNameLabel:@"标准杆" thirdNameLabel:@"柏忌"];


    
    
    //球杆
    UIButton *cueButton=[[UIButton alloc] init];
    
    CGFloat cueButtonX=totalGradeBtnX;
    CGFloat cueButtonY=rodNumberBtnY+rodNumberBtnH+10;
    CGFloat cueButtonW=totalGradeBtnW;
    CGFloat cueButtonH=120;
    cueButton.frame=CGRectMake(cueButtonX, cueButtonY, cueButtonW, cueButtonH);
    [self.scrollView addSubview:cueButton];
    
    //点击监听
    //[cueButton addTarget:self action:@selector(clickCueButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self addcueButtonContent:cueButton];
    
    
    
    
    
    scrollView.contentSize = CGSizeMake(0,cueButtonY+cueButtonH+60 );
    
    
    
}


//背景线
-(void)blackgroundLine:(UIView*)view
{
    UIView *bjView=[[UIView alloc] init];
    bjView.frame=CGRectMake(0, view.frame.size.height-1, SCREEN_WIDTH, 1);
    bjView.backgroundColor=ZCColor(136, 119, 73);
    [view addSubview:bjView];
}




//点击监听总成绩
-(void)clicktotalGradeBtn
{
    ZCTotalGradeViewController *totalGradeViewController=[[ZCTotalGradeViewController alloc] init];
    totalGradeViewController.professionalScorecardModel=self.professionalStatisticalModel.scorecards;
    totalGradeViewController.totalModel=self.professionalStatisticalModel.item_01;
    [self.navigationController pushViewController:totalGradeViewController animated:YES];
}




//点击监听球杆
-(void)clickCueButton
{

    ZCCueTableViewController *cueTableViewController=[[ZCCueTableViewController alloc] init];
    cueTableViewController.cueModel=self.professionalStatisticalModel.item_10[@"clubs"];
    [self.navigationController pushViewController:cueTableViewController animated:YES];
    
}


//点击杆数
-(void)clickRodNumberBtn
{
    ZCRodNumberViewController *RodNumberViewController=[[ZCRodNumberViewController alloc] init];
    RodNumberViewController.rodNumberModel=self.professionalStatisticalModel.item_09;
    [self.navigationController pushViewController:RodNumberViewController animated:YES];
   
}

//点击监听开球
-(void)clickkickOffBtn
{
    ZCKickOffViewController *kickOffViewController=[[ZCKickOffViewController alloc] init];
    kickOffViewController.kickOffModel=self.professionalStatisticalModel.item_08;
    [self.navigationController pushViewController:kickOffViewController animated:YES];
}


//点击监听球道位置
-(void)clickFairwayBtn
{
    ZCFairwayViewController *fairwayViewController=[[ZCFairwayViewController alloc] init];
    fairwayViewController.fairwayModel=self.professionalStatisticalModel.item_07;
    [self.navigationController pushViewController:fairwayViewController animated:YES];

}


//点击监听攻果岭
-(void)clickBreenBtn
{
    ZCGreenViewController *greenViewController=[[ZCGreenViewController alloc] init];
    greenViewController.greenModel=self.professionalStatisticalModel.item_06;
    [self.navigationController pushViewController:greenViewController animated:YES];
}


//点击监听沙坑
-(void)clickbunkersBtn
{
    ZCBunkersViewController *bunkersViewController=[[ZCBunkersViewController alloc] init];
    bunkersViewController.bunkersModel=self.professionalStatisticalModel.item_04;
    [self.navigationController pushViewController:bunkersViewController animated:YES];
}


//监听点击平均干
-(void)clickaverageBtn
{
    ZCAverageViewController *averageViewController=[[ZCAverageViewController alloc] init];
    NSDictionary *averageModel=self.professionalStatisticalModel.item_02;
    averageViewController.averageModel=averageModel;
    [self.navigationController pushViewController:averageViewController animated:YES];

}

//点击切杆
-(void)clickwedgeBtn
{
    ZCWedgeViewController *wedgeViewController=[[ZCWedgeViewController alloc] init];
    wedgeViewController.wedgeModel=self.professionalStatisticalModel.item_05;
    [self .navigationController pushViewController:wedgeViewController animated:YES];
}

//监听点击推杆
-(void)clickpushRodBtn
{
    ZCPushRodViewController *pushRodViewController=[[ZCPushRodViewController alloc] init];
    pushRodViewController.pushRodModel=self.professionalStatisticalModel.item_03;
    
    [self.navigationController pushViewController:pushRodViewController animated:YES];

}


//总成绩内容
-(void)addContent:(UIButton *)button imageView:(NSString *)imageStr  nameLabel:(NSString *)nameLabelText  firstLabel:(NSString *)firstLabelText  secondLabel:(NSString *)secondLabelText thirdLabel:(NSString *)thirdLabelText  firstNameLabel:(NSString *)firstNameLabelText  secondNameLabel:(NSString *)secondNameLabelText  thirdNameLabel:(NSString *)thirdNameLabelText
{
    //UIImage *im=[UIImage imageNamed:imageStr];
    //ZCLog(@"%@",im)
    
    UIImageView *imageView=[[UIImageView alloc] init];
    CGFloat imageViewW=188;
    CGFloat imageViewH=120;
    CGFloat imageViewX=0;
    CGFloat imageViewY=(button.frame.size.height-imageViewH)*0.5;
    imageView.frame=CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    imageView.image=[UIImage imageNamed:imageStr];//@"20141118042246536"
    [button addSubview:imageView];
    
    
    UILabel *nameLabel=[[UILabel alloc] init];
    
    CGFloat nameLabelY=10;
    CGFloat nameLabelW=80;
    CGFloat nameLabelH=20;
    CGFloat nameLabelX=SCREEN_WIDTH-nameLabelW-10;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.text=nameLabelText;
    nameLabel.textColor=ZCColor(240, 208, 122);
    nameLabel.font=[UIFont systemFontOfSize:13];
    nameLabel.textAlignment=NSTextAlignmentRight;
    [button addSubview:nameLabel];
    
    
    
    //第一个名字
    UILabel *firstNameLabel=[[UILabel alloc] init];
    
    CGFloat firstNameLabelX=imageViewW;
    CGFloat firstNameLabelY=nameLabelY+nameLabelH+5;
    CGFloat firstNameLabelW=60;
    CGFloat firstNameLabelH=20;
    firstNameLabel.frame=CGRectMake(firstNameLabelX, firstNameLabelY, firstNameLabelW, firstNameLabelH);
    firstNameLabel.text=firstNameLabelText;
    firstNameLabel.textColor=ZCColor(240, 208, 122);
    firstNameLabel.font=[UIFont systemFontOfSize:14];
    [button addSubview:firstNameLabel];
    
    
    //第二个名字
    UILabel *secondNameLabel=[[UILabel alloc] init];
    
    CGFloat secondNameLabelX=firstNameLabelX ;
    CGFloat secondNameLabelY=firstNameLabelY+firstNameLabelH+10;
    CGFloat secondNameLabelW=60;
    CGFloat secondNameLabelH=20;
    secondNameLabel.frame=CGRectMake(secondNameLabelX, secondNameLabelY, secondNameLabelW, secondNameLabelH);
    secondNameLabel.text=secondNameLabelText;
    secondNameLabel.textColor=ZCColor(240, 208, 122);
    secondNameLabel.font=[UIFont systemFontOfSize:14];
    [button addSubview:secondNameLabel];
    
    //第三个名字
    UILabel *thirdNameLabel=[[UILabel alloc] init];
    
    CGFloat thirdNameLabelX=firstNameLabelX;
    CGFloat thirdNameLabelY=secondNameLabelH+secondNameLabelY+10;
    CGFloat thirdNameLabelW=70;
    CGFloat thirdNameLabelH=20;
    thirdNameLabel.frame=CGRectMake(thirdNameLabelX, thirdNameLabelY, thirdNameLabelW, thirdNameLabelH);
    thirdNameLabel.text=thirdNameLabelText;
    thirdNameLabel.textColor=ZCColor(240, 208, 122);
    thirdNameLabel.font=[UIFont systemFontOfSize:14];
    [button addSubview:thirdNameLabel];

    
    
    
    
    //第一个数字
    UILabel *firstLabel=[[UILabel alloc] init];
    
    CGFloat firstLabelX=firstNameLabelX+firstNameLabelW+10;
    CGFloat firstLabelY=firstNameLabelY;
    CGFloat firstLabelW=60;
    CGFloat firstLabelH=20;
    firstLabel.frame=CGRectMake(firstLabelX, firstLabelY, firstLabelW, firstLabelH);
   
   
    firstLabel.textColor=ZCColor(240, 208, 122);
    [button addSubview:firstLabel];
    if ([firstLabelText isEqual:@"<null>"]) {
        
    }else
    {
     firstLabel.text=firstLabelText;
    }
    
    
    
    
    //第二个数字
    UILabel *secondLabel=[[UILabel alloc] init];
    
    CGFloat secondLabelX=firstLabelX;
    CGFloat secondLabelY=firstLabelY+firstLabelH+10;
    CGFloat secondLabelW=60;
    CGFloat secondLabelH=20;
    secondLabel.frame=CGRectMake(secondLabelX, secondLabelY, secondLabelW, secondLabelH);
    
    secondLabel.textColor=ZCColor(240, 208, 122);
    [button addSubview:secondLabel];
    if ([secondLabelText isEqual:@"<null>"]) {
        
    }else
    {
        secondLabel.text=secondLabelText;
    }

    
    //第三个数字
    UILabel *thirdLabel=[[UILabel alloc] init];
    
    CGFloat thirdLabelX=firstLabelX;
    CGFloat thirdLabelY=secondLabelY+secondLabelH+10;
    CGFloat thirdLabelW=60;
    CGFloat thirdLabelH=20;
    thirdLabel.frame=CGRectMake(thirdLabelX, thirdLabelY, thirdLabelW, thirdLabelH);
    
    thirdLabel.textColor=ZCColor(240, 208, 122);
    [button addSubview:thirdLabel];
    
    if ([thirdLabelText isEqual:@"<null>"]) {
        
    }else
    {
        thirdLabel.text=thirdLabelText;
    }


    
    
    
    //向右的箭头
    UIImageView *rightImage=[[UIImageView alloc] init];
    CGFloat rightImageW=10;
    CGFloat rightImageH=15;
    CGFloat rightImageX=SCREEN_WIDTH-rightImageW-5;
    CGFloat rightImageY=(button.frame.size.height-rightImageH)*0.5;
    rightImage.frame=CGRectMake(rightImageX, rightImageY, rightImageW, rightImageH);
    //rightImage.image=[UIImage imageNamed:@"lsjfk_xiayibu_iocn"];
    [button addSubview:rightImage];
    
    
    
}

//添加球杆里的内容
-(void)addcueButtonContent:(UIButton *)button
{
     NSArray *frequentlyArray= self.professionalStatisticalModel.item_10[@"frequently_used_clubs"];
    ZCLog(@"%@",self.professionalStatisticalModel.item_10[@"frequently_used_clubs"]);
    
    
    NSMutableArray *cueMutableArray=[NSMutableArray array];
    for (NSDictionary *dict in frequentlyArray) {
        
        ZCCueMode *cueMode=[ZCCueMode cueModelWithDict:dict];
        [cueMutableArray addObject:cueMode];
    }
   
    
    
    
    UILabel *nameLabel=[[UILabel alloc] init];
    
    CGFloat nameLabelY=10;
    CGFloat nameLabelW=80;
    CGFloat nameLabelH=20;
    CGFloat nameLabelX=(button.frame.size.width-nameLabelW)*0.5;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.text=@"球杆";
    nameLabel.textColor=ZCColor(240, 208, 122);
    [button addSubview:nameLabel];
    
    
     UIView *firstView=[[UIView alloc] init];
     CGFloat firstViewX=10;
     CGFloat firstViewY=nameLabelY+nameLabelH+10;
     CGFloat firstViewW=(SCREEN_WIDTH-50)*0.25;
     CGFloat firstViewH=80;
     firstView.frame=CGRectMake(firstViewX, firstViewY, firstViewW, firstViewH);
     [button addSubview:firstView];
    //添加里面内容
    if (cueMutableArray.count>=1) {
        ZCCueMode *cue= cueMutableArray[0];
        [self addView:firstView topLabel:[NSString stringWithFormat:@"%@",cue.name] cueImageName:@"qiugan" codeNumber:[NSString stringWithFormat:@"%@",cue.maximum_length]];
        

    }else
    {
      [self addView:firstView topLabel:@"未选取" cueImageName:@"qiugan_wu" codeNumber:@""];
    }
    
    
    
    
    UIView *secondView=[[UIView alloc] init];
    CGFloat secondViewX=firstViewX+firstViewW+10;
    CGFloat secondViewY=firstViewY;
    CGFloat secondViewW=firstViewW;
    CGFloat secondViewH=firstViewH;
    secondView.frame=CGRectMake(secondViewX, secondViewY, secondViewW, secondViewH);
    [button addSubview:secondView];
    
    //添加里面内容qiugan_wu
    if (cueMutableArray.count>=2) {
        ZCCueMode *cue= cueMutableArray[1];
        [self addView:secondView topLabel:[NSString stringWithFormat:@"%@",cue.name] cueImageName:@"qiugan" codeNumber:[NSString stringWithFormat:@"%@",cue.maximum_length]];
 
        
    }else{
        [self addView:secondView topLabel:@"未选取" cueImageName:@"qiugan_wu" codeNumber:@""];
    }

    
   

    
    UIView *thirdView=[[UIView alloc] init];
    CGFloat thirdViewX=secondViewX+secondViewW+5;
    CGFloat thirdViewY=firstViewY;
    CGFloat thirdViewW=firstViewW;
    CGFloat thirdViewH=firstViewH;
    thirdView.frame=CGRectMake(thirdViewX, thirdViewY, thirdViewW, thirdViewH);
    [button addSubview:thirdView];
    //添加里面内容
    if (cueMutableArray.count>=3) {
        ZCCueMode *cue= cueMutableArray[2];
        [self addView:thirdView topLabel:[NSString stringWithFormat:@"%@",cue.name] cueImageName:@"qiugan" codeNumber:[NSString stringWithFormat:@"%@",cue.maximum_length]];
        
        
    }else{
        [self addView:thirdView topLabel:@"未选取" cueImageName:@"qiugan_wu" codeNumber:@""];
    }
    

    
    UIView *fourthView=[[UIView alloc] init];
    
    CGFloat fourthViewX=thirdViewX+thirdViewW+5;
    CGFloat fourthViewY=firstViewY;
    CGFloat fourthViewW=firstViewW;
    CGFloat fourthViewH=firstViewH;
    fourthView.frame=CGRectMake(fourthViewX, fourthViewY, fourthViewW, fourthViewH);
    [button addSubview:fourthView];
   
    //添加里面内容
    if (cueMutableArray.count>=4) {
        ZCCueMode *cue= cueMutableArray[3];
        [self addView:fourthView topLabel:[NSString stringWithFormat:@"%@",cue.name] cueImageName:@"qiugan" codeNumber:[NSString stringWithFormat:@"%@",cue.maximum_length]];
        
        
    }else{
       [self addView:fourthView topLabel:@"未选取" cueImageName:@"qiugan_wu" codeNumber:@""];
    }

    
    
    //向右的箭头
    UIImageView *rightImage=[[UIImageView alloc] init];
    CGFloat rightImageW=10;
    CGFloat rightImageH=20;
    CGFloat rightImageX=SCREEN_WIDTH-rightImageW-30;
    CGFloat rightImageY=(button.frame.size.height-rightImageH)*0.5;
    rightImage.frame=CGRectMake(rightImageX, rightImageY, rightImageW, rightImageH);
   // rightImage.image=[UIImage imageNamed:@"icon_arrow-副本"];
    [button addSubview:rightImage];
    
}


//添加球杆里的内容的view内容qiugan_wu  qiugan
-(void)addView:(UIView *)view topLabel:(NSString *)cueName cueImageName:(NSString *)imageStr codeNumber:(NSString *)codeNumber
{
    
    
    UIImageView *imageView=[[UIImageView alloc] init];
    CGFloat imageViewW=26;
    CGFloat imageViewH=46;
    CGFloat imageViewX=0;
    CGFloat imageViewY=10;
    imageView.frame=CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    imageView.image=[UIImage imageNamed:imageStr];
    [view addSubview:imageView];
    
    
    
    
    
    UILabel *codeNumberLabel=[[UILabel alloc] init];
    
    CGFloat codeNumberLabelH=30;
    CGFloat codeNumberLabelX=imageViewX+imageViewW+5;
    CGFloat codeNumberLabelY=0;
    CGFloat codeNumberLabelW=view.frame.size.width-codeNumberLabelX;
    codeNumberLabel.frame=CGRectMake(codeNumberLabelX, codeNumberLabelY, codeNumberLabelW, codeNumberLabelH);
    codeNumberLabel.textAlignment=NSTextAlignmentCenter;
    
    codeNumberLabel.textColor=ZCColor(240, 208, 122);
    [view addSubview:codeNumberLabel];
    if ([codeNumber isEqual:@"<null>"]) {
        
    }else
    {
    codeNumberLabel.text=codeNumber;
    }
    
    
    
    

    UILabel *nameLabel=[[UILabel alloc] init];
    CGFloat nameLabelW=codeNumberLabelW;
    CGFloat nameLabelH=20;
    CGFloat nameLabelX=codeNumberLabelX;
    CGFloat nameLabelY=codeNumberLabelY+codeNumberLabelH+10;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.text=cueName;
    nameLabel.textAlignment=NSTextAlignmentCenter;
    nameLabel.textColor=ZCColor(240, 208, 122);
    nameLabel.font=[UIFont systemFontOfSize:11];
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
