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
#import "ZCOfflinePlayer.h"
#import "ZCFightTheLandlordModel.h"
#import "ZCSwitchModel.h"
#import "ZCEntertainmentRankingTableViewController.h"
#import "ZCBirdBallView.h"
#import "ZCSingletonTool.h"
@interface ZCLasVegasViewController ()<ZCBirdBallViewDelegate>
@property(nonatomic,weak)ZCLasVegasGameView *lasVegasGameView;
@property(nonatomic,strong)NSMutableArray *viewArray;
@property(nonatomic,assign)int index;
@property(nonatomic,weak)UIButton *afterBtn;
@property(nonatomic,weak)UIButton *beforeBtn;
@property(nonatomic,assign)BOOL isYES;
@property(nonatomic,strong)ZCSwitchModel *switchModel;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)ZCBirdBallView *birdBallView;
//判断是否是历史进来执行提示语
@property(nonatomic,assign)BOOL isLiShi;
//判断是否从历史进来是18个都记满的情况下
@property(nonatomic,assign)BOOL open;

//取消按钮
@property(nonatomic,weak)UIButton *cancelBtn;
//确认修改按钮
@property(nonatomic,weak)UIButton *confirmBtn;

@end

@implementation ZCLasVegasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"拉斯维加斯";
    
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
        ZCLasVegasGameView *lasVegasGameView=[[ZCLasVegasGameView alloc] init];
        lasVegasGameView.number=[NSString stringWithFormat:@"%d",i+1];
        [self.viewArray addObject:lasVegasGameView];
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
    
    
    
    for (int i=0; i<historyCount; i++) {
        
        [self savelasVegasGameTheData];
        //关闭交互
        [self whetherCloseInteraction];
        ZCLasVegasGameView *lasVegasGameView=self.viewArray[i];
        
        lasVegasGameView.lasVegasModel=self.dataArray[i];
        self.index++;
        
    }
    
    
    
    if (self.index==18) {
        ZCLasVegasGameView *lasVegasGameView=self.viewArray[self.index-1];
          lasVegasGameView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-114);
        self.open=YES;
        [self.view addSubview:lasVegasGameView];
        lasVegasGameView.lasVegasModel=self.dataArray[self.index-1];
        self.lasVegasGameView=lasVegasGameView;
        
        [self.afterBtn setTitle:@"下一洞" forState:UIControlStateNormal];
 
    }else{
    
    ZCLasVegasGameView *lasVegasGameView=self.viewArray[self.index];
    
    
    lasVegasGameView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-114);
    
    [self.view addSubview:lasVegasGameView];
    lasVegasGameView.lasVegasModel=self.dataArray[self.index];
    self.lasVegasGameView=lasVegasGameView;
    
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
    ZCOfflinePlayer *play4= fightTheLandlordModel.plays[3];
    
    if (self.index==0) {
        play1.score=0;
        play2.score=0;
        play3.score=0;
        play4.score=0;
        
    }else{
        ZCFightTheLandlordModel *upFightTheLandlordModel=self.dataArray[self.index-1];
     
        
        
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
        
        
        for (ZCOfflinePlayer *play in upFightTheLandlordModel.plays) {
            if (play4.player_id==play.player_id) {
                play4.score=play.score;
                break;
            }
        }

        
    }
    
    
    
    if ([self valueIsNotEmpty]) {
        
        [self savelasVegasGameTheData];
        
        
        fightTheLandlordModel.isSavePar=0;
        play1.isSaveStroke=0;
        play2.isSaveStroke=0;
        play3.isSaveStroke=0;
        play4.isSaveStroke=0;
        
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
    self.lasVegasGameView.beforeTheChangeModel=fightTheLandlordModel;
    
    
    [_cancelBtn removeFromSuperview];
    [_confirmBtn removeFromSuperview];
}








//上一洞
-(void)clickTheBeforeBtn
{
    ZCLog(@"%d",self.index);
    ZCLog(@"%d",self.open);
    
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
        self.lasVegasGameView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        [self.lasVegasGameView removeFromSuperview];
        
        ZCLasVegasGameView *lasVegasGameView=self.viewArray[self.index];
        lasVegasGameView.transform = CGAffineTransformIdentity;
        lasVegasGameView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-114);
        [self.view addSubview:lasVegasGameView];
        self.lasVegasGameView=lasVegasGameView;
        
        
        
    }];
    
    }
    
}


