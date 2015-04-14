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
@interface ZCProfessionalStatisticalViewController ()
@property(nonatomic,weak)UIScrollView *scrollView;
@property(nonatomic,strong)ZCProfessionalStatisticalModel *professionalStatisticalModel;
@end

@implementation ZCProfessionalStatisticalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //网络加载
    [self online];
    
    
    
    
}


-(void)online
{
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
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         ZCLog(@"%@",error);
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
    
    scrollView.contentSize = CGSizeMake(0,SCREEN_HEIGHT+2200 );

    
    
    //总成绩
    UIButton *totalGradeBtn=[[UIButton alloc] init];
    totalGradeBtn.backgroundColor=[UIColor yellowColor];
    CGFloat totalGradeBtnX=0;
    CGFloat totalGradeBtnY=20;
    CGFloat totalGradeBtnW=SCREEN_WIDTH;
    CGFloat totalGradeBtnH=120;
    totalGradeBtn.frame=CGRectMake(totalGradeBtnX, totalGradeBtnY, totalGradeBtnW, totalGradeBtnH);
   
    [self.scrollView addSubview:totalGradeBtn];
    NSDictionary *total= self.professionalStatisticalModel.item_01;
    //总成绩里面的内容
    [self addContent:totalGradeBtn imageView:@"20141118042246536.jpg" nameLabel:@"总成绩" firstLabel:[NSString stringWithFormat:@"%@",total[@"score"]] secondLabel:[NSString stringWithFormat:@"%@",total[@"putts"]] thirdLabel:[NSString stringWithFormat:@"%@",total[@"net"]] firstNameLabel:@"总杆" secondNameLabel:@"净杆" thirdNameLabel:@"推杆"];
    
    
    //平均杆
    UIButton *averageBtn=[[UIButton alloc] init];
    averageBtn.backgroundColor=[UIColor yellowColor];
    CGFloat averageBtnX=totalGradeBtnX;
    CGFloat averageBtnY=totalGradeBtnY+totalGradeBtnH+10;
    CGFloat averageBtnW=totalGradeBtnW;
    CGFloat averageBtnH=totalGradeBtnH;
    averageBtn.frame=CGRectMake(averageBtnX, averageBtnY, averageBtnW, averageBtnH);
    [self.scrollView addSubview:averageBtn];
    //监听点击
    [averageBtn addTarget:self action:@selector(clickaverageBtn) forControlEvents:UIControlEventTouchUpInside];
    
    NSDictionary *average= self.professionalStatisticalModel.item_02;
    //平均杆里内容
    [self addContent:averageBtn imageView:@"20141118042246536.jpg" nameLabel:@"平均杆数" firstLabel:[NSString stringWithFormat:@"%@",average[@"average_score_par_3"]] secondLabel:[NSString stringWithFormat:@"%@",average[@"average_score_par_4"]] thirdLabel:[NSString stringWithFormat:@"%@",average[@"average_score_par_5"]] firstNameLabel:@"3杆洞" secondNameLabel:@"4杆洞" thirdNameLabel:@"5杆洞"];
    
    
    //推杆
    UIButton *pushRodBtn=[[UIButton alloc] init];
    pushRodBtn.backgroundColor=[UIColor yellowColor];
    CGFloat pushRodBtnX=totalGradeBtnX;
    CGFloat pushRodBtnY=averageBtnY+averageBtnH+10;
    CGFloat pushRodBtnW=totalGradeBtnW;
    CGFloat pushRodBtnH=totalGradeBtnH;
    pushRodBtn.frame=CGRectMake(pushRodBtnX, pushRodBtnY, pushRodBtnW, pushRodBtnH);
    [self.scrollView addSubview:pushRodBtn];

    //监听点击
    [pushRodBtn addTarget:self action:@selector(clickpushRodBtn) forControlEvents:UIControlEventTouchUpInside];

    
    NSDictionary *pushRod= self.professionalStatisticalModel.item_03;
    //推杆里内容
    [self addContent:pushRodBtn imageView:@"20141118042246536.jpg" nameLabel:@"推杆" firstLabel:[NSString stringWithFormat:@"%@",pushRod[@"average_putts"]] secondLabel:[NSString stringWithFormat:@"%@",pushRod[@"putts_per_gir"]] thirdLabel:[NSString stringWithFormat:@"%@",pushRod[@"putts_per_non_gir"]] firstNameLabel:@"平均/洞" secondNameLabel:@"标准杆" thirdNameLabel:@"大于标准杆"];
    
    
    
    
    //沙坑
    UIButton *bunkersBtn=[[UIButton alloc] init];
    bunkersBtn.backgroundColor=[UIColor yellowColor];
    CGFloat bunkersBtnX=totalGradeBtnX;
    CGFloat bunkersBtnY=pushRodBtnY+pushRodBtnH+10;
    CGFloat bunkersBtnW=totalGradeBtnW;
    CGFloat bunkersBtnH=totalGradeBtnH;
    bunkersBtn.frame=CGRectMake(bunkersBtnX, bunkersBtnY, bunkersBtnW, bunkersBtnH);
    [self.scrollView addSubview:bunkersBtn];
    
    NSDictionary *bunkers= self.professionalStatisticalModel.item_04;

    //推杆里内容
    [self addContent:bunkersBtn imageView:@"20141118042246536.jpg" nameLabel:@"沙坑" firstLabel:[NSString stringWithFormat:@"%@",bunkers[@"sand_saves"]] secondLabel:nil thirdLabel:nil firstNameLabel:@"沙坑救球（40)" secondNameLabel:nil thirdNameLabel:nil];
    
    
    
    
    
    //切杆
    UIButton *wedgeBtn=[[UIButton alloc] init];
    wedgeBtn.backgroundColor=[UIColor yellowColor];
    CGFloat wedgeBtnX=totalGradeBtnX;
    CGFloat wedgeBtnY=bunkersBtnY+bunkersBtnH+10;
    CGFloat wedgeBtnW=totalGradeBtnW;
    CGFloat wedgeBtnH=totalGradeBtnH;
    wedgeBtn.frame=CGRectMake(wedgeBtnX, wedgeBtnY, wedgeBtnW, wedgeBtnH);
    [self.scrollView addSubview:wedgeBtn];
    //切杆里内容
    NSDictionary *wedge= self.professionalStatisticalModel.item_05;
    [self addContent:wedgeBtn imageView:@"20141118042246536.jpg" nameLabel:@"切杆" firstLabel:[NSString stringWithFormat:@"%@",wedge[@"up_and_downs_count"]] secondLabel:nil thirdLabel:[NSString stringWithFormat:@"%@",wedge[@"longest_chip_ins_length"]] firstNameLabel:@"一切一推" secondNameLabel:nil thirdNameLabel:@"切杆进洞"];
    
    
    
    
    //攻果岭
    UIButton *greenBtn=[[UIButton alloc] init];
    greenBtn.backgroundColor=[UIColor yellowColor];
    CGFloat greenBtnX=totalGradeBtnX;
    CGFloat greenBtnY=wedgeBtnY+wedgeBtnH+10;
    CGFloat greenBtnW=totalGradeBtnW;
    CGFloat greenBtnH=totalGradeBtnH;
    greenBtn.frame=CGRectMake(greenBtnX, greenBtnY, greenBtnW, greenBtnH);
    [self.scrollView addSubview:greenBtn];
    //攻果岭
    NSDictionary *green= self.professionalStatisticalModel.item_06;
    [self addContent:greenBtn imageView:@"20141118042246536.jpg" nameLabel:@"攻果岭" firstLabel:[NSString stringWithFormat:@"%@",green[@"gir_percentage"]] secondLabel:[NSString stringWithFormat:@"%@",green[@"non_gir_percentage"]] thirdLabel:nil firstNameLabel:@"命中" secondNameLabel:@"未命中" thirdNameLabel:nil];
    
    
    //球道命中
    UIButton *fairwayBtn=[[UIButton alloc] init];
    fairwayBtn.backgroundColor=[UIColor yellowColor];
    CGFloat fairwayBtnX=totalGradeBtnX;
    CGFloat fairwayBtnY=greenBtnY+greenBtnH+10;
    CGFloat fairwayBtnW=totalGradeBtnW;
    CGFloat fairwayBtnH=totalGradeBtnH;
    fairwayBtn.frame=CGRectMake(fairwayBtnX, fairwayBtnY, fairwayBtnW, fairwayBtnH);
    [self.scrollView addSubview:fairwayBtn];
    //球道命中
    NSDictionary *fairway= self.professionalStatisticalModel.item_07;
    [self addContent:fairwayBtn imageView:@"20141118042246536.jpg" nameLabel:@"球道命中" firstLabel:[NSString stringWithFormat:@"%@",fairway[@"drive_fairways_hit"]] secondLabel:[NSString stringWithFormat:@"%@",fairway[@"drive_left_roughs_hit"]] thirdLabel:[NSString stringWithFormat:@"%@",fairway[@"drive_right_roughs_hit"]] firstNameLabel:@"命中" secondNameLabel:@"左侧" thirdNameLabel:@"右侧"];
    

    
    
    
    //开球
    UIButton *kickOffBtn=[[UIButton alloc] init];
    kickOffBtn.backgroundColor=[UIColor yellowColor];
    CGFloat kickOffBtnX=totalGradeBtnX;
    CGFloat kickOffBtnY=fairwayBtnY+fairwayBtnH+10;
    CGFloat kickOffBtnW=totalGradeBtnW;
    CGFloat kickOffBtnH=totalGradeBtnH;
    kickOffBtn.frame=CGRectMake(kickOffBtnX, kickOffBtnY, kickOffBtnW, kickOffBtnH);
    [self.scrollView addSubview:kickOffBtn];
    //开球
    NSDictionary *kickOff= self.professionalStatisticalModel.item_08;
    [self addContent:kickOffBtn imageView:@"20141118042246536.jpg" nameLabel:@"开球" firstLabel:[NSString stringWithFormat:@"%@",kickOff[@"longest_drive_length"]] secondLabel:[NSString stringWithFormat:@"%@",kickOff[@"average_drive_length"]] thirdLabel:[NSString stringWithFormat:@"%@",kickOff[@"good_drives"]] firstNameLabel:@"最远max" secondNameLabel:@"平均" thirdNameLabel:@"max/2"];
    
    
    //杆数
    UIButton *rodNumberBtn=[[UIButton alloc] init];
    rodNumberBtn.backgroundColor=[UIColor yellowColor];
    CGFloat rodNumberBtnX=totalGradeBtnX;
    CGFloat rodNumberBtnY=kickOffBtnY+kickOffBtnH+10;
    CGFloat rodNumberBtnW=totalGradeBtnW;
    CGFloat rodNumberBtnH=totalGradeBtnH;
    rodNumberBtn.frame=CGRectMake(rodNumberBtnX, rodNumberBtnY, rodNumberBtnW, rodNumberBtnH);
    [self.scrollView addSubview:rodNumberBtn];

    //杆数
    NSDictionary *rodNumber= self.professionalStatisticalModel.item_09;
    [self addContent:rodNumberBtn imageView:@"20141118042246536.jpg" nameLabel:@"杆数" firstLabel:[NSString stringWithFormat:@"%@",rodNumber[@"birdie"]] secondLabel:[NSString stringWithFormat:@"%@",rodNumber[@"par"]] thirdLabel:[NSString stringWithFormat:@"%@",rodNumber[@"bogey"]] firstNameLabel:@"小鸟" secondNameLabel:@"标准杆" thirdNameLabel:@"柏忌"];


    
    
    //球杆
    UIButton *cueButton=[[UIButton alloc] init];
    cueButton.backgroundColor=[UIColor yellowColor];
    CGFloat cueButtonX=totalGradeBtnX;
    CGFloat cueButtonY=rodNumberBtnY+rodNumberBtnH+10;
    CGFloat cueButtonW=totalGradeBtnW;
    CGFloat cueButtonH=150;
    cueButton.frame=CGRectMake(cueButtonX, cueButtonY, cueButtonW, cueButtonH);
    [self.scrollView addSubview:cueButton];
    [self addcueButtonContent:cueButton];
    
    
    
}

