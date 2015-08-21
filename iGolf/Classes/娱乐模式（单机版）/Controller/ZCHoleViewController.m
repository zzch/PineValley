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
#import "ZCBirdBallView.h"
#import "ZCSingletonTool.h"
@interface ZCHoleViewController ()<ZCHoleScoringViewDelegate,ZCBirdBallViewDelegate>
@property(nonatomic,strong)NSMutableArray *viewArray;

@property(nonatomic,assign)int index;
@property(nonatomic,strong)ZCHoleScoringView *holeScoringView;
@property(nonatomic,weak)UIButton *afterBtn;
@property(nonatomic,weak)UIButton *beforeBtn;
@property(nonatomic,assign)BOOL isYES;
@property(nonatomic,strong)ZCHoleModel *holeModel;
//自己的总成绩
@property(nonatomic,assign)int userScore;
//其他的总成绩
@property(nonatomic,assign)int otherScore;
//是否打平进入下一洞
@property(nonatomic,assign)int isNext;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)ZCBirdBallView *birdBallView;
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
////记录当前洞是累计了多少平局过来的
//@property(nonatomic,assign)int last_isNext;
////记录当前洞是多少洞累计了多少平局过来的
//@property(nonatomic,assign)int last_holeIndex;


@end

@implementation ZCHoleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"比洞赛";
    
    //返回
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barBtnItemWithNormalImageName:@"fanhui" hightImageName:@"fanhui" action:@selector(dataToModify:) target:self];
    
    self.view.backgroundColor=[UIColor whiteColor];
    UIBarButtonItem *ButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"排名" style:UIBarButtonItemStyleDone target:self action:@selector(clickTherightItem)];
    
    self.navigationItem.rightBarButtonItem = ButtonItem;
    
    
    
    
    
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
    
    // ZCLog(@"%ld",self.dataArray[0] pa);
    self.viewArray=[NSMutableArray array];
    
    for (int i=0; i<18; i++) {
        ZCHoleScoringView *holeScoringView=[[ZCHoleScoringView alloc] init];
        holeScoringView.delegate=self;
        holeScoringView.number=[NSString stringWithFormat:@"%d",i+1];
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
        //关闭交互
        [self whetherCloseInteraction];
        
        ZCHoleScoringView *holeScoringView=self.viewArray[i];
        
        holeScoringView.fightTheLandlordModel=self.dataArray[i];
        self.index++;
        ZCLog(@"%d",self.index);
        ZCLog(@"%d",historyCount);
        
    }
    
    if (self.index==18) {
        ZCHoleScoringView *holeScoringView=self.viewArray[self.index-1];
        self.open=YES;
        
        holeScoringView.fightTheLandlordModel=self.dataArray[self.index-1];
        holeScoringView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-114);
        
        [self.view addSubview:holeScoringView];
        self.holeScoringView=holeScoringView;
        
        
        [self.afterBtn setTitle:@"下一洞" forState:UIControlStateNormal];
    }else{
    
    
    ZCLog(@"%d",self.index);
    
    ZCHoleScoringView *holeScoringView=self.viewArray[self.index];
    
    holeScoringView.fightTheLandlordModel=self.dataArray[self.index];
    holeScoringView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-114);
    
    [self.view addSubview:holeScoringView];
    self.holeScoringView=holeScoringView;
    
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
    ZCLog(@"---------------------%d",self.index);
    
//    self.isYES=NO;
//    [self.afterBtn setTitle:@"确认成绩" forState:UIControlStateNormal];
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
    
   
   // self.afterBtn=confirmBtn;

    
    
    
}


