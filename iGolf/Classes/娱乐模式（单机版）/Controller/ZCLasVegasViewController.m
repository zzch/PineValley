//
//  ZCLasVegasViewController.m
//  iGolf
//
//  Created by hh on 15/7/23.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCLasVegasViewController.h"
#import "ZCLasVegasGameView.h"
#import "ZCDatabaseTool.h"
@interface ZCLasVegasViewController ()
@property(nonatomic,weak)ZCLasVegasGameView *lasVegasGameView;
@property(nonatomic,strong)NSMutableArray *viewArray;
@property(nonatomic,assign)int index;
@property(nonatomic,weak)UIButton *afterBtn;
@property(nonatomic,assign)BOOL isYES;

@property(nonatomic,strong)NSArray *dataArray;
@end

@implementation ZCLasVegasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    //从数据库拿到数据
    self.dataArray= [ZCDatabaseTool doudizhuGameData];
    
    
    self.viewArray=[NSMutableArray array];
    
    for (int i=0; i<18; i++) {
        ZCLasVegasGameView *lasVegasGameView=[[ZCLasVegasGameView alloc] init];
        lasVegasGameView.number=[NSString stringWithFormat:@"%d",i];
        [self.viewArray addObject:lasVegasGameView];
    }
    
    
    
    ZCLasVegasGameView *lasVegasGameView=self.viewArray[self.index];
    
    
    lasVegasGameView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-120);
    
    [self.view addSubview:lasVegasGameView];
    lasVegasGameView.lasVegasModel=self.dataArray[self.index];
    self.lasVegasGameView=lasVegasGameView;
    
    
    
    
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
    
    
    [UIView animateWithDuration:0.5 animations:^{
        self.lasVegasGameView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        [self.lasVegasGameView removeFromSuperview];
        
        ZCLasVegasGameView *lasVegasGameView=self.viewArray[self.index];
        lasVegasGameView.transform = CGAffineTransformIdentity;
        lasVegasGameView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-120);
        [self.view addSubview:lasVegasGameView];
        self.lasVegasGameView=lasVegasGameView;
        
        
        
    }];
    
    
    
}


//点击开始
-(void)clickTheStartBtn
{
    
    
    self.isYES=!self.isYES;
    
    if (self.isYES) {//确认成绩
        [self.afterBtn setTitle:@"下一洞" forState:UIControlStateNormal];
        self.lasVegasGameView.number=@"asdasd";
        // [self.viewArray replaceObjectAtIndex:self.index withObject:self.holeScoringView];
        
        
    }else{
        self.index++;
        
        
        
        [UIView animateWithDuration:0.5 animations:^{
            self.lasVegasGameView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        } completion:^(BOOL finished) {
            [self.lasVegasGameView removeFromSuperview];
            
            ZCLasVegasGameView *lasVegasGameView=self.viewArray[self.index];
            lasVegasGameView.transform = CGAffineTransformIdentity;
            lasVegasGameView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-120);
            [self.view addSubview:lasVegasGameView];
            self.lasVegasGameView=lasVegasGameView;
            
        }];
        
        [self.afterBtn setTitle:@"确认比赛" forState:UIControlStateNormal];
    }
    
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
