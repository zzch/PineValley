//
//  ZCDoudizhuGameViewController.m
//  iGolf
//
//  Created by hh on 15/7/23.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCDoudizhuGameViewController.h"
#import "ZCDoudizhuGameView.h"
#import "ZCDatabaseTool.h"
#import "ZCSwitchModel.h"
#import "ZCOfflinePlayer.h"
#import "ZCEntertainmentRankingTableViewController.h"
#import "ZCBirdBallView.h"
#import "ZCSingletonTool.h"
@interface ZCDoudizhuGameViewController ()<ZCDoudizhuGameViewDelegate>
@property(nonatomic,weak)ZCDoudizhuGameView *doudizhuGameView;
@property(nonatomic,strong)NSMutableArray *viewArray;
@property(nonatomic,assign)int index;
@property(nonatomic,weak)UIButton *afterBtn;
@property(nonatomic,weak)UIButton *beforeBtn;
@property(nonatomic,assign)BOOL isYES;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)ZCBirdBallView *birdBallView;
@property(nonatomic,assign) int liftScore;
@property(nonatomic,assign) int middleScore;
@property(nonatomic,assign) int rightScore;
@property(nonatomic,strong)ZCFightTheLandlordModel*fightTheLandlordModel;

////打平进入下一洞的次数
//@property(nonatomic,assign)int isNext;

//判断是否是历史进来执行提示语
@property(nonatomic,assign)BOOL isLiShi;
//判断是否从历史进来是18个都记满的情况下
@property(nonatomic,assign)BOOL open;


//取消按钮
@property(nonatomic,weak)UIButton *cancelBtn;
//确认修改按钮
@property(nonatomic,weak)UIButton *confirmBtn;

//判断是否是修改的成绩，控制修改打平后的累计属性
@property(nonatomic,assign)BOOL isModify;
@end

