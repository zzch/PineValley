//
//  ZCPushRodViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/4/14.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCPushRodViewController.h"

@interface ZCPushRodViewController ()
@property(nonatomic,assign)int index;
@property(nonatomic,assign)int index2;
//
@property(nonatomic,weak)UIScrollView *scrollView;
@end

@implementation ZCPushRodViewController

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
    
    [self addChildControls:firstView imageStr:@"20141118042246536.jpg" numberStr:[NSString stringWithFormat:@"%@",self.pushRodModel[@"average_putts"]] nameStr:@"平均推杆数"];
    
    UIView *secendView=[[UIView alloc] init];
    CGFloat secendViewX=0;
    CGFloat secendViewY=firstViewY+firstViewH;
    CGFloat secendViewW=firstViewW;
    CGFloat secendViewH=firstViewH;
    secendView.frame=CGRectMake(secendViewX, secendViewY, secendViewW, secendViewH);
    [topView addSubview:secendView];
    //[self addChildControls:secendView imageStr:@"20141118042246536.jpg" numberStr:[NSString stringWithFormat:@"%@",self.averageModel[@"average_score_par_4"]] nameStr:@"4杆洞"];
   [self addChildControls:secendView imageStr:@"20141118042246536.jpg" numberStr:[NSString stringWithFormat:@"%@",self.pushRodModel[@"putts_per_gir"]] nameStr:@"GIR平均推杆数"];
    
    
    UIView *thirdView=[[UIView alloc] init];
    thirdView.backgroundColor=[UIColor redColor];
    CGFloat thirdViewX=0;
    CGFloat thirdViewY=secendViewY+secendViewH;
    CGFloat thirdViewW=firstViewW;
    CGFloat thirdViewH=firstViewH;
    thirdView.frame=CGRectMake(thirdViewX, thirdViewY, thirdViewW, thirdViewH);
    [topView addSubview:thirdView];
    //[self addChildControls:thirdView imageStr:@"20141118042246536.jpg" numberStr:[NSString stringWithFormat:@"%@",self.averageModel[@"average_score_par_5"]] nameStr:@"5杆洞"];
    
    [self addChildControls:thirdView imageStr:@"20141118042246536.jpg" numberStr:[NSString stringWithFormat:@"%@",self.pushRodModel[@"putts_per_non_gir"]] nameStr:@"大于GIR平均推杆数"];
    //右边图片
    UIImageView *barChartImage=[[UIImageView alloc] init];
    CGFloat barChartImageX=topViewH+10;
    CGFloat barChartImageY=20;
    CGFloat barChartImageW=100;
    CGFloat barChartImageH=100;
    barChartImage.frame=CGRectMake(barChartImageX, barChartImageY, barChartImageW, barChartImageH);
    barChartImage.image=[UIImage imageNamed:@"20141118042246536.jpg"];
    [self.scrollView addSubview:barChartImage];
    
    
    
    
    
    UIView *middleView=[[UIView alloc] init];
    CGFloat middleViewX=0;
    CGFloat middleViewY=topViewY+topViewH+20;
    CGFloat middleViewW=SCREEN_WIDTH;
    CGFloat middleViewH=200;
    middleView.frame=CGRectMake(middleViewX, middleViewY, middleViewW, middleViewH);
    [self.scrollView addSubview:middleView];
    //添加中间按钮
    [self addMiddleViewControls:middleView];
    
    
    //中间第三个View
    UIView *middlethirdView=[[UIView alloc] init];
    CGFloat middlethirdViewX=0;
    CGFloat middlethirdViewY=middleViewY+middleViewH+20;
    CGFloat middlethirdViewW=SCREEN_WIDTH;
    CGFloat middlethirdViewH=200;
    middlethirdView.frame=CGRectMake(middlethirdViewX, middlethirdViewY, middlethirdViewW, middlethirdViewH);
    [self.scrollView addSubview:middlethirdView];
    //添加middlethirdView的内容
    [self addMiddlethirdViewControls:middlethirdView];
    
    
    
    //中间第四个View
    UIView *middleFourthView=[[UIView alloc] init];
    CGFloat middleFourthViewX=0;
    CGFloat middleFourthViewY=middlethirdViewY+middlethirdViewH+20;
    CGFloat middleFourthViewW=SCREEN_WIDTH;
    CGFloat middleFourthViewH=200;
    middleFourthView.frame=CGRectMake(middleFourthViewX, middleFourthViewY, middleFourthViewW, middleFourthViewH);
    [self.scrollView addSubview:middleFourthView];
    NSDictionary *distance_0_1=self.pushRodModel[@"distance_0_1_from_hole_in_green"];
    [self addMiddleViewControls:middleFourthView codeStr:@"10-20码" tryStr:[NSString stringWithFormat:@"%@",distance_0_1[@"per_round"]] averageStr:[NSString stringWithFormat:@"%@",distance_0_1[@"shots_to_hole"]] ALeverToPromote:distance_0_1[@"holed_percentage"] averageRemainingYards:[NSString stringWithFormat:@"%@",distance_0_1[@"dispersion"]]];

    //中间第五个View
    UIView *middleFifthView=[[UIView alloc] init];
    CGFloat middleFifthViewX=0;
    CGFloat middleFifthViewY=middleFourthViewY+middleFourthViewH+20;
    CGFloat middleFifthViewW=SCREEN_WIDTH;
    CGFloat middleFifthViewH=200;
    middleFifthView.frame=CGRectMake(middleFifthViewX, middleFifthViewY, middleFifthViewW, middleFifthViewH);
    [self.scrollView addSubview:middleFifthView];
    //添加里面内容
    NSDictionary *distance_0_2=self.pushRodModel[@"distance_1_2_from_hole_in_green"];
    [self addMiddleViewControls:middleFifthView codeStr:@"20-30码" tryStr:[NSString stringWithFormat:@"%@",distance_0_2[@"per_round"]] averageStr:[NSString stringWithFormat:@"%@",distance_0_2[@"shots_to_hole"]] ALeverToPromote:distance_0_2[@"holed_percentage"] averageRemainingYards:[NSString stringWithFormat:@"%@",distance_0_2[@"dispersion"]]];

    
    //中间第六个View
    UIView *middleSixthView=[[UIView alloc] init];
    CGFloat middleSixthViewX=0;
    CGFloat middleSixthViewY=middleFifthViewY+middleFifthViewH+20;
    CGFloat middleSixthViewW=SCREEN_WIDTH;
    CGFloat middleSixthViewH=200;
    middleSixthView.frame=CGRectMake(middleSixthViewX, middleSixthViewY, middleSixthViewW, middleSixthViewH);
    [self.scrollView addSubview:middleSixthView];
    
    //添加里面内容
    NSDictionary *distance_0_3=self.pushRodModel[@"distance_2_3_from_hole_in_green"];
    [self addMiddleViewControls:middleSixthView codeStr:@"30-40码" tryStr:[NSString stringWithFormat:@"%@",distance_0_3[@"per_round"]] averageStr:[NSString stringWithFormat:@"%@",distance_0_3[@"shots_to_hole"]] ALeverToPromote:distance_0_3[@"holed_percentage"] averageRemainingYards:[NSString stringWithFormat:@"%@",distance_0_3[@"dispersion"]]];
    
    

    
    UIView *middleSeventhView=[[UIView alloc] init];
    CGFloat middleSeventhViewX=0;
    CGFloat middleSeventhViewY=middleSixthViewY+middleSixthViewH+20;
    CGFloat middleSeventhViewW=SCREEN_WIDTH;
    CGFloat middleSeventhViewH=200;
    middleSeventhView.frame=CGRectMake(middleSeventhViewX, middleSeventhViewY, middleSeventhViewW, middleSeventhViewH);
    [self.scrollView addSubview:middleSeventhView];
    
    //添加里面内容
    NSDictionary *distance_0_4=self.pushRodModel[@"distance_3_5_from_hole_in_green"];
    [self addMiddleViewControls:middleSeventhView codeStr:@"40-50码" tryStr:[NSString stringWithFormat:@"%@",distance_0_4[@"per_round"]] averageStr:[NSString stringWithFormat:@"%@",distance_0_4[@"shots_to_hole"]] ALeverToPromote:distance_0_4[@"holed_percentage"] averageRemainingYards:[NSString stringWithFormat:@"%@",distance_0_4[@"dispersion"]]];


}



