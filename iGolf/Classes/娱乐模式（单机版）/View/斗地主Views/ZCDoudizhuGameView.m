//
//  ZCDoudizhuGameView.m
//  iGolf
//
//  Created by hh on 15/7/23.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCDoudizhuGameView.h"
#import "ZCHeadPortrait.h"
#import "ZCKeyboardView.h"
#import "ZCParKeyboardView.h"
#import "ZCFightTheLandlordModel.h"
#import "ZCOfflinePlayer.h"
#import "ZCSingletonTool.h"
@interface ZCDoudizhuGameView()<ZCKeyboardViewDelegate,ZCParKeyboardViewDelegate>
@property(nonatomic,weak)UIScrollView *scollView;
@property(nonatomic,weak)UILabel *holeNumber;
@property(nonatomic,weak)UILabel *nameLabel;
@property(nonatomic,weak)UIButton *scoreButton;
@property(nonatomic,weak)UILabel *promptLabel;
@property(nonatomic,weak)ZCHeadPortrait *liftImageView;
@property(nonatomic,weak)ZCHeadPortrait *middleImageView;
@property(nonatomic,weak)ZCHeadPortrait *rightImageView;
@property(nonatomic,weak)UIButton *liftScoreLabel;
@property(nonatomic,weak)UIButton *middleScoreLabel;
@property(nonatomic,weak)UIButton *rightScoreLabel;


@property(nonatomic,weak)UILabel *liftLabel;
@property(nonatomic,weak)UILabel *middleLabel;
@property(nonatomic,weak)UILabel *rightLabel;
@property(nonatomic,weak)UILabel *farmersLabel;
@property(nonatomic,weak)UILabel *farmersLabel2;
@property(nonatomic,weak)UILabel *diZhuLabel;
@property(nonatomic,weak)UILabel *numberLabel;
@property(nonatomic,weak)UILabel *numberLabel2;
@property(nonatomic,weak)UILabel *numberLabel3;


@property(nonatomic,weak)UIImageView *bjRedImage;
@property(nonatomic,weak)UIImageView *bjMiddleImage;

// 1为点击左边的成绩   2为点击中间的成绩  3 为点击右边的成绩
@property(nonatomic,assign)int index;
@end


@implementation ZCDoudizhuGameView

//-(ZCFightTheLandlordModel *)holeModel{
//    
//    if (_holeModel==nil) {
//        _holeModel=[[ZCHoleModel alloc] init];
//    }
//    return _holeModel;
//}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
       
        [self addControls];
        
    }
    return self;
}


