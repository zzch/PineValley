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
    self.view.backgroundColor=ZCColor(237, 237, 237);
    self.navigationItem.title=@"沙坑救球";
    
    
    //返回
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barBtnItemWithNormalImageName:@"fanhui" hightImageName:@"fanhui" action:@selector(liftBthClick:) target:self];
    
    [self addControls];
}



//返回
-(void)liftBthClick:(UIButton *)btn
{
    
    [self.navigationController popViewControllerAnimated:YES];
}




//添加控件
-(void)addControls
{
    UIScrollView *scrollView=[[UIScrollView alloc] init];
    scrollView.frame=[UIScreen mainScreen].bounds;
    self.scrollView=scrollView;
    [self.view addSubview:scrollView];
    
   
    
    
    
    
    UIView *topView=[[UIView alloc] init];
    CGFloat topViewX=0;
    CGFloat topViewY=0;
    CGFloat topViewW=SCREEN_WIDTH;
    CGFloat topViewH=100;
    topView.frame=CGRectMake(topViewX, topViewY, topViewW, topViewH);
    topView.backgroundColor=ZCColor(60, 57, 78);
    [self.scrollView addSubview:topView];
    
    
    UIView *firstView=[[UIView alloc] init];
    CGFloat firstViewX=0;
    CGFloat firstViewY=0;
    CGFloat firstViewW=SCREEN_WIDTH/3-1;
    CGFloat firstViewH=100;
    firstView.frame=CGRectMake(firstViewX, firstViewY, firstViewW, firstViewH);
    firstView.tag=4111;
    [topView addSubview:firstView];
    
    [self addChildControls:firstView imageStr:@"baisewenhao" numberStr:[NSString stringWithFormat:@"%@",self.bunkersModel[@"bunker_shots"]] nameStr:@"沙坑救球"];
    
    
    
    //竖条背景色
    UIView *bjView=[[UIView alloc] initWithFrame:CGRectMake(firstViewW, 25, 0.5, topViewH-50)];
    bjView.backgroundColor=[UIColor whiteColor];
    [topView addSubview:bjView];
    
    
    UIView *secendView=[[UIView alloc] init];
    CGFloat secendViewX=firstViewX+firstViewW+0.5;
    CGFloat secendViewY=0;
    CGFloat secendViewW=firstViewW;
    CGFloat secendViewH=firstViewH;
    secendView.frame=CGRectMake(secendViewX, secendViewY, secendViewW, secendViewH);
    [topView addSubview:secendView];
   
   [self addChildControls:secendView imageStr:@"20141118042246536.jpg" numberStr:[NSString stringWithFormat:@"%@",self.bunkersModel[@"bunker_shots"]] nameStr:@"进入次数"];
    
    
    
    //竖条背景色
    UIView *bjView2=[[UIView alloc] initWithFrame:CGRectMake(secendViewX+secendViewW+0.5, 25, 0.5, topViewH-50)];
    bjView2.backgroundColor=[UIColor whiteColor];
    [topView addSubview:bjView2];
    
    
    UIView *thirdView=[[UIView alloc] init];
    
    CGFloat thirdViewX=secendViewX+secendViewW+0.5;
    CGFloat thirdViewY=0;
    CGFloat thirdViewW=firstViewW;
    CGFloat thirdViewH=firstViewH;
    thirdView.frame=CGRectMake(thirdViewX, thirdViewY, thirdViewW, thirdViewH);
    [topView addSubview:thirdView];
   
    [self addChildControls:thirdView imageStr:@"20141118042246536.jpg" numberStr:[NSString stringWithFormat:@"%@",self.bunkersModel[@"sand_saves_percentage"]] nameStr:@"成功率"];
//    //右边图片
//    UIImageView *barChartImage=[[UIImageView alloc] init];
//    CGFloat barChartImageX=topViewH+10;
//    CGFloat barChartImageY=20;
//    CGFloat barChartImageW=100;
//    CGFloat barChartImageH=100;
//    barChartImage.frame=CGRectMake(barChartImageX, barChartImageY, barChartImageW, barChartImageH);
//    barChartImage.image=[UIImage imageNamed:@"20141118042246536.jpg"];
//    [self.scrollView addSubview:barChartImage];
//    
    
    
    //最后四个View
    
    //中间第四个View
    UIView *middleFourthView=[[UIView alloc] init];
    CGFloat middleFourthViewX=0;
    CGFloat middleFourthViewY=topViewY+topViewH+20;
    CGFloat middleFourthViewW=SCREEN_WIDTH;
    CGFloat middleFourthViewH=150;
    middleFourthView.frame=CGRectMake(middleFourthViewX, middleFourthViewY, middleFourthViewW, middleFourthViewH);
    middleFourthView.backgroundColor=[UIColor whiteColor];
    [self.scrollView addSubview:middleFourthView];
    NSDictionary *distance_0_1=self.bunkersModel[@"distance_0_10_from_hole_in_bunker"];
    [self addMiddleViewControls:middleFourthView codeStr:@"0 - 10 码" tryStr:[NSString stringWithFormat:@"%@",distance_0_1[@"per_round"]] averageStr:[NSString stringWithFormat:@"%@",distance_0_1[@"shots_to_hole"]] averageRemainingYards:[NSString stringWithFormat:@"%@",distance_0_1[@"dispersion"]]];

    
    //中间第五个View
    UIView *middleFifthView=[[UIView alloc] init];
    CGFloat middleFifthViewX=0;
    CGFloat middleFifthViewY=middleFourthViewY+middleFourthViewH+1;
    CGFloat middleFifthViewW=SCREEN_WIDTH;
    CGFloat middleFifthViewH=150;
    middleFifthView.frame=CGRectMake(middleFifthViewX, middleFifthViewY, middleFifthViewW, middleFifthViewH);
    middleFifthView.backgroundColor=[UIColor whiteColor];
    [self.scrollView addSubview:middleFifthView];
    
    NSDictionary *distance_0_2=self.bunkersModel[@"distance_10_20_from_hole_in_bunker"];
    [self addMiddleViewControls:middleFifthView codeStr:@"10 - 20 码" tryStr:[NSString stringWithFormat:@"%@",distance_0_2[@"per_round"]] averageStr:[NSString stringWithFormat:@"%@",distance_0_2[@"shots_to_hole"]] averageRemainingYards:[NSString stringWithFormat:@"%@",distance_0_2[@"dispersion"]]];
    //中间第六个View
    UIView *middleSixthView=[[UIView alloc] init];
    CGFloat middleSixthViewX=0;
    CGFloat middleSixthViewY=middleFifthViewY+middleFifthViewH+1;
    CGFloat middleSixthViewW=SCREEN_WIDTH;
    CGFloat middleSixthViewH=150;
    middleSixthView.frame=CGRectMake(middleSixthViewX, middleSixthViewY, middleSixthViewW, middleSixthViewH);
    middleSixthView.backgroundColor=[UIColor whiteColor];
    [self.scrollView addSubview:middleSixthView];
    
    
    NSDictionary *distance_0_3=self.bunkersModel[@"distance_20_50_from_hole_in_bunker"];
    [self addMiddleViewControls:middleSixthView codeStr:@"20 - 50 码" tryStr:[NSString stringWithFormat:@"%@",distance_0_3[@"per_round"]] averageStr:[NSString stringWithFormat:@"%@",distance_0_3[@"shots_to_hole"]] averageRemainingYards:[NSString stringWithFormat:@"%@",distance_0_3[@"dispersion"]]];
    
    
    
    UIView *middleSeventhView=[[UIView alloc] init];
    CGFloat middleSeventhViewX=0;
    CGFloat middleSeventhViewY=middleSixthViewY+middleSixthViewH+1;
    CGFloat middleSeventhViewW=SCREEN_WIDTH;
    CGFloat middleSeventhViewH=150;
    middleSeventhView.frame=CGRectMake(middleSeventhViewX, middleSeventhViewY, middleSeventhViewW, middleSeventhViewH);
    middleSeventhView.backgroundColor=[UIColor whiteColor];
    [self.scrollView addSubview:middleSeventhView];
    
    NSDictionary *distance_0_4=self.bunkersModel[@"distance_50_100_from_hole_in_bunker"];
    [self addMiddleViewControls:middleSeventhView codeStr:@"50 - 100 码" tryStr:[NSString stringWithFormat:@"%@",distance_0_4[@"per_round"]] averageStr:[NSString stringWithFormat:@"%@",distance_0_4[@"shots_to_hole"]] averageRemainingYards:[NSString stringWithFormat:@"%@",distance_0_4[@"dispersion"]]];

    
    
    
     scrollView.contentSize = CGSizeMake(0,middleSeventhViewY+middleSeventhViewH+65);
    
}


