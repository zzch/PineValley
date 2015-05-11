//
//  ZCBunkersViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/4/15.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCBunkersViewController.h"

@interface ZCBunkersViewController ()
@property(nonatomic,weak)UIScrollView *scrollView;
@property(nonatomic,assign)int index;
@property(nonatomic,assign)int index2;

@end

@implementation ZCBunkersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addControls];
}




//添加控件
-(void)addControls
{
    UIScrollView *scrollView=[[UIScrollView alloc] init];
    scrollView.frame=[UIScreen mainScreen].bounds;
    self.scrollView=scrollView;
    [self.view addSubview:scrollView];
    
    scrollView.contentSize = CGSizeMake(0,SCREEN_HEIGHT+2200 );
    
    
    
    
    UIView *topView=[[UIView alloc] init];
    CGFloat topViewX=0;
    CGFloat topViewY=0;
    CGFloat topViewW=SCREEN_WIDTH;
    CGFloat topViewH=150;
    topView.frame=CGRectMake(topViewX, topViewY, topViewW, topViewH);
    [self.scrollView addSubview:topView];
    
    
    UIView *firstView=[[UIView alloc] init];
    CGFloat firstViewX=0;
    CGFloat firstViewY=10;
    CGFloat firstViewW=120;
    CGFloat firstViewH=50;
    firstView.frame=CGRectMake(firstViewX, firstViewY, firstViewW, firstViewH);
    [topView addSubview:firstView];
    
    [self addChildControls:firstView imageStr:@"20141118042246536.jpg" numberStr:[NSString stringWithFormat:@"%@",self.bunkersModel[@"bunker_shots"]] nameStr:@"沙坑救球"];
    
    UIView *secendView=[[UIView alloc] init];
    CGFloat secendViewX=0;
    CGFloat secendViewY=firstViewY+firstViewH;
    CGFloat secendViewW=firstViewW;
    CGFloat secendViewH=firstViewH;
    secendView.frame=CGRectMake(secendViewX, secendViewY, secendViewW, secendViewH);
    [topView addSubview:secendView];
   
   [self addChildControls:secendView imageStr:@"20141118042246536.jpg" numberStr:[NSString stringWithFormat:@"%@",self.bunkersModel[@"bunker_shots"]] nameStr:@"进入沙坑"];
    
    
    UIView *thirdView=[[UIView alloc] init];
    thirdView.backgroundColor=[UIColor redColor];
    CGFloat thirdViewX=0;
    CGFloat thirdViewY=secendViewY+secendViewH;
    CGFloat thirdViewW=firstViewW;
    CGFloat thirdViewH=firstViewH;
    thirdView.frame=CGRectMake(thirdViewX, thirdViewY, thirdViewW, thirdViewH);
    [topView addSubview:thirdView];
   
    [self addChildControls:thirdView imageStr:@"20141118042246536.jpg" numberStr:[NSString stringWithFormat:@"%@",self.bunkersModel[@"sand_saves_percentage"]] nameStr:@"成功率"];
    //右边图片
    UIImageView *barChartImage=[[UIImageView alloc] init];
    CGFloat barChartImageX=topViewH+10;
    CGFloat barChartImageY=20;
    CGFloat barChartImageW=100;
    CGFloat barChartImageH=100;
    barChartImage.frame=CGRectMake(barChartImageX, barChartImageY, barChartImageW, barChartImageH);
    barChartImage.image=[UIImage imageNamed:@"20141118042246536.jpg"];
    [self.scrollView addSubview:barChartImage];
    
    
    
    //最后四个View
    
    //中间第四个View
    UIView *middleFourthView=[[UIView alloc] init];
    CGFloat middleFourthViewX=0;
    CGFloat middleFourthViewY=topViewY+topViewH+20;
    CGFloat middleFourthViewW=SCREEN_WIDTH;
    CGFloat middleFourthViewH=150;
    middleFourthView.frame=CGRectMake(middleFourthViewX, middleFourthViewY, middleFourthViewW, middleFourthViewH);
    [self.scrollView addSubview:middleFourthView];
    NSDictionary *distance_0_1=self.bunkersModel[@"distance_0_10_from_hole_in_bunker"];
    [self addMiddleViewControls:middleFourthView codeStr:@"0 - 10 码" tryStr:[NSString stringWithFormat:@"%@",distance_0_1[@"per_round"]] averageStr:[NSString stringWithFormat:@"%@",distance_0_1[@"shots_to_hole"]] averageRemainingYards:[NSString stringWithFormat:@"%@",distance_0_1[@"dispersion"]]];

    
    //中间第五个View
    UIView *middleFifthView=[[UIView alloc] init];
    CGFloat middleFifthViewX=0;
    CGFloat middleFifthViewY=middleFourthViewY+middleFourthViewH+20;
    CGFloat middleFifthViewW=SCREEN_WIDTH;
    CGFloat middleFifthViewH=200;
    middleFifthView.frame=CGRectMake(middleFifthViewX, middleFifthViewY, middleFifthViewW, middleFifthViewH);
    [self.scrollView addSubview:middleFifthView];
    
    NSDictionary *distance_0_2=self.bunkersModel[@"distance_10_20_from_hole_in_bunker"];
    [self addMiddleViewControls:middleFifthView codeStr:@"10 - 20 码" tryStr:[NSString stringWithFormat:@"%@",distance_0_2[@"per_round"]] averageStr:[NSString stringWithFormat:@"%@",distance_0_2[@"shots_to_hole"]] averageRemainingYards:[NSString stringWithFormat:@"%@",distance_0_2[@"dispersion"]]];
    //中间第六个View
    UIView *middleSixthView=[[UIView alloc] init];
    CGFloat middleSixthViewX=0;
    CGFloat middleSixthViewY=middleFifthViewY+middleFifthViewH+20;
    CGFloat middleSixthViewW=SCREEN_WIDTH;
    CGFloat middleSixthViewH=200;
    middleSixthView.frame=CGRectMake(middleSixthViewX, middleSixthViewY, middleSixthViewW, middleSixthViewH);
    [self.scrollView addSubview:middleSixthView];
    
    
    NSDictionary *distance_0_3=self.bunkersModel[@"distance_20_50_from_hole_in_bunker"];
    [self addMiddleViewControls:middleSixthView codeStr:@"20 - 50 码" tryStr:[NSString stringWithFormat:@"%@",distance_0_3[@"per_round"]] averageStr:[NSString stringWithFormat:@"%@",distance_0_3[@"shots_to_hole"]] averageRemainingYards:[NSString stringWithFormat:@"%@",distance_0_3[@"dispersion"]]];
    
    
    
    UIView *middleSeventhView=[[UIView alloc] init];
    CGFloat middleSeventhViewX=0;
    CGFloat middleSeventhViewY=middleSixthViewY+middleSixthViewH+20;
    CGFloat middleSeventhViewW=SCREEN_WIDTH;
    CGFloat middleSeventhViewH=200;
    middleSeventhView.frame=CGRectMake(middleSeventhViewX, middleSeventhViewY, middleSeventhViewW, middleSeventhViewH);
    [self.scrollView addSubview:middleSeventhView];
    
    NSDictionary *distance_0_4=self.bunkersModel[@"distance_50_100_from_hole_in_bunker"];
    [self addMiddleViewControls:middleSeventhView codeStr:@"50 - 100 码" tryStr:[NSString stringWithFormat:@"%@",distance_0_4[@"per_round"]] averageStr:[NSString stringWithFormat:@"%@",distance_0_4[@"shots_to_hole"]] averageRemainingYards:[NSString stringWithFormat:@"%@",distance_0_4[@"dispersion"]]];

    
}