-(void)addControls
{
    
    UIImageView *bjMiddleImage=[[UIImageView alloc] init];
    bjMiddleImage.image=[UIImage imageNamed:@"hole_bjimage"];
    [self addSubview:bjMiddleImage];
    self.bjMiddleImage=bjMiddleImage;

    
    
    UIScrollView *scollView=[[UIScrollView  alloc] init];
    [scollView setShowsVerticalScrollIndicator:NO];
    scollView.bounces=NO;
    [self addSubview:scollView];
    self.scollView=scollView;
    
    
    UIImageView *bjRedImage=[[UIImageView alloc] init];
    bjRedImage.image=[UIImage imageNamed:@"yule_dingbu_bj"];
    [scollView addSubview:bjRedImage];
    self.bjRedImage=bjRedImage;
    
//    UILabel *holeNumber=[[UILabel alloc] init];
//    [scollView addSubview:holeNumber];
//    self.holeNumber=holeNumber;
//    
//    UILabel *nameLabel=[[UILabel alloc] init];
//    nameLabel.text=@"标准杆";
//    nameLabel.textAlignment=NSTextAlignmentCenter;
//    [scollView addSubview:nameLabel];
//    self.nameLabel=nameLabel;
    
    //计分成绩
    UIButton *scoreButton=[[UIButton alloc] init];
    scoreButton.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"yule_anniu_mor"]];
    [scoreButton setTitleColor:ZCColor(85, 85, 85) forState:UIControlStateNormal];
    [scoreButton setTitle:@"-" forState:UIControlStateNormal];
    scoreButton.titleLabel.font=[UIFont systemFontOfSize:25];
    [scoreButton addTarget:self action:@selector(cliclkThescoreButton) forControlEvents:UIControlEventTouchUpInside];
    [scollView addSubview:scoreButton];
    self.scoreButton=scoreButton;
    
    
    // 显示提示语
    UILabel *promptLabel=[[UILabel alloc] init];
    promptLabel.hidden=YES;
    promptLabel.text=@"上3洞打平均数累计本洞获胜方将获得4洞的分数";
    promptLabel.textColor=[UIColor whiteColor];
    //自动折行设置
    //promptLabel.lineBreakMode = UILineBreakModeWordWrap;
    promptLabel.textAlignment=NSTextAlignmentCenter;
    promptLabel.numberOfLines = 0;
    [scollView addSubview:promptLabel];
    self.promptLabel=promptLabel;
    
    
    UILabel *farmersLabel=[[UILabel alloc] init];
    
    farmersLabel.text=@"平民";
    farmersLabel.textColor=ZCColor(34, 34, 34);
    farmersLabel.textAlignment=NSTextAlignmentCenter;
    [scollView addSubview:farmersLabel];
    self.farmersLabel=farmersLabel;
    
    
    
    UILabel *diZhuLabel=[[UILabel alloc] init];
    
    diZhuLabel.text=@"地主";
    diZhuLabel.textColor=ZCColor(34, 34, 34);
    diZhuLabel.textAlignment=NSTextAlignmentCenter;
    [scollView addSubview:diZhuLabel];
    self.diZhuLabel=diZhuLabel;
    
    UILabel *farmersLabel2=[[UILabel alloc] init];
    farmersLabel2.text=@"平民";
    farmersLabel2.textColor=ZCColor(34, 34, 34);
    farmersLabel2.textAlignment=NSTextAlignmentCenter;
    [scollView addSubview:farmersLabel2];
    self.farmersLabel2=farmersLabel2;

    
    UILabel *numberLabel=[[UILabel alloc] init];
    
    numberLabel.text=@"1号发球";
    numberLabel.font=[UIFont systemFontOfSize:12];
    numberLabel.textAlignment=NSTextAlignmentCenter;
    [scollView addSubview:numberLabel];
    self.numberLabel=numberLabel;
    
    
    UILabel *numberLabel2=[[UILabel alloc] init];
    
    numberLabel2.text=@"2号发球";
    numberLabel2.font=[UIFont systemFontOfSize:12];
    numberLabel2.textAlignment=NSTextAlignmentCenter;
    [scollView addSubview:numberLabel2];
    self.numberLabel2=numberLabel2;
    
    UILabel *numberLabel3=[[UILabel alloc] init];
    
    numberLabel3.text=@"3号发球";
    numberLabel3.font=[UIFont systemFontOfSize:12];
    numberLabel3.textAlignment=NSTextAlignmentCenter;
    [scollView addSubview:numberLabel3];
    self.numberLabel3=numberLabel3;
    
    
    ZCHeadPortrait *liftImageView=[[ZCHeadPortrait alloc] init];
    liftImageView.indexColor=2;
    [scollView addSubview:liftImageView];
    self.liftImageView=liftImageView;
    
    
    ZCHeadPortrait *middleImageView=[[ZCHeadPortrait alloc] init];
    middleImageView.indexColor=1;
    [scollView addSubview:middleImageView];
    self.middleImageView=middleImageView;
    
    ZCHeadPortrait *rightImageView=[[ZCHeadPortrait alloc] init];
    rightImageView.indexColor=2;
    [scollView addSubview:rightImageView];
    self.rightImageView=rightImageView;
    
    
    UILabel *liftLabel=[[UILabel alloc] init];
    liftLabel.textAlignment=NSTextAlignmentCenter;
    [scollView addSubview:liftLabel];
    self.liftLabel=liftLabel;
    
    UILabel *middleLabel=[[UILabel alloc] init];
    middleLabel.textAlignment=NSTextAlignmentCenter;
    [scollView addSubview:middleLabel];
    self.middleLabel=middleLabel;
    
    UILabel *rightLabel=[[UILabel alloc] init];
    rightLabel.textAlignment=NSTextAlignmentCenter;
    [scollView addSubview:rightLabel];
    self.rightLabel=rightLabel;
    
    
    
    UIButton *liftScoreLabel=[[UIButton alloc] init];
    liftScoreLabel.tag=23100;
    liftScoreLabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"yule_anniu_mor"]];
    [liftScoreLabel setTitleColor:ZCColor(85, 85, 85) forState:UIControlStateNormal];
    [liftScoreLabel setTitle:@"-" forState:UIControlStateNormal];
    liftScoreLabel.titleLabel.font=[UIFont systemFontOfSize:25];    [liftScoreLabel addTarget:self action:@selector(cliclkTheScoreLabel:) forControlEvents:UIControlEventTouchUpInside];
    [scollView addSubview:liftScoreLabel];
    self.liftScoreLabel=liftScoreLabel;
    
    
    UIButton *middleScoreLabel=[[UIButton alloc] init];
    middleScoreLabel.tag=23101;
    middleScoreLabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"yule_anniu_mor"]];
    [middleScoreLabel setTitleColor:ZCColor(85, 85, 85) forState:UIControlStateNormal];
    [middleScoreLabel setTitle:@"-" forState:UIControlStateNormal];
    middleScoreLabel.titleLabel.font=[UIFont systemFontOfSize:25];
    [middleScoreLabel addTarget:self action:@selector(cliclkTheScoreLabel:) forControlEvents:UIControlEventTouchUpInside];
    [scollView addSubview:middleScoreLabel];
    self.middleScoreLabel=middleScoreLabel;
    
    
    UIButton *rightScoreLabel=[[UIButton alloc] init];
    rightScoreLabel.tag=23102;
    rightScoreLabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"yule_anniu_mor"]];
    [rightScoreLabel setTitle:@"-" forState:UIControlStateNormal];
    [rightScoreLabel setTitleColor:ZCColor(85, 85, 85) forState:UIControlStateNormal];
    rightScoreLabel.titleLabel.font=[UIFont systemFontOfSize:25];
    [rightScoreLabel addTarget:self action:@selector(cliclkTheScoreLabel:) forControlEvents:UIControlEventTouchUpInside];
    [scollView addSubview:rightScoreLabel];
    self.rightScoreLabel=rightScoreLabel;
    
   
    
}


