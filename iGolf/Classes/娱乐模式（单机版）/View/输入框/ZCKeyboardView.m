//
//  ZCKeyboardView.m
//  iGolf
//
//  Created by hh on 15/7/23.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCKeyboardView.h"
@interface ZCKeyboardView()
@property(nonatomic,weak)UILabel *titleLabel;
@property(nonatomic,weak)UIImageView *imageView;
@property(nonatomic,weak)UILabel *nameLabel;
@property(nonatomic,weak)UILabel *scoreLabel;
@property(nonatomic,weak)UIView *keyView;
@end
@implementation ZCKeyboardView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
        
        
        UILabel *titleLabel=[[UILabel alloc] init];
        titleLabel.text=@"杆数";
        titleLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        self.titleLabel=titleLabel;
        
        UIImageView *imageView=[[UIImageView alloc] init];
        imageView.backgroundColor=[UIColor yellowColor];
        imageView.layer.masksToBounds=YES;
        imageView.layer.cornerRadius=20;
        [self addSubview:imageView];
        self.imageView=imageView;
        
        UILabel *nameLabel=[[UILabel alloc] init];
        nameLabel.text=@"张三";
        [self addSubview:nameLabel];
        self.nameLabel=nameLabel;
        
        
        UILabel *scoreLabel=[[UILabel alloc] init];
        scoreLabel.backgroundColor=[UIColor redColor];
        scoreLabel.textAlignment=NSTextAlignmentCenter;
        scoreLabel.textColor=[UIColor whiteColor];
        //scoreLabel.text=@"-";
        scoreLabel.layer.masksToBounds=YES;
        scoreLabel.layer.cornerRadius=25;
        [self addSubview:scoreLabel];
        self.scoreLabel=scoreLabel;
        
        
        
        UIView *keyView=[[UIView alloc] init];
        [self addSubview:keyView];
        self.keyView=keyView;
        [self  addButtonForKeyView:keyView];
        
        
        
    }
    return self;
}


-(void)addButtonForKeyView:(UIView *)view
{
    
    for (int index=0; index<12; index++) {
        UIButton *button=[[UIButton alloc] init];
        button.backgroundColor=[UIColor redColor];
        //[button setTitle:[NSString stringWithFormat:@"%d",index] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickTheButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.keyView addSubview:button];
        
        if (index<9) {
            [button setTitle:[NSString stringWithFormat:@"%d",index+1] forState:UIControlStateNormal];
        }else if (index==9)
        {
         button.tag=50555;
        [button setTitle:@"X" forState:UIControlStateNormal];
        }else if (index==10)
        {
        [button setTitle:@"0" forState:UIControlStateNormal];
        }else{
         button.tag=50556;
        [button setTitle:@"return" forState:UIControlStateNormal];
        }
        
    }
    
}


//点击按钮
-(void)clickTheButton:(UIButton *)button
{
    if (button.tag==50555) {
        if (self.scoreLabel.text.length==1) {
            self.scoreLabel.text=nil;
        }else{
       NSString *text = [self.scoreLabel.text substringWithRange:NSMakeRange(self.scoreLabel.text.length-1, 1)];
        self.scoreLabel.text=text;
        }
    }else if (button.tag==50556)
    {
        
        if ([self.delegate respondsToSelector:@selector(keyboardViewConfirmThatTheInput:)]) {
            [self.delegate keyboardViewConfirmThatTheInput:self.scoreLabel.text];
            [self removeFromSuperview];
        }
        
    }else
    {
        if (self.scoreLabel.text.length==1) {
            //self.scoreLabel.text=nil;
            NSString *str=[NSString stringWithFormat:@"%@%@",self.scoreLabel.text,button.titleLabel.text];
            ZCLog(@"%@",str);
            self.scoreLabel.text=str;
          }else {
              self.scoreLabel.text=button.titleLabel.text;

            
        }
    }
    
    
   // button.titleLabel.text
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    CGFloat  titleLabelX=0;
    CGFloat  titleLabelY=20;
    CGFloat  titleLabelW=SCREEN_WIDTH;
    CGFloat  titleLabelH=15;
    self.titleLabel.frame=CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    
    CGFloat imageViewX=20;
    CGFloat imageViewY=titleLabelY+titleLabelH+5;
    CGFloat imageViewW=40;
    CGFloat imageViewH=40;
    self.imageView.frame=CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    
    
    CGFloat nameLabelX=20;
    CGFloat nameLabelY=imageViewY+imageViewH;
    CGFloat nameLabelW=40;
    CGFloat nameLabelH=15;
    self.nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    
    CGFloat scoreLabelW=50;
    CGFloat scoreLabelH=50;
    CGFloat scoreLabelX=(SCREEN_WIDTH-scoreLabelW)/2;
    CGFloat scoreLabelY=titleLabelY+titleLabelH+50;
    self.scoreLabel.frame=CGRectMake(scoreLabelX, scoreLabelY, scoreLabelW, scoreLabelH);
    
    
    
    CGFloat keyViewX=0;
    CGFloat keyViewY=scoreLabelH+scoreLabelH+30;
    CGFloat keyViewW=SCREEN_WIDTH;
    CGFloat keyViewH=SCREEN_HEIGHT-keyViewY;
    self.keyView.frame=CGRectMake(keyViewX, keyViewY, keyViewW, keyViewH);
    
    
    // 总列数
    int totalColumns=3;
    
    //尺寸
    CGFloat buttonW=(self.keyView.frame.size.width-80)/3;
    CGFloat buttonH=buttonW;
    
    // 2.间隙 = (控制器view的宽度 - 3 * 应用宽度) / 4
    //CGFloat marginX = (self.view.frame.size.width - totalColumns * appW) / (totalColumns + 1);
    CGFloat marginX = 20;
    CGFloat marginY = 20;
    
   
    for (int index=0; index<self.keyView.subviews.count; index++) {
        UIButton *button=self.keyView.subviews[index];
        // 计算行号和列号
        int row = index / totalColumns;
        int col = index % totalColumns;
        // 计算x和y
        CGFloat buttonX = marginX + col * (buttonW + marginX);
        CGFloat buttonY = marginY+row * (buttonW + marginY);
        // 设置frame
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);


    }
    

    
}

@end