//点击开始
-(void)clickTheStartBtn
{
    ZCLog(@"%d",self.index);
 
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
            
            // [self.viewArray replaceObjectAtIndex:self.index withObject:self.holeScoringView];
            [self savelasVegasGameTheData];
        }else{
            self.isYES=!self.isYES;
            [MBProgressHUD showSuccess:@"请填写标准杆和所有玩家的成绩"];
            
        }

        
    
        }else{
        
        self.index++;
        
        
        
        [UIView animateWithDuration:0.5 animations:^{
            self.lasVegasGameView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        } completion:^(BOOL finished) {
            [self.lasVegasGameView removeFromSuperview];
            
            ZCLasVegasGameView *lasVegasGameView=self.viewArray[self.index];
            lasVegasGameView.lasVegasModel=self.dataArray[self.index];
            lasVegasGameView.transform = CGAffineTransformIdentity;
            lasVegasGameView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-114);
            [self.view addSubview:lasVegasGameView];
            self.lasVegasGameView=lasVegasGameView;
            
        }];
        
        ZCFightTheLandlordModel *lasVegasGameModel=self.dataArray[self.index];
        if (lasVegasGameModel.par==0) {
            self.isYES=NO;
            [self.afterBtn setTitle:@"确认比赛" forState:UIControlStateNormal];
        }else{
            self.isYES=YES;
            [self.afterBtn setTitle:@"下一洞" forState:UIControlStateNormal];
        }

        
       // [self.afterBtn setTitle:@"确认比赛" forState:UIControlStateNormal];
     }
    }
    
}

//关闭前一洞的交互
-(void)whetherCloseInteraction
{
    
    if (self.index>0) {
        ZCLasVegasGameView *LasVegasGameView=self.viewArray[self.index-1];
        LasVegasGameView.isClick=YES;
    }
    
    
}



//判断是否值为空
-(BOOL)valueIsNotEmpty
{
    ZCFightTheLandlordModel *fightTheLandlordModel=self.dataArray[self.index];
    ZCOfflinePlayer *play1=fightTheLandlordModel.plays[0];
    ZCOfflinePlayer *play2=fightTheLandlordModel.plays[1];
    ZCOfflinePlayer *play3=fightTheLandlordModel.plays[2];
    ZCOfflinePlayer *play4=fightTheLandlordModel.plays[3];
    
    if ( fightTheLandlordModel.par==0 || play1.stroke==0 || play2.stroke==0 || play3.stroke==0 || play4.stroke==0) {
        return NO;
    }else {
        return  YES;
    }
    
    
}




