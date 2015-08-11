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
#import "ZCFightTheLandlordModel.h"
#import "ZCOfflinePlayer.h"
#import "ZCEntertainmentRankingTableViewController.h"
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
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation ZCHoleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    UIBarButtonItem *ButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"排名" style:UIBarButtonItemStyleDone target:self action:@selector(clickTherightItem)];
    
    self.navigationItem.rightBarButtonItem = ButtonItem;
    
    //从数据库拿到数据
    self.dataArray= [ZCDatabaseTool doudizhuGameData];
    
   // ZCLog(@"%ld",self.dataArray[0] pa);
    self.viewArray=[NSMutableArray array];
    
    for (int i=0; i<18; i++) {
     ZCHoleScoringView *holeScoringView=[[ZCHoleScoringView alloc] init];
        holeScoringView.delegate=self;
        holeScoringView.number=[NSString stringWithFormat:@"%d",i];
        [self.viewArray addObject:holeScoringView];
    }
    
    
    //历史进来打了多少球
    int historyCount = 0;
    for (int j=0; j<18; j++) {
        ZCFightTheLandlordModel *fightTheLandlordModel=self.dataArray[j];
        if (fightTheLandlordModel.par==0) {
            break;
        }else{
            historyCount++;
        }
        
    }
    
    ZCLog(@"%d",historyCount);
    
    for (int i=0; i<historyCount; i++) {
        
        [self saveTheData];
        ZCHoleScoringView *holeScoringView=self.viewArray[i];
        
        holeScoringView.fightTheLandlordModel=self.dataArray[i];
        self.index++;
        
    }
    

    
    
    
    
    ZCHoleScoringView *holeScoringView=self.viewArray[self.index];
    
    holeScoringView.fightTheLandlordModel=self.dataArray[self.index];
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

    self.isYES=YES;
    [self.afterBtn setTitle:@"下一洞" forState:UIControlStateNormal];
    
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
        ZCFightTheLandlordModel *FightTheLandlordModel=self.dataArray[self.index];
        if (FightTheLandlordModel.par==0) {
            holeScoringView.fightTheLandlordModel=self.dataArray[self.index];
            holeScoringView.isNext=self.isNext;
        }

//        holeScoringView.userWinPoints=self.userScore;
//        holeScoringView.otherWinPoints=self.otherScore;
//        holeScoringView.isNext=self.isNext;
        holeScoringView.transform = CGAffineTransformIdentity;
        holeScoringView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-120);
        [self.view addSubview:holeScoringView];
        self.holeScoringView=holeScoringView;
        
    }];
        
        
        ZCFightTheLandlordModel *FightTheLandlordModel=self.dataArray[self.index];
        if (FightTheLandlordModel.par==0) {
            self.isYES=NO;
            [self.afterBtn setTitle:@"确认比赛" forState:UIControlStateNormal];
        }else{
            self.isYES=YES;
            [self.afterBtn setTitle:@"下一洞" forState:UIControlStateNormal];
        }

        
       
    }
    
}




