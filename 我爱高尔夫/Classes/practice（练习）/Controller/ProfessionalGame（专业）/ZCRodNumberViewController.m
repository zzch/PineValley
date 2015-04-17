//
//  ZCRodNumberViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/4/15.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCRodNumberViewController.h"

@interface ZCRodNumberViewController ()

@end

@implementation ZCRodNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addControls];
    
}

//添加控件
-(void)addControls
{
//    UIScrollView *scrollView=[[UIScrollView alloc] init];
//    scrollView.frame=[UIScreen mainScreen].bounds;
//    self.scrollView=scrollView;
//    [self.view addSubview:scrollView];
//    
//    scrollView.contentSize = CGSizeMake(0,SCREEN_HEIGHT+2200 );
//    
    
    
    
    UIView *topView=[[UIView alloc] init];
    CGFloat topViewX=0;
    CGFloat topViewY=0;
    CGFloat topViewW=SCREEN_WIDTH;
    CGFloat topViewH=250;
    topView.frame=CGRectMake(topViewX, topViewY, topViewW, topViewH);
    [self.view addSubview:topView];
    
    
    UIView *firstView=[[UIView alloc] init];
    CGFloat firstViewX=0;
    CGFloat firstViewY=10;
    CGFloat firstViewW=180;
    CGFloat firstViewH=30;
    firstView.frame=CGRectMake(firstViewX, firstViewY, firstViewW, firstViewH);
    [topView addSubview:firstView];
    
    [self addChildControls:firstView imageStr:@"20141118042246536.jpg" numberStr:[NSString stringWithFormat:@"%@",self.rodNumberModel[@"double_eagle_percentage"]] nameStr:@"信天翁"];
    
    UIView *secendView=[[UIView alloc] init];
    CGFloat secendViewX=0;
    CGFloat secendViewY=firstViewY+firstViewH;
    CGFloat secendViewW=firstViewW;
    CGFloat secendViewH=firstViewH;
    secendView.frame=CGRectMake(secendViewX, secendViewY, secendViewW, secendViewH);
    [topView addSubview:secendView];
    
    [self addChildControls:secendView imageStr:@"20141118042246536.jpg" numberStr:[NSString stringWithFormat:@"%@",self.rodNumberModel[@"eagle_percentage"]] nameStr:@"老鹰"];
    
    
    UIView *thirdView=[[UIView alloc] init];
    thirdView.backgroundColor=[UIColor redColor];
    CGFloat thirdViewX=0;
    CGFloat thirdViewY=secendViewY+secendViewH;
    CGFloat thirdViewW=firstViewW;
    CGFloat thirdViewH=firstViewH;
    thirdView.frame=CGRectMake(thirdViewX, thirdViewY, thirdViewW, thirdViewH);
    [topView addSubview:thirdView];
    
    [self addChildControls:thirdView imageStr:@"20141118042246536.jpg" numberStr:[NSString stringWithFormat:@"%@",self.rodNumberModel[@"birdie_percentage"]] nameStr:@"小鸟"];
    
    
    UIView *fourthView=[[UIView alloc] init];
    thirdView.backgroundColor=[UIColor redColor];
    CGFloat fourthViewX=0;
    CGFloat fourthViewY=thirdViewY+thirdViewH;
    CGFloat fourthViewW=firstViewW;
    CGFloat fourthViewH=firstViewH;
    fourthView.frame=CGRectMake(fourthViewX, fourthViewY, fourthViewW, fourthViewH);
    [topView addSubview:fourthView];
    [self addChildControls:fourthView imageStr:@"20141118042246536.jpg" numberStr:[NSString stringWithFormat:@"%@",self.rodNumberModel[@"par_percentage"]] nameStr:@"标准杆"];
    
    
    
    UIView *fifthView=[[UIView alloc] init];
    fifthView.backgroundColor=[UIColor redColor];
    CGFloat fifthViewX=0;
    CGFloat fifthViewY=fourthViewY+fourthViewH;
    CGFloat fifthViewW=firstViewW;
    CGFloat fifthViewH=firstViewH;
    fifthView.frame=CGRectMake(fifthViewX, fifthViewY, fifthViewW, fifthViewH);
    [topView addSubview:fifthView];
    [self addChildControls:fifthView imageStr:@"20141118042246536.jpg" numberStr:[NSString stringWithFormat:@"%@",self.rodNumberModel[@"bogey_percentage"]] nameStr:@"柏忌"];
    
    
    
    
    UIView *sixthView=[[UIView alloc] init];
    sixthView.backgroundColor=[UIColor redColor];
    CGFloat sixthViewX=0;
    CGFloat sixthViewY=fifthViewY+fifthViewH;
    CGFloat sixthViewW=firstViewW;
    CGFloat sixthViewH=firstViewH;
    sixthView.frame=CGRectMake(sixthViewX, sixthViewY, sixthViewW, sixthViewH);
    [topView addSubview:sixthView];
    [self addChildControls:sixthView imageStr:@"20141118042246536.jpg" numberStr:[NSString stringWithFormat:@"%@",self.rodNumberModel[@"double_bogey_percentage"]] nameStr:@"双柏忌+"];
    
    
    //右边图片
    UIImageView *barChartImage=[[UIImageView alloc] init];
    CGFloat barChartImageX=topViewH+60;
    CGFloat barChartImageY=20;
    CGFloat barChartImageW=100;
    CGFloat barChartImageH=100;
    barChartImage.frame=CGRectMake(barChartImageX, barChartImageY, barChartImageW, barChartImageH);
    barChartImage.image=[UIImage imageNamed:@"20141118042246536.jpg"];
    [self.view addSubview:barChartImage];
    
    
    
    //最后四个View
    
    //中间第四个View
    UIView *middleFourthView=[[UIView alloc] init];
    CGFloat middleFourthViewX=0;
    CGFloat middleFourthViewY=topViewY+topViewH+20;
    CGFloat middleFourthViewW=SCREEN_WIDTH;
    CGFloat middleFourthViewH=150;
    middleFourthView.frame=CGRectMake(middleFourthViewX, middleFourthViewY, middleFourthViewW, middleFourthViewH);
    [self.view addSubview:middleFourthView];
   // [self addMiddleView:middleFourthView nameLabelStr:@"命中" girStr:[NSString stringWithFormat:@"%@",self.fairwayModel[@"drive_fairways_count"]] percentage:[NSString stringWithFormat:@"%@",self.fairwayModel[@"drive_fairways_hit"]] holesNSArray:self.fairwayModel[@"holes_of_drive_fairways"]];
    [self addMiddlethirdViewControls:middleFourthView nameLabelStr:@"小鸟球转化率" numberLabelStr:[NSString stringWithFormat:@"%@",self.rodNumberModel[@"advantage_transformation"]]];
    
    //中间第五个View[]
    UIView *middleFifthView=[[UIView alloc] init];
    CGFloat middleFifthViewX=0;
    CGFloat middleFifthViewY=middleFourthViewY+middleFourthViewH+20;
    CGFloat middleFifthViewW=SCREEN_WIDTH;
    CGFloat middleFifthViewH=200;
    middleFifthView.frame=CGRectMake(middleFifthViewX, middleFifthViewY, middleFifthViewW, middleFifthViewH);
    [self.view addSubview:middleFifthView];
    //[self addMiddleView:middleFifthView nameLabelStr:@"左侧" girStr:[NSString stringWithFormat:@"%@",self.fairwayModel[@"drive_left_roughs_count"]] percentage:[NSString stringWithFormat:@"%@",self.fairwayModel[@"drive_left_roughs_hit"]] holesNSArray:self.fairwayModel[@"holes_of_drive_left_roughs"]];
    [self addMiddlethirdViewControls:middleFifthView nameLabelStr:@"反弹率" numberLabelStr:[NSString stringWithFormat:@"%@",self.rodNumberModel[@"bounce"]]];
}