//保存成绩，并计算分数
-(void)savelasVegasGameTheData
{
    ZCFightTheLandlordModel *lasVegasGameModel=self.dataArray[self.index];
    
    
    //拿出比赛设置数据
    ZCSwitchModel *switchModel= [ZCDatabaseTool querySwitchProperties];
    self.switchModel=switchModel;
    
    ZCLog(@"%d,%d",switchModel.birdie_x2,switchModel.double_par_x2);

    //拿出4人的成绩
    ZCOfflinePlayer *play1= lasVegasGameModel.plays[0];
    ZCOfflinePlayer *play2= lasVegasGameModel.plays[1];
    ZCOfflinePlayer *play3= lasVegasGameModel.plays[2];
    ZCOfflinePlayer *play4= lasVegasGameModel.plays[3];
     ZCLog(@"%ld %ld %ld %ld %d",(long)play1.stroke,(long)play2.stroke,(long)play3.stroke,(long)play4.stroke,lasVegasGameModel.par);
    
    int first=0;
    int second=0;
    int third=0;
    int fourth=0;
    
    if (switchModel.birdie_x2==1) {
        //判断第一组是否有小鸟或者老鹰球
        if (play1.stroke-lasVegasGameModel.par<=-1 || play2.stroke-lasVegasGameModel.par<=-1) {
            if (switchModel.birdie_x2==1) {
                first=1;
            }else
            {
                first=0;
            }
            
            
        }
        
        
        
        //判断第二组是否有小鸟或者老鹰球
        if (play3.stroke-lasVegasGameModel.par<=-1 || play4.stroke-lasVegasGameModel.par<=-1) {
            if (switchModel.birdie_x2==1) {
                third=1;
            }else
            {
                third=0;
            }
            
        }

 
    }
    
    
    if (switchModel.double_par_x2==1) {
        //判断第一组是否有双倍标准杆
        if (play1.stroke-2*lasVegasGameModel.par>=0 || play2.stroke-2*lasVegasGameModel.par>=0){
            if (switchModel.double_par_x2==1) {
                second=1;
            }else
            {
                second=0;
            }
            
            
        }
        
        
        //判断第二组是否有双倍标准杆
        if (play3.stroke-2*lasVegasGameModel.par>=0 || play4.stroke-2*lasVegasGameModel.par>=0){
            if (switchModel.double_par_x2==1) {
                fourth=1;
            }else
            {
                fourth=0;
            }
            
        }


        
    }
    
   
    ZCLog(@"%d %d %d %d ",first,second,third,fourth);
    
    NSInteger firstScore;//第一组总成绩
    NSInteger secondScore;//第二组总成绩
    //计算第一组成绩
    if (play1.stroke<play2.stroke) {
        
     firstScore=play1.stroke*10 + play2.stroke;
        
    }else{
    
     firstScore=play2.stroke*10 + play1.stroke;
  
    }
    
     //计算第二组成绩
    if (play3.stroke<play4.stroke) {
        
        secondScore=play3.stroke*10 + play4.stroke;
        
    }else{
        
      secondScore=play4.stroke*10 + play3.stroke;
     }

    
    NSInteger winFirstScore;
    NSInteger winSecendScore;
    //是否翻转计算
    if (firstScore<secondScore) {//第一组赢
        if (second==1) {
            
            if (play1.stroke<play2.stroke) {
                winFirstScore=play2.stroke*10 + play1.stroke;
            }else{
            winFirstScore=play1.stroke*10 + play2.stroke;
            }
            
        }else{
            winFirstScore=firstScore;
        }
        
        //第二组
        if (first==1 || fourth==1) {
            if (play3.stroke<play4.stroke) {
                winSecendScore=play4.stroke*10 + play3.stroke;
            }else{
            winSecendScore=play3.stroke*10 + play4.stroke;
            }
            
        }else{
            winSecendScore=secondScore;
        }
        
        
    }else{//输
    //第一组
        if (second==1||third==1) {
            if (play1.stroke<play2.stroke) {
            
                winFirstScore=play2.stroke*10 + play1.stroke;
            }else{
               winFirstScore=play1.stroke*10 + play2.stroke;
            }
        }else
        {
            winFirstScore=firstScore;
        }
        
        
        
            //第二组
            if (fourth==1) {
                if (play3.stroke<play4.stroke) {
                    winSecendScore=play4.stroke*10 + play3.stroke;
                }else{
                winSecendScore=play3.stroke*10 + play4.stroke;
                }
                
            }else{
                winSecendScore=secondScore;
            }
            
        
        
        
        
    }
    
    
    
    //计算输赢
    if (firstScore<secondScore) { //第一组赢
        play1.winScore=winSecendScore-winFirstScore;
        play1.score=play1.score+(winSecendScore-winFirstScore);
        
        play2.winScore=winSecendScore-winFirstScore;
        play2.score=play2.score+(winSecendScore-winFirstScore);
        
        play3.winScore=winFirstScore-winSecendScore;
        play3.score=play3.score-(winSecendScore-winFirstScore);
        
        play4.winScore=winFirstScore-winSecendScore;
        play4.score=play4.score-(winSecendScore-winFirstScore);
        //判断打什么球提示语
        if (self.isLiShi) {
            [self ToJudgeWhatIsPlayingTheBallWithfirstScore:firstScore andSecondScore:secondScore];
        }

    }else if (firstScore==secondScore)
    {
        play1.winScore=0;
        play2.winScore=0;
        play3.winScore=0;
        play4.winScore=0;
      [MBProgressHUD showSuccess:@"该局打平"];
    }else{///第一组输
    
        play1.winScore=winSecendScore-winFirstScore;
        play1.score=play1.score-(winFirstScore-winSecendScore);
        
        play2.winScore=winSecendScore-winFirstScore;
        play2.score=play2.score-(winFirstScore-winSecendScore);
        
        play3.winScore=winFirstScore-winSecendScore;
        play3.score=play3.score+(winFirstScore-winSecendScore);
        
        play4.winScore=winFirstScore-winSecendScore;
        play4.score=play4.score+(winFirstScore-winSecendScore);
        //判断打什么球提示语
        if (self.isLiShi) {
            [self ToJudgeWhatIsPlayingTheBallWithfirstScore:firstScore andSecondScore:secondScore];
        }

    }
    
    
    BOOL success=[ZCDatabaseTool saveTheLasVegas:lasVegasGameModel andHoleNumber:self.index];
    if (success) {
        lasVegasGameModel.isSave=YES;
       self.lasVegasGameView.lasVegasModel=lasVegasGameModel;
        
    }

    if (self.index<17) {
       [self TheNextHoleLocationChange];
    }
    
    
}


