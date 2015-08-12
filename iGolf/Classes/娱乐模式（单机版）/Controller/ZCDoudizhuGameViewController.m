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
@interface ZCDoudizhuGameViewController ()<ZCDoudizhuGameViewDelegate>
@property(nonatomic,weak)ZCDoudizhuGameView *doudizhuGameView;
@property(nonatomic,strong)NSMutableArray *viewArray;
@property(nonatomic,assign)int index;
@property(nonatomic,weak)UIButton *afterBtn;
@property(nonatomic,assign)BOOL isYES;
@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,assign) int liftScore;
@property(nonatomic,assign) int middleScore;
@property(nonatomic,assign) int rightScore;
@property(nonatomic,strong)ZCFightTheLandlordModel*fightTheLandlordModel;

//打平进入下一洞的次数
@property(nonatomic,assign)int isNext;
@end

@implementation ZCDoudizhuGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //返回
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barBtnItemWithNormalImageName:@"fanhui" hightImageName:@"fanhui" action:@selector(dataToModify:) target:self];
    
    UIBarButtonItem *ButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"排名" style:UIBarButtonItemStyleDone target:self action:@selector(clickTherightItem)];
    
    self.navigationItem.rightBarButtonItem = ButtonItem;
    
    self.view.backgroundColor=[UIColor whiteColor];
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
        ZCDoudizhuGameView *doudizhuGameView=self.viewArray[i];
        
        doudizhuGameView.fightTheLandlordModel=self.dataArray[i];
        self.index++;
        
    }
    
    
    
    
    ZCDoudizhuGameView *doudizhuGameView=self.viewArray[self.index];
    
    doudizhuGameView.fightTheLandlordModel=self.dataArray[self.index];
    doudizhuGameView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-114);
    
    [self.view addSubview:doudizhuGameView];
   // doudizhuGameView.delegate=self;
    self.doudizhuGameView=doudizhuGameView;
    
    
    
    
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
    
    

    
}


//上一洞
-(void)clickTheBeforeBtn
{
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


//点击开始
-(void)clickTheStartBtn
{
    
    self.isYES=!self.isYES;
    
    if (self.isYES) {//确认成绩
        if ([self valueIsNotEmpty]) {
            [self.afterBtn setTitle:@"下一洞" forState:UIControlStateNormal];
            //self.doudizhuGameView.number=@"asdasd";
            // [self.viewArray replaceObjectAtIndex:self.index withObject:self.holeScoringView];
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
                doudizhuGameView.isNext=self.isNext;
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
            first=1;
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
            second=1;
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
            third=1;
        }
        
    }else{
        third=1;
    }

    
       
    
    int i=first;
    int j=second;
    int k=third;
   
    
    //地主赢
    if (2*play2.stroke<(play1.stroke+play3.stroke)) {
        
        play1.winScore=0-j*(self.isNext+1);
        play2.winScore=j*(self.isNext+1)*2;
        play3.winScore=0-j*(self.isNext+1);
        
        
        play1.score=play1.score-j*(self.isNext+1);
        play2.score=play2.score+j*(self.isNext+1)*2;
        play3.score=play3.score-j*(self.isNext+1);
        
        
        if (self.isNext) {
          
            doudizhuGameView.clues=@"本洞获胜方获得了累计分数";
        }
        self.isNext=0;
        //位置变化
        [self TheNextHoleLocationChange];
    }else if (2*play2.stroke==(play1.stroke+play3.stroke)){//平局
        
        if (switchModel.drau_to_next==1) {//打开了打球进入下一洞
            self.isNext++;
            
            doudizhuGameView.clues=@"本洞比分打平,分数累至下一洞";
            [self drawTheNextHoleLocationChange];
        }else{
        
            play1.winScore=0;
            play2.winScore=0;
            play3.winScore=0;

        }
        
        
        
    }else{
    
        if (i<k) {
            play1.winScore=k*(self.isNext+1);
            play2.winScore=0-k*(self.isNext+1)*2;
            play3.winScore=k*(self.isNext+1);
            play1.score=play1.score+k*(self.isNext+1);
            play2.score=play2.score-k*(self.isNext+1)*2;
            play3.score=play3.score+k*(self.isNext+1);
        }else
        {
            play1.winScore=i*(self.isNext+1);
            play2.winScore=0-i*(self.isNext+1)*2;
            play3.winScore=i*(self.isNext+1);
            
            play1.score=play1.score+i*(self.isNext+1);
            play2.score=play2.score-i*(self.isNext+1)*2;
            play3.score=play3.score+i*(self.isNext+1);
        }
        
        if (self.isNext) {
           
            doudizhuGameView.clues=@"本洞获胜方获得了累计分数";
        }
        self.isNext=0;
        //位置变化
        [self TheNextHoleLocationChange];
    }
    
    
    
    
    BOOL success=[ZCDatabaseTool saveTheFightTheLandlord:fightTheLandlordModel andHoleNumber:self.index];
    if (success) {
        self.doudizhuGameView.fightTheLandlordModel=fightTheLandlordModel;
        
    }
    ZCLog(@"%p",fightTheLandlordModel);

   


    
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
   // fightTheLandlordModelNext.isNext=self.isNext;
    
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