//监听点击平均干
-(void)clickaverageBtn
{
    ZCAverageViewController *averageViewController=[[ZCAverageViewController alloc] init];
    NSDictionary *averageModel=self.professionalStatisticalModel.item_02;
    averageViewController.averageModel=averageModel;
    [self.navigationController pushViewController:averageViewController animated:YES];

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
    UIImageView *imageView=[[UIImageView alloc] init];
    CGFloat imageViewW=60;
    CGFloat imageViewH=80;
    CGFloat imageViewX=10;
    CGFloat imageViewY=(button.frame.size.height-imageViewH)*0.5;
    imageView.frame=CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    imageView.image=[UIImage imageNamed:imageStr];//@"20141118042246536"
    [button addSubview:imageView];
    
    
    UILabel *nameLabel=[[UILabel alloc] init];
    CGFloat nameLabelX=imageViewX+imageViewW+10;
    CGFloat nameLabelY=imageViewY;
    CGFloat nameLabelW=60;
    CGFloat nameLabelH=20;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.text=nameLabelText;
    [button addSubview:nameLabel];
    
    //第一个数字
    UILabel *firstLabel=[[UILabel alloc] init];
    firstLabel.backgroundColor=[UIColor blueColor];
    CGFloat firstLabelX=nameLabelX;
    CGFloat firstLabelY=nameLabelY+nameLabelH+5;
    CGFloat firstLabelW=60;
    CGFloat firstLabelH=20;
    firstLabel.frame=CGRectMake(firstLabelX, firstLabelY, firstLabelW, firstLabelH);
    firstLabel.text=firstLabelText;
    [button addSubview:firstLabel];
    
    
    //第二个数字
    UILabel *secondLabel=[[UILabel alloc] init];
    secondLabel.backgroundColor=[UIColor redColor];
    CGFloat secondLabelX=firstLabelX+firstLabelW+10;
    CGFloat secondLabelY=firstLabelY;
    CGFloat secondLabelW=60;
    CGFloat secondLabelH=20;
    secondLabel.frame=CGRectMake(secondLabelX, secondLabelY, secondLabelW, secondLabelH);
    secondLabel.text=secondLabelText;
    [button addSubview:secondLabel];
    
    //第三个数字
    UILabel *thirdLabel=[[UILabel alloc] init];
    thirdLabel.backgroundColor=[UIColor yellowColor];
    CGFloat thirdLabelX=secondLabelX+secondLabelW+10;
    CGFloat thirdLabelY=firstLabelY;
    CGFloat thirdLabelW=60;
    CGFloat thirdLabelH=20;
    thirdLabel.frame=CGRectMake(thirdLabelX, thirdLabelY, thirdLabelW, thirdLabelH);
    thirdLabel.text=thirdLabelText;
    [button addSubview:thirdLabel];

    //第一个名字
    UILabel *firstNameLabel=[[UILabel alloc] init];
    firstNameLabel.backgroundColor=[UIColor blueColor];
    CGFloat firstNameLabelX=firstLabelX;
    CGFloat firstNameLabelY=firstLabelY+firstLabelH+10;
    CGFloat firstNameLabelW=60;
    CGFloat firstNameLabelH=20;
    firstNameLabel.frame=CGRectMake(firstNameLabelX, firstNameLabelY, firstNameLabelW, firstNameLabelH);
    firstNameLabel.text=firstNameLabelText;
    [button addSubview:firstNameLabel];
    
    
    //第二个名字
    UILabel *secondNameLabel=[[UILabel alloc] init];
    secondNameLabel.backgroundColor=[UIColor yellowColor];
    CGFloat secondNameLabelX=firstNameLabelX+firstNameLabelW+10 ;
    CGFloat secondNameLabelY=firstNameLabelY;
    CGFloat secondNameLabelW=60;
    CGFloat secondNameLabelH=20;
    secondNameLabel.frame=CGRectMake(secondNameLabelX, secondNameLabelY, secondNameLabelW, secondNameLabelH);
    secondNameLabel.text=secondNameLabelText;
    [button addSubview:secondNameLabel];

    //第三个名字
    UILabel *thirdNameLabel=[[UILabel alloc] init];
    thirdNameLabel.backgroundColor=[UIColor redColor];
    CGFloat thirdNameLabelX=secondNameLabelX+secondNameLabelW+10;
    CGFloat thirdNameLabelY=firstNameLabelY;
    CGFloat thirdNameLabelW=60;
    CGFloat thirdNameLabelH=20;
    thirdNameLabel.frame=CGRectMake(thirdNameLabelX, thirdNameLabelY, thirdNameLabelW, thirdNameLabelH);
    thirdNameLabel.text=thirdNameLabelText;
    [button addSubview:thirdNameLabel];
    
    
    
    //向右的箭头
    UIImageView *rightImage=[[UIImageView alloc] init];
    CGFloat rightImageW=10;
    CGFloat rightImageH=20;
    CGFloat rightImageX=SCREEN_WIDTH-rightImageW-30;
    CGFloat rightImageY=(button.frame.size.height-rightImageH)*0.5;
    rightImage.frame=CGRectMake(rightImageX, rightImageY, rightImageW, rightImageH);
    rightImage.image=[UIImage imageNamed:@"icon_arrow-副本"];
    [button addSubview:rightImage];
    
    
    
}