////判断是打了什么球提示语
-(void)ToJudgeWhatIsPlayingTheBallWithfirstScore:(NSInteger)firstScore andSecondScore:(NSInteger)secondScore
{
    
    ZCFightTheLandlordModel *lasVegasGameModel=self.dataArray[self.index];
    
    
    //拿出4人的成绩
    ZCOfflinePlayer *play1= lasVegasGameModel.plays[0];
    ZCOfflinePlayer *play2= lasVegasGameModel.plays[1];
    ZCOfflinePlayer *play3= lasVegasGameModel.plays[2];
    ZCOfflinePlayer *play4= lasVegasGameModel.plays[3];
    
    
    
    //判断显示
    if (firstScore<secondScore) {
        
        int index;
        
        int index2;
        
    if (self.switchModel.birdie_x2==1) {
        if (play1.stroke<play2.stroke) {
             if (play1.stroke-lasVegasGameModel.par<=-2) {
                index=4;
                
            }else if (play1.stroke-lasVegasGameModel.par<=-1){
                index=2;
            }else{
                index=1;
            }
            
        }else{
            
            if (play2.stroke-lasVegasGameModel.par<=-2) {
                index=4;
            }else if (play2.stroke-lasVegasGameModel.par<=-1){
                index=2;
            }else{
                index=1;
            }
            
            
            
        }
        }
        
        
        if (self.switchModel.double_par_x2==1) {
            
        if (play3.stroke<play4.stroke) {
            
            if (play4.stroke>=2*lasVegasGameModel.par) {
                index2=2;
            }
            
        }else{
            
            if (play3.stroke>=2*lasVegasGameModel.par) {
                index2=2;
            }
            
            
        }
        
        }
        
        [self ToJudgeWhetherAMultipleGoalsAndWin:@"蓝队" andTimes:index andLost:@"绿队" andLostTimes:index2];
    }else{//输
        
       //蓝队
        int index=0;
       //绿队
        int index2=0;
        
        if (self.switchModel.double_par_x2==1) {
            
        
        if (play1.stroke<play2.stroke) {
            
            if (play2.stroke>=2*lasVegasGameModel.par) {
                index=2;
            }
            
        }else{
           
            if (play1.stroke>=2*lasVegasGameModel.par) {
                index=2;
            }
            
            
        }
            
        }
        
        
        if (self.switchModel.birdie_x2==1) {
            
        
        if (play3.stroke<play4.stroke) {
            
            if (play3.stroke-lasVegasGameModel.par<=-2) {
                index2=4;
            }else if (play3.stroke-lasVegasGameModel.par<=-1){
                index2=2;
            }else{
                index2=0;
            }
        }else{
           
            if (play4.stroke-lasVegasGameModel.par<=-2) {
                index2=4;
            }else if (play4.stroke-lasVegasGameModel.par<=-1){
                index2=2;
            }else{
                index2=0;
            }
            
            
        }
        }
        
        [self ToJudgeWhetherAMultipleGoalsAndWin:@"绿队" andTimes:index2 andLost:@"蓝队" andLostTimes:index];
        
        
    }
    
    

    

}




