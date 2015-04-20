//
//  ZCTimeView.m
//  我爱高尔夫
//
//  Created by hh on 15/4/20.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCTimeView.h"
#import "ZCDatapickerView.h"
@interface ZCTimeView()<ZCDatapickerViewDelegate>
@property(nonatomic,weak)UIButton *startButton;
@property(nonatomic,weak)UIButton *endButton;
@property(nonatomic,weak)UILabel *startTime;
@property(nonatomic,weak)UILabel *startName;
@property(nonatomic,weak)UILabel *endTime;
@property(nonatomic,weak)UILabel *endName;
@property(nonatomic,weak)ZCDatapickerView *dataPick;
@property(nonatomic,weak)UIView *alphaView;
//判断是点击开始按钮 还是 结束按钮
@property(nonatomic,assign)int index;


@end
@implementation ZCTimeView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor ];
        
        [self addControls];
    }
    return self;
    
}


//添加控件
-(void)addControls
{
    UIButton *startButton=[[UIButton alloc] init];
    [startButton addTarget:self action:@selector(clickStartButton) forControlEvents:UIControlEventTouchUpInside];
    self.startButton=startButton;
    [self addSubview:startButton];
    
    UILabel *startName=[[UILabel alloc] init];
    self.startName=startName;
    startName.text=@"开始时间";
    [startButton  addSubview:startName];
    
    UILabel *startTime=[[UILabel alloc] init];
    self.startTime=startTime;
    [startButton  addSubview:startTime];
    
    //结束
    UIButton *endButton=[[UIButton alloc] init];
    [endButton addTarget:self action:@selector(clickendButton) forControlEvents:UIControlEventTouchUpInside];
    self.endButton=endButton;
    [self addSubview:endButton];
    
    UILabel *endName=[[UILabel alloc] init];
    self.endName=endName;
    endName.text=@"结束时间";
    [endButton  addSubview:endName];
    
    UILabel *endTime=[[UILabel alloc] init];
    self.endTime=endTime;
    [endButton  addSubview:endTime];
    
    
   
    

}

//开始
-(void)clickStartButton
{
    self.index=1;
    [self addDateView];
    
   
}




//结束
-(void)clickendButton
{

    self.index=2;
    [self addDateView];
}


//添加pickView

-(void)addDateView
{
    UIView *view=[[UIView alloc] init];
    
    view.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.4];
    
    self.alphaView=view;
    
    
    [self addSubview:view];
    
    
    
    ZCDatapickerView *dataPick=[[ZCDatapickerView alloc] init];
    dataPick.backgroundColor=[UIColor redColor];
    dataPick.alpha=1.0f;
    dataPick.delegate=self;
    [view addSubview:dataPick];
    self.dataPick=dataPick;


}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.alphaView removeFromSuperview];
}

//代理方法
-(void)datapickerViewDelegate:(UIDatePicker *)datePicker
{
    // 获取用户通过UIDatePicker设置的日期和时间
    NSDate *selected = [datePicker date];
    // 创建一个日期格式器
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // 为日期格式器设置格式字符串
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    // 使用日期格式器格式化日期、时间
    NSString *destDateString = [dateFormatter stringFromDate:selected];
    
    
    if (self.index==1) {
        [self.startTime setText:destDateString ];

    }else
    {
    [self.endTime setText:destDateString ];
    }
    


}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat startButtonX=0;
    CGFloat startButtonY=20;
    CGFloat startButtonW=SCREEN_WIDTH;
    CGFloat startButtonH=50;
    self.startButton.frame=CGRectMake(startButtonX, startButtonY, startButtonW, startButtonH);
    
    CGFloat startNameX=10;
    CGFloat startNameY=0;
    CGFloat startNameW=80;
    CGFloat startNameH=startButtonH;
    self.startName.frame=CGRectMake(startNameX, startNameY, startNameW, startNameH);

    CGFloat startTimeX=startNameX+startNameW+10;
    CGFloat startTimeY=0;
    CGFloat startTimeW=180;
    CGFloat startTimeH=startButtonH;
    self.startTime.frame=CGRectMake(startTimeX, startTimeY, startTimeW, startTimeH);
    
    
    CGFloat endButtonX=0;
    CGFloat endButtonY=startButtonY+startButtonH+10;
    CGFloat endButtonW=SCREEN_WIDTH;
    CGFloat endButtonH=startButtonH;
    self.endButton.frame=CGRectMake(endButtonX, endButtonY, endButtonW, endButtonH);


    CGFloat endNameX=10;
    CGFloat endNameY=0;
    CGFloat endNameW=80;
    CGFloat endNameH=endButtonH;
    self.endName.frame=CGRectMake(endNameX, endNameY, endNameW, endNameH);
    
    CGFloat endTimeX=endNameX+endNameW+10;
    CGFloat endTimeY=0;
    CGFloat endTimeW=180;
    CGFloat endTimeH=endButtonH;
    self.endTime.frame=CGRectMake(endTimeX, endTimeY, endTimeW, endTimeH);
    

    
    CGFloat dataPickX=0;
    CGFloat dataPickY=endButtonY+endButtonH+20;
    CGFloat dataPickW=SCREEN_WIDTH;
    CGFloat dataPickH=400;
    self.dataPick.frame=CGRectMake(dataPickX, dataPickY, dataPickW, dataPickH);


    
    
    self.alphaView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}
@end
