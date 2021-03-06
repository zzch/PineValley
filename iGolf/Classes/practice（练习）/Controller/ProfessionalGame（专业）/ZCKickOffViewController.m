//
//  ZCKickOffViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/4/15.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCKickOffViewController.h"
#import "ZCProfessionalStatisticsPromptView.h"
@interface ZCKickOffViewController ()

@end

@implementation ZCKickOffViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"开球";
    self.view.backgroundColor=ZCColor(237, 237, 237);
    
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
    CGFloat topViewH=100;
    topView.frame=CGRectMake(topViewX, topViewY, topViewW, topViewH);
    topView.backgroundColor=ZCColor(60, 57, 78);
    [self.view addSubview:topView];
    
    
    UIView *firstView=[[UIView alloc] init];
    CGFloat firstViewX=0;
    CGFloat firstViewY=0;
    CGFloat firstViewW=SCREEN_WIDTH/3-1;
    CGFloat firstViewH=100;
    firstView.frame=CGRectMake(firstViewX, firstViewY, firstViewW, firstViewH);
    [topView addSubview:firstView];
    
    [self addChildControls:firstView imageStr:@"20141118042246536.jpg" numberStr:[NSString stringWithFormat:@"%@",self.kickOffModel[@"longest_drive_length"]] nameStr:@"最远max"];
    
    
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
    
    [self addChildControls:secendView imageStr:@"20141118042246536.jpg" numberStr:[NSString stringWithFormat:@"%@",self.kickOffModel[@"average_drive_length"]] nameStr:@"平均"];
    
    
    
    //竖条背景色
    UIView *bjView2=[[UIView alloc] initWithFrame:CGRectMake(secendViewX+secendViewW, 25, 0.5, topViewH-50)];
    bjView2.backgroundColor=[UIColor whiteColor];
    [topView addSubview:bjView2];

    
    UIView *thirdView=[[UIView alloc] init];
    
    CGFloat thirdViewX=secendViewX+secendViewW+0.5;
    CGFloat thirdViewY=0;
    CGFloat thirdViewW=firstViewW;
    CGFloat thirdViewH=firstViewH;
    thirdView.frame=CGRectMake(thirdViewX, thirdViewY, thirdViewW, thirdViewH);
    [topView addSubview:thirdView];
    //
       [self addChildControls:thirdView imageStr:@"20141118042246536.jpg" numberStr:[NSString stringWithFormat:@"%@",self.kickOffModel[@"longest_2_drive_length"]] nameStr:@"max/2"];
//    //右边图片
//    UIImageView *barChartImage=[[UIImageView alloc] init];
//    CGFloat barChartImageX=topViewH+10;
//    CGFloat barChartImageY=20;
//    CGFloat barChartImageW=100;
//    CGFloat barChartImageH=100;
//    barChartImage.frame=CGRectMake(barChartImageX, barChartImageY, barChartImageW, barChartImageH);
//    barChartImage.image=[UIImage imageNamed:@"20141118042246536.jpg"];
//    [self.view addSubview:barChartImage];
    
    
    //中间第四个View
    UIView *middleView=[[UIView alloc] init];
    CGFloat middleViewX=0;
    CGFloat middleViewY=topViewY+topViewH+20;
    CGFloat middleViewW=SCREEN_WIDTH;
    CGFloat middleViewH=120;
    middleView.frame=CGRectMake(middleViewX, middleViewY, middleViewW, middleViewH);
    middleView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:middleView];
    
    [self addMiddleView:middleView nameLabelStr:@"最佳球位" girStr:[NSString stringWithFormat:@"%@",self.kickOffModel[@"good_drives"]] percentage:[NSString stringWithFormat:@"%@",self.kickOffModel[@"good_drives_percentage"]] holesNSArray:self.kickOffModel[@"holes_of_good_drives"]];
    
}