//最后4个模型View 调用创建
-(void)addMiddleViewControls:(UIView *)view codeStr:(NSString *)codeStr tryStr:(NSString *)tryStr averageStr:(NSString *)averageStr  ALeverToPromote:(NSString *)leverStr  averageRemainingYards :(NSString *)averageRemainingYards
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
    CGFloat firstNumberW=SCREEN_WIDTH/4;
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
    thirdNumber.text=leverStr;
    thirdNumber.textAlignment=NSTextAlignmentCenter;
    [view addSubview:thirdNumber];
    
    
    UILabel *fourthNumber=[[UILabel alloc] init];
    CGFloat fourthNumberX=thirdNumberX+thirdNumberW;
    CGFloat fourthNumberY=firstNumberY;
    CGFloat fourthNumberW=firstNumberW;
    CGFloat fourthNumberH=30;
    fourthNumber.frame=CGRectMake(fourthNumberX, fourthNumberY, fourthNumberW, fourthNumberH);
    fourthNumber.text=averageRemainingYards;
    fourthNumber.textAlignment=NSTextAlignmentCenter;
    [view addSubview:fourthNumber];
    
    
    
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
    thirdNameLabel.text=@"一杆推进";
    thirdNameLabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:thirdNameLabel];
    
    
    UILabel *fourthNameLabel=[[UILabel alloc] init];
    CGFloat fourthNameLabelX=fourthNumberX;
    CGFloat fourthNameLabelY=firstNameLabelY;
    CGFloat fourthNameLabelW=firstNumberW;
    CGFloat fourthNameLabelH=firstNameLabelH;
    fourthNameLabel.frame=CGRectMake(fourthNameLabelX, fourthNameLabelY, fourthNameLabelW, fourthNameLabelH);
    fourthNameLabel.text=@"第一推后剩";
    fourthNameLabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:fourthNameLabel];
    
    UILabel *fifthNameLabel=[[UILabel alloc] init];
    CGFloat fifthNameLabelX=fourthNumberX;
    CGFloat fifthNameLabelY=fourthNameLabelY+fourthNameLabelH;
    CGFloat fifthNameLabellW=firstNumberW;
    CGFloat fifthNameLabelH=firstNameLabelH;
    fifthNameLabel.frame=CGRectMake(fifthNameLabelX, fifthNameLabelY, fifthNameLabellW, fifthNameLabelH);
    fifthNameLabel.text=@"余平均码数";
    fifthNameLabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:fifthNameLabel];




}



