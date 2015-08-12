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
        self.backgroundColor=ZCColor(237, 237, 237);
        
        
        
        
        UIImageView *imageView=[[UIImageView alloc] init];
        imageView.backgroundColor=[UIColor yellowColor];
        imageView.layer.masksToBounds=YES;
        imageView.layer.cornerRadius=40;
        imageView.layer.borderWidth=2;
        [self addSubview:imageView];
        self.imageView=imageView;
        
        UILabel *nameLabel=[[UILabel alloc] init];
        nameLabel.text=@"张三";
        nameLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:nameLabel];
        self.nameLabel=nameLabel;
        
        
        UILabel *titleLabel=[[UILabel alloc] init];
        titleLabel.text=@"杆数";
        titleLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        self.titleLabel=titleLabel;
        
        UILabel *scoreLabel=[[UILabel alloc] init];
        scoreLabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"ganshuchengji"]];
        scoreLabel.textAlignment=NSTextAlignmentCenter;
        scoreLabel.textColor=[UIColor whiteColor];
        scoreLabel.font=[UIFont systemFontOfSize:25];
        scoreLabel.text=@"-";
//        scoreLabel.layer.masksToBounds=YES;
//        scoreLabel.layer.cornerRadius=25;
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
        [button setTitleColor:ZCColor(34, 34, 34) forState:UIControlStateNormal];
        button.backgroundColor=[UIColor whiteColor];
        button.titleLabel.font=[UIFont systemFontOfSize:25];
        //[button setTitle:[NSString stringWithFormat:@"%d",index] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickTheButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.keyView addSubview:button];
        
        if (index<9) {
            [button setTitle:[NSString stringWithFormat:@"%d",index+1] forState:UIControlStateNormal];
        }else if (index==9)
        {
         button.tag=50555;
        [button setImage:[UIImage imageNamed:@"shanchu"] forState:UIControlStateNormal];
        }else if (index==10)
        {
        [button setTitle:@"0" forState:UIControlStateNormal];
        }else{
         button.tag=50556;
        [button setImage:[UIImage imageNamed:@"quereng"] forState:UIControlStateNormal];
        }
        
    }
    
}

-(void)setColorIndex:(int )colorIndex
{
    _colorIndex=colorIndex;
    if (colorIndex==1) {
        self.imageView.layer.borderColor=[UIColor redColor].CGColor;
    }else{
    self.imageView.layer.borderColor=[UIColor yellowColor].CGColor;
    }

}

-(void)setName:(NSString *)name
{
    _name=name;
    
    self.nameLabel.text=name;
    
}

-(void)setImageStr:(NSString *)imageStr{
    _imageStr=imageStr;
    // 获取路劲 取出图片
    NSString *path=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:imageStr];
    NSData *imageData=[NSData dataWithContentsOfFile:path];
    UIImage *image=[[UIImage alloc] initWithData:imageData];
    self.imageView.image=image;

}

//点击按钮
-(void)clickTheButton:(UIButton *)button
{
    if ([self.scoreLabel.text isEqual:@"-"]) {
        self.scoreLabel.text=nil;
    }
    
    if (button.tag==50555) {
        if (self.scoreLabel.text.length==0) {
            [self removeFromSuperview];
        }else if (self.scoreLabel.text.length==1) {
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
    
    
    
    
    CGFloat imageViewY=30;
    CGFloat imageViewW=80;
    CGFloat imageViewH=80;
    CGFloat imageViewX=(SCREEN_WIDTH-imageViewW)/2;
    self.imageView.frame=CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    
    
    CGFloat nameLabelX=0;
    CGFloat nameLabelY=imageViewY+imageViewH+10;
    CGFloat nameLabelW=SCREEN_WIDTH;
    CGFloat nameLabelH=20;
    self.nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    CGFloat  titleLabelX=0;
    CGFloat  titleLabelY=nameLabelY+nameLabelH+15;
    CGFloat  titleLabelW=SCREEN_WIDTH;
    CGFloat  titleLabelH=15;
    self.titleLabel.frame=CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);

    
    
    CGFloat scoreLabelW=115;
    CGFloat scoreLabelH=50;
    CGFloat scoreLabelX=(SCREEN_WIDTH-scoreLabelW)/2;
    CGFloat scoreLabelY=titleLabelY+titleLabelH+10;
    self.scoreLabel.frame=CGRectMake(scoreLabelX, scoreLabelY, scoreLabelW, scoreLabelH);
    
    
    
    CGFloat keyViewX=0;
    
    CGFloat keyViewW=SCREEN_WIDTH;
    CGFloat keyViewH=225;
    CGFloat keyViewY=SCREEN_HEIGHT-keyViewH;
    self.keyView.frame=CGRectMake(keyViewX, keyViewY, keyViewW, keyViewH);
    
    
    // 总列数
    int totalColumns=3;
    
    //尺寸
    CGFloat buttonW=(self.keyView.frame.size.width-2)/3;
    CGFloat buttonH=(self.keyView.frame.size.height-3)/4;
    
    // 2.间隙 = (控制器view的宽度 - 3 * 应用宽度) / 4
    //CGFloat marginX = (self.view.frame.size.width - totalColumns * appW) / (totalColumns + 1);
    CGFloat marginX = 1;
    CGFloat marginY = 1;
    
   
    for (int index=0; index<self.keyView.subviews.count; index++) {
        UIButton *button=self.keyView.subviews[index];
        // 计算行号和列号
        int row = index / totalColumns;
        int col = index % totalColumns;
        // 计算x和y
        CGFloat buttonX = marginX + col * (buttonW + marginX);
        CGFloat buttonY = marginY+row * (buttonH + marginY);
        // 设置frame
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);


    }
    

    
}

@end
