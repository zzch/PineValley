//
//  ZCGreenViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/4/15.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCGreenViewController.h"

@interface ZCGreenViewController ()

@end

@implementation ZCGreenViewController

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
    
    [self addChildControls:firstView imageStr:@"20141118042246536.jpg" numberStr:[NSString stringWithFormat:@"%@",self.greenModel[@"gir_percentage"]] nameStr:@"命中"];
    
    UIView *secendView=[[UIView alloc] init];
    CGFloat secendViewX=0;
    CGFloat secendViewY=firstViewY+firstViewH;
    CGFloat secendViewW=firstViewW;
    CGFloat secendViewH=firstViewH;
    secendView.frame=CGRectMake(secendViewX, secendViewY, secendViewW, secendViewH);
    [topView addSubview:secendView];
    
  [self addChildControls:secendView imageStr:@"20141118042246536.jpg" numberStr:[NSString stringWithFormat:@"%@",self.greenModel[@"non_gir_percentage"]] nameStr:@"未命中"];
    
    
//    UIView *thirdView=[[UIView alloc] init];
//    thirdView.backgroundColor=[UIColor redColor];
//    CGFloat thirdViewX=0;
//    CGFloat thirdViewY=secendViewY+secendViewH;
//    CGFloat thirdViewW=firstViewW;
//    CGFloat thirdViewH=firstViewH;
//    thirdView.frame=CGRectMake(thirdViewX, thirdViewY, thirdViewW, thirdViewH);
//    [topView addSubview:thirdView];
//    
//    [self addChildControls:thirdView imageStr:@"20141118042246536.jpg" numberStr:[NSString stringWithFormat:@"%@",self.bunkersModel[@"sand_saves_percentage"]] nameStr:@"成功率"];
    //右边图片
    UIImageView *barChartImage=[[UIImageView alloc] init];
    CGFloat barChartImageX=topViewH+10;
    CGFloat barChartImageY=20;
    CGFloat barChartImageW=100;
    CGFloat barChartImageH=100;
    barChartImage.frame=CGRectMake(barChartImageX, barChartImageY, barChartImageW, barChartImageH);
    barChartImage.image=[UIImage imageNamed:@"20141118042246536.jpg"];
    [self.view addSubview:barChartImage];
    
    
    //中间第四个View
    UIView *middleView=[[UIView alloc] init];
    CGFloat middleViewX=0;
    CGFloat middleViewY=topViewY+topViewH+20;
    CGFloat middleViewW=SCREEN_WIDTH;
    CGFloat middleViewH=150;
    middleView.frame=CGRectMake(middleViewX, middleViewY, middleViewW, middleViewH);
    [self.view addSubview:middleView];
    
    [self addMiddleView:middleView nameLabelStr:@"标准杆上果岭" girStr:[NSString stringWithFormat:@"%@",self.greenModel[@"gir"]] percentage:[NSString stringWithFormat:@"%@",self.greenModel[@"gir_percentage"]] holesNSArray:self.greenModel[@"holes_of_gir"]];
    
    
    //最后一个View
    UIView *lastView=[[UIView alloc] init];
    CGFloat lastViewX=0;
    CGFloat lastViewY=middleViewY+middleViewH+20;
    CGFloat lastViewW=SCREEN_WIDTH;
    CGFloat lastViewH=150;
    lastView.frame=CGRectMake(lastViewX, lastViewY, lastViewW, lastViewH);
    [self.view addSubview:lastView];
    
    [self addMiddleView:lastView nameLabelStr:@"标准杆上果岭距离球洞小于5码" girStr:[NSString stringWithFormat:@"%@",self.greenModel[@"gir_to_within_5"]] percentage:[NSString stringWithFormat:@"%@",self.greenModel[@"gir_to_within_5_percentage"]] holesNSArray:self.greenModel[@"holes_of_gir_to_within_5"]];

    
    
    
    
}