-(void)setNumber:(NSString *)number

{
    _number=number;
    
    self.holeNumber.text=[NSString stringWithFormat:@"球洞%@",number];
}



-(void)cliclkThescoreButton
{
    if (self.isClick) {
        [MBProgressHUD showSuccess:@"已经不可以修改数据了"];
    }else{
    ZCParKeyboardView *ParKeyboardView=[[ZCParKeyboardView alloc] init];
    ParKeyboardView.frame=[UIScreen mainScreen].bounds;
    ParKeyboardView.delegate=self;
    UIWindow *wd = [[UIApplication sharedApplication].delegate window];
    [wd addSubview:ParKeyboardView];
    }
}


//par的键盘代理方法
-(void)ParKeyboardViewConfirmThatTheInput:(NSString *)number
{
    int intNum=[number intValue];
    int holeNumber=[self.number intValue];
    if (self.fightTheLandlordModel.isSave) {
        if (self.fightTheLandlordModel.isSavePar==0) {
            
            self.fightTheLandlordModel.isSavePar=self.fightTheLandlordModel.par;
        }
        
       // int intNum=[number intValue];
        self.fightTheLandlordModel.par=intNum;
        [self.scoreButton setTitle:number forState:UIControlStateNormal];

    }else{
    
    
    self.fightTheLandlordModel.par=intNum;
//    if ([self.delegate respondsToSelector:@selector(doudizhuGameViewDelegateForScore:andForHoleNumber:)]) {
//        [self.delegate doudizhuGameViewDelegateForScore:self.fightTheLandlordModel andForHoleNumber:holeNumber];
//    }
    
    [self.scoreButton setTitle:number forState:UIControlStateNormal];
    
    }
    //通知控制器数据已经修改重新计算成绩
    ZCSingletonTool *tool=[ZCSingletonTool sharedEventUuidTool];
    tool.isModify=YES;
}