//点击修改成绩
-(void)clickTheConfirmBtn
{
    self.isLiShi=YES;

    ZCFightTheLandlordModel *fightTheLandlordModel=self.dataArray[self.index];
    //拿出二人的成绩
    ZCOfflinePlayer *play1= fightTheLandlordModel.plays[0];
    ZCOfflinePlayer *play2= fightTheLandlordModel.plays[1];
    
    if (self.index==0) {
        play1.score=0;
        play2.score=0;
        
    }else{
        ZCFightTheLandlordModel *upFightTheLandlordModel=self.dataArray[self.index-1];
        //拿出二人的成绩
        ZCOfflinePlayer *upPlay1= upFightTheLandlordModel.plays[0];
        ZCOfflinePlayer *upPlay2= upFightTheLandlordModel.plays[1];
    
        play1.score=upPlay1.score;
        play2.score=upPlay2.score;
        
    }
    
    
    //计算分数之前，确定为修改成绩
    self.isModify=YES;
    
    if ([self valueIsNotEmpty]) {
    
    [self saveTheData];
    
        //计算分数之后，确定为不是修改成绩
        self.isModify=NO;
    
    fightTheLandlordModel.isSavePar=0;
    play1.isSaveStroke=0;
    play2.isSaveStroke=0;
    
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
    self.holeScoringView.beforeTheChangeModel=fightTheLandlordModel;

    
    [_cancelBtn removeFromSuperview];
    [_confirmBtn removeFromSuperview];
}





//上一洞
-(void)clickTheBeforeBtn
{
    if (self.open && self.index==18) {
        self.index=17;
    }

    if (self.index==0) {
        [MBProgressHUD showSuccess:@"已经没有了"];
    }else{
    self.index--;
    self.isYES=YES;
        ZCLog(@"%d",self.index);
    [self.afterBtn setTitle:@"下一洞" forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.holeScoringView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        [self.holeScoringView removeFromSuperview];
        
        ZCHoleScoringView *holeScoringView=self.viewArray[self.index];
        holeScoringView.transform = CGAffineTransformIdentity;
        holeScoringView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-114);
        [self.view addSubview:holeScoringView];
        self.holeScoringView=holeScoringView;
        
     
        
    }];

    }
    
}


//点击开始
-(void)clickTheStartBtn
{
    
    if (self.index>=17 && [self.dataArray[17] isSave]) {
        
            [MBProgressHUD showSuccess:@"已经是最后一洞了"];
 
    }else{
    
    
  
   
   if (self.index<18) {
    
    
       

      self.isYES=!self.isYES;
    
    
    if (self.isYES) {//确认成绩
        
        self.isLiShi=YES;
        if ([self valueIsNotEmpty]) {
            
            [self.afterBtn setTitle:@"下一洞" forState:UIControlStateNormal];
            //关闭交互
            [self whetherCloseInteraction];
           
            [self saveTheData];
            
            
        }else{
            self.isYES=!self.isYES;
            [MBProgressHUD showSuccess:@"请填写标准杆和所有玩家的成绩"];

        }
        
        
        
    }else{
        
       
        self.index++;
        
        ZCLog(@"%d",self.index);
           
        
        if (self.index<=17) {
            

           
            
    [UIView animateWithDuration:0.5 animations:^{
          self.holeScoringView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        [self.holeScoringView removeFromSuperview];
        
        ZCHoleScoringView *holeScoringView=self.viewArray[self.index];
        ZCFightTheLandlordModel *FightTheLandlordModel=self.dataArray[self.index];
        if (FightTheLandlordModel.isSave==NO) {
            holeScoringView.fightTheLandlordModel=self.dataArray[self.index];
            holeScoringView.isNext=FightTheLandlordModel.isNext;
        }


        holeScoringView.transform = CGAffineTransformIdentity;
        holeScoringView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-120);
        [self.view addSubview:holeScoringView];
        self.holeScoringView=holeScoringView;
        
    }];
        
       
            
        
           
        ZCLog(@"%d",self.index);
       
        ZCFightTheLandlordModel *FightTheLandlordModel=self.dataArray[self.index];
        if (FightTheLandlordModel.isSave==NO) {
            self.isYES=NO;
            [self.afterBtn setTitle:@"确认比赛" forState:UIControlStateNormal];
        }else{
            self.isYES=YES;
            [self.afterBtn setTitle:@"下一洞" forState:UIControlStateNormal];
        }

        }
       
  
        
    }
   }
       
   }
}