//最后4个模型View 调用创建
-(void)addMiddleViewControls:(UIView *)view codeStr:(NSString *)codeStr tryStr:(NSString *)tryStr averageStr:(NSString *)averageStr  averageRemainingYards :(NSString *)averageRemainingYards
{
    UIImageView *personImage=[[UIImageView alloc] init];
    CGFloat personImageX=30;
    CGFloat personImageY=10;
    CGFloat personImageW=20;
    CGFloat personImageH=20;
    personImage.frame=CGRectMake(personImageX, personImageY, personImageW, personImageH);
    personImage.image=[UIImage imageNamed:@"20141118042246536.jpg"];
    [view addSubview:personImage];
    
    UILabel *nameLabel=[[UILabel alloc] init];
    CGFloat nameLabelX=personImageX+personImageW+10;
    CGFloat nameLabelY=personImageY;
    CGFloat nameLabelW=100;
    CGFloat nameLabelH=20;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.text=@"距离球洞";
    [view addSubview:nameLabel];
    
    UILabel *codeLabel=[[UILabel alloc] init];
    CGFloat codeLabelX=nameLabelX+nameLabelW+10;
    CGFloat codeLabelY=personImageY;
    CGFloat codeLabelW=100;
    CGFloat codeLabelH=20;
    codeLabel.frame=CGRectMake(codeLabelX, codeLabelY, codeLabelW, codeLabelH);
    codeLabel.text=codeStr;
    [view addSubview:codeLabel];
    
    
    
    //提示按钮
    UIButton *promptBtn=[[UIButton alloc] init];
    CGFloat promptBtnX=codeLabelX+codeLabelW+10;
    CGFloat promptBtnY=personImageY;
    CGFloat promptBtnW=20;
    CGFloat promptBtnH=20;
    promptBtn.frame=CGRectMake(promptBtnX, promptBtnY, promptBtnW, promptBtnH);
    [promptBtn setImage:[UIImage imageNamed:@"20141118042246536.jpg"]
               forState:UIControlStateNormal];
    self.index++;
    promptBtn.tag=self.index+1000;
    [promptBtn addTarget:self action:@selector(clickpromptishi:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:promptBtn];
    
    //第一行
    UILabel *firstNumber=[[UILabel alloc] init];
    CGFloat firstNumberX=0;
    CGFloat firstNumberY=personImageY+personImageH;
    CGFloat firstNumberW=SCREEN_WIDTH/3;
    CGFloat firstNumberH=30;
    firstNumber.frame=CGRectMake(firstNumberX, firstNumberY, firstNumberW, firstNumberH);
    firstNumber.text=tryStr;
    firstNumber.textAlignment=NSTextAlignmentCenter;
    [view addSubview:firstNumber];
    
    
    
    UILabel *secondNumber=[[UILabel alloc] init];
    CGFloat secondNumberX=firstNumberX+firstNumberW;
    CGFloat secondNumberY=firstNumberY;
    CGFloat secondNumberW=firstNumberW;
    CGFloat secondNumberH=30;
    secondNumber.frame=CGRectMake(secondNumberX, secondNumberY, secondNumberW, secondNumberH);
    secondNumber.text=averageStr;
    secondNumber.textAlignment=NSTextAlignmentCenter;
    [view addSubview:secondNumber];
    
    
    UILabel *thirdNumber=[[UILabel alloc] init];
    CGFloat thirdNumberX=secondNumberX+secondNumberW;
    CGFloat thirdNumberY=firstNumberY;
    CGFloat thirdNumberW=firstNumberW;
    CGFloat thirdNumberH=30;
    thirdNumber.frame=CGRectMake(thirdNumberX, thirdNumberY, thirdNumberW, thirdNumberH);
    thirdNumber.text=averageRemainingYards;
    thirdNumber.textAlignment=NSTextAlignmentCenter;
    [view addSubview:thirdNumber];
    
//    
//    UILabel *fourthNumber=[[UILabel alloc] init];
//    CGFloat fourthNumberX=thirdNumberX+thirdNumberW;
//    CGFloat fourthNumberY=firstNumberY;
//    CGFloat fourthNumberW=firstNumberW;
//    CGFloat fourthNumberH=30;
//    fourthNumber.frame=CGRectMake(fourthNumberX, fourthNumberY, fourthNumberW, fourthNumberH);
//    fourthNumber.text=averageRemainingYards;
//    fourthNumber.textAlignment=NSTextAlignmentCenter;
//    [view addSubview:fourthNumber];
    
    
    
    //第二行
    
    UILabel *firstNameLabel=[[UILabel alloc] init];
    CGFloat firstNameLabelX=firstNumberX;
    CGFloat firstNameLabelY=firstNumberY+firstNumberH;
    CGFloat firstNameLabelW=firstNumberW;
    CGFloat firstNameLabelH=25;
    firstNameLabel.frame=CGRectMake(firstNameLabelX, firstNameLabelY, firstNameLabelW, firstNameLabelH);
    firstNameLabel.text=@"尝试次数";
    firstNameLabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:firstNameLabel];
    
    
    UILabel *secondNameLabel=[[UILabel alloc] init];
    CGFloat secondNameLabelX=secondNumberX;
    CGFloat secondNameLabelY=firstNameLabelY;
    CGFloat secondNameLabelW=firstNumberW;
    CGFloat secondNameLabelH=firstNameLabelH;
    secondNameLabel.frame=CGRectMake(secondNameLabelX, secondNameLabelY, secondNameLabelW, secondNameLabelH);
    secondNameLabel.text=@"平均杆数";
    secondNameLabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:secondNameLabel];
    
    UILabel *thirdNameLabel=[[UILabel alloc] init];
    CGFloat thirdNameLabelX=thirdNumberX;
    CGFloat thirdNameLabelY=firstNameLabelY;
    CGFloat thirdNameLabelW=firstNumberW;
    CGFloat thirdNameLabelH=firstNameLabelH;
    thirdNameLabel.frame=CGRectMake(thirdNameLabelX, thirdNameLabelY, thirdNameLabelW, thirdNameLabelH);
    thirdNameLabel.text=@"第一推后剩";
    thirdNameLabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:thirdNameLabel];
    
    