//添加middlethirdView的内容
-(void)addMiddlethirdViewControls:(UIView *)middlethirdView  nameLabelStr:(NSString *)nameLabelStr   numberLabelStr:(NSString *)numberLabelStr
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
    nameLabel.text=nameLabelStr;
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
    numberLabel.text=numberLabelStr;//[NSString stringWithFormat:@"%@",self.pushRodModel[@"holed_putt_length"]];
    numberLabel.textAlignment=NSTextAlignmentCenter;
    [middlethirdView addSubview:numberLabel];
    
    
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
    
    
//    //提示按钮
//    UIButton *promptBtn=[[UIButton alloc] init];
//    CGFloat promptBtnX=nameLabelX+nameLabelW;
//    CGFloat promptBtnY=nameLabelY;
//    CGFloat promptBtnW=20;
//    CGFloat promptBtnH=20;
//    promptBtn.frame=CGRectMake(promptBtnX, promptBtnY, promptBtnW, promptBtnH);
//    [promptBtn setImage:[UIImage imageNamed:@"20141118042246536.jpg"] forState:UIControlStateNormal];
//    
//    //self.index2++;
//   // promptBtn.tag=self.index2+1100;
//    [promptBtn addTarget:self action:@selector(clickpromptishi:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [childView addSubview:promptBtn];
//    
    
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