@implementation ZCDoudizhuGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"斗地主";
   // self.birdBallView.delegate=self;
    
    //返回
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barBtnItemWithNormalImageName:@"fanhui" hightImageName:@"fanhui" action:@selector(dataToModify:) target:self];
    
    UIBarButtonItem *ButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"排名" style:UIBarButtonItemStyleDone target:self action:@selector(clickTherightItem)];
    
    self.navigationItem.rightBarButtonItem = ButtonItem;
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    
    
    UIButton *beforeBtn=[[UIButton alloc] init];
    beforeBtn.backgroundColor=ZCColor(8, 188, 80);
    CGFloat beforeBtnX=0;
    CGFloat beforeBtnY=self.view.frame.size.height-114;
    CGFloat beforeBtnW=SCREEN_WIDTH/2;
    CGFloat beforeBtnH=50;
    beforeBtn.frame=CGRectMake(beforeBtnX, beforeBtnY, beforeBtnW, beforeBtnH);
    [beforeBtn setTitle:@"上一洞" forState:UIControlStateNormal];
    [beforeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [beforeBtn addTarget:self action:@selector(clickTheBeforeBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:beforeBtn];
    self.beforeBtn=beforeBtn;
    
    UIButton *afterBtn=[[UIButton alloc] init];
    afterBtn.backgroundColor=ZCColor(255, 150, 29);
    CGFloat afterBtnX=beforeBtnW;
    CGFloat afterBtnY=self.view.frame.size.height-114;
    CGFloat afterBtnW=beforeBtnW;
    CGFloat afterBtnH=50;
    afterBtn.frame=CGRectMake(afterBtnX, afterBtnY, afterBtnW, afterBtnH);
    [afterBtn setTitle:@"确认成绩" forState:UIControlStateNormal];
    [afterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [afterBtn addTarget:self action:@selector(clickTheStartBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:afterBtn];
    self.afterBtn=afterBtn;

    
    
    
   //从数据库拿到数据
   self.dataArray= [ZCDatabaseTool doudizhuGameData];
    
    
    self.viewArray=[NSMutableArray array];
    
    for (int i=0; i<18; i++) {
        ZCDoudizhuGameView *doudizhuGameView=[[ZCDoudizhuGameView alloc] init];
        doudizhuGameView.number=[NSString stringWithFormat:@"%d",i+1];
        [self.viewArray addObject:doudizhuGameView];
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
        
        [self saveDouTheData];
        //关闭交互
        [self whetherCloseInteraction];
        ZCDoudizhuGameView *doudizhuGameView=self.viewArray[i];
        
        doudizhuGameView.fightTheLandlordModel=self.dataArray[i];
        self.index++;
        
    }
    
    
    if (self.index==18) {
        ZCDoudizhuGameView *doudizhuGameView=self.viewArray[self.index-1];
        
        doudizhuGameView.fightTheLandlordModel=self.dataArray[self.index-1];
        doudizhuGameView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-114);
        self.open=YES;
        [self.view addSubview:doudizhuGameView];
        self.doudizhuGameView=doudizhuGameView;
        [self.afterBtn setTitle:@"下一洞" forState:UIControlStateNormal];
    }else{
    
    ZCDoudizhuGameView *doudizhuGameView=self.viewArray[self.index];
    
    doudizhuGameView.fightTheLandlordModel=self.dataArray[self.index];
    doudizhuGameView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-114);
    
    [self.view addSubview:doudizhuGameView];
   // doudizhuGameView.delegate=self;
    self.doudizhuGameView=doudizhuGameView;
    
    }
    
    
    
    
    //注册观察者
    ZCSingletonTool *tool=[ZCSingletonTool sharedEventUuidTool];
    [tool addObserver:self forKeyPath:@"isModify" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
}


-(void)dealloc
{
    ZCSingletonTool *tool=[ZCSingletonTool sharedEventUuidTool];
    // 移除观察者
    [tool removeObserver:self forKeyPath:@"isModify"];
    
}


//观察者调用方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    
    if (self.open && self.index==18) {
        self.index=17;
    }

    
    ZCFightTheLandlordModel *fightTheLandlordModel=self.dataArray[self.index];
    
    
    if (fightTheLandlordModel.isSave) {
        
        if (self.cancelBtn==nil) {
            UIButton *cancelBtn=[[UIButton alloc] init];
            cancelBtn.backgroundColor=ZCColor(8, 188, 80);
            
            cancelBtn.frame=self.beforeBtn.bounds;
            [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
            [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cancelBtn addTarget:self action:@selector(clickThecancelBtn) forControlEvents:UIControlEventTouchUpInside];
            [self.beforeBtn addSubview:cancelBtn];
            self.cancelBtn=cancelBtn;
            
            
            
            UIButton *confirmBtn=[[UIButton alloc] init];
            confirmBtn.backgroundColor=ZCColor(255, 150, 29);
            
            confirmBtn.frame=self.afterBtn.bounds;
            [confirmBtn setTitle:@"确认修改" forState:UIControlStateNormal];
            [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [confirmBtn addTarget:self action:@selector(clickTheConfirmBtn) forControlEvents:UIControlEventTouchUpInside];
            [self.afterBtn addSubview:confirmBtn];
            self.confirmBtn=confirmBtn;
            
        }
        
        
        
        
    }
    
    

    
}


//点击修改成绩
-(void)clickTheConfirmBtn
{
    self.isLiShi=YES;
    
    ZCFightTheLandlordModel *fightTheLandlordModel=self.dataArray[self.index];
    //拿出二人的成绩
    ZCOfflinePlayer *play1= fightTheLandlordModel.plays[0];
    ZCOfflinePlayer *play2= fightTheLandlordModel.plays[1];
    ZCOfflinePlayer *play3= fightTheLandlordModel.plays[2];
    
    if (self.index==0) {
        play1.score=0;
        play2.score=0;
        play3.score=0;
        
    }else{
        ZCFightTheLandlordModel *upFightTheLandlordModel=self.dataArray[self.index-1];
//        //拿出二人的成绩
//        ZCOfflinePlayer *upPlay1= upFightTheLandlordModel.plays[0];
//        ZCOfflinePlayer *upPlay2= upFightTheLandlordModel.plays[1];
//        ZCOfflinePlayer *upPlay3= upFightTheLandlordModel.plays[2];
        
        
        for (ZCOfflinePlayer *play in upFightTheLandlordModel.plays) {
            if (play1.player_id==play.player_id) {
                play1.score=play.score;
                break;
            }
        }

        for (ZCOfflinePlayer *play in upFightTheLandlordModel.plays) {
            if (play2.player_id==play.player_id) {
                play2.score=play.score;
                break;
            }
        }
        
        
        for (ZCOfflinePlayer *play in upFightTheLandlordModel.plays) {
            if (play3.player_id==play.player_id) {
                play3.score=play.score;
                break;
            }
        }

        
        
    }
    
    //计算分数之前，确定为修改成绩
    self.isModify=YES;
    
    if ([self valueIsNotEmpty]) {
        //计算分数
        [self saveDouTheData];
       
        //计算分数之后，确定为修改成绩
        self.isModify=NO;
        
        
        fightTheLandlordModel.isSavePar=0;
        play1.isSaveStroke=0;
        play2.isSaveStroke=0;
        play3.isSaveStroke=0;
        
        [_cancelBtn removeFromSuperview];
        [_confirmBtn removeFromSuperview];
        
    }else{
        [MBProgressHUD showSuccess:@"请填写标准杆和所有玩家的成绩"];
    }
}




//取消修改
-(void)clickThecancelBtn
{
    ZCFightTheLandlordModel *fightTheLandlordModel=self.dataArray[self.index];
    self.doudizhuGameView.beforeTheChangeModel=fightTheLandlordModel;
    
    
    [_cancelBtn removeFromSuperview];
    [_confirmBtn removeFromSuperview];
}






//上一洞
-(void)clickTheBeforeBtn
{
    // 如果是历史18个洞进来点击上一洞
    if (self.open && self.index==18) {
        self.index=17;
    }
    
    if (self.index==0) {
        [MBProgressHUD showSuccess:@"已经没有了"];
    }else{
    self.index--;
    
    self.isYES=YES;
    [self.afterBtn setTitle:@"下一洞" forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.doudizhuGameView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        [self.doudizhuGameView removeFromSuperview];
        
        ZCDoudizhuGameView *doudizhuGameView=self.viewArray[self.index];
        //doudizhuGameView.fightTheLandlordModel=self.dataArray[self.index-1];
        doudizhuGameView.transform = CGAffineTransformIdentity;
        doudizhuGameView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-114);
        [self.view addSubview:doudizhuGameView];
        self.doudizhuGameView=doudizhuGameView;
        
        
        
    }];
    
    
    }
}


//点击开始
-(void)clickTheStartBtn
{
    
    if (self.index>=17 && [self.dataArray[17] isSave]) {
        
        [MBProgressHUD showSuccess:@"已经是最后一洞了"];
        
    }else{
    
    self.isYES=!self.isYES;
    
    if (self.isYES) {//确认成绩
        //关闭交互
        [self whetherCloseInteraction];
        self.isLiShi=YES;
        if ([self valueIsNotEmpty]) {
            [self.afterBtn setTitle:@"下一洞" forState:UIControlStateNormal];
            
            [self saveDouTheData];
        }else{
            self.isYES=!self.isYES;
            [MBProgressHUD showSuccess:@"请填写标准杆和所有玩家的成绩"];
        }
        
        
    }else{
        
        
        self.index++;
        
        
        
        [UIView animateWithDuration:0.5 animations:^{
            self.doudizhuGameView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        } completion:^(BOOL finished) {
            [self.doudizhuGameView removeFromSuperview];
            
            ZCDoudizhuGameView *doudizhuGameView=self.viewArray[self.index];
            ZCFightTheLandlordModel *FightTheLandlordModel=self.dataArray[self.index];
            if (FightTheLandlordModel.par==0) {
                doudizhuGameView.fightTheLandlordModel=self.dataArray[self.index];
                doudizhuGameView.isNext=FightTheLandlordModel.isNext;
            }
            
            doudizhuGameView.transform = CGAffineTransformIdentity;
            doudizhuGameView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-114);
            [self.view addSubview:doudizhuGameView];
            self.doudizhuGameView=doudizhuGameView;
            
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
    
    
}



//关闭前一洞的交互
-(void)whetherCloseInteraction
{
    
    if (self.index>0) {
        ZCDoudizhuGameView *DoudizhuGameView=self.viewArray[self.index-1];
        DoudizhuGameView.isClick=YES;
    }
    
    
}


//判断是否值为空
-(BOOL)valueIsNotEmpty
{
    ZCFightTheLandlordModel *fightTheLandlordModel=self.dataArray[self.index];
    ZCOfflinePlayer *play1=fightTheLandlordModel.plays[0];
    ZCOfflinePlayer *play2=fightTheLandlordModel.plays[1];
    ZCOfflinePlayer *play3=fightTheLandlordModel.plays[2];
    ZCLog(@"%ld",(long)fightTheLandlordModel.par);
    ZCLog(@"%ld",(long)play1.stroke);
    ZCLog(@"%ld",(long)play2.stroke);
    if ( fightTheLandlordModel.par==0 || play1.stroke==0 || play2.stroke==0 ||play3.stroke==0) {
        return NO;
    }else {
        return  YES;
    }
    
    
}



//保存成绩
-(void)saveDouTheData
{
     ZCDoudizhuGameView *doudizhuGameView=  self.viewArray[self.index];
    
    ZCFightTheLandlordModel *fightTheLandlordModel=self.dataArray[self.index];
    
    
    //拿出比赛设置数据
     ZCSwitchModel *switchModel= [ZCDatabaseTool querySwitchProperties];
    
    //拿出三人的成绩
    ZCOfflinePlayer *play1= fightTheLandlordModel.plays[0];
    ZCOfflinePlayer *play2= fightTheLandlordModel.plays[1];
    ZCOfflinePlayer *play3= fightTheLandlordModel.plays[2];
    
    
   
  
    
//    if (playScore1>playScore2&&playScore1>playScore3&&playScore2>playScore3) {
//        ZCFightTheLandlordModel *fightTheLandlordModel=self.dataArray[self.index+1];
//        [fightTheLandlordModel.plays exchangeObjectAtIndex:0 withObjectAtIndex:1];
////    }
//    ZCFightTheLandlordModel *fightTheLandlordModel1=self.dataArray[self.index+1];
//    [fightTheLandlordModel1.plays exchangeObjectAtIndex:0 withObjectAtIndex:1];
    int first;
    int second;
    int third ;
    
    
    
    //判断打的什么球
    if (play1.stroke-fightTheLandlordModel.par==-1) {
        if (switchModel.birdie_x2==1){
            first=2;
        }else
        {
            first=1;
        }

    }else if (play1.stroke-fightTheLandlordModel.par<-1)
    {
        if (switchModel.eagle_x4==1){
            first=4;
        }else{
            if (play1.stroke-fightTheLandlordModel.par<=-1) {
                if (switchModel.birdie_x2==1) {
                    first=2;
                }else{
                first=1;
                }
                
            }else
            {
            first=1;
            }
            
            
        }

    }else{
    first=1;
    }
    
    //第二个人
    if (play2.stroke-fightTheLandlordModel.par==-1) {
        if (switchModel.birdie_x2==1){
            second=2;
        }else
        {
            second=1;
        }
        
    }else if (play2.stroke-fightTheLandlordModel.par<-1)
    {
        if (switchModel.eagle_x4==1){
            second=4;
        }else{
            if (play2.stroke-fightTheLandlordModel.par<=-1) {
                if (switchModel.birdie_x2==1) {
                    second=2;
                }else{
                second=1;
                }
            }else{
             second=1;
            }
           
        }
        
    }else{
        second=1;
    }

    //第三个人
    
    if (play3.stroke-fightTheLandlordModel.par==-1) {
        if (switchModel.birdie_x2==1){
            third=2;
        }else
        {
            third=1;
        }
        
    }else if (play3.stroke-fightTheLandlordModel.par<-1)
    {
        if (switchModel.eagle_x4==1){
            third=4;
        }else{
            
            if (play3.stroke-fightTheLandlordModel.par<=-1) {
                if (switchModel.birdie_x2==1) {
                    third=2;
                }else{
                third=1;
                }
               
            }else{
                third=1;
            }
            
        }
        
    }else{
        third=1;
    }

    
       
    
    int i=first;
    int j=second;
    int k=third;
   
   
    
    
   
    
    
    
    //地主赢
    if (2*play2.stroke<(play1.stroke+play3.stroke)) {
        
        if (self.index==0) {
            fightTheLandlordModel.isNext=0;
        }else{
        ZCFightTheLandlordModel *beforFightTheLandlordModel=self.dataArray[self.index-1];
        fightTheLandlordModel.isNext=beforFightTheLandlordModel.isNext;
        }
        
        play1.winScore=0-j*(fightTheLandlordModel.isNext+1);
        play2.winScore=j*(fightTheLandlordModel.isNext+1)*2;
        play3.winScore=0-j*(fightTheLandlordModel.isNext+1);
        
        
        play1.score=play1.score-j*(fightTheLandlordModel.isNext+1);
        play2.score=play2.score+j*(fightTheLandlordModel.isNext+1)*2;
        play3.score=play3.score-j*(fightTheLandlordModel.isNext+1);
        
        
        if (fightTheLandlordModel.isNext) {
          
            doudizhuGameView.clues=@"本洞获胜方获得了累计分数";
        }
        fightTheLandlordModel.isNext=0;
        doudizhuGameView.isNext=fightTheLandlordModel.isNext;
        
        if (self.index<17) {
        //位置变化
        [self TheNextHoleLocationChange];
        }
        
        //判断是打了什么球提示语
        if (self.isLiShi) {
            
            [self ToJudgeWhatIsPlayingTheBall:first andSecond:second andThird:third];
        }

        ZCLog(@"%ld,%ld,%ld",(long)play1.stroke,(long)play2.stroke,(long)play3.stroke);
        ZCLog(@"%ld,%ld,%ld",(long)play1.score,(long)play2.score,(long)play3.score);
        
    }else if (2*play2.stroke==(play1.stroke+play3.stroke)){//平局
        
        if (switchModel.drau_to_next==1) {//打开了打球进入下一洞
            
            if (self.isModify) {
                
                
                if (self.index==0) {
                    fightTheLandlordModel.isNext=0;
                }else{
                    ZCFightTheLandlordModel *beforFightTheLandlordModel=self.dataArray[self.index-1];
                    fightTheLandlordModel.isNext=beforFightTheLandlordModel.isNext;
                    fightTheLandlordModel.isNext++;
                }

                
            }else{
            fightTheLandlordModel.isNext++;
            }

            
            doudizhuGameView.clues=@"本洞比分打平,分数累至下一洞";
            play1.winScore=0;
            play2.winScore=0;
            play3.winScore=0;
            play1.score=play1.score;
            play2.score=play2.score;
            play3.score=play3.score;
            
            
        }else{
        
            play1.winScore=0;
            play2.winScore=0;
            play3.winScore=0;
            play1.score=play1.score;
            play2.score=play2.score;
            play3.score=play3.score;

        }
        
        if (self.index<17){
            [self drawTheNextHoleLocationChange];
        }
        
    }else{
    
        if (self.index==0) {
            fightTheLandlordModel.isNext=0;
        }else{
            ZCFightTheLandlordModel *beforFightTheLandlordModel=self.dataArray[self.index-1];
            fightTheLandlordModel.isNext=beforFightTheLandlordModel.isNext;
        }

        
        if (i<k) {
            play1.winScore=k*(fightTheLandlordModel.isNext+1);
            play2.winScore=0-k*(fightTheLandlordModel.isNext+1)*2;
            play3.winScore=k*(fightTheLandlordModel.isNext+1);
            
            ZCLog(@"%ld,%ld,%ld",(long)play1.stroke,(long)play2.stroke,(long)play3.stroke);
            ZCLog(@"%ld,%ld,%ld",(long)play1.score,(long)play2.score,(long)play3.score);
            
            play1.score=play1.score+k*(fightTheLandlordModel.isNext+1);
            play2.score=play2.score-k*(fightTheLandlordModel.isNext+1)*2;
            play3.score=play3.score+k*(fightTheLandlordModel.isNext+1);
            
            ZCLog(@"%ld,%ld,%ld",(long)play1.stroke,(long)play2.stroke,(long)play3.stroke);
            ZCLog(@"%ld,%ld,%ld",(long)play1.score,(long)play2.score,(long)play3.score);
        }else
        {
            play1.winScore=i*(fightTheLandlordModel.isNext+1);
            play2.winScore=0-i*(fightTheLandlordModel.isNext+1)*2;
            play3.winScore=i*(fightTheLandlordModel.isNext+1);
            
            ZCLog(@"%ld,%ld,%ld",(long)play1.stroke,(long)play2.stroke,(long)play3.stroke);
            ZCLog(@"%ld,%ld,%ld",(long)play1.score,(long)play2.score,(long)play3.score);
            
            play1.score=play1.score+i*(fightTheLandlordModel.isNext+1);
            play2.score=play2.score-i*(fightTheLandlordModel.isNext+1)*2;
            play3.score=play3.score+i*(fightTheLandlordModel.isNext+1);
        }
        
        if (fightTheLandlordModel.isNext) {
           
            doudizhuGameView.clues=@"本洞获胜方获得了累计分数";
        }
        fightTheLandlordModel.isNext=0;
        doudizhuGameView.isNext=fightTheLandlordModel.isNext;
        
        if (self.index<17) {
        //位置变化
        [self TheNextHoleLocationChange];
        }
        
        
        //判断是打了什么球提示语
        if (self.isLiShi) {
            
            [self ToJudgeWhatIsPlayingTheBall:first andSecond:second andThird:third];
        }
        
        
        ZCLog(@"%ld,%ld,%ld",(long)play1.stroke,(long)play2.stroke,(long)play3.stroke);
         ZCLog(@"%ld,%ld,%ld",(long)play1.score,(long)play2.score,(long)play3.score);

    }
    
    
    
    
    BOOL success=[ZCDatabaseTool saveTheFightTheLandlord:fightTheLandlordModel andHoleNumber:self.index];
    if (success) {
        fightTheLandlordModel.isSave=YES;
        self.doudizhuGameView.fightTheLandlordModel=fightTheLandlordModel;
        
    }
   

   


    
}

//判断打出的球提示语
-(void)ToJudgeWhatIsPlayingTheBall:(int)first andSecond:(int)second andThird:(int)third
{
    
    ZCLog(@"%d,%d,%d",first,second,third);
    
    
   ZCFightTheLandlordModel *fightTheLandlordModel=self.dataArray[self.index];
    
    //拿出三人的成绩
    ZCOfflinePlayer *play1= fightTheLandlordModel.plays[0];
    ZCOfflinePlayer *play2= fightTheLandlordModel.plays[1];
    ZCOfflinePlayer *play3= fightTheLandlordModel.plays[2];

    
    if (2*play2.stroke<(play1.stroke+play3.stroke)) {//地主赢
        
//        if (first>=third) {
//            index=first;
//        }else{
//            index=third;
//        }
        
        [self ToJudgeWhetherAMultipleGoalsAndWin:@"地主" andTimes:second andLost:nil andLostTimes:0];
    }else{//地主输
        if (play1.stroke<play3.stroke) {
            [self ToJudgeWhetherAMultipleGoalsAndWin:@"平民" andTimes:first andLost:@"地主" andLostTimes:second];
        }else{
            [self ToJudgeWhetherAMultipleGoalsAndWin:@"平民" andTimes:third andLost:@"地主" andLostTimes:second];
        }
        
    }

    
}



//打平进入下一洞位置变化
-(void)drawTheNextHoleLocationChange
{
    ZCFightTheLandlordModel *fightTheLandlordModel=self.dataArray[self.index];
    
    //拿出三人的成绩
    ZCOfflinePlayer *play1= fightTheLandlordModel.plays[0];
    ZCOfflinePlayer *play2= fightTheLandlordModel.plays[1];
    ZCOfflinePlayer *play3= fightTheLandlordModel.plays[2];

    //给下一洞头像移动位置
    ZCFightTheLandlordModel *fightTheLandlordModelNext=self.dataArray[self.index+1];
    fightTheLandlordModelNext.isNext=fightTheLandlordModel.isNext;
    
    NSMutableArray *teamArray=[NSMutableArray array];
    for (ZCOfflinePlayer *play in fightTheLandlordModelNext.plays) {
        if (play.player_id==play1.player_id) {
            play.score=play1.score;
            [teamArray addObject:play];
            break;
        }
    }
    
    for (ZCOfflinePlayer *play in fightTheLandlordModelNext.plays) {
        if (play.player_id==play2.player_id) {
            play.score=play2.score;
            [teamArray addObject:play];
            break;
        }
    }
    
    for (ZCOfflinePlayer *play in fightTheLandlordModelNext.plays) {
        if (play.player_id==play3.player_id) {
            play.score=play3.score;
            [teamArray addObject:play];
            break;
        }
    }
    
    
    fightTheLandlordModelNext.plays=teamArray;
    

    
    
}


//非平局下的 下一洞位置变化
-(void)TheNextHoleLocationChange
{
    ZCFightTheLandlordModel *fightTheLandlordModel=self.dataArray[self.index];
    //拿出三人的成绩
    ZCOfflinePlayer *play1= fightTheLandlordModel.plays[0];
    ZCOfflinePlayer *play2= fightTheLandlordModel.plays[1];
    ZCOfflinePlayer *play3= fightTheLandlordModel.plays[2];
    
    CGFloat playScore1=(CGFloat)play1.stroke+0.2;
    CGFloat playScore2=(CGFloat)play2.stroke+0.1;
    CGFloat playScore3=(CGFloat)play3.stroke+0.3;
    
    
    //给下一洞头像移动位置
    ZCFightTheLandlordModel *fightTheLandlordModelNext=self.dataArray[self.index+1];
    fightTheLandlordModelNext.isNext=fightTheLandlordModel.isNext;
    if (playScore1<playScore2&&playScore1<playScore3&&playScore2<playScore3) {
        
        NSMutableArray *teamArray=[NSMutableArray array];
        for (ZCOfflinePlayer *play in fightTheLandlordModelNext.plays) {
            if (play.player_id==play2.player_id) {
                play.score=play2.score;
                [teamArray addObject:play];
                break;
            }
        }
        
        for (ZCOfflinePlayer *play in fightTheLandlordModelNext.plays) {
            if (play.player_id==play1.player_id) {
                play.score=play1.score;
                [teamArray addObject:play];
                break;
            }
        }
        
        for (ZCOfflinePlayer *play in fightTheLandlordModelNext.plays) {
            if (play.player_id==play3.player_id) {
                play.score=play3.score;
                [teamArray addObject:play];
                break;
            }
        }
        
        
        fightTheLandlordModelNext.plays=teamArray;
        
    }else if (playScore1<playScore2&&playScore1<playScore3&&playScore2>playScore3)
    {
        
        NSMutableArray *teamArray=[NSMutableArray array];
        for (ZCOfflinePlayer *play in fightTheLandlordModelNext.plays) {
            if (play.player_id==play3.player_id) {
                play.score=play3.score;
                [teamArray addObject:play];
                break;
            }
        }
        
        for (ZCOfflinePlayer *play in fightTheLandlordModelNext.plays) {
            if (play.player_id==play1.player_id) {
                play.score=play1.score;
                [teamArray addObject:play];
                break;
            }
        }
        
        for (ZCOfflinePlayer *play in fightTheLandlordModelNext.plays) {
            if (play.player_id==play2.player_id) {
                play.score=play2.score;
                [teamArray addObject:play];
                break;
            }
        }
        
        
        fightTheLandlordModelNext.plays=teamArray;
        
        
        
    }else if (playScore2<playScore1&&playScore2<playScore3&&playScore1<playScore3)
    {
        
        NSMutableArray *teamArray=[NSMutableArray array];
        for (ZCOfflinePlayer *play in fightTheLandlordModelNext.plays) {
            if (play.player_id==play1.player_id) {
                play.score=play1.score;
                [teamArray addObject:play];
                break;
            }
        }
        
        for (ZCOfflinePlayer *play in fightTheLandlordModelNext.plays) {
            if (play.player_id==play2.player_id) {
                play.score=play2.score;
                [teamArray addObject:play];
                break;
            }
        }
        
        for (ZCOfflinePlayer *play in fightTheLandlordModelNext.plays) {
            if (play.player_id==play3.player_id) {
                play.score=play3.score;
                [teamArray addObject:play];
                break;
            }
        }
        
        
        fightTheLandlordModelNext.plays=teamArray;
        
        
        
    }else if (playScore2<playScore1&&playScore2<playScore3&&playScore1>playScore3)
    {
        NSMutableArray *teamArray=[NSMutableArray array];
        for (ZCOfflinePlayer *play in fightTheLandlordModelNext.plays) {
            if (play.player_id==play3.player_id) {
                play.score=play3.score;
                [teamArray addObject:play];
                break;
            }
        }
        
        for (ZCOfflinePlayer *play in fightTheLandlordModelNext.plays) {
            if (play.player_id==play2.player_id) {
                play.score=play2.score;
                [teamArray addObject:play];
                break;
            }
        }
        
        for (ZCOfflinePlayer *play in fightTheLandlordModelNext.plays) {
            if (play.player_id==play1.player_id) {
                play.score=play1.score;
                [teamArray addObject:play];
                break;
            }
        }
        
        
        fightTheLandlordModelNext.plays=teamArray;
        
        
        
    }else if (playScore3<playScore2&&playScore3<playScore1&&playScore2>playScore1)
    {
        
        NSMutableArray *teamArray=[NSMutableArray array];
        for (ZCOfflinePlayer *play in fightTheLandlordModelNext.plays) {
            if (play.player_id==play1.player_id) {
                play.score=play1.score;
                [teamArray addObject:play];
                break;
            }
        }
        
        for (ZCOfflinePlayer *play in fightTheLandlordModelNext.plays) {
            if (play.player_id==play3.player_id) {
                play.score=play3.score;
                [teamArray addObject:play];
                break;
            }
        }
        
        for (ZCOfflinePlayer *play in fightTheLandlordModelNext.plays) {
            if (play.player_id==play2.player_id) {
                play.score=play2.score;
                [teamArray addObject:play];
                break;
            }
        }
        
        
        fightTheLandlordModelNext.plays=teamArray;
        
        
        
        
    }else if (playScore3<playScore2&&playScore3<playScore1&&playScore1>playScore2)
    {
        NSMutableArray *teamArray=[NSMutableArray array];
        for (ZCOfflinePlayer *play in fightTheLandlordModelNext.plays) {
            if (play.player_id==play2.player_id) {
                play.score=play2.score;
                [teamArray addObject:play];
                break;
            }
        }
        
        for (ZCOfflinePlayer *play in fightTheLandlordModelNext.plays) {
            if (play.player_id==play3.player_id) {
                play.score=play3.score;
                [teamArray addObject:play];
                break;
            }
        }
        
        for (ZCOfflinePlayer *play in fightTheLandlordModelNext.plays) {
            if (play.player_id==play1.player_id) {
                play.score=play1.score;
                [teamArray addObject:play];
                break;
            }
        }
        
        
        fightTheLandlordModelNext.plays=teamArray;
        
        
    }


    
    ZCLog(@"%@,%@,%@",[fightTheLandlordModel.plays[0] nickname],[fightTheLandlordModel.plays[1] nickname],[fightTheLandlordModel.plays[2] nickname]);
    
    ZCLog(@"%@,%@,%@",[fightTheLandlordModelNext.plays[0] nickname],[fightTheLandlordModelNext.plays[1] nickname],[fightTheLandlordModelNext.plays[2] nickname]);
    
    
}


-(void)doudizhuGameViewDelegateForScore:(ZCFightTheLandlordModel *)fightTheLandlordModel andForHoleNumber:(int)number
{
//    ZCFightTheLandlordModel *FightTheLandlordModel=self.dataArray[number];
//    ZCLog(@"%d",FightTheLandlordModel.par);
//
//    [self.dataArray replaceObjectAtIndex:number withObject:fightTheLandlordModel];
//    ZCFightTheLandlordModel *FightTheLandlordModel1=self.dataArray[number];
//    ZCLog(@"%d",FightTheLandlordModel1.par);
    
}


//判断是什么球提示用户
-(void)ToJudgeWhetherAMultipleGoalsAndWin:(NSString *)playerName andTimes:(int)few andLost:(NSString *) otherPlayerName andLostTimes:(int)otherFew
{
    ZCLog(@"%d",otherFew);
    
    UIWindow *wd = [[[UIApplication sharedApplication] windows] lastObject];
    
    if (few==2 || few==4) {//小鸟
       // ZCBirdBallView *birdBallView=[[ZCBirdBallView alloc] init];
        
        self.birdBallView.frame=[UIScreen mainScreen].bounds;
        [self.birdBallView setName:playerName andIndex:few];
        self.birdBallView.douDoulePar=otherFew;
        self.birdBallView.name=otherPlayerName;
        [wd addSubview:self.birdBallView];
    }   else{
        if (otherFew==2) {
            ZCBirdBallView *birdBallView=[[ZCBirdBallView alloc] init];
            birdBallView.frame=[UIScreen mainScreen].bounds;
           [self.birdBallView setName:otherPlayerName andIndex:otherFew];
            [wd addSubview:birdBallView];
            
            
        }
    
        
}

    
    
    
}


//-(void)ZCBirdBallViewWhetherPopUpNextWithDouDiZhu:(NSString *)playerName andIndexDoulePar:(int)doulePar{
//
//    UIWindow *wd = [[[UIApplication sharedApplication] windows] lastObject];
//    self.birdBallView.frame=[UIScreen mainScreen].bounds;
//    [self.birdBallView setName:playerName andIndex:doulePar];
//    
//    [wd addSubview:self.birdBallView];
//
//}
//

//点击排名
-(void)clickTherightItem
{
    ZCEntertainmentRankingTableViewController *vc=[[ZCEntertainmentRankingTableViewController alloc] init];
    ZCFightTheLandlordModel *FightTheLandlordModel=self.dataArray[self.index];
    vc.dataArray=FightTheLandlordModel.plays;
    [self.navigationController pushViewController:vc animated:YES];

}



//点击返回按钮
-(void)dataToModify:(UIButton *)bth
{
    // 弹框
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定要返回吗？" message:@"返回后您可以通过历史重新进入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    // 设置对话框的类型
    alert.alertViewStyle = UIKeyboardTypeNumberPad;
    
    [alert show];
    
    
}




#pragma mark - alertView的代理方法
/**
 *  点击了alertView上面的按钮就会调用这个方法
 *
 *  @param buttonIndex 按钮的索引,从0开始
 */

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    // 按钮的索引肯定不是0
    
}


-(ZCBirdBallView *)birdBallView
{
    if (_birdBallView==nil) {
        _birdBallView=[[ZCBirdBallView alloc] init];
        _birdBallView.delegate=self;
    }
    return _birdBallView;
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