//输入键盘代理方法
-(void)keyboardViewConfirmThatTheInput:(NSString *)number{
    
    
    int intNum=[number intValue];
   int holeNumber=[self.number intValue];
    
    if (self.fightTheLandlordModel.isSave) {
        if (self.index==1) {
            [self.liftScoreLabel setTitle:number forState:UIControlStateNormal];
            ZCOfflinePlayer *player=  self.fightTheLandlordModel.plays[0];
            //用于修改取消修改后的成绩
            if (player.isSaveStroke==0) {
                player.isSaveStroke=player.stroke;
            }

            player.stroke=intNum;
        }else if (self.index==2){
            [self.middleScoreLabel setTitle:number forState:UIControlStateNormal];
            ZCOfflinePlayer *player=  self.fightTheLandlordModel.plays[1];
            //用于修改取消修改后的成绩
            if (player.isSaveStroke==0) {
                player.isSaveStroke=player.stroke;
            }
            ZCLog(@"%ld",(long)player.isSaveStroke);
             ZCLog(@"%ld",(long)player.stroke
                   );
            player.stroke=intNum;
        }else
        {
            
            [self.rightScoreLabel setTitle:number forState:UIControlStateNormal];
            ZCOfflinePlayer *player=  self.fightTheLandlordModel.plays[2];
            //用于修改取消修改后的成绩
            if (player.isSaveStroke==0) {
                player.isSaveStroke=player.stroke;
            }

            player.stroke=intNum;
        }
 
    }else{
    
    
    
    if (self.index==1) {
        [self.liftScoreLabel setTitle:number forState:UIControlStateNormal];
       ZCOfflinePlayer *player=  self.fightTheLandlordModel.plays[0];
        player.stroke=intNum;
    }else if (self.index==2){
    [self.middleScoreLabel setTitle:number forState:UIControlStateNormal];
        ZCOfflinePlayer *player=  self.fightTheLandlordModel.plays[1];
        player.stroke=intNum;
    }else
    {
        
        [self.rightScoreLabel setTitle:number forState:UIControlStateNormal];
        ZCOfflinePlayer *player=  self.fightTheLandlordModel.plays[2];
        player.stroke=intNum;
    }
    
    }
    
    if ([self.delegate respondsToSelector:@selector(doudizhuGameViewDelegateForScore:andForHoleNumber:)]) {
        [self.delegate doudizhuGameViewDelegateForScore:self.fightTheLandlordModel andForHoleNumber:holeNumber];
    }
    
    
    
    //通知控制器数据已经修改重新计算成绩
    ZCSingletonTool *tool=[ZCSingletonTool sharedEventUuidTool];
    tool.isModify=YES;
}