//中间添加内容
-(void)addMiddleView:(UIView *)view  nameLabelStr:(NSString *)nameStr  girStr:(NSString *)girStr  percentage:(NSString *)percentage  holesNSArray:(NSArray*)holes
{
    ZCLog(@"%lu",holes.count);

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
    nameLabel.text=nameStr;
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
    //promptBtn.tag=1006;
   // [promptBtn addTarget:self action:@selector(clickpromptishi:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:promptBtn];
    
    
    UILabel *firstNumberLaber=[[UILabel alloc] init];
    CGFloat  firstNumberLaberX=0;
    CGFloat  firstNumberLaberY=personImageY+personImageH+10;
    CGFloat  firstNumberLaberW=SCREEN_WIDTH/4;
    CGFloat  firstNumberLaberH=30;
    firstNumberLaber.frame=CGRectMake(firstNumberLaberX, firstNumberLaberY, firstNumberLaberW, firstNumberLaberH);
    firstNumberLaber.textAlignment=NSTextAlignmentCenter;
    firstNumberLaber.text=girStr;
    [view addSubview:firstNumberLaber];
    
    //baifenbi
    UILabel *firstNameLaber=[[UILabel alloc] init];
    CGFloat  firstNameLaberX=firstNumberLaberX;
    CGFloat  firstNameLaberY=firstNumberLaberY+firstNumberLaberH+10;
    CGFloat  firstNameLaberW=firstNumberLaberW;
    CGFloat  firstNameLaberH=20;
    firstNameLaber.frame=CGRectMake(firstNameLaberX, firstNameLaberY, firstNameLaberW, firstNameLaberH);
    firstNameLaber.textAlignment=NSTextAlignmentCenter;
    firstNameLaber.text=percentage;
    [view addSubview:firstNameLaber];
    
    
    //显示数量不等的小圆球
    UIView *holesView=[[UIView alloc] init];
    CGFloat holesViewX=firstNumberLaberW+firstNumberLaberX;
    CGFloat holesViewY=firstNumberLaberY;
    CGFloat holesViewW=SCREEN_WIDTH-holesViewX;
    CGFloat holesViewH=view.frame.size.height-holesViewY;
    holesView.frame=CGRectMake(holesViewX, holesViewY, holesViewW, holesViewH);
    [view addSubview:holesView];
    
    
    //添加个数
   // NSArray *holes= holes;
    
    // 0.总列数(一行最多3列)
    int totalColumns = 9;
    
    // 1.数字的尺寸
    CGFloat appW =20; //(self.beforeScoringView.frame.size.width-0)/11;
    CGFloat appH =20; //(self.beforeScoringView.frame.size.height-0)/4;
    
    // 2.间隙 = (控制器view的宽度 - 3 * 应用宽度) / 4
    //CGFloat marginX = (self.view.frame.size.width - totalColumns * appW) / (totalColumns + 1);
    CGFloat marginX = 2;
    CGFloat marginY = 2;
    
    for (int index=0; index<holes.count; index++) {
        UILabel *nameLabel=[[UILabel alloc] init];
        // 3.2.计算框框的位置
        // 计算行号和列号
        int row = index / totalColumns;
        int col = index % totalColumns;
        // 计算x和y
        CGFloat appX = marginX + col * (appW + marginX);
        CGFloat appY = row * (appH + marginY);
        // 设置frame
        nameLabel.frame = CGRectMake(appX, appY, appW, appH);
        nameLabel.backgroundColor=[UIColor  redColor];
        nameLabel.text=[NSString stringWithFormat:@"%@",holes[index]];
        // holesResult.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jstj_yihangbeijing"]];
        //holesResult.textColor=ZCColor(208, 210, 212);
        [holesView addSubview:nameLabel];
//        UIView *bjView=[[UIView alloc] init];
//        bjView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jstj_shutiao"]];
//        bjView.frame=CGRectMake(0, 0, 1, labelView.frame.size.height);
//        [labelView addSubview:bjView];
//        UILabel *holesResult=[[UILabel alloc] init];
//        holesResult.frame=CGRectMake(1, 0, labelView.frame.size.width-1, labelView.frame.size.height);
//        holesResult.textColor=ZCColor(208, 210, 212);
//        holesResult.textAlignment=NSTextAlignmentCenter;
//        holesResult.font=[UIFont systemFontOfSize:14];
//        [labelView addSubview:holesResult];
        
        
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
    
    
//    //提示按钮
//    UIButton *promptBtn=[[UIButton alloc] init];
//    CGFloat promptBtnX=nameLabelX+nameLabelW;
//    CGFloat promptBtnY=nameLabelY;
//    CGFloat promptBtnW=20;
//    CGFloat promptBtnH=20;
//    promptBtn.frame=CGRectMake(promptBtnX, promptBtnY, promptBtnW, promptBtnH);
//    [promptBtn setImage:[UIImage imageNamed:@"20141118042246536.jpg"] forState:UIControlStateNormal];
//    
//    self.index2++;
//    promptBtn.tag=self.index2+1100;
//    [promptBtn addTarget:self action:@selector(clickpromptishi:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [childView addSubview:promptBtn];
    
    
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