//最后4个模型View 调用创建
-(void)addMiddleViewControls:(UIView *)view codeStr:(NSString *)codeStr tryStr:(NSString *)tryStr averageStr:(NSString *)averageStr  averageRemainingYards :(NSString *)averageRemainingYards
{
//    UIImageView *personImage=[[UIImageView alloc] init];
//    CGFloat personImageX=30;
//    CGFloat personImageY=10;
//    CGFloat personImageW=20;
//    CGFloat personImageH=20;
//    personImage.frame=CGRectMake(personImageX, personImageY, personImageW, personImageH);
//    personImage.image=[UIImage imageNamed:@"20141118042246536.jpg"];
//    [view addSubview:personImage];
    
    UILabel *nameLabel=[[UILabel alloc] init];
    CGFloat nameLabelX=10;
    CGFloat nameLabelY=21;
    CGFloat nameLabelW=100;
    CGFloat nameLabelH=20;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.text=@"距离球洞";
    nameLabel.textColor=ZCColor(255, 150, 29);
    [view addSubview:nameLabel];
    
    
    UILabel *codeLabel=[[UILabel alloc] init];
    CGFloat codeLabelX=nameLabelX+nameLabelW+10;
    CGFloat codeLabelY=nameLabelY;
    CGFloat codeLabelW=90;
    CGFloat codeLabelH=20;
    codeLabel.frame=CGRectMake(codeLabelX, codeLabelY, codeLabelW, codeLabelH);
    codeLabel.text=codeStr;
    codeLabel.textColor=ZCColor(255, 150, 29);
    [view addSubview:codeLabel];
    
    
    
    //提示按钮
    UIButton *promptBtn=[[UIButton alloc] init];
    CGFloat promptBtnX=codeLabelX+codeLabelW+5;
    CGFloat promptBtnY=nameLabelY;
    CGFloat promptBtnW=20;
    CGFloat promptBtnH=20;
    promptBtn.frame=CGRectMake(promptBtnX, promptBtnY, promptBtnW, promptBtnH);
    [promptBtn setImage:[UIImage imageNamed:@"chengsewenhao"]
               forState:UIControlStateNormal];
    self.index++;
    promptBtn.tag=self.index+1000;
    [promptBtn addTarget:self action:@selector(clickpromptishi:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:promptBtn];
    
    //第一行
    UILabel *firstNumber=[[UILabel alloc] init];
    CGFloat firstNumberX=0;
    CGFloat firstNumberY=nameLabelY+nameLabelH+20;
    CGFloat firstNumberW=SCREEN_WIDTH/4-1.5;
    CGFloat firstNumberH=50;
    firstNumber.frame=CGRectMake(firstNumberX, firstNumberY, firstNumberW, firstNumberH);
    firstNumber.text=tryStr;
    firstNumber.textAlignment=NSTextAlignmentCenter;
    
    [view addSubview:firstNumber];
    
    //背景竖条
    UIView *bjView1=[[UIView alloc]initWithFrame:CGRectMake(firstNumberX+firstNumberW, nameLabelY+nameLabelH+20, 0.5, view.frame.size.height-82)];
    bjView1.backgroundColor=ZCColor(170, 170, 170);
    [view addSubview:bjView1];
    
    UILabel *secondNumber=[[UILabel alloc] init];
    CGFloat secondNumberX=firstNumberX+firstNumberW;
    CGFloat secondNumberY=firstNumberY;
    CGFloat secondNumberW=firstNumberW;
    CGFloat secondNumberH=50;
    secondNumber.frame=CGRectMake(secondNumberX, secondNumberY, secondNumberW, secondNumberH);
    if ([averageStr isEqual:@"<null>"]) {
        secondNumber.text=@"-";
    }else
    {
    secondNumber.text=averageStr;
    }
    
    
    secondNumber.textAlignment=NSTextAlignmentCenter;
    [view addSubview:secondNumber];
    
    
    //背景竖条
    UIView *bjView2=[[UIView alloc]initWithFrame:CGRectMake(secondNumberX+secondNumberW+0.5, nameLabelY+nameLabelH+20, 0.5, view.frame.size.height-82)];
    bjView2.backgroundColor=ZCColor(170, 170, 170);
    [view addSubview:bjView2];
    
    UILabel *thirdNumber=[[UILabel alloc] init];
    CGFloat thirdNumberX=secondNumberX+secondNumberW;
    CGFloat thirdNumberY=firstNumberY;
    CGFloat thirdNumberW=firstNumberW;
    CGFloat thirdNumberH=50;
    thirdNumber.frame=CGRectMake(thirdNumberX, thirdNumberY, thirdNumberW, thirdNumberH);
    if ([averageStr isEqual:@"<null>"]) {
        thirdNumber.text=@"-";
    }else
    {
        thirdNumber.text=averageStr;
    }
    
    
    
    thirdNumber.textAlignment=NSTextAlignmentCenter;
    [view addSubview:thirdNumber];
    
    
    //背景竖条
    UIView *bjView3=[[UIView alloc]initWithFrame:CGRectMake(thirdNumberX+thirdNumberW+0.5, nameLabelY+nameLabelH+20, 0.5, view.frame.size.height-82)];
    bjView3.backgroundColor=ZCColor(170, 170, 170);
    [view addSubview:bjView3];
    
    
    UILabel *fourthNumber=[[UILabel alloc] init];
    CGFloat fourthNumberX=thirdNumberX+thirdNumberW;
    CGFloat fourthNumberY=firstNumberY;
    CGFloat fourthNumberW=firstNumberW;
    CGFloat fourthNumberH=50;
    fourthNumber.frame=CGRectMake(fourthNumberX, fourthNumberY, fourthNumberW, fourthNumberH);
    if ([averageRemainingYards isEqual:@"<null>"]) {
        fourthNumber.text=@"-";
    }else
    {
    fourthNumber.text=averageRemainingYards;
    }
    fourthNumber.textAlignment=NSTextAlignmentCenter;
    [view addSubview:fourthNumber];
    
    
    
    //第二行
    
    UILabel *firstNameLabel=[[UILabel alloc] init];
    CGFloat firstNameLabelX=firstNumberX;
    CGFloat firstNameLabelY=firstNumberY+firstNumberH;
    CGFloat firstNameLabelW=firstNumberW;
    CGFloat firstNameLabelH=20;
    firstNameLabel.frame=CGRectMake(firstNameLabelX, firstNameLabelY, firstNameLabelW, firstNameLabelH);
    firstNameLabel.text=@"尝试次数";
    firstNameLabel.textAlignment=NSTextAlignmentCenter;
    firstNameLabel.textColor=ZCColor(102, 102, 102);
    firstNameLabel.font=[UIFont systemFontOfSize:14];
    [view addSubview:firstNameLabel];
    
    
    UILabel *secondNameLabel=[[UILabel alloc] init];
    CGFloat secondNameLabelX=secondNumberX;
    CGFloat secondNameLabelY=firstNameLabelY;
    CGFloat secondNameLabelW=firstNumberW;
    CGFloat secondNameLabelH=firstNameLabelH;
    secondNameLabel.frame=CGRectMake(secondNameLabelX, secondNameLabelY, secondNameLabelW, secondNameLabelH);
    secondNameLabel.text=@"平均杆数";
    secondNameLabel.textAlignment=NSTextAlignmentCenter;
    secondNameLabel.textColor=ZCColor(102, 102, 102);
    secondNameLabel.font=[UIFont systemFontOfSize:14];
    
    [view addSubview:secondNameLabel];
    
    UILabel *thirdNameLabel=[[UILabel alloc] init];
    CGFloat thirdNameLabelX=thirdNumberX;
    CGFloat thirdNameLabelY=firstNameLabelY;
    CGFloat thirdNameLabelW=firstNumberW;
    CGFloat thirdNameLabelH=firstNameLabelH;
    thirdNameLabel.frame=CGRectMake(thirdNameLabelX, thirdNameLabelY, thirdNameLabelW, thirdNameLabelH);
    thirdNameLabel.text=@"一杆推进";
    thirdNameLabel.textAlignment=NSTextAlignmentCenter;
    thirdNameLabel.textColor=ZCColor(102, 102, 102);
    thirdNameLabel.font=[UIFont systemFontOfSize:14];
    
    [view addSubview:thirdNameLabel];
    
    
    UILabel *fourthNameLabel=[[UILabel alloc] init];
    CGFloat fourthNameLabelX=fourthNumberX;
    CGFloat fourthNameLabelY=firstNameLabelY;
    CGFloat fourthNameLabelW=firstNumberW;
    CGFloat fourthNameLabelH=firstNameLabelH;
    fourthNameLabel.frame=CGRectMake(fourthNameLabelX, fourthNameLabelY, fourthNameLabelW, fourthNameLabelH);
    fourthNameLabel.text=@"第一推后剩";
    fourthNameLabel.textAlignment=NSTextAlignmentCenter;
    fourthNameLabel.textColor=ZCColor(102, 102, 102);
    fourthNameLabel.font=[UIFont systemFontOfSize:14];
    [view addSubview:fourthNameLabel];
    
    UILabel *fifthNameLabel=[[UILabel alloc] init];
    CGFloat fifthNameLabelX=fourthNumberX;
    CGFloat fifthNameLabelY=fourthNameLabelY+fourthNameLabelH;
    CGFloat fifthNameLabellW=firstNumberW;
    CGFloat fifthNameLabelH=firstNameLabelH;
    fifthNameLabel.frame=CGRectMake(fifthNameLabelX, fifthNameLabelY, fifthNameLabellW, fifthNameLabelH);
    fifthNameLabel.text=@"余平均码数";
    fifthNameLabel.textAlignment=NSTextAlignmentCenter;
    fifthNameLabel.textColor=ZCColor(102, 102, 102);
    fifthNameLabel.font=[UIFont systemFontOfSize:14];
    [view addSubview:fifthNameLabel];
    
    
    
    
}


//添加子控件
-(void)addChildControls:(UIView *)childView  imageStr:(NSString *)imageStr  numberStr:(NSString *)numberStr  nameStr:(NSString *)nameStr
{
//    UIImageView *imageView=[[UIImageView alloc] init];
//    CGFloat imageViewX=5;
//    CGFloat imageViewW=30;
//    CGFloat imageViewH=30;
//    CGFloat imageViewY=(childView.frame.size.height-imageViewH)*0.5;
//    imageView.frame=CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
//    imageView.image=[UIImage imageNamed:imageStr];
//    [childView addSubview:imageView];
    
    
    UILabel *numberLabel=[[UILabel alloc ] init];
    CGFloat numberLabelX=0;
    CGFloat numberLabelW=childView.frame.size.width;
    CGFloat numberLabelH=20;
    CGFloat numberLabelY=25;
    numberLabel.frame=CGRectMake(numberLabelX, numberLabelY, numberLabelW, numberLabelH);
    numberLabel.textColor=[UIColor whiteColor];
    numberLabel.text=numberStr;
    numberLabel.textAlignment=NSTextAlignmentCenter;
    [childView addSubview:numberLabel];
    
    
    
    
    UILabel *nameLabel=[[UILabel alloc] init];
    
    CGFloat nameLabelW=[self getFrame:CGSizeMake(1000, 20) content:nameStr fontSize:[UIFont systemFontOfSize:15]].size.width;
    CGFloat nameLabelH=20;
    CGFloat nameLabelY=numberLabelH+numberLabelY+5;
    CGFloat nameLabelX;
    if (childView.tag==4111) {
        nameLabelX=(childView.frame.size.width-nameLabelW-25)/2;
    }else
    {
    nameLabelX=(childView.frame.size.width-nameLabelW)/2;
    }
    
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.text=nameStr;
    //     nameLabel.contentMode=UIViewContentModeTopLeft;
    //    nameLabel.numberOfLines=0;
    nameLabel.font=[UIFont systemFontOfSize:15];
    nameLabel.textColor=[UIColor whiteColor];
    [childView addSubview:nameLabel];
    
    if (childView.tag==4111) {
        //提示按钮
        UIButton *promptBtn=[[UIButton alloc] init];
        CGFloat promptBtnX=nameLabelX+nameLabelW+5;
        CGFloat promptBtnY=nameLabelY;
        CGFloat promptBtnW=20;
        CGFloat promptBtnH=20;
        promptBtn.frame=CGRectMake(promptBtnX, promptBtnY, promptBtnW, promptBtnH);
        [promptBtn setImage:[UIImage imageNamed:@"baisewenhao"] forState:UIControlStateNormal];

        self.index2++;
        promptBtn.tag=self.index2+1100;
        [promptBtn addTarget:self action:@selector(clickpromptishi:) forControlEvents:UIControlEventTouchUpInside];
        
        [childView addSubview:promptBtn];
        
    }
    
   
    
   
    
    
}

//根据字符串计算出宽高
-(CGRect)getFrame:(CGSize)frame content:(NSString *)content fontSize:(UIFont *)fontSize
{
    CGRect rect = [content boundingRectWithSize:frame options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:fontSize,NSFontAttributeName, nil] context:nil];
    return rect;
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