//    UILabel *fourthNameLabel=[[UILabel alloc] init];
//    CGFloat fourthNameLabelX=thirdNumberX;
//    CGFloat fourthNameLabelY=firstNameLabelY;
//    CGFloat fourthNameLabelW=firstNumberW;
//    CGFloat fourthNameLabelH=firstNameLabelH;
//    fourthNameLabel.frame=CGRectMake(fourthNameLabelX, fourthNameLabelY, fourthNameLabelW, fourthNameLabelH);
//    fourthNameLabel.text=@"余平均码数";
//    fourthNameLabel.textAlignment=NSTextAlignmentCenter;
//    [view addSubview:fourthNameLabel];
    
    UILabel *fifthNameLabel=[[UILabel alloc] init];
    CGFloat fifthNameLabelX=thirdNumberX;
    CGFloat fifthNameLabelY=thirdNameLabelY+thirdNameLabelH;
    CGFloat fifthNameLabellW=firstNumberW;
    CGFloat fifthNameLabelH=firstNameLabelH;
    fifthNameLabel.frame=CGRectMake(fifthNameLabelX, fifthNameLabelY, fifthNameLabellW, fifthNameLabelH);
    fifthNameLabel.text=@"余平均码数";
    fifthNameLabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:fifthNameLabel];
    
    
    
    
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
    CGFloat nameLabelX=numberLabelX;
    CGFloat nameLabelW=60;
    CGFloat nameLabelH=20;
    CGFloat nameLabelY=numberLabelH+numberLabelY;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.text=nameStr;
    [childView addSubview:nameLabel];
    
    
    //提示按钮
    UIButton *promptBtn=[[UIButton alloc] init];
    CGFloat promptBtnX=nameLabelX+nameLabelW;
    CGFloat promptBtnY=nameLabelY;
    CGFloat promptBtnW=20;
    CGFloat promptBtnH=20;
    promptBtn.frame=CGRectMake(promptBtnX, promptBtnY, promptBtnW, promptBtnH);
    [promptBtn setImage:[UIImage imageNamed:@"20141118042246536.jpg"] forState:UIControlStateNormal];
    
    self.index2++;
    promptBtn.tag=self.index2+1100;
    [promptBtn addTarget:self action:@selector(clickpromptishi:) forControlEvents:UIControlEventTouchUpInside];
    
    [childView addSubview:promptBtn];
    
    
}




-(void)clickpromptishi:(UIButton *)btn
{

    
    ZCLog(@"%ld",btn.tag);
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
