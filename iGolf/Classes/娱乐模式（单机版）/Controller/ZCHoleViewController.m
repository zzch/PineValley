//
//  ZCHoleViewController.m
//  iGolf
//
//  Created by hh on 15/7/22.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCHoleViewController.h"
#import "ZCHoleScoringView.h"
#import "ZCHoleModel.h"
#import "ZCDatabaseTool.h"
#import "ZCSwitchModel.h"
@interface ZCHoleViewController ()<ZCHoleScoringViewDelegate>
@property(nonatomic,strong)NSMutableArray *viewArray;

@property(nonatomic,assign)int index;
@property(nonatomic,strong)ZCHoleScoringView *holeScoringView;
@property(nonatomic,weak)UIButton *afterBtn;
@property(nonatomic,assign)BOOL isYES;
@property(nonatomic,strong)ZCHoleModel *holeModel;
//自己的总成绩
@property(nonatomic,assign)int userScore;
//其他的总成绩
@property(nonatomic,assign)int otherScore;
//是否打平进入下一洞
@property(nonatomic,assign)int isNext;
@end

@implementation ZCHoleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.viewArray=[NSMutableArray array];
    
    for (int i=0; i<18; i++) {
     ZCHoleScoringView *holeScoringView=[[ZCHoleScoringView alloc] init];
        holeScoringView.delegate=self;
        holeScoringView.number=[NSString stringWithFormat:@"%d",i];
        [self.viewArray addObject:holeScoringView];
    }
    
    
    
    ZCHoleScoringView *holeScoringView=self.viewArray[self.index];
    
   
    holeScoringView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-120);
    
    [self.view addSubview:holeScoringView];
    self.holeScoringView=holeScoringView;
    
    
    
    
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
        self.holeScoringView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        [self.holeScoringView removeFromSuperview];
        
        ZCHoleScoringView *holeScoringView=self.viewArray[self.index];
        holeScoringView.transform = CGAffineTransformIdentity;
        holeScoringView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-120);
        [self.view addSubview:holeScoringView];
        self.holeScoringView=holeScoringView;
        
     
        
    }];

    
    
}


//点击开始
-(void)clickTheStartBtn
{
  
    
    self.isYES=!self.isYES;
    
    if (self.isYES) {//确认成绩
        [self.afterBtn setTitle:@"下一洞" forState:UIControlStateNormal];
        self.holeScoringView.number=@"asdasd";
       // [self.viewArray replaceObjectAtIndex:self.index withObject:self.holeScoringView];
        [self saveTheData];
        
    }else{
        self.index++;

    
    
    [UIView animateWithDuration:0.5 animations:^{
          self.holeScoringView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        [self.holeScoringView removeFromSuperview];
        
        ZCHoleScoringView *holeScoringView=self.viewArray[self.index];
        holeScoringView.userWinPoints=self.userScore;
        holeScoringView.otherWinPoints=self.otherScore;
        holeScoringView.isNext=self.isNext;
        holeScoringView.transform = CGAffineTransformIdentity;
        holeScoringView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-120);
        [self.view addSubview:holeScoringView];
        self.holeScoringView=holeScoringView;
        
    }];
        
        [self.afterBtn setTitle:@"确认比赛" forState:UIControlStateNormal];
    }
    
}




//保存数据
-(void)saveTheData
{
    
    int who;
    int otherWho;
  ZCSwitchModel *switchModel= [ZCDatabaseTool querySwitchProperties];
    //计算分数
    if (self.holeModel.userScore-self.holeModel.par==-1) {
        if (switchModel.birdie_x2==1){
            who=2;
        }else
            {
                 who=1;
            }
       
        
    }else if (self.holeModel.userScore-self.holeModel.par<-1)
    {
        if (switchModel.eagle_x4==1){
            who=4;
        }else{
         who=1;
        }
    }else if (self.holeModel.userScore-self.holeModel.par>=2*self.holeModel.par)
    {
        if (switchModel.double_par_x2==1){
         who=2;
        }else{
         who=1;
        }
    }else{
        who=1;
    }
    
    if (self.holeModel.otherScore-self.holeModel.par==-1) {
        otherWho=2;
    }else if (self.holeModel.otherScore-self.holeModel.par<-1)
    {
        otherWho=4;
    }else if (self.holeModel.otherScore-self.holeModel.par>=self.holeModel.par)
    {
        otherWho=2;
    }else{
        otherWho=1;
    }

    
    
    
    //判断谁赢
    if (self.holeModel.userScore-self.holeModel.otherScore<0) {
        //本机机主赢
        
//        if (self.isNext) {
//            
//        }
        
        if (otherWho==2) {
            self.userScore= self.userScore+ who*(self.isNext+1)*2;
            self.otherScore=self.otherScore-who*(self.isNext+1)*2;
        }else
        {
        self.userScore= self.userScore+ who*(self.isNext+1);
        self.otherScore=self.otherScore-who*(self.isNext+1);
        }
        
        if (self.isNext) {
            self.holeScoringView.clues=@"本洞获胜方获得了累计分数";
        }
        self.isNext=0;
    }else if (self.holeModel.userScore-self.holeModel.otherScore==0)
    {//打平
        if (switchModel.drau_to_next==1) {
            self.isNext++;
            
            self.holeScoringView.clues=@"本洞比分打平,分数累至下一洞";
            
            
        }else{
            self.userScore= self.userScore;
            self.otherScore=self.otherScore;
        }
        
    
    }else
    {
    self.isNext=0;
        //本机机主输
        if (who==2) {
            self.userScore= self.userScore- otherWho*(self.isNext+1)*2;
            self.otherScore=self.otherScore+otherWho*(self.isNext+1)*2;
        }else
        {
            self.userScore= self.userScore- otherWho*(self.isNext+1);
            self.otherScore=self.otherScore+otherWho*(self.isNext+1);
        }

        if (self.isNext) {
            self.holeScoringView.clues=@"本洞获胜方获得了累计分数";
        }
        
    }
    
   //保存数据库
  BOOL success=  [ZCDatabaseTool saveEveryHole:self.holeModel];
    if (success) {
        self.holeScoringView.userWinPoints=self.userScore;
        self.holeScoringView.otherWinPoints=self.otherScore;
        ZCLog(@"成功");
    }else
    {
    ZCLog(@"失败");
    }
    
}


//代理方法 传值回来
-(void)holeScoringViewForScore:(ZCHoleModel *)holeModel
{
    self.holeModel=holeModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
