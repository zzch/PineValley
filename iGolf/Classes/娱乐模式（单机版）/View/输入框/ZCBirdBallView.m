//
//  ZCBirdBallView.m
//  iGolf
//
//  Created by hh on 15/8/13.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCBirdBallView.h"
@interface ZCBirdBallView()
@property(nonatomic,weak)UIImageView *imageView;
@property(nonatomic,weak)UILabel *textLabel;
@property(nonatomic,assign,getter=isOpen)BOOL open;
@end
@implementation ZCBirdBallView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        self.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.8];
        [self addControls];
        self.open=NO;
    }
    return self;

}

//laoyingqiu_tishi
-(void)addControls
{
    UIImageView *imageView=[[UIImageView alloc] init];
    
    [self addSubview:imageView];
    self.imageView=imageView;
    
    
    
    UILabel *textLabel=[[UILabel alloc] init];
    textLabel.textAlignment=NSTextAlignmentCenter;
    textLabel.textColor=[UIColor whiteColor];
    [self addSubview:textLabel];
    self.textLabel=textLabel;
    

    
}


//斗地主页面调用
-(void)setName:(NSString *)str andIndex:(NSInteger)index1{

    if (index1==2) {
      self.textLabel.text=[NSString stringWithFormat:@"%@打了小鸟球",str];
        self.imageView.image=[UIImage imageNamed:@"xiaoniaoqiu_ts"];
    }else if (index1==4)
    {
    self.textLabel.text=[NSString stringWithFormat:@"%@打了老鹰球",str];
    self.imageView.image=[UIImage imageNamed:@"laoyingqiu_tishi"];
    }else if (index1==1)
    {
    self.textLabel.text=[NSString stringWithFormat:@"%@居然打了双倍标准杆",str];
        self.imageView.image=[UIImage imageNamed:@"sbbzg_ts"];
    }
    self.open=NO;
    [self layoutSubviewssss];
}


-(void)setIndex:(int)index
{
    _index=index;
    
    if (index==1) {
        self.textLabel.text=[NSString stringWithFormat:@"%@打了双倍标准杆",self.player.nickname];
        self.imageView.image=[UIImage imageNamed:@"sbbzg_ts"];
    }else if (index==2)
    {
    self.textLabel.text=[NSString stringWithFormat:@"%@打了小鸟球",self.player.nickname];
         self.imageView.image=[UIImage imageNamed:@"xiaoniaoqiu_ts"];
    }else{
    self.textLabel.text=[NSString stringWithFormat:@"%@打了老鹰球",self.player.nickname];
        self.imageView.image=[UIImage imageNamed:@"laoyingqiu_tishi"];
    }

     self.open=NO;
    [self layoutSubviewssss];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
    
    if (self.doulePar==2) {
        if ([self.delegate respondsToSelector:@selector(ZCBirdBallViewWhetherPopUpNext:andIndexDoulePar:)]) {
            [self.delegate ZCBirdBallViewWhetherPopUpNext:self.otherPlayer andIndexDoulePar:self.doulePar];
            self.doulePar=0;
        }
 
    }
    
    
    if (self.douDoulePar==2) {
        
        if ([self.delegate respondsToSelector:@selector(ZCBirdBallViewWhetherPopUpNextWithDouDiZhu:andIndexDoulePar:)]) {
            [self .delegate ZCBirdBallViewWhetherPopUpNextWithDouDiZhu:self.name andIndexDoulePar:self.douDoulePar];
            
            self.douDoulePar=0;
        }
    }
    
    
}
-(void)layoutSubviewssss
{
   // [super layoutSubviews];
    
    
    CGFloat imageViewW=10;
    CGFloat imageViewH=10;
    CGFloat imageViewX=(SCREEN_WIDTH-imageViewW)/2;
    CGFloat imageViewY=(SCREEN_HEIGHT-imageViewH-30)/2;
    self.imageView.frame=CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    
//    [UIView animateWithDuration:0.5 animations:^{
//        //self.imageView.transform = CGAffineTransformMakeScale(1, 1);
//        CGFloat imageViewW=1;
//        CGFloat imageViewH=1;
//        CGFloat imageViewX=(SCREEN_WIDTH-imageViewW)/2;
//        CGFloat imageViewY=(SCREEN_HEIGHT-imageViewH-30)/2;
//        self.imageView.frame=CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
//    } completion:^(BOOL finished) {
//        
//        CGFloat imageViewW=173;
//        CGFloat imageViewH=149;
//        CGFloat imageViewX=(SCREEN_WIDTH-imageViewW)/2;
//        CGFloat imageViewY=(SCREEN_HEIGHT-imageViewH-30)/2;
//        self.imageView.frame=CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
//        
//      //  self.imageView.transform = CGAffineTransformIdentity;
//        
//    }];
//
    
    
    
    CGFloat textLabelX=0;
    CGFloat textLabelY=(SCREEN_HEIGHT-imageViewH-30)/2+149+10;
    CGFloat textLabelW=1;
    CGFloat textLabelH=1;
    self.textLabel.frame=CGRectMake(textLabelX, textLabelY, textLabelW, textLabelH);
    
    
    
//    [UIView animateWithDuration:0.5 animations:^{
//        
//        // 设置view弹出来的位置
//////        
//        CGFloat imageViewW=173;
//        CGFloat imageViewH=149;
//        CGFloat imageViewX=(SCREEN_WIDTH-imageViewW)/2;
//        CGFloat imageViewY=(SCREEN_HEIGHT-imageViewH-30)/2;
//        self.imageView.frame=CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
//        // self.imageView.transform = CGAffineTransformMakeScale(100, 100);
//        
//        ZCLog(@"几次");
//        
//    }];
    
    
    
   // if (self.open==NO) {
        
    
     [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
         CGFloat imageViewW=173;
         CGFloat imageViewH=149;
         CGFloat imageViewX=(SCREEN_WIDTH-imageViewW)/2;
         CGFloat imageViewY=(SCREEN_HEIGHT-imageViewH-30)/2;
         self.imageView.frame=CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
         
         
         CGFloat textLabelX=0;
         CGFloat textLabelY=(SCREEN_HEIGHT-imageViewH-30)/2+149+10;
         CGFloat textLabelW=SCREEN_WIDTH;
         CGFloat textLabelH=20;
         self.textLabel.frame=CGRectMake(textLabelX, textLabelY, textLabelW, textLabelH);
         
     } completion:^(BOOL finished) {
         self.open=YES;
     }];
    
  //  }
    

//    [UIView animateWithDuration:0.8 animations:^{
//        CGFloat textLabelX=0;
//        CGFloat textLabelY=(SCREEN_HEIGHT-imageViewH-30)/2+149+10;
//        CGFloat textLabelW=SCREEN_WIDTH;
//        CGFloat textLabelH=20;
//        self.textLabel.frame=CGRectMake(textLabelX, textLabelY, textLabelW, textLabelH);
//
//         }];
    
//    [UIView animateWithDuration:0.5 animations:^{
//        //self.holeScoringView.transform = CGAffineTransformMakeScale(0.01, 0.01);
//    } completion:^(BOOL finished) {
//        
//        
//    }];

    
}

@end