//保存数据
-(void)saveTheData
{
    
    //self.holeScoringView
    ZCHoleScoringView *holeScoringView=self.viewArray[self.index];
    ZCFightTheLandlordModel *fightTheLandlordModel=self.dataArray[self.index];
    
    ZCLog(@"%d",fightTheLandlordModel.par);
    //拿出二人的成绩
    ZCOfflinePlayer *play1= fightTheLandlordModel.plays[0];
    ZCOfflinePlayer *play2= fightTheLandlordModel.plays[1];
    
    
    ZCLog(@"%ld",(long)play1.stroke);
    ZCLog(@"%ld",(long)play2.stroke);
    int who=1 ;
    int otherWho=1  ;
    int  doublePar1 = 0;
    int  doublePar2 = 0;
  ZCSwitchModel *switchModel= [ZCDatabaseTool querySwitchProperties];
    //计算分数
    if (play1.stroke-fightTheLandlordModel.par==-1) {
        if (switchModel.birdie_x2==1){
            who=2;
        }else
            {
                 who=1;
            }
       
        
    }else if (play1.stroke-fightTheLandlordModel.par<-1)
    {
        if (switchModel.eagle_x4==1){
            who=4;
        }else{
         who=1;
        }
    }else if (play1.stroke-fightTheLandlordModel.par>=2*fightTheLandlordModel.par)
    {
        if (switchModel.double_par_x2==1){
         doublePar1=2;
            who=1;
        }else{
         doublePar1=1;
            who=1;
        }
    }else{
        who=1;
    }
    
    ZCLog(@"%d",who);
    
    
    if (play2.stroke-fightTheLandlordModel.par==-1) {
        otherWho=2;
    }else if (play2.stroke-fightTheLandlordModel.par<-1)
    {
        otherWho=4;
    }else if (play2.stroke-fightTheLandlordModel.par>=fightTheLandlordModel.par)
    {
         doublePar2=2;
    }else{
        doublePar2=1;
    }

    
    
    
    //判断谁赢
    if (play1.stroke<play2.stroke) {
        //本机机主赢
        
        ZCLog(@"%d",doublePar2);
        ZCLog(@"%d",doublePar1);
        
        
        if (doublePar2==2) {
            play1.score= play1.score+ who*(self.isNext+1)*2;
            play2.score=play2.score-who*(self.isNext+1)*2;
            
            ZCLog(@"%ld",play1.score+ who*(self.isNext+1)*2);
            ZCLog(@"%ld",(long)play1.score);
            ZCLog(@"%ld",(long)play2.score);

        }else
        {
        play1.score= play1.score+ who*(self.isNext+1);
        play2.score=play2.score-who*(self.isNext+1);
        }
        
        if (self.isNext) {
            holeScoringView.clues=@"本洞获胜方获得了累计分数";
        }
        self.isNext=0;
    }else if (play1.stroke-play2.stroke==0)
    {//打平
        if (switchModel.drau_to_next==1) {
            self.isNext++;
            
            holeScoringView.clues=@"本洞比分打平,分数累至下一洞";
            
            
        }else{
            play1.winScore=0;
            play2.winScore=0;
        }
        
    
    }else
    {
    self.isNext=0;
        //本机机主输
        if (doublePar1==2) {
            play1.score= play1.score- otherWho*(self.isNext+1)*2;
            play2.score=play2.score+otherWho*(self.isNext+1)*2;
            ZCLog(@"%ld",play2.score+otherWho*(self.isNext+1)*2);
        }else
        {
            play1.score= play1.score- otherWho*(self.isNext+1);
            play2.score=play2.score+otherWho*(self.isNext+1);
        }

        if (self.isNext) {
            holeScoringView.clues=@"本洞获胜方获得了累计分数";
        }
        
    }
    
    
    ZCLog(@"%ld",(long)play1.score);
    ZCLog(@"%ld",(long)play2.score);
    
   //保存数据库
  BOOL success=  [ZCDatabaseTool saveEveryHole:fightTheLandlordModel andHoleNumber:self.index];
    if (success) {
        self.holeScoringView.fightTheLandlordModel=fightTheLandlordModel;
        
       ZCFightTheLandlordModel *fightTheLandlordModel=self.dataArray[self.index+1];
       ZCOfflinePlayer *play3= fightTheLandlordModel.plays[0];
       ZCOfflinePlayer *play4= fightTheLandlordModel.plays[1];
        
        play3.score=play1.score;
        play4.score=play2.score;

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



-(void)clickTherightItem
{
    ZCEntertainmentRankingTableViewController *vc=[[ZCEntertainmentRankingTableViewController alloc] init];
    ZCFightTheLandlordModel *FightTheLandlordModel=self.dataArray[self.index];
    vc.dataArray=FightTheLandlordModel.plays;
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