//添加球杆里的内容
-(void)addcueButtonContent:(UIButton *)button
{
    UILabel *nameLabel=[[UILabel alloc] init];
    
    CGFloat nameLabelY=10;
    CGFloat nameLabelW=80;
    CGFloat nameLabelH=20;
    CGFloat nameLabelX=(button.frame.size.width-nameLabelW)*0.5;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.text=@"球杆";
    [button addSubview:nameLabel];
    
    
     UIView *firstView=[[UIView alloc] init];
     CGFloat firstViewX=10;
     CGFloat firstViewY=nameLabelY+nameLabelH+10;
     CGFloat firstViewW=(SCREEN_WIDTH-80)*0.25;
     CGFloat firstViewH=100;
     firstView.frame=CGRectMake(firstViewX, firstViewY, firstViewW, firstViewH);
     [button addSubview:firstView];
    //添加里面内容
    NSDictionary *Dict= self.professionalStatisticalModel.item_10;
    NSDictionary *firstDict=Dict[@"club_1w"];
    [self addView:firstView topLabel:@"1w" cueImageName:@"20141118042246536.jpg" codeNumber:[NSString stringWithFormat:@"%@",firstDict[@"maximum_length"]]];
    
    
    
    
    UIView *secondView=[[UIView alloc] init];
    CGFloat secondViewX=firstViewX+firstViewW+5;
    CGFloat secondViewY=firstViewY;
    CGFloat secondViewW=firstViewW;
    CGFloat secondViewH=firstViewH;
    secondView.frame=CGRectMake(secondViewX, secondViewY, secondViewW, secondViewH);
    [button addSubview:secondView];
    //添加里面内容
    NSDictionary *secondDict=Dict[@"club_3w"];
    [self addView:secondView topLabel:@"3w" cueImageName:@"20141118042246536.jpg" codeNumber:[NSString stringWithFormat:@"%@",secondDict[@"maximum_length"]]];

    
    UIView *thirdView=[[UIView alloc] init];
    CGFloat thirdViewX=secondViewX+secondViewW+5;
    CGFloat thirdViewY=firstViewY;
    CGFloat thirdViewW=firstViewW;
    CGFloat thirdViewH=firstViewH;
    thirdView.frame=CGRectMake(thirdViewX, thirdViewY, thirdViewW, thirdViewH);
    [button addSubview:thirdView];
    //添加里面内容
     NSDictionary *thirdDict=Dict[@"club_5w"];
    [self addView:thirdView topLabel:@"5w" cueImageName:@"20141118042246536.jpg" codeNumber:[NSString stringWithFormat:@"%@",thirdDict[@"maximum_length"]]];
    
    UIView *fourthView=[[UIView alloc] init];
    
    CGFloat fourthViewX=thirdViewX+thirdViewW+5;
    CGFloat fourthViewY=firstViewY;
    CGFloat fourthViewW=firstViewW;
    CGFloat fourthViewH=firstViewH;
    fourthView.frame=CGRectMake(fourthViewX, fourthViewY, fourthViewW, fourthViewH);
    [button addSubview:fourthView];
    //添加里面内容
    NSDictionary *fourthDict=Dict[@"club_7w"];
    [self addView:fourthView topLabel:@"7w" cueImageName:@"20141118042246536.jpg" codeNumber:[NSString stringWithFormat:@"%@",fourthDict[@"maximum_length"]]];
    
    //向右的箭头
    UIImageView *rightImage=[[UIImageView alloc] init];
    CGFloat rightImageW=10;
    CGFloat rightImageH=20;
    CGFloat rightImageX=SCREEN_WIDTH-rightImageW-30;
    CGFloat rightImageY=(button.frame.size.height-rightImageH)*0.5;
    rightImage.frame=CGRectMake(rightImageX, rightImageY, rightImageW, rightImageH);
    rightImage.image=[UIImage imageNamed:@"icon_arrow-副本"];
    [button addSubview:rightImage];
    
}


