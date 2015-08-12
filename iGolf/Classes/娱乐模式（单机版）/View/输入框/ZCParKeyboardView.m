//
//  ZCParKeyboardView.m
//  iGolf
//
//  Created by hh on 15/7/27.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCParKeyboardView.h"
@interface ZCParKeyboardView()
@property(nonatomic,weak)UILabel *titleLabel;
@property(nonatomic,weak)UIButton *button1;
@property(nonatomic,weak)UIButton *button2;
@property(nonatomic,weak)UIButton *button3;
@property(nonatomic,weak)UIButton *Xbutton;
@end
@implementation ZCParKeyboardView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        self.backgroundColor=[UIColor whiteColor];
//        UILabel *titleLabel=[[UILabel alloc] init];
//        titleLabel.text=@"标准杆";
//        titleLabel.textAlignment=NSTextAlignmentCenter;
//        [self addSubview:titleLabel];
//        self.titleLabel=titleLabel;
        
        UIButton *button1=[[UIButton alloc] init];
        button1.tag=57555;
        [button1 setBackgroundImage:[UIImage imageNamed:@"ganshuluru"] forState:UIControlStateNormal];
        [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button1.titleLabel.font=[UIFont systemFontOfSize:25];
        [button1 setTitle:@"3" forState:UIControlStateNormal];
        [button1 addTarget:self action:@selector(clickTheButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button1];
        self.button1=button1;
        
        UIButton *button2=[[UIButton alloc] init];
         button2.tag=57556;
        [button2 setBackgroundImage:[UIImage imageNamed:@"ganshuluru"] forState:UIControlStateNormal];
        [button2 setTitleColor :[UIColor whiteColor] forState:UIControlStateNormal];
        button2.titleLabel.font=[UIFont systemFontOfSize:25];
        [button2 setTitle:@"4" forState:UIControlStateNormal];
        [self addSubview:button2];
        [button2 addTarget:self action:@selector(clickTheButton:) forControlEvents:UIControlEventTouchUpInside];
        
        self.button2=button2;
        
        UIButton *button3=[[UIButton alloc] init];
         button3.tag=57557;
        [button3 setBackgroundImage:[UIImage imageNamed:@"ganshuluru"] forState:UIControlStateNormal];
        [button3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button3.titleLabel.font=[UIFont systemFontOfSize:25];
        [button3 setTitle:@"5" forState:UIControlStateNormal];
        [self addSubview:button3];
        [button3 addTarget:self action:@selector(clickTheButton:) forControlEvents:UIControlEventTouchUpInside];
        
        
        self.button3=button3;
        
        UIButton *Xbutton=[[UIButton alloc] init];
        [Xbutton setBackgroundImage:[UIImage imageNamed:@"chacha"] forState:UIControlStateNormal];
        
        
        [self addSubview:Xbutton];
        [Xbutton addTarget:self action:@selector(clickTheXbutton) forControlEvents:UIControlEventTouchUpInside];
        [Xbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.Xbutton=Xbutton;

        
    }

    return self;
}


-(void)clickTheXbutton
{
    [self removeFromSuperview];
}

//点击
-(void)clickTheButton:(UIButton *)button
{
    //button.titleLabel.text
    
    if ([self.delegate respondsToSelector:@selector(ParKeyboardViewConfirmThatTheInput:)]) {
        [self.delegate ParKeyboardViewConfirmThatTheInput:button.titleLabel.text];
        [self removeFromSuperview];
    }
}



-(void)layoutSubviews
{
    [super layoutSubviews];

    //self.titleLabel.frame=CGRectMake(0, 100, SCREEN_WIDTH, 20);
    
    
    CGFloat button1X=28;
    CGFloat button1Y=150;
    CGFloat button1W=80;
    CGFloat button1H=button1W;
    self.button1.frame=CGRectMake(button1X, button1Y, button1W, button1H);
    
    
    CGFloat button2Y=125;
    CGFloat button2W=button1W;
    CGFloat button2H=button1W;
    CGFloat button2X=(SCREEN_WIDTH-button2W)/2;
    self.button2.frame=CGRectMake(button2X, button2Y, button2W, button2H);
    
    
    CGFloat button3X=SCREEN_WIDTH-button1W-28;
    CGFloat button3Y=button1Y;
    CGFloat button3W=button1W;
    CGFloat button3H=button1W;
    self.button3.frame=CGRectMake(button3X, button3Y, button3W, button3H);

    
    
    
    CGFloat XbuttonY=button3Y+button3H+164;
    CGFloat XbuttonW=50;
    CGFloat XbuttonH=50;
    CGFloat XbuttonX=(SCREEN_WIDTH-XbuttonW)/2;
    self.Xbutton.frame=CGRectMake(XbuttonX, XbuttonY, XbuttonW, XbuttonH);
    
}



@end
