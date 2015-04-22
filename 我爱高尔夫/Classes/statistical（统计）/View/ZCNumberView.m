//
//  ZCNumberView.m
//  我爱高尔夫
//
//  Created by hh on 15/4/20.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCNumberView.h"
#import "ZCResultsViewController.h"
@interface ZCNumberView()
@property(nonatomic,weak)UIButton *button1;
@property(nonatomic,weak)UIButton *button2;
@property(nonatomic,weak)UIButton *button3;
@property(nonatomic,weak)UIButton *button4;
@property(nonatomic,weak)UIButton *button5;
@property(nonatomic,weak)UIButton *button6;
@end
@implementation ZCNumberView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor redColor ];
        
        [self addControls];
        
    }
    return self;

}


-(void)addControls
{
    UIButton *button1=[[UIButton alloc] init];
    [button1 setTitle:@"最近5场" forState:UIControlStateNormal];
    button1.tag=4005;
    [button1 addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
     self.button1=button1;
    [self addSubview:button1];
    
    UIButton *button2=[[UIButton alloc] init];
    [button2 setTitle:@"最近10场" forState:UIControlStateNormal];
    button2.tag=4010;
    [button2 addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    self.button2=button2;
    [self addSubview:button2];

    
    UIButton *button3=[[UIButton alloc] init];
    [button3 setTitle:@"最近30场" forState:UIControlStateNormal];
    button3.tag=4030;
    [button3 addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    self.button3=button3;
    [self addSubview:button3];

    
    UIButton *button4=[[UIButton alloc] init];
    [button4 setTitle:@"最近50场" forState:UIControlStateNormal];
    button4.tag=4050;
    [button4 addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];

    self.button4=button4;
    [self addSubview:button4];

    
    UIButton *button5=[[UIButton alloc] init];
    [button5 setTitle:@"最近100场" forState:UIControlStateNormal];
    button5.tag=4100;
    [button5 addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    self.button5=button5;
    [self addSubview:button5];

    
    UIButton *button6=[[UIButton alloc] init];
    [button6 setTitle:@"全部场次" forState:UIControlStateNormal];
    
    button6.tag=4101;
    [button6 addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    self.button6=button6;
    [self addSubview:button6];


}


//通知控制器  我被点击了
-(void)clickButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(numberViewDidClickedButton:didClickButton:)]) {
        [self.delegate numberViewDidClickedButton:self didClickButton:button];
    }
    
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat button1W=80;
    CGFloat button1H=40;
    CGFloat button1X=(SCREEN_WIDTH-button1W)*0.5;
    CGFloat button1Y=30;
    self.button1.frame=CGRectMake(button1X, button1Y, button1W, button1H);
    
    
    
    CGFloat button2W=button1W;
    CGFloat button2H=button1H;
    CGFloat button2X=button1X;
    CGFloat button2Y=button1Y+button1H+20;
    self.button2.frame=CGRectMake(button2X, button2Y, button2W, button2H);
    
    
    CGFloat button3W=button1W;
    CGFloat button3H=button1H;
    CGFloat button3X=button1X;
    CGFloat button3Y=button2Y+button2H+20;
    self.button3.frame=CGRectMake(button3X, button3Y, button3W, button3H);


    CGFloat button4W=button1W;
    CGFloat button4H=button1H;
    CGFloat button4X=button1X;
    CGFloat button4Y=button3Y+button3H+20;
    self.button4.frame=CGRectMake(button4X, button4Y, button4W, button4H);
    
    
    CGFloat button5W=button1W;
    CGFloat button5H=button1H;
    CGFloat button5X=button1X;
    CGFloat button5Y=button4Y+button4H+20;
    self.button5.frame=CGRectMake(button5X, button5Y, button5W, button5H);
    
    CGFloat button6W=button1W;
    CGFloat button6H=button1H;
    CGFloat button6X=button1X;
    CGFloat button6Y=button5Y+button5H+20;
    self.button6.frame=CGRectMake(button6X, button6Y, button6W, button6H);


    


}
@end