//添加球杆里的内容的view内容
-(void)addView:(UIView *)view topLabel:(NSString *)cueName cueImageName:(NSString *)imageStr codeNumber:(NSString *)codeNumber
{
    UILabel *nameLabel=[[UILabel alloc] init];
    CGFloat nameLabelW=view.frame.size.width;
    CGFloat nameLabelH=20;
    CGFloat nameLabelX=0;
    CGFloat nameLabelY=0;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.text=cueName;
    nameLabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:nameLabel];
    
    UIImageView *imageView=[[UIImageView alloc] init];
    CGFloat imageViewW=view.frame.size.width;
    CGFloat imageViewH=50;
    CGFloat imageViewX=0;
    CGFloat imageViewY=nameLabelH;
    imageView.frame=CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    imageView.image=[UIImage imageNamed:imageStr];
    [view addSubview:imageView];
    
    UILabel *codeNumberLabel=[[UILabel alloc] init];
    CGFloat codeNumberLabelW=view.frame.size.width;
    CGFloat codeNumberLabelH=20;
    CGFloat codeNumberLabelX=0;
    CGFloat codeNumberLabelY=imageViewY+imageViewH;
    codeNumberLabel.frame=CGRectMake(codeNumberLabelX, codeNumberLabelY, codeNumberLabelW, codeNumberLabelH);
    codeNumberLabel.textAlignment=NSTextAlignmentCenter;
    codeNumberLabel.text=codeNumber;
    [view addSubview:codeNumberLabel];
    

    


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