//中间添加内容
-(void)addMiddleView:(UIView *)view  nameLabelStr:(NSString *)nameStr  girStr:(NSString *)girStr  percentage:(NSString *)percentage  holesNSArray:(NSArray*)holes
{
    if ([girStr isEqual:@"<null>"]) {
        girStr=@"0";
    }
    
    if ([percentage isEqual:@"<null>"]) {
        percentage=@"0%";
    }
    
    
    NSString *str=[NSString stringWithFormat:@"%@%@/14  (%@)",nameStr,girStr,percentage];
    
    UILabel *nameLabel=[[UILabel alloc] init];
    CGFloat nameLabelX=20;
    CGFloat nameLabelY=10;
    CGFloat nameLabelW=[self getFrame:CGSizeMake(1000, 20) content:str fontSize:[UIFont systemFontOfSize:18]].size.width;
    CGFloat nameLabelH=20;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.text=str;
    nameLabel.font=[UIFont systemFontOfSize:18];
    nameLabel.textColor=ZCColor(225, 150, 29);
    [view addSubview:nameLabel];
    //提示按钮
    UIButton *promptBtn=[[UIButton alloc] init];
    CGFloat promptBtnX=nameLabelX+nameLabelW+10;
    CGFloat promptBtnY=nameLabelY;
    CGFloat promptBtnW=20;
    CGFloat promptBtnH=20;
    promptBtn.frame=CGRectMake(promptBtnX, promptBtnY, promptBtnW, promptBtnH);
    [promptBtn setImage:[UIImage imageNamed:@"chengsewenhao"]
               forState:UIControlStateNormal];
    promptBtn.tag=19000;
     [promptBtn addTarget:self action:@selector(clickpromptishi:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:promptBtn];
    
    
    UILabel *firstNumberLaber=[[UILabel alloc] init];
    CGFloat  firstNumberLaberX=0;
    CGFloat  firstNumberLaberY=nameLabelY+nameLabelH+10;
    CGFloat  firstNumberLaberW=SCREEN_WIDTH/4;
    CGFloat  firstNumberLaberH=30;
    firstNumberLaber.frame=CGRectMake(firstNumberLaberX, firstNumberLaberY, firstNumberLaberW, firstNumberLaberH);
    firstNumberLaber.textAlignment=NSTextAlignmentCenter;
    if ([girStr isEqual:@"<null>"]) {
        firstNumberLaber.text=@"0";
    }else
    {
        firstNumberLaber.text=girStr;
    }
    firstNumberLaber.font=[UIFont systemFontOfSize:26];
    [view addSubview:firstNumberLaber];
    
    
    //baifenbi
    UILabel *firstNameLaber=[[UILabel alloc] init];
    CGFloat  firstNameLaberX=firstNumberLaberX;
    CGFloat  firstNameLaberY=firstNumberLaberY+firstNumberLaberH+10;
    CGFloat  firstNameLaberW=firstNumberLaberW;
    CGFloat  firstNameLaberH=20;
    firstNameLaber.frame=CGRectMake(firstNameLaberX, firstNameLaberY, firstNameLaberW, firstNameLaberH);
    firstNameLaber.textColor=ZCColor(102, 102, 102);
    firstNameLaber.textAlignment=NSTextAlignmentCenter;
    if ([percentage isEqual:@"<null>"]) {
        firstNameLaber.text=@"0%";
    }else
    {
        firstNameLaber.text=percentage;
    }
    [view addSubview:firstNameLaber];
    
    
    
    
    //显示数量不等的小圆球
    UIView *holesView=[[UIView alloc] init];
    
    CGFloat holesViewX=firstNumberLaberW+firstNumberLaberX;
    CGFloat holesViewY=firstNumberLaberY;
    CGFloat holesViewW=SCREEN_WIDTH-holesViewX;
    CGFloat holesViewH=view.frame.size.height-holesViewY;
    holesView.frame=CGRectMake(holesViewX, holesViewY, holesViewW, holesViewH);
    [view addSubview:holesView];
    
    
    
//    int count;
//    if ([self _valueOrNil:holes]==nil) {
//        count=0;
//    }else
//    {
//        count=holes.count;
//    }
    
    
    //添加个数
    // NSArray *holes= holes;
    
    // 0.总列数(一行最多3列)
    int totalColumns = 9;
    
    // 1.数字的尺寸
    CGFloat appW =20; //(self.beforeScoringView.frame.size.width-0)/11;
    CGFloat appH =20; //(self.beforeScoringView.frame.size.height-0)/4;
    
    // 2.间隙 = (控制器view的宽度 - 3 * 应用宽度) / 4
    //CGFloat marginX = (self.view.frame.size.width - totalColumns * appW) / (totalColumns + 1);
    CGFloat marginX = (holesView.frame.size.width-totalColumns * appW)/(totalColumns + 1);
    CGFloat marginY = (holesView.frame.size.height-2*appH)/3;
    
    
    for (int index=0; index<holes.count; index++) {
        UILabel *nameLabel=[[UILabel alloc] init];
        // 3.2.计算框框的位置
        // 计算行号和列号
        int row = index / totalColumns;
        int col = index % totalColumns;
        // 计算x和y
        CGFloat appX = marginX + col * (appW + marginX);
        CGFloat appY = marginY+row * (appH + marginY);
        // 设置frame
        nameLabel.frame = CGRectMake(appX, appY, appW, appH);
        nameLabel.backgroundColor=[UIColor  redColor];
        nameLabel.text=[NSString stringWithFormat:@"%@",holes[index]];
        nameLabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"yuan"]];
        nameLabel.textAlignment=NSTextAlignmentCenter;
        nameLabel.textColor=ZCColor(102, 102, 102);
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
    UILabel *numberLabel=[[UILabel alloc ] init];
    CGFloat numberLabelX=0;
    CGFloat numberLabelW=childView.frame.size.width;
    CGFloat numberLabelH=20;
    CGFloat numberLabelY=25;
    numberLabel.frame=CGRectMake(numberLabelX, numberLabelY, numberLabelW, numberLabelH);
    if ([numberStr isEqual:@"<null>"]) {
        numberLabel.text=@"-";
    }else
    {
        numberLabel.text=numberStr;
        
    }
    numberLabel.textAlignment=NSTextAlignmentCenter;
    numberLabel.textColor=[UIColor whiteColor];
    [childView addSubview:numberLabel];
    
    UILabel *nameLabel=[[UILabel alloc] init];
    CGFloat nameLabelX=0;
    CGFloat nameLabelW=numberLabelW;
    CGFloat nameLabelH=20;
    CGFloat nameLabelY=numberLabelH+numberLabelY+5;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.text=nameStr;
    nameLabel.textColor=[UIColor whiteColor];
    nameLabel.textAlignment=NSTextAlignmentCenter;
    [childView addSubview:nameLabel];
    
    
}


//根据字符串计算出宽高
-(CGRect)getFrame:(CGSize)frame content:(NSString *)content fontSize:(UIFont *)fontSize
{
    CGRect rect = [content boundingRectWithSize:frame options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:fontSize,NSFontAttributeName, nil] context:nil];
    return rect;
}



-(void)clickpromptishi:(UIButton *)btn
{
    ZCProfessionalStatisticsPromptView *PromptView=[[ZCProfessionalStatisticsPromptView alloc] init];
    PromptView.frame= [[UIScreen mainScreen] bounds];
    
    PromptView.nameStr=@"最佳球位";
    PromptView.instructionsStr=@"4/5杆洞开球后未上球道，但是该球洞标准杆上果岭。";
    UIWindow *wd = [[UIApplication sharedApplication].delegate window];
    [wd addSubview:PromptView];

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
