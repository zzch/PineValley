//
//  ZCSetupModeViewController.m
//  iGolf
//
//  Created by hh on 15/7/20.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCSetupModeViewController.h"
#import "ZCHoleView.h"
#import "ZCFightTheLandlordView.h"
#import "ZCLasVegasView.h"
#import "ZCHoleViewController.h"
@interface ZCSetupModeViewController ()
@property(nonatomic,weak)ZCHoleView *holeView;
@property(nonatomic,weak)ZCFightTheLandlordView *fightTheLandlordView;
@property(nonatomic,weak)ZCLasVegasView *lasVegasView;
@end

@implementation ZCSetupModeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self addControls];
    
}

//添加控件
-(void)addControls
{
    UIButton *holeBtn=[[UIButton alloc] init];
    CGFloat  holeBtnX=20;
    CGFloat  holeBtnY=20;
    CGFloat  holeBtnW=(SCREEN_WIDTH-80)/3;
    CGFloat  holeBtnH=30;
    holeBtn.frame=CGRectMake(holeBtnX, holeBtnY, holeBtnW, holeBtnH);
    holeBtn.backgroundColor=[UIColor redColor];
    [holeBtn setTitle:@"比洞" forState:UIControlStateNormal];
    [holeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [holeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [holeBtn addTarget:self action:@selector(clickTheHoleBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:holeBtn];
    
    
    UIButton *landlordsBtn=[[UIButton alloc] init];
    CGFloat  landlordsBtnX=20+holeBtnW+20;
    CGFloat  landlordsBtnY=20;
    CGFloat  landlordsBtnW=(SCREEN_WIDTH-80)/3;
    CGFloat  landlordsBtnH=30;
    landlordsBtn.frame=CGRectMake(landlordsBtnX, landlordsBtnY, landlordsBtnW, landlordsBtnH);
    [landlordsBtn setTitle:@"斗地主" forState:UIControlStateNormal];
    [landlordsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [landlordsBtn addTarget:self action:@selector(clickTheLandlordsBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:landlordsBtn];
    
    
    UIButton *lasVegasBtn=[[UIButton alloc] init];
    CGFloat  lasVegasBtnX=20+holeBtnW+20+holeBtnW+20;
    CGFloat  lasVegasBtnY=20;
    CGFloat  lasVegasBtnW=(SCREEN_WIDTH-80)/3;
    CGFloat  lasVegasBtnH=30;
    lasVegasBtn.frame=CGRectMake(lasVegasBtnX, lasVegasBtnY, lasVegasBtnW, lasVegasBtnH);
    [lasVegasBtn setTitle:@"拉斯维加斯" forState:UIControlStateNormal];
    [lasVegasBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [lasVegasBtn addTarget:self action:@selector(clickTheLasVegasBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lasVegasBtn];
    
    
    
    
    ZCHoleView *holeView=[[ZCHoleView alloc] init];
    //ZCFightTheLandlordView *holeView=[[ZCFightTheLandlordView alloc ] init];
    CGFloat holeViewX=0;
    CGFloat holeViewY=60;
    CGFloat holeViewW=SCREEN_WIDTH;
    CGFloat holeViewH=SCREEN_HEIGHT;
    holeView.frame=CGRectMake(holeViewX, holeViewY, holeViewW, holeViewH);
    [self.view addSubview:holeView];
    self.holeView=holeView;
    
    
   

    UIButton *startBtn=[[UIButton alloc] init];
    startBtn.backgroundColor=[UIColor redColor];
    CGFloat startBtnX=0;
    CGFloat startBtnY=self.view.frame.size.height-100;
    CGFloat startBtnW=SCREEN_WIDTH;
    CGFloat startBtnH=30;
    startBtn.frame=CGRectMake(startBtnX, startBtnY, startBtnW, startBtnH);
    [startBtn setTitle:@"开始" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(clickTheStartBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    
}

//点击开始
-(void)clickTheStartBtn
{
    ZCHoleViewController *hole=[[ZCHoleViewController alloc] init];
    [self.navigationController pushViewController:hole animated:YES];
}


//比洞模式
-(void)clickTheHoleBtn
{
    self.holeView.hidden=NO;
    self.fightTheLandlordView.hidden=YES;
    self.lasVegasView.hidden=YES;
}


//斗地主模式
-(void)clickTheLandlordsBtn
{
    if (self.fightTheLandlordView==nil) {
        self.holeView.hidden=YES;
        self.lasVegasView.hidden=YES;
        ZCFightTheLandlordView *fightTheLandlordView=[[ZCFightTheLandlordView alloc ] init];
        CGFloat holeViewX=0;
        CGFloat holeViewY=60;
        CGFloat holeViewW=SCREEN_WIDTH;
        CGFloat holeViewH=SCREEN_HEIGHT;
        fightTheLandlordView.frame=CGRectMake(holeViewX, holeViewY, holeViewW, holeViewH);
        [self.view addSubview:fightTheLandlordView];
        self.fightTheLandlordView=fightTheLandlordView;

    }else
    {
      self.holeView.hidden=YES;
        self.lasVegasView.hidden=YES;
      self.fightTheLandlordView.hidden=NO;
    }
    
}


//拉斯维加斯
-(void)clickTheLasVegasBtn
{
    
    if (self.lasVegasView==nil) {
        self.holeView.hidden=YES;
        self.fightTheLandlordView.hidden=YES;
        ZCLasVegasView *lasVegasView=[[ZCLasVegasView alloc ] init];
        CGFloat holeViewX=0;
        CGFloat holeViewY=60;
        CGFloat holeViewW=SCREEN_WIDTH;
        CGFloat holeViewH=SCREEN_HEIGHT;
        lasVegasView.frame=CGRectMake(holeViewX, holeViewY, holeViewW, holeViewH);
        [self.view addSubview:lasVegasView];
        self.lasVegasView=lasVegasView;
    }else
    {
        self.holeView.hidden=YES;
        self.fightTheLandlordView.hidden=YES;
        self.lasVegasView.hidden=NO;

    
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
