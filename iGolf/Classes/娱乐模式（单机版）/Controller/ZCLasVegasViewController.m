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
        ZCLasVegasGameView *lasVegasGameView=self.viewArray[i];
        
        lasVegasGameView.lasVegasModel=self.dataArray[i];
        self.index++;
        
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
    self.isYES=YES;
    [self.afterBtn setTitle:@"下一洞" forState:UIControlStateNormal];
    
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
         [self savelasVegasGameTheData];
        
    }else{
        self.index++;
        
        
        
        [UIView animateWithDuration:0.5 animations:^{
            self.lasVegasGameView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        } completion:^(BOOL finished) {
            [self.lasVegasGameView removeFromSuperview];
            
            ZCLasVegasGameView *lasVegasGameView=self.viewArray[self.index];
            lasVegasGameView.lasVegasModel=self.dataArray[self.index];
            lasVegasGameView.transform = CGAffineTransformIdentity;
            lasVegasGameView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-120);
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



//保存成绩，并计算分数
-(void)savelasVegasGameTheData
{
    ZCFightTheLandlordModel *lasVegasGameModel=self.dataArray[self.index];
    
    
    //拿出比赛设置数据
    ZCSwitchModel *switchModel= [ZCDatabaseTool querySwitchProperties];

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
    //判断第一组是否有小鸟或者老鹰球
    if (play1.stroke-lasVegasGameModel.par<=-1 || play2.stroke-lasVegasGameModel.par<=-1) {
        if (switchModel.birdie_x2==1) {
            first=1;
        }else
        {
        first=0;
        }
        
       
    }
    //判断第一组是否有双倍标准杆
    if (play1.stroke-2*lasVegasGameModel.par>=0 || play2.stroke-2*lasVegasGameModel.par>=0){
        if (switchModel.double_par_x2==1) {
            second=1;
        }else
        {
            second=0;
        }

        
    }
     //判断第二组是否有小鸟或者老鹰球
    if (play3.stroke-lasVegasGameModel.par<=-1 || play3.stroke-lasVegasGameModel.par<=-1) {
        if (switchModel.birdie_x2==1) {
            third=1;
        }else
        {
            third=0;
        }
        
    }
    //判断第二组是否有双倍标准杆
    if (play4.stroke-2*lasVegasGameModel.par>=0 || play4.stroke-2*lasVegasGameModel.par>=0){
        if (switchModel.double_par_x2==1) {
            fourth=1;
        }else
        {
            fourth=0;
        }

    }

   
    ZCLog(@"%d %d %d %d ",first,second,third,fourth);
    
    NSInteger firstScore;//第一组总成绩
    NSInteger secondScore;//第二组总成绩
    //计算第一组成绩
    if (play1.stroke<play2.stroke) {
        if (second==1 || third==1) {
            firstScore=play2.stroke*10 + play1.stroke;
        }else{
        firstScore=play1.stroke*10 + play2.stroke;
        }
    }else{
    
        if (second==1 || third==1) {
            firstScore=play1.stroke*10 + play2.stroke;
        }else{
            firstScore=play2.stroke*10 + play1.stroke;
        }

    }
    
    
    //计算第二组成绩
    if (play3.stroke<play4.stroke) {
        if (first==1 || fourth==1) {
            secondScore=play4.stroke*10 + play3.stroke;
        }else{
            secondScore=play3.stroke*10 + play4.stroke;
        }
    }else{
        
        if (first==1 || fourth==1) {
            secondScore=play3.stroke*10 + play4.stroke;
        }else{
            secondScore=play4.stroke*10 + play3.stroke;
        }
        
    }


    //计算输赢
    if (firstScore<secondScore) { //第一组赢
        play1.winScore=secondScore-firstScore;
        play1.score=play1.score+(secondScore-firstScore);
        
        play2.winScore=secondScore-firstScore;
        play2.score=play2.score+(secondScore-firstScore);
        
        play3.winScore=firstScore-secondScore;
        play3.score=play3.score-(secondScore-firstScore);
        
        play4.winScore=firstScore-secondScore;
        play4.score=play4.score-(secondScore-firstScore);
    }else{///第一组输
    
        play1.winScore=secondScore-firstScore;
        play1.score=play1.score-(firstScore-secondScore);
        
        play2.winScore=secondScore-firstScore;
        play2.score=play2.score-(firstScore-secondScore);
        
        play3.winScore=firstScore-secondScore;
        play3.score=play3.score+(firstScore-secondScore);
        
        play4.winScore=firstScore-secondScore;
        play4.score=play4.score+(firstScore-secondScore);
    }
    
    
    BOOL success=[ZCDatabaseTool saveTheLasVegas:lasVegasGameModel andHoleNumber:self.index];
    if (success) {
       self.lasVegasGameView.lasVegasModel=lasVegasGameModel;
        
    }

    
    [self TheNextHoleLocationChange];
    
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
