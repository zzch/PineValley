//
//  ZCAverageViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/4/14.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCAverageViewController.h"

@interface ZCAverageViewController ()
@property(nonatomic,weak)UIView *middleView;
@property (nonatomic, assign, getter = isOpened) BOOL opened;
@property(nonatomic,weak)UILabel *prompLabel;
@end

@implementation ZCAverageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self addControls];
    
}


//添加控件
-(void)addControls
{
    UIView *topView=[[UIView alloc] init];
    CGFloat topViewX=0;
    CGFloat topViewY=0;
    CGFloat topViewW=SCREEN_WIDTH;
    CGFloat topViewH=150;
    topView.frame=CGRectMake(topViewX, topViewY, topViewW, topViewH);
    [self.view addSubview:topView];
    
    
    UIView *firstView=[[UIView alloc] init];
    CGFloat firstViewX=0;
    CGFloat firstViewY=10;
    CGFloat firstViewW=120;
    CGFloat firstViewH=50;
    firstView.frame=CGRectMake(firstViewX, firstViewY, firstViewW, firstViewH);
    [topView addSubview:firstView];
    
    [self addChildControls:firstView imageStr:@"20141118042246536.jpg" numberStr:[NSString stringWithFormat:@"%@",self.averageModel[@"average_score_par_3"]] nameStr:@"3杆洞"];
    
    
    UIView *secendView=[[UIView alloc] init];
    CGFloat secendViewX=0;
    CGFloat secendViewY=firstViewY+firstViewH;
    CGFloat secendViewW=firstViewW;
    CGFloat secendViewH=firstViewH;
    secendView.frame=CGRectMake(secendViewX, secendViewY, secendViewW, secendViewH);
    [topView addSubview:secendView];
    [self addChildControls:secendView imageStr:@"20141118042246536.jpg" numberStr:[NSString stringWithFormat:@"%@",self.averageModel[@"average_score_par_4"]] nameStr:@"4杆洞"];
    
    
    
    UIView *thirdView=[[UIView alloc] init];
    thirdView.backgroundColor=[UIColor redColor];
    CGFloat thirdViewX=0;
    CGFloat thirdViewY=secendViewY+secendViewH;
    CGFloat thirdViewW=firstViewW;
    CGFloat thirdViewH=firstViewH;
    thirdView.frame=CGRectMake(thirdViewX, thirdViewY, thirdViewW, thirdViewH);
    [topView addSubview:thirdView];
    [self addChildControls:thirdView imageStr:@"20141118042246536.jpg" numberStr:[NSString stringWithFormat:@"%@",self.averageModel[@"average_score_par_5"]] nameStr:@"5杆洞"];
    
    
    //右边图片
    UIImageView *barChartImage=[[UIImageView alloc] init];
    CGFloat barChartImageX=topViewH+10;
    CGFloat barChartImageY=20;
    CGFloat barChartImageW=100;
    CGFloat barChartImageH=100;
    barChartImage.frame=CGRectMake(barChartImageX, barChartImageY, barChartImageW, barChartImageH);
    barChartImage.image=[UIImage imageNamed:@"20141118042246536.jpg"];
    [self.view addSubview:barChartImage];
    
    
    
    
    
    UIView *middleView=[[UIView alloc] init];
    CGFloat middleViewX=0;
    CGFloat middleViewY=topViewY+topViewH+20;
    CGFloat middleViewW=SCREEN_WIDTH;
    CGFloat middleViewH=200;
    middleView.frame=CGRectMake(middleViewX, middleViewY, middleViewW, middleViewH);
    [self.view addSubview:middleView];
    self.middleView=middleView;
    
    
    
    
    UIImageView *personImage=[[UIImageView alloc] init];
    CGFloat personImageX=30;
    CGFloat personImageY=10;
    CGFloat personImageW=20;
    CGFloat personImageH=20;
    personImage.frame=CGRectMake(personImageX, personImageY, personImageW, personImageH);
    personImage.image=[UIImage imageNamed:@"20141118042246536.jpg"];
    [middleView addSubview:personImage];
    
    UILabel *nameLabel=[[UILabel alloc] init];
    CGFloat nameLabelX=personImageX+personImageW+10;
    CGFloat nameLabelY=personImageY;
    CGFloat nameLabelW=200;
    CGFloat nameLabelH=20;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.text=[NSString stringWithFormat:@"救平标准杆率%@/%@ (%@)",self.averageModel[@"scrambles"],self.averageModel[@"non_gir"],self.averageModel[@"scrambles_percentage"]];
    [middleView addSubview:nameLabel];
    //提示按钮
    UIButton *promptBtn=[[UIButton alloc] init];
    CGFloat promptBtnX=nameLabelX+nameLabelW+10;
    CGFloat promptBtnY=personImageY;
    CGFloat promptBtnW=20;
    CGFloat promptBtnH=20;
    promptBtn.frame=CGRectMake(promptBtnX, promptBtnY, promptBtnW, promptBtnH);
    [promptBtn setImage:[UIImage imageNamed:@"20141118042246536.jpg"]
               forState:UIControlStateNormal];
    [promptBtn addTarget:self action:@selector(clickprompBtn:) forControlEvents:UIControlEventTouchUpInside];
    [middleView addSubview:promptBtn];
    
    
    UILabel *numberLabel=[[UILabel alloc] init];
    
    CGFloat numberLabelY=personImageY+20;
    CGFloat numberLabelW=60;
    CGFloat numberLabelH=40;
    CGFloat numberLabelX=(middleView.frame.size.width-numberLabelW)*0.5;
    numberLabel.frame=CGRectMake(numberLabelX, numberLabelY, numberLabelW, numberLabelH);
    numberLabel.text=[NSString stringWithFormat:@"%@",self.averageModel[@"scrambles"]];
    [middleView addSubview:numberLabel];
    
    //第二个下面的 百分比
    UILabel *percentLabel=[[UILabel alloc] init];
    
    CGFloat percentLabelY=numberLabelY+numberLabelH+10;
    CGFloat percentLabelW=40;
    CGFloat percentLabelH=20;
    CGFloat percentLabelX=(middleView.frame.size.width-percentLabelW)*0.5;
    percentLabel.frame=CGRectMake(percentLabelX, percentLabelY, percentLabelW, percentLabelH);
    percentLabel.text=[NSString stringWithFormat:@"%@",self.averageModel[@"scrambles_percentage"]];
    [middleView addSubview:percentLabel];
    
    
    

}


//点击提示
-(void)clickprompBtn:(UIButton *)prompBtn
{
 
    if (self.opened==NO) {
        self.opened=YES;
        UILabel *prompLabel=[[UILabel alloc] init];
        CGFloat prompLabelX=prompBtn.frame.origin.x-60;
        CGFloat prompLabelY=prompBtn.frame.origin.y+30;
        CGFloat prompLabelW=200;
        CGFloat prompLabelH=20;
        prompLabel.frame=CGRectMake(prompLabelX, prompLabelY, prompLabelW, prompLabelH);
        prompLabel.text=@"提示语提示语提示语提示语提示语提示语提示语";
        [self.middleView addSubview:prompLabel];
        self.prompLabel=prompLabel;

    }else
    {
        [self.prompLabel removeFromSuperview];
        self.opened=NO;
    }
   
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