//set方法
-(void)setFightTheLandlordModel:(ZCFightTheLandlordModel *)fightTheLandlordModel
{
    _fightTheLandlordModel=fightTheLandlordModel;
    ZCLog(@"%d",fightTheLandlordModel.par);
    
    if (fightTheLandlordModel.par==0) {
        [self.scoreButton setTitle:@"-" forState:UIControlStateNormal];
    }else{
        
       [self.scoreButton setTitle:[NSString stringWithFormat:@"%d",fightTheLandlordModel.par] forState:UIControlStateNormal];
    }

    
    
    self.liftImageView.offlinePlayer=fightTheLandlordModel.plays[0];
    self.middleImageView.offlinePlayer=fightTheLandlordModel.plays[1];
    self.rightImageView.offlinePlayer=fightTheLandlordModel.plays[2] ;
    
    
    ZCOfflinePlayer *offPlayer1=fightTheLandlordModel.plays[0];
    ZCOfflinePlayer *offPlayer2=fightTheLandlordModel.plays[1];
    ZCOfflinePlayer *offPlayer3=fightTheLandlordModel.plays[2];
   
    
    if (offPlayer1.stroke==0) {
        [self.liftScoreLabel setTitle:@"-" forState:UIControlStateNormal];
    }else{
        [self.liftScoreLabel setTitle:[NSString stringWithFormat:@"%ld",offPlayer1.stroke] forState:UIControlStateNormal];
    }

    
    
    
    
    if (offPlayer2.stroke==0) {
        [self.middleScoreLabel setTitle:@"-" forState:UIControlStateNormal];
    }else{
        [self.middleScoreLabel setTitle:[NSString stringWithFormat:@"%ld",(long)offPlayer2.stroke] forState:UIControlStateNormal];
    }

    
    if (offPlayer3.stroke==0) {
        [self.rightScoreLabel setTitle:@"-" forState:UIControlStateNormal];
    }else{
        [self.rightScoreLabel setTitle:[NSString stringWithFormat:@"%ld",(long)offPlayer3.stroke] forState:UIControlStateNormal];
    }

    
    
   
    
    
    self.liftLabel.text=[NSString stringWithFormat:@"%ld",(long)[fightTheLandlordModel.plays[0] winScore]];
    self.middleLabel.text=[NSString stringWithFormat:@"%ld",(long)[fightTheLandlordModel.plays[1] winScore]];
    self.rightLabel.text=[NSString stringWithFormat:@"%ld",(long)[fightTheLandlordModel.plays[2] winScore]];
}




//点击取消后传回修改前的值
-(void)setBeforeTheChangeModel:(ZCFightTheLandlordModel *)beforeTheChangeModel
{
    _beforeTheChangeModel=beforeTheChangeModel;
    
    if (beforeTheChangeModel.isSavePar==0) {
        
    }else{
        
        [self.scoreButton setTitle:[NSString stringWithFormat:@"%ld",(long)beforeTheChangeModel.isSavePar] forState:UIControlStateNormal];
    }
    
    
    ZCOfflinePlayer *offPlayer1=beforeTheChangeModel.plays[0];
    ZCOfflinePlayer *offPlayer2=beforeTheChangeModel.plays[1];
    ZCOfflinePlayer *offPlayer3=beforeTheChangeModel.plays[2];
    
    
    
    
    if (offPlayer1.isSaveStroke==0) {
        
    }else{
        [self.liftScoreLabel setTitle:[NSString stringWithFormat:@"%ld",(long)offPlayer1.isSaveStroke] forState:UIControlStateNormal];
    }
    
    if (offPlayer2.isSaveStroke==0) {
        
    }else{
        ZCLog(@"%ld",(long)offPlayer2.isSaveStroke);
        [self.middleScoreLabel setTitle:[NSString stringWithFormat:@"%ld",(long)offPlayer2.isSaveStroke] forState:UIControlStateNormal];
    }
    
    
    
    if (offPlayer3.isSaveStroke==0) {
        
    }else{
        [self.rightScoreLabel setTitle:[NSString stringWithFormat:@"%ld",(long)offPlayer3.isSaveStroke] forState:UIControlStateNormal];
    }

    
    
    
    
}




-(void)setIsNext:(int)isNext
{
    if (isNext==0) {
        self.promptLabel.hidden=YES;
    }else
    {
        self.promptLabel.hidden=NO;
        self.promptLabel.text=[NSString stringWithFormat:@"上%d洞打平\r本洞获胜方将获得累计分数",isNext];
    }
    
}

-(void)setClues:(NSString *)clues
{
    self.promptLabel.hidden=NO;
    self.promptLabel.text=clues;
}