//关闭前一洞的交互
-(void)whetherCloseInteraction
{

    if (self.index>0) {
        ZCHoleScoringView *HoleScoringView=self.viewArray[self.index-1];
        HoleScoringView.isClick=YES;
    }
    
    
}



//判断是否值为空
-(BOOL)valueIsNotEmpty
{
    ZCFightTheLandlordModel *fightTheLandlordModel=self.dataArray[self.index];
    ZCOfflinePlayer *play1=fightTheLandlordModel.plays[0];
    ZCOfflinePlayer *play2=fightTheLandlordModel.plays[1];
    ZCLog(@"%ld",(long)fightTheLandlordModel.par);
    ZCLog(@"%ld",(long)play1.stroke);
    ZCLog(@"%ld",(long)play2.stroke);
    if ( fightTheLandlordModel.par==0 || play1.stroke==0 || play2.stroke==0 ) {
        return NO;
    }else {
    return  YES;
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
    
    
    
    int who=1 ;
    int otherWho=1  ;
    int  doublePar1 = 0;
    int  doublePar2 = 0;
  ZCSwitchModel *switchModel= [ZCDatabaseTool querySwitchProperties];
    //计算分数
    
    if (play1.stroke-fightTheLandlordModel.par<-1)
    {
        if (switchModel.eagle_x4==1){
            who=4;
        }else{
            if (play1.stroke-fightTheLandlordModel.par<=-1) {
                if (switchModel.birdie_x2==1) {
                    who=2;
                }else{
                who=1;
                }
            }else{
            who=1;
            }
        }
    }else if (play1.stroke-fightTheLandlordModel.par==-1) {
        if (switchModel.birdie_x2==1){
            who=2;
        }else
            {
                 who=1;
            }
       
        
    }else if (play1.stroke>=2*fightTheLandlordModel.par)
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
    
   
    
    if (play2.stroke-fightTheLandlordModel.par<-1)
    {
        if (switchModel.eagle_x4==1) {
           otherWho=4;
        }else{
            if (play2.stroke-fightTheLandlordModel.par<=-1){
                if (switchModel.birdie_x2==1) {
                    otherWho=2;
                }else{
                otherWho=1;
                }
            
            }else{
                otherWho=1;
            }
        
        }
        
    }else  if (play2.stroke-fightTheLandlordModel.par==-1) {
        if (switchModel.birdie_x2==1) {
            otherWho=2;
        }else{
        otherWho=1;
        }
        
    }else if (play2.stroke-fightTheLandlordModel.par>=fightTheLandlordModel.par)
    {
        if (switchModel.double_par_x2==1) {
           doublePar2=2;
        }else{
        doublePar2=1;
        }
        
    }else{
        doublePar2=1;
    }

    
    
    
    
    //判断谁赢
    if (play1.stroke<play2.stroke) {
        //本机机主赢
        
        
        if (self.index==0) {
            fightTheLandlordModel.isNext=0;
        }else{
            ZCFightTheLandlordModel *beforFightTheLandlordModel=self.dataArray[self.index-1];
            fightTheLandlordModel.isNext=beforFightTheLandlordModel.isNext;
        }

        
    

    
    
        if (doublePar2==2) {
            play1.score= play1.score+ who*(fightTheLandlordModel.isNext+1)*2;
            play2.score=play2.score-who*(fightTheLandlordModel.isNext+1)*2;
            
            play1.winScore=who*(fightTheLandlordModel.isNext+1)*2;
            play2.winScore=0-who*(fightTheLandlordModel.isNext+1)*2;
            


        }else
        {
            play1.winScore=who*(fightTheLandlordModel.isNext+1);
            play2.winScore=0-who*(fightTheLandlordModel.isNext+1);
            play1.score= play1.score+ who*(fightTheLandlordModel.isNext+1);
            play2.score=play2.score-who*(fightTheLandlordModel.isNext+1);
            
        }
        ZCLog(@"%d",self.isNext);
        if (fightTheLandlordModel.isNext) {
            holeScoringView.clues=@"本洞获胜方获得了累计分数";
                   }
//        if (self.isModify==NO) {
//           self.isNext=0;
//        }
        
        fightTheLandlordModel.isNext=0;
        holeScoringView.isNext=fightTheLandlordModel.isNext;
        
        //点击确定时执行 历史进来的不执行
        if (self.isLiShi) {
            //判断是打了什么球
            [self ToJudgeWhatIsPlayingTheBall:who andOther:otherWho anddoublePar1:doublePar1 anddoublePar2:doublePar2];
        }

        
    }else if (play1.stroke-play2.stroke==0)
    {//打平
        
        
        
        if (switchModel.drau_to_next==1) {
            
            if (self.isModify) {
                ZCLog(@"%d",fightTheLandlordModel.isNext);
                

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
        
          
            
            holeScoringView.clues=@"本洞比分打平,分数累至下一洞";
            play1.winScore=0;
            play2.winScore=0;
            play1.score=play1.score;
            play2.score=play2.score;
            
        }else{
            
            if (switchModel.drau_to_win==1) {
                play1.winScore=1;
                play2.winScore=0-1;
                play1.score=play1.score+1;
                play2.score=play2.score-1;
            }else{
            play1.winScore=0-1;
            play2.winScore=1;
            play1.score=play1.score-1;
            play2.score=play2.score+1;
            ;
            }
        }
        
    
    }else
    {
        if (self.index==0) {
            fightTheLandlordModel.isNext=0;
        }else{
            ZCFightTheLandlordModel *beforFightTheLandlordModel=self.dataArray[self.index-1];
            fightTheLandlordModel.isNext=beforFightTheLandlordModel.isNext;
        }

        
    
        //本机机主输
        if (doublePar1==2) {
            play1.score= play1.score- otherWho*(fightTheLandlordModel.isNext+1)*2;
            play2.score=play2.score+otherWho*(fightTheLandlordModel.isNext+1)*2;
            play1.winScore=0-otherWho*(fightTheLandlordModel.isNext+1)*2;
            play2.winScore=otherWho*(fightTheLandlordModel.isNext+1)*2;
            
        }else
        {
            play1.score= play1.score- otherWho*(fightTheLandlordModel.isNext+1);
            play2.score=play2.score+otherWho*(fightTheLandlordModel.isNext+1);
            play1.winScore=0-otherWho*(fightTheLandlordModel.isNext+1);
            play2.winScore=otherWho*(fightTheLandlordModel.isNext+1);
        }

        if (fightTheLandlordModel.isNext) {
            holeScoringView.clues=@"本洞获胜方获得了累计分数";
           
        }
        fightTheLandlordModel.isNext=0;
//        if (self.isModify==NO) {
//            self.isNext=0;
//        }
        holeScoringView.isNext=fightTheLandlordModel.isNext;
        
        //点击确定时执行 历史进来的不执行
        if (self.isLiShi) {
            //判断是打了什么球
            [self ToJudgeWhatIsPlayingTheBall:who andOther:otherWho anddoublePar1:doublePar1 anddoublePar2:doublePar2];
        }

        
    }
    
    
    
    
   //保存数据库
  BOOL success=  [ZCDatabaseTool saveEveryHole:fightTheLandlordModel andHoleNumber:self.index];
    if (success) {
        fightTheLandlordModel.isSave=YES;
        self.holeScoringView.fightTheLandlordModel=fightTheLandlordModel;
        
        if (self.index<17) {
            ZCFightTheLandlordModel *fightTheLandlordModelNext=self.dataArray[self.index+1];
            ZCOfflinePlayer *play3= fightTheLandlordModelNext.plays[0];
            ZCOfflinePlayer *play4= fightTheLandlordModelNext.plays[1];
            
            play3.score=play1.score;
            play4.score=play2.score;
            fightTheLandlordModelNext.isNext=fightTheLandlordModel.isNext;

        }
      

        ZCLog(@"成功");
    }else
    {
    ZCLog(@"失败");
    }
    
}

//判断是什么球提示用户
-(void)ToJudgeWhetherAMultipleGoalsAndWin:(ZCOfflinePlayer *)player andTimes:(int)few andLost:(ZCOfflinePlayer *) otherPlayer andLostTimes:(int)otherFew
{
    self.isLiShi=NO;
    
    UIWindow *wd = [[[UIApplication sharedApplication] windows] lastObject];
    
    if (few==2) {//小鸟
       // ZCBirdBallView *birdBallView=[[ZCBirdBallView alloc] init];
      
        self.birdBallView.frame=[UIScreen mainScreen].bounds;
        self.birdBallView.player=player;
        self.birdBallView.index=2;
        self.birdBallView.doulePar=otherFew;
        self.birdBallView.otherPlayer=otherPlayer;
        [wd addSubview:self.birdBallView];
    }else if (few==4){//老鹰
       // ZCBirdBallView *birdBallView=[[ZCBirdBallView alloc] init];
        self.birdBallView.delegate=self;
        self.birdBallView.frame=[UIScreen mainScreen].bounds;
        self.birdBallView.player=player;
        self.birdBallView.index=4;
        self.birdBallView.doulePar=otherFew;
        self.birdBallView.otherPlayer=otherPlayer;
        [wd addSubview:self.birdBallView];
    }else{
        if (otherFew==2) {
           // ZCBirdBallView *birdBallView=[[ZCBirdBallView alloc] init];
            self.birdBallView.frame=[UIScreen mainScreen].bounds;
            self.birdBallView.player=otherPlayer;
            self.birdBallView.index=1;
            [wd addSubview:self.birdBallView];
            
            
        }

    
    }
    
    
    

}



//判断打什么球提示语
-(void)ToJudgeWhatIsPlayingTheBall:(int)who andOther:(int)otherWho anddoublePar1:(int)doublePar1 anddoublePar2:(int)doublePar2
{
    
    ZCFightTheLandlordModel *fightTheLandlordModel=self.dataArray[self.index];
    
    ZCLog(@"%d",fightTheLandlordModel.par);
    //拿出二人的成绩
    ZCOfflinePlayer *play1= fightTheLandlordModel.plays[0];
    ZCOfflinePlayer *play2= fightTheLandlordModel.plays[1];
    //判断是打了什么球
    if (play1.stroke<play2.stroke) {
        [self ToJudgeWhetherAMultipleGoalsAndWin:play1 andTimes:who andLost:play2 andLostTimes:doublePar2 ];
    }else
    {
        [self ToJudgeWhetherAMultipleGoalsAndWin:play2 andTimes:otherWho andLost:play1 andLostTimes:doublePar1 ];
    }
    

}




-(void)ZCBirdBallViewWhetherPopUpNext:(ZCOfflinePlayer *)player andIndexDoulePar:(int)doulePar{
    
    UIWindow *wd = [[[UIApplication sharedApplication] windows] lastObject];
        if (doulePar==2) {
           // ZCBirdBallView *birdBallView=[[ZCBirdBallView alloc] init];
            self.birdBallView.frame=[UIScreen mainScreen].bounds;
            self.birdBallView.player=player;
            self.birdBallView.index=1;
            [wd addSubview:self.birdBallView];
    
            
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



-(ZCBirdBallView *)birdBallView{
    if (_birdBallView==nil) {
        _birdBallView=[[ZCBirdBallView alloc] init];
        _birdBallView.delegate=self;
    }
    return _birdBallView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
