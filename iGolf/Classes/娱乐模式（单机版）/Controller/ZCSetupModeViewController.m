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
#import "ZCDoudizhuGameViewController.h"
#import "ZCLasVegasViewController.h"
#import "ZCDatabaseTool.h"
#import "ZCDouModel.h"
@interface ZCSetupModeViewController ()<ZCHoleViewDelegate,ZCFightTheLandlordViewDelegate>
@property(nonatomic,weak)ZCHoleView *holeView;
@property(nonatomic,weak)ZCFightTheLandlordView *fightTheLandlordView;
@property(nonatomic,weak)ZCLasVegasView *lasVegasView;
@property(nonatomic,assign)int index;
//开关
@property(nonatomic,strong)NSMutableDictionary *switchDict;
@property(nonatomic,strong)NSMutableDictionary *fightTheLandlordDict;
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
    
    
    
    self.index=1;
    ZCHoleView *holeView=[[ZCHoleView alloc] init];
    //ZCFightTheLandlordView *holeView=[[ZCFightTheLandlordView alloc ] init];
    CGFloat holeViewX=0;
    CGFloat holeViewY=60;
    CGFloat holeViewW=SCREEN_WIDTH;
    CGFloat holeViewH=SCREEN_HEIGHT-160;
    holeView.frame=CGRectMake(holeViewX, holeViewY, holeViewW, holeViewH);
    holeView.delegate=self;
    [self.view addSubview:holeView];
    self.holeView=holeView;
    //让View 把默认值穿件来
    [self.holeView theDefaultValue];
    
   

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
    
    
    if (self.index==1) {
        //创建比赛，讲比赛保存到数据库
        BOOL success=[ZCDatabaseTool ToCreateAGame:self.switchDict];
        if (success) {
            ZCHoleViewController *hole=[[ZCHoleViewController alloc] init];
            [self.navigationController pushViewController:hole animated:YES];
        }
        
      
      
        
    }else if (self.index==2)
    {
       NSMutableArray *array= [self.fightTheLandlordView obtainCompetitorInformation];
        self.fightTheLandlordDict[@"playerArray"]=array;
        //创建比赛，讲比赛保存到数据库
        BOOL success=[ZCDatabaseTool ToCreateDoudizhuGame:self.fightTheLandlordDict];
        if (success) {
            ZCDoudizhuGameViewController *vc=[[ZCDoudizhuGameViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];

        }
        
    }else if (self.index==3)
    {
        //获得参赛者信息
        NSMutableArray *array=[self.lasVegasView obtainCompetitorInformation];
        //获得开关状态
        NSMutableDictionary *dict=[self.lasVegasView TheStateOfTheSwitch];
        dict[@"type"]=@(self.index);
        //创建比赛 ，保存比赛到数据库
        BOOL success=[ZCDatabaseTool createALasVegasGame:array andSwitch:dict ];
        if (success) {
            ZCLasVegasViewController *vc=[[ZCLasVegasViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
    
}


//比洞模式
-(void)clickTheHoleBtn
{
    self.index=1;
    self.holeView.hidden=NO;
    self.fightTheLandlordView.hidden=YES;
    self.lasVegasView.hidden=YES;
}


//斗地主模式
-(void)clickTheLandlordsBtn
{
    self.index=2;
    if (self.fightTheLandlordView==nil) {
        self.holeView.hidden=YES;
        self.lasVegasView.hidden=YES;
        ZCFightTheLandlordView *fightTheLandlordView=[[ZCFightTheLandlordView alloc ] init];
        CGFloat holeViewX=0;
        CGFloat holeViewY=60;
        CGFloat holeViewW=SCREEN_WIDTH;
        CGFloat holeViewH=SCREEN_HEIGHT-160;
        fightTheLandlordView.frame=CGRectMake(holeViewX, holeViewY, holeViewW, holeViewH);
        [self.view addSubview:fightTheLandlordView];
        fightTheLandlordView.delegate=self;
        //让View 把默认值穿件来
        [fightTheLandlordView theDefaultValue];
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
    self.index=3;
    if (self.lasVegasView==nil) {
        self.holeView.hidden=YES;
        self.fightTheLandlordView.hidden=YES;
        ZCLasVegasView *lasVegasView=[[ZCLasVegasView alloc ] init];
        CGFloat holeViewX=0;
        CGFloat holeViewY=60;
        CGFloat holeViewW=SCREEN_WIDTH;
        CGFloat holeViewH=SCREEN_HEIGHT-160;
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



//ZCHoleViewDelegate 方法
-(void)switchButtonIsOpen:(int)isOpen1 andSwitch2:(int)isOpen2 andSwitch3:(int)isOpen3 andSwitch4:(int)isOpen4 andSwitch5:(int)isOpen5 andWhoWin:(int)whoWin andUserDict:(NSMutableDictionary *)userDict andOtherDict:(NSMutableDictionary *)otherDict
{
   // ZCLog(@"%@",userDict);
    
   NSMutableDictionary *switchDict = [NSMutableDictionary dictionary];
    switchDict[@"isOpen1"]=@(isOpen1);
    switchDict[@"isOpen2"]=@(isOpen2);
    switchDict[@"isOpen3"]=@(isOpen3);
    switchDict[@"isOpen4"]=@(isOpen4);
    switchDict[@"isOpen5"]=@(isOpen5);
    switchDict[@"whoWin"]=@(whoWin);
    switchDict[@"type"]=@(self.index);
    switchDict[@"userDict"]=userDict;
    switchDict[@"otherDict"]=otherDict;
    self.switchDict=switchDict;
    
    //ZCLog(@"%@",self.switchDict[@"userDict"]);
    
}



//ZCFightTheLandlordView 代理方法
-(void)switchButtonIsOpen:(int)isOpen1 andSwitch2:(int)isOpen2 andSwitch3:(int)isOpen3 andUserDict:(ZCDouModel *)userModel andOtherDict:(ZCDouModel *)otherModel andAnotherDict:(ZCDouModel *)anotherModel
{
    
    
    NSMutableDictionary *switchDict = [NSMutableDictionary dictionary];
    switchDict[@"isOpen1"]=@(isOpen1);
    switchDict[@"isOpen2"]=@(isOpen2);
    switchDict[@"isOpen3"]=@(isOpen3);
    switchDict[@"type"]=@(self.index);
    
    self.fightTheLandlordDict=switchDict;
    
    
}


-(NSMutableDictionary *)switchDict
{

    if (_switchDict==nil) {
        //用户不操作时默认状态
        _switchDict = [NSMutableDictionary dictionary];
        _switchDict[@"isOpen1"]=@(1);
        _switchDict[@"isOpen2"]=@(1);
        _switchDict[@"isOpen3"]=@(1);
        _switchDict[@"isOpen4"]=@(1);
        _switchDict[@"isOpen5"]=@(0);
        _switchDict[@"whoWin"]=@(0);
        _switchDict[@"type"]=@(self.index);
       
    }
    return _switchDict;
    
    
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
