//
//  ZCHoleViewController.m
//  iGolf
//
//  Created by hh on 15/7/22.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCHoleViewController.h"
#import "ZCHoleScoringView.h"

@interface ZCHoleViewController ()
@property(nonatomic,strong)NSMutableArray *viewArray;
@property(nonatomic,assign)int index;
@property(nonatomic,strong)ZCHoleScoringView *holeScoringView;
@property(nonatomic,weak)UIButton *afterBtn;
@property(nonatomic,assign)BOOL isYES;

@end

@implementation ZCHoleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.viewArray=[NSMutableArray array];
    for (int i=0; i<18; i++) {
     ZCHoleScoringView *holeScoringView=[[ZCHoleScoringView alloc] init];
        holeScoringView.number=[NSString stringWithFormat:@"%d",i];
        [self.viewArray addObject:holeScoringView];
    }
    
    
    
    ZCHoleScoringView *holeScoringView=self.viewArray[self.index];
    
   
    holeScoringView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-120);
    
    [self.view addSubview:holeScoringView];
    self.holeScoringView=holeScoringView;
    ZCLog(@"%p",holeScoringView);
    
    
    
    UIButton *beforeBtn=[[UIButton alloc] init];
    beforeBtn.backgroundColor=[UIColor redColor];
    CGFloat beforeBtnX=0;
    CGFloat beforeBtnY=self.view.frame.size.height-94;
    CGFloat beforeBtnW=SCREEN_WIDTH/2;
    CGFloat beforeBtnH=30;
    beforeBtn.frame=CGRectMake(beforeBtnX, beforeBtnY, beforeBtnW, beforeBtnH);
    [beforeBtn setTitle:@"上一洞" forState:UIControlStateNormal];
    [beforeBtn addTarget:self action:@selector(clickTheBeforeBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:beforeBtn];
    
    UIButton *afterBtn=[[UIButton alloc] init];
    afterBtn.backgroundColor=[UIColor redColor];
    CGFloat afterBtnX=beforeBtnW;
    CGFloat afterBtnY=self.view.frame.size.height-94;
    CGFloat afterBtnW=beforeBtnW;
    CGFloat afterBtnH=30;
    afterBtn.frame=CGRectMake(afterBtnX, afterBtnY, afterBtnW, afterBtnH);
    [afterBtn setTitle:@"确认成绩" forState:UIControlStateNormal];
    [afterBtn addTarget:self action:@selector(clickTheStartBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:afterBtn];
    self.afterBtn=afterBtn;

    
}

//上一洞
-(void)clickTheBeforeBtn
{
    self.index--;
    ZCLog(@"%d",self.index);
    ZCLog(@"%@",self.holeScoringView);
    ZCLog(@"%lu",(unsigned long)self.view.subviews.count);
    [self.holeScoringView removeFromSuperview];
    self.holeScoringView=nil;
    ZCLog(@"%@",self.holeScoringView);
    
    ZCHoleScoringView *holeScoringView=self.viewArray[self.index];
    ZCLog(@"%@",self.holeScoringView);
    holeScoringView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-120);
    holeScoringView.backgroundColor=[UIColor redColor];
    [self.view addSubview:holeScoringView];
    self.holeScoringView=holeScoringView;
    
    ZCLog(@"%@",holeScoringView);

    
//    [UIView animateWithDuration:0.5 animations:^{
//        self.holeScoringView.transform = CGAffineTransformMakeScale(0.01, 0.01);
//    } completion:^(BOOL finished) {
//        [self.holeScoringView removeFromSuperview];
//        
//        ZCHoleScoringView *holeScoringView=self.viewArray[self.index];
//        holeScoringView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-120);
//        [self.view addSubview:holeScoringView];
//        self.holeScoringView=holeScoringView;
//        
//        ZCLog(@"%@",holeScoringView);
//        
//    }];

    
    
//    self.index--;
//    [self.holeScoringView removeFromSuperview];
//    ZCHoleScoringView *holeScoringView=self.viewArray[self.index];
//    holeScoringView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-120);
//    [self.view addSubview:holeScoringView];
//    self.holeScoringView=holeScoringView;
//   
}


//点击开始
-(void)clickTheStartBtn
{
    self.index++;
   // self.index;
    ZCLog(@"%d",self.index);
    ZCLog(@"%lu",(unsigned long)self.view.subviews.count);
    [UIView animateWithDuration:0.5 animations:^{
        self.holeScoringView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        [self.holeScoringView removeFromSuperview];
        self.holeScoringView=nil;
        ZCLog(@"%@",self.holeScoringView);
        ZCHoleScoringView *holeScoringView=self.viewArray[self.index];
        ZCLog(@"%p",holeScoringView);
        holeScoringView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-120);
        [self.view addSubview:holeScoringView];
        self.holeScoringView=holeScoringView;
        ZCLog(@"%p",self.holeScoringView);
        
    }];
    

    
//    self.isYES=!self.isYES;
//    
//    if (self.isYES) {//确认成绩
//        [self.afterBtn setTitle:@"下一洞" forState:UIControlStateNormal];
//        self.holeScoringView.number=@"asdasd";
//        [self.viewArray replaceObjectAtIndex:self.index withObject:self.holeScoringView];
//      
//        
//    }else{
//        self.index++;
//
//    
//    
//    [UIView animateWithDuration:0.5 animations:^{
//          self.holeScoringView.transform = CGAffineTransformMakeScale(0.01, 0.01);
//    } completion:^(BOOL finished) {
//        [self.holeScoringView removeFromSuperview];
//        
//        ZCHoleScoringView *holeScoringView=self.viewArray[self.index];
//        holeScoringView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-120);
//        [self.view addSubview:holeScoringView];
//        self.holeScoringView=holeScoringView;
//        
//    }];
//        
//        [self.afterBtn setTitle:@"确认比赛" forState:UIControlStateNormal];
//    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