//添加middlethirdView的内容
-(void)addMiddlethirdViewControls:(UIView *)middlethirdView
{
    UIImageView *personImage=[[UIImageView alloc] init];
    CGFloat personImageX=30;
    CGFloat personImageY=10;
    CGFloat personImageW=20;
    CGFloat personImageH=20;
    personImage.frame=CGRectMake(personImageX, personImageY, personImageW, personImageH);
    personImage.image=[UIImage imageNamed:@"20141118042246536.jpg"];
    [middlethirdView addSubview:personImage];
    
    UILabel *nameLabel=[[UILabel alloc] init];
    CGFloat nameLabelX=personImageX+personImageW+10;
    CGFloat nameLabelY=personImageY;
    CGFloat nameLabelW=200;
    CGFloat nameLabelH=20;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.text=@"最后一推码数的平均数";
    [middlethirdView addSubview:nameLabel];
    //提示按钮
    UIButton *promptBtn=[[UIButton alloc] init];
    CGFloat promptBtnX=nameLabelX+nameLabelW+10;
    CGFloat promptBtnY=personImageY;
    CGFloat promptBtnW=20;
    CGFloat promptBtnH=20;
    promptBtn.frame=CGRectMake(promptBtnX, promptBtnY, promptBtnW, promptBtnH);
    [promptBtn setImage:[UIImage imageNamed:@"20141118042246536.jpg"]
               forState:UIControlStateNormal];
    promptBtn.tag=1007;
    [promptBtn addTarget:self action:@selector(clickpromptishi:) forControlEvents:UIControlEventTouchUpInside];
    [middlethirdView addSubview:promptBtn];
    

    //
    UILabel *numberLabel=[[UILabel alloc] init];
    CGFloat numberLabelX=0;
    CGFloat numberLabelY=personImageY+personImageH+10;
    CGFloat numberLabelW=SCREEN_WIDTH;
    CGFloat numberLabelH=70;
    numberLabel.frame=CGRectMake(numberLabelX, numberLabelY, numberLabelW, numberLabelH);
    numberLabel.text=[NSString stringWithFormat:@"%@",self.pushRodModel[@"holed_putt_length"]];
    numberLabel.textAlignment=NSTextAlignmentCenter;
    [middlethirdView addSubview:numberLabel];
    

}