//点击了个人成绩
-(void)cliclkTheScoreLabel:(UIButton *)btn
{
    if (self.isClick) {
        [MBProgressHUD showSuccess:@"已经不可以修改数据了"];
    }else{
    
    ZCOfflinePlayer *player;
    int colorIndex;
    
    if (btn.tag==23100) {
        self.index=1;
        ZCOfflinePlayer *player1=  self.fightTheLandlordModel.plays[0];
        player=player1;
        colorIndex=2;
    }else if (btn.tag==23101)
    {
        self.index=2;
        ZCOfflinePlayer *player1=  self.fightTheLandlordModel.plays[1];
        player=player1;
        colorIndex=1;
    }else
    {
        self.index=3;
        ZCOfflinePlayer *player1=  self.fightTheLandlordModel.plays[2];
        player=player1;
        colorIndex=2;
    }
    
    ZCKeyboardView *keyboardView=[[ZCKeyboardView alloc] init];
    keyboardView.colorIndex=colorIndex;
    keyboardView.imageStr=player.portrait;
    keyboardView.name=player.nickname;
    keyboardView.frame=[UIScreen mainScreen].bounds;
    keyboardView.delegate=self;
    UIWindow *wd = [[UIApplication sharedApplication].delegate window];
    [wd addSubview:keyboardView];
  }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.scollView.frame=self.bounds;
    
    CGFloat bjRedImageH=SCREEN_HEIGHT*0.174295;
    self.bjRedImage.frame=CGRectMake(0, 0, SCREEN_WIDTH, bjRedImageH);
    
    CGFloat bjMiddleImageY=bjRedImageH;
    CGFloat bjMiddleImageH=SCREEN_HEIGHT*0.62676;
    self.bjMiddleImage.frame=CGRectMake(0, bjMiddleImageY, SCREEN_WIDTH, bjMiddleImageH);
    
    
//    CGFloat holeNumberX=30;
//    CGFloat holeNumberY=21;
//    CGFloat holeNumberW=100;
//    CGFloat holeNumberH=20;
//    self.holeNumber.frame=CGRectMake(holeNumberX, holeNumberY, holeNumberW, holeNumberH);
//    
//    CGFloat nameLabelW=60;
//    CGFloat nameLabelH=20;
//    CGFloat nameLabelX=(SCREEN_WIDTH-nameLabelW)/2;
//    CGFloat nameLabelY=19;
//    self.nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    
    CGFloat promptLabelX=40;
    CGFloat promptLabelY=15;
    CGFloat promptLabelW=SCREEN_WIDTH-2*promptLabelX;
    CGFloat promptLabelH=[ZCTool getFrame:CGSizeMake(promptLabelW, 2000) content:self.promptLabel.text fontSize:[UIFont systemFontOfSize:18]].size.height;
    self.promptLabel.frame=CGRectMake(promptLabelX, promptLabelY, promptLabelW, promptLabelH);
    

    
    CGFloat scoreLabelW=60;
    CGFloat scoreLabelH=60;
    CGFloat scoreLabelX=(SCREEN_WIDTH-scoreLabelW)/2;
    CGFloat scoreLabelY=bjRedImageH-30;
    self.scoreButton.frame=CGRectMake(scoreLabelX, scoreLabelY, scoreLabelW, scoreLabelH);
    
    
    
    CGFloat farmersLabelX=5;
    CGFloat farmersLabelY=scoreLabelY+scoreLabelH+33;
    CGFloat farmersLabelW=(SCREEN_WIDTH-15)/3;
    CGFloat farmersLabelH=20;
    self.farmersLabel.frame=CGRectMake(farmersLabelX, farmersLabelY, farmersLabelW, farmersLabelH);
    
    self.numberLabel.frame=CGRectMake(farmersLabelX, farmersLabelY+farmersLabelH+5, farmersLabelW, farmersLabelH);
    
    CGFloat diZhuLabelY=farmersLabelY;
    CGFloat diZhuLabelW=farmersLabelW;
    CGFloat diZhuLabelH=20;
    CGFloat diZhuLabelX=(SCREEN_WIDTH-diZhuLabelW)/2;
    ;
    self.diZhuLabel.frame=CGRectMake(diZhuLabelX, diZhuLabelY, diZhuLabelW, diZhuLabelH);
    
    self.numberLabel2.frame=CGRectMake(diZhuLabelX, farmersLabelY+farmersLabelH+5, farmersLabelW, farmersLabelH);
    
    CGFloat farmersLabel2Y=farmersLabelY;
    CGFloat farmersLabel2W=farmersLabelW;
    CGFloat farmersLabel2H=20;
    CGFloat farmersLabel2X=SCREEN_WIDTH-farmersLabel2W-5;
    self.farmersLabel2.frame=CGRectMake(farmersLabel2X, farmersLabel2Y, farmersLabel2W, farmersLabel2H);
    
    self.numberLabel3.frame=CGRectMake(farmersLabel2X, farmersLabelY+farmersLabelH+5, farmersLabelW, farmersLabelH);
    
    CGFloat liftImageViewX=5;
    CGFloat liftImageViewY=farmersLabelY+farmersLabelH+35;
    CGFloat liftImageViewW=(SCREEN_WIDTH-15)/3;
    CGFloat liftImageViewH=150;
    self.liftImageView.frame=CGRectMake(liftImageViewX, liftImageViewY, liftImageViewW, liftImageViewH);
    
    
    
    
    CGFloat middleImageViewY=liftImageViewY;
    CGFloat middleImageViewW=liftImageViewW;
    CGFloat middleImageViewH=liftImageViewH;
    CGFloat middleImageViewX=(SCREEN_WIDTH-middleImageViewW)/2;
    self.middleImageView.frame=CGRectMake(middleImageViewX, middleImageViewY, middleImageViewW, middleImageViewH);
    
    
    CGFloat rightImageViewY=liftImageViewY;
    CGFloat rightImageViewW=liftImageViewW;
    CGFloat rightImageViewH=liftImageViewH;
    CGFloat rightImageViewX=SCREEN_WIDTH-rightImageViewW-5;
    self.rightImageView.frame=CGRectMake(rightImageViewX, rightImageViewY, rightImageViewW, rightImageViewH);
    
    
    
    CGFloat  liftLabelX=liftImageViewX;
    CGFloat  liftLabelY=liftImageViewY+liftImageViewH+10;
    CGFloat  liftLabelW=liftImageViewW;
    CGFloat  liftLabelH=15;
    self.liftLabel.frame=CGRectMake(liftLabelX, liftLabelY, liftLabelW, liftLabelH);
    
    
    CGFloat  middleLabelX=middleImageViewX;
    CGFloat  middleLabelY=liftImageViewY+liftImageViewH+10;
    CGFloat  middleLabelW=liftImageViewW;
    CGFloat  middleLabelH=15;
    self.middleLabel.frame=CGRectMake(middleLabelX, middleLabelY, middleLabelW, middleLabelH);
    
    CGFloat  rightLabelX=rightImageViewX;
    CGFloat  rightLabelY=liftImageViewY+liftImageViewH+10;
    CGFloat  rightLabelW=liftImageViewW;
    CGFloat  rightLabelH=15;
    self.rightLabel.frame=CGRectMake(rightLabelX, rightLabelY, rightLabelW, rightLabelH);
    
    
    
    CGFloat liftScoreLabelY=liftLabelY+liftLabelH+20;
    CGFloat liftScoreLabelW=60;
    CGFloat liftScoreLabelH=60;
    CGFloat liftScoreLabelX=liftImageViewX+(liftImageViewW-liftScoreLabelW)/2;
    self.liftScoreLabel.frame=CGRectMake(liftScoreLabelX, liftScoreLabelY, liftScoreLabelW, liftScoreLabelH);
    
    
    
    CGFloat middleScoreLabelY=middleLabelY+middleLabelH+20;
    CGFloat middleScoreLabelW=60;
    CGFloat middleScoreLabelH=60;
    CGFloat middleScoreLabelX=middleImageViewX+(middleImageViewW-middleScoreLabelW)/2;
    self.middleScoreLabel.frame=CGRectMake(middleScoreLabelX, middleScoreLabelY, middleScoreLabelW, middleScoreLabelH);
    
    
    CGFloat rightScoreLabelY=liftScoreLabelY;
    CGFloat rightScoreLabelW=60;
    CGFloat rightScoreLabelH=60;
    CGFloat rightScoreLabelX=rightImageViewX+(rightImageViewW-rightScoreLabelW)/2;
    self.rightScoreLabel.frame=CGRectMake(rightScoreLabelX, rightScoreLabelY, rightScoreLabelW, rightScoreLabelH);
    
    self.scollView.contentSize=CGSizeMake(0, rightScoreLabelY+rightScoreLabelH+20);
}



@end