//设置下一组头像的顺序
-(void)TheNextHoleLocationChange
{
    ZCFightTheLandlordModel *lasVegasGameModel=self.dataArray[self.index];
 
    
    NSMutableArray *teamArray=[[NSMutableArray alloc] init];
    
    
    //克隆数组
    for (int index=0; index<4; index++) {
        [teamArray addObject:lasVegasGameModel.plays[index]];
    }
    
    ZCOfflinePlayer *play1= teamArray[0];
    ZCOfflinePlayer *play2= teamArray[1];
    ZCOfflinePlayer *play3= teamArray[2];
    ZCOfflinePlayer *play4= teamArray[3];
    
    CGFloat playScore1=(CGFloat)play1.stroke+0.4;
    CGFloat playScore2=(CGFloat)play2.stroke+0.1;
    CGFloat playScore3=(CGFloat)play3.stroke+0.2;
    CGFloat playScore4=(CGFloat)play4.stroke+0.3;
    
    
    play1.strokeToCompare=playScore1;
    play2.strokeToCompare=playScore2;
    play3.strokeToCompare=playScore3;
    play4.strokeToCompare=playScore4;

    //冒泡排序  个数大的时候请勿使用
    for (int i=0; i<3; i++) {
        for (int j=0; j<3; j++) {
            if ([teamArray[j] strokeToCompare] > [teamArray[j+1] strokeToCompare]) {
                ZCOfflinePlayer *teamPlayer=[[ZCOfflinePlayer alloc] init];
                teamPlayer=teamArray[j];
                teamArray[j]=teamArray[j+1];
                teamArray[j+1]=teamPlayer;
            }
        }
    }
    
   
    
    ZCFightTheLandlordModel *lasVegasGameModelNext=self.dataArray[self.index+1];
    
     NSMutableArray *teamNextArray=[NSMutableArray array];
    
    
        for ( ZCOfflinePlayer *play in lasVegasGameModelNext.plays) {
            if (play.player_id==[teamArray[0] player_id]) {
                play.score=[teamArray[0] score];
                [teamNextArray addObject:play];
                break;
            }
            
        }

    for ( ZCOfflinePlayer *play in lasVegasGameModelNext.plays) {
        if (play.player_id==[teamArray[3] player_id]) {
            play.score=[teamArray[3] score];
            [teamNextArray addObject:play];
            break;
        }
        
    }

    for ( ZCOfflinePlayer *play in lasVegasGameModelNext.plays) {
        if (play.player_id==[teamArray[1] player_id]) {
            play.score=[teamArray[1] score];
            [teamNextArray addObject:play];
            break;
        }
        
    }

    for ( ZCOfflinePlayer *play in lasVegasGameModelNext.plays) {
        if (play.player_id==[teamArray[2] player_id]) {
            play.score=[teamArray[2] score];
            [teamNextArray addObject:play];
            break;
        }
        
    }

    lasVegasGameModelNext.plays=teamNextArray;
    
//    for (int n=0; n<4; n++) {
//        ZCOfflinePlayer *play1= teamArray[n];
//        ZCLog(@"%ld",(long)play1.stroke);
//    }
//    
//    
//    for (int n=0; n<4; n++) {
//        ZCOfflinePlayer *play1= lasVegasGameModel.plays[n];
//        ZCLog(@"%ld",(long)play1.stroke);
//    }

    
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



//判断是什么球提示用户
-(void)ToJudgeWhetherAMultipleGoalsAndWin:(NSString *)playerName andTimes:(int)few andLost:(NSString *) otherPlayerName andLostTimes:(int)otherFew
{

    ZCLog(@"-----%d,-----%d",few,otherFew);
    UIWindow *wd = [[[UIApplication sharedApplication] windows] lastObject];
    
    if (few==2 || few==4) {//小鸟
        
       self.birdBallView.frame=[UIScreen mainScreen].bounds;
        [self.birdBallView setName:playerName andIndex:few];
        
        self.birdBallView.douDoulePar=otherFew;
        self.birdBallView.name=otherPlayerName;
        [wd addSubview:self.birdBallView];
    }else{
        if (otherFew==2) {
            
            [self.birdBallView setName:otherPlayerName andIndex:1];
            self.birdBallView.frame=[UIScreen mainScreen].bounds;
//            birdBallView.player=otherPlayer;
//            birdBallView.index=1;
            [wd addSubview:self.birdBallView];
            
            
        }
        
        
    }
    
    
    
    
}


-(void)ZCBirdBallViewWhetherPopUpNextWithDouDiZhu:(NSString *)playerName andIndexDoulePar:(int)doulePar{
    
    UIWindow *wd = [[[UIApplication sharedApplication] windows] lastObject];
    if (doulePar==2) {
       // ZCBirdBallView *birdBallView=[[ZCBirdBallView alloc] init];
        self.birdBallView.frame=[UIScreen mainScreen].bounds;
       [self.birdBallView setName:playerName andIndex:1];
        [wd addSubview:self.birdBallView];
        
        
    }
    
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