//添加中间View内容
-(void)addMiddleViewControls:(UIView *)view
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
    CGFloat nameLabelW=200;
    CGFloat nameLabelH=20;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.text=@"第一次推杆后距离球洞码数的平均数";//[NSString stringWithFormat:@"救平标准杆率%@/%@ (%@)",self.averageModel[@"scrambles"],self.averageModel[@"non_gir"],self.averageModel[@"scrambles_percentage"]];
    [view addSubview:nameLabel];
    //提示按钮
    UIButton *promptBtn=[[UIButton alloc] init];
    CGFloat promptBtnX=nameLabelX+nameLabelW+10;
    CGFloat promptBtnY=personImageY;
    CGFloat promptBtnW=20;
    CGFloat promptBtnH=20;
    promptBtn.frame=CGRectMake(promptBtnX, promptBtnY, promptBtnW, promptBtnH);
    [promptBtn setImage:[UIImage imageNamed:@"20141118042246536.jpg"]
               forState:UIControlStateNormal];
    promptBtn.tag=1006;
    [promptBtn addTarget:self action:@selector(clickpromptishi:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:promptBtn];

    
    UILabel *firstNumberLaber=[[UILabel alloc] init];
    CGFloat  firstNumberLaberX=0;
    CGFloat  firstNumberLaberY=personImageY+personImageH+10;
    CGFloat  firstNumberLaberW=SCREEN_WIDTH/3;
    CGFloat  firstNumberLaberH=30;
    firstNumberLaber.frame=CGRectMake(firstNumberLaberX, firstNumberLaberY, firstNumberLaberW, firstNumberLaberH);
    firstNumberLaber.textAlignment=NSTextAlignmentCenter;
    firstNumberLaber.text=[NSString stringWithFormat:@"%@",self.pushRodModel[@"first_putt_length"]];
    [view addSubview:firstNumberLaber];
    
    //没秋冬
    UILabel *firstNameLaber=[[UILabel alloc] init];
    CGFloat  firstNameLaberX=firstNumberLaberX;
    CGFloat  firstNameLaberY=firstNumberLaberY+firstNumberLaberH+10;
    CGFloat  firstNameLaberW=firstNumberLaberW;
    CGFloat  firstNameLaberH=20;
    firstNameLaber.frame=CGRectMake(firstNameLaberX, firstNameLaberY, firstNameLaberW, firstNameLaberH);
    firstNameLaber.textAlignment=NSTextAlignmentCenter;
    firstNameLaber.text=@"每球洞";
    [view addSubview:firstNameLaber];

    
    //第二组
    UILabel *secondNumberLaber=[[UILabel alloc] init];
    CGFloat  secondNumberLaberX=firstNumberLaberX+firstNumberLaberW;
    CGFloat  secondNumberLaberY=firstNumberLaberY;
    CGFloat  secondNumberLaberW=SCREEN_WIDTH/3;
    CGFloat  secondNumberLaberH=30;
    secondNumberLaber.frame=CGRectMake(secondNumberLaberX, secondNumberLaberY, secondNumberLaberW, secondNumberLaberH);
    secondNumberLaber.textAlignment=NSTextAlignmentCenter;
    secondNumberLaber.text=[NSString stringWithFormat:@"%@",self.pushRodModel[@"first_putt_length_gir"]];
    [view addSubview:secondNumberLaber];
    
    
    UILabel *secondNameLaber=[[UILabel alloc] init];
    CGFloat  secondNameLaberX=secondNumberLaberX;
    CGFloat  secondNameLaberY=secondNumberLaberY+secondNumberLaberH+10;
    CGFloat  secondNameLaberW=firstNumberLaberW;
    CGFloat  secondNameLaberH=20;
    secondNameLaber.frame=CGRectMake(secondNameLaberX, secondNameLaberY, secondNameLaberW, secondNameLaberH);
    secondNameLaber.textAlignment=NSTextAlignmentCenter;
    secondNameLaber.text=@"每GIR";
    [view addSubview:secondNameLaber];
    
    
    //第三组
    UILabel *thirdNumberLaber=[[UILabel alloc] init];
    CGFloat  thirdNumberLaberX=secondNumberLaberX+secondNumberLaberW;
    CGFloat  thirdNumberLaberY=firstNumberLaberY;
    CGFloat  thirdNumberLaberW=SCREEN_WIDTH/3;
    CGFloat  thirdNumberLaberH=30;
    thirdNumberLaber.frame=CGRectMake(thirdNumberLaberX, thirdNumberLaberY, thirdNumberLaberW, thirdNumberLaberH);
    thirdNumberLaber.textAlignment=NSTextAlignmentCenter;
    thirdNumberLaber.text=[NSString stringWithFormat:@"%@",self.pushRodModel[@"first_putt_length_non_gir"]];
    [view addSubview:thirdNumberLaber];
    

    UILabel *thirdNameLaber=[[UILabel alloc] init];
    CGFloat  thirdNameLaberX=thirdNumberLaberX;
    CGFloat  thirdNameLaberY=thirdNumberLaberY+thirdNumberLaberH+10;
    CGFloat  thirdNameLaberW=firstNumberLaberW;
    CGFloat  thirdNameLaberH=20;
    thirdNameLaber.frame=CGRectMake(thirdNameLaberX, thirdNameLaberY, thirdNameLaberW, thirdNameLaberH);
    thirdNameLaber.textAlignment=NSTextAlignmentCenter;
    thirdNameLaber.text=@"non-GIR";
    [view addSubview:thirdNameLaber];
    
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


//提示按钮点击
-(void)clickpromptishi:(UIButton *)btn
{
    

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
