//
//  ZCLasVegasGameView.m
//  iGolf
//
//  Created by hh on 15/7/23.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCLasVegasGameView.h"
#import "ZCLasVegasPhotoView.h"
#import "ZCKeyboardView.h"
#import "ZCParKeyboardView.h"
#import "ZCFightTheLandlordModel.h"
#import "ZCOfflinePlayer.h"
#import "ZCSingletonTool.h"
@interface ZCLasVegasGameView()<ZCKeyboardViewDelegate,ZCParKeyboardViewDelegate>
@property(nonatomic,weak)UIScrollView *scollView;
@property(nonatomic,weak)UILabel *holeNumber;
@property(nonatomic,weak)UILabel *nameLabel;
@property(nonatomic,weak)UIButton *scoreLabel;
@property(nonatomic,weak)UILabel *promptLabel;
@property(nonatomic,weak)ZCLasVegasPhotoView *liftImageView;
@property(nonatomic,weak)ZCLasVegasPhotoView *middleImageView;
@property(nonatomic,weak)ZCLasVegasPhotoView *rightImageView;
@property(nonatomic,weak)ZCLasVegasPhotoView *lastImageView;
@property(nonatomic,weak)UIButton *liftScoreLabel;
@property(nonatomic,weak)UIButton *middleScoreLabel;
@property(nonatomic,weak)UIButton *rightScoreLabel;
@property(nonatomic,weak)UIButton *lastScoreLabel;
@property(nonatomic,weak)UIImageView *VSImage;

@property(nonatomic,weak)UILabel *liftLabel;
@property(nonatomic,weak)UILabel *middleLabel;
@property(nonatomic,weak)UILabel *rightLabel;
@property(nonatomic,weak)UILabel *lastLabel;

@property(nonatomic,weak)UILabel *numberLabel;
@property(nonatomic,weak)UILabel *numberLabel2;
@property(nonatomic,weak)UILabel *numberLabel3;
@property(nonatomic,weak)UILabel *numberLabel4;
// 1为点击左边的成绩   2为点击中左间的成绩  3 为点击中右边的成绩 4为最右边
@property(nonatomic,assign)int index;
@end

@implementation ZCLasVegasGameView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
       
        [self addControls];
        
    }
    return self;
}


-(void)addControls
{
    UIScrollView *scollView=[[UIScrollView  alloc] init];
    [scollView setShowsVerticalScrollIndicator:NO];
    scollView.bounces=NO;
    [self addSubview:scollView];
    self.scollView=scollView;
    
    UILabel *holeNumber=[[UILabel alloc] init];
    [scollView addSubview:holeNumber];
    self.holeNumber=holeNumber;
    
    UILabel *nameLabel=[[UILabel alloc] init];
    nameLabel.text=@"标准杆";
    nameLabel.textAlignment=NSTextAlignmentCenter;
    [scollView addSubview:nameLabel];
    self.nameLabel=nameLabel;
    
    //计分成绩cliclkThescoreButton
    UIButton *scoreLabel=[[UIButton alloc] init];
    scoreLabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"ganshuluru"]];
    [scoreLabel setTitle:@"-" forState:UIControlStateNormal];
    scoreLabel.titleLabel.font=[UIFont systemFontOfSize:25];    [scoreLabel addTarget:self action:@selector(cliclkThescoreButton) forControlEvents:UIControlEventTouchUpInside];
    [scollView addSubview:scoreLabel];
    self.scoreLabel=scoreLabel;
    
    
//    // 显示提示语
//    UILabel *promptLabel=[[UILabel alloc] init];
//    promptLabel.text=@"上3洞打平均数累计本洞获胜方将获得4洞的分数";
//    //自动折行设置
//   // promptLabel.lineBreakMode = UILineBreakModeWordWrap;
//    promptLabel.numberOfLines = 0;
//    [self addSubview:promptLabel];
//    self.promptLabel=promptLabel;
    
    
    
    UILabel *numberLabel=[[UILabel alloc] init];
    
    numberLabel.text=@"1号发球";
    numberLabel.font=[UIFont systemFontOfSize:12];
    numberLabel.textAlignment=NSTextAlignmentCenter;
    [scollView addSubview:numberLabel];
    self.numberLabel=numberLabel;
    
    UILabel *numberLabel2=[[UILabel alloc] init];
   
    numberLabel2.text=@"4号发球";
    numberLabel2.font=[UIFont systemFontOfSize:12];
    numberLabel2.textAlignment=NSTextAlignmentCenter;
    [scollView addSubview:numberLabel2];
    self.numberLabel2=numberLabel2;
    
    UILabel *numberLabel3=[[UILabel alloc] init];
    
    numberLabel3.text=@"2号发球";
    numberLabel3.font=[UIFont systemFontOfSize:12];
    numberLabel3.textAlignment=NSTextAlignmentCenter;
    [scollView addSubview:numberLabel3];
    self.numberLabel3=numberLabel3;
    
    UILabel *numberLabel4=[[UILabel alloc] init];
    
    numberLabel4.text=@"3号发球";
    numberLabel4.font=[UIFont systemFontOfSize:12];
    numberLabel4.textAlignment=NSTextAlignmentCenter;
    [scollView addSubview:numberLabel4];
    self.numberLabel4=numberLabel4;
    
    ZCLasVegasPhotoView *liftImageView=[[ZCLasVegasPhotoView alloc] init];
    liftImageView.indexColor=1;
    [scollView addSubview:liftImageView];
    self.liftImageView=liftImageView;
    
    
    ZCLasVegasPhotoView *middleImageView=[[ZCLasVegasPhotoView alloc] init];
    middleImageView.indexColor=1;
    [scollView addSubview:middleImageView];
    self.middleImageView=middleImageView;
    
    ZCLasVegasPhotoView *rightImageView=[[ZCLasVegasPhotoView alloc] init];
    rightImageView.indexColor=2;
    [scollView addSubview:rightImageView];
    self.rightImageView=rightImageView;
    
    ZCLasVegasPhotoView *lastImageView=[[ZCLasVegasPhotoView alloc] init];
    lastImageView.indexColor=2;
    [scollView addSubview:lastImageView];
    self.lastImageView=lastImageView;
    
    
    
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
    
    
    UILabel *lastLabel=[[UILabel alloc] init];
    lastLabel.textAlignment=NSTextAlignmentCenter;
    [scollView addSubview:lastLabel];
    self.lastLabel=lastLabel;
    
    
    UIButton *liftScoreLabel=[[UIButton alloc] init];
    liftScoreLabel.tag=23300;
    liftScoreLabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"ganshuluru"]];
    [liftScoreLabel setTitle:@"-" forState:UIControlStateNormal];
    liftScoreLabel.titleLabel.font=[UIFont systemFontOfSize:25];    [liftScoreLabel addTarget:self action:@selector(cliclkTheScoreLabel:) forControlEvents:UIControlEventTouchUpInside];
    [scollView addSubview:liftScoreLabel];
    self.liftScoreLabel=liftScoreLabel;
    
    
    UIButton *middleScoreLabel=[[UIButton alloc] init];
    middleScoreLabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"ganshuluru"]];
    [middleScoreLabel setTitle:@"-" forState:UIControlStateNormal];
    middleScoreLabel.titleLabel.font=[UIFont systemFontOfSize:25];
    middleScoreLabel.tag=23301;
    
    [middleScoreLabel addTarget:self action:@selector(cliclkTheScoreLabel:) forControlEvents:UIControlEventTouchUpInside];
    [scollView addSubview:middleScoreLabel];
    self.middleScoreLabel=middleScoreLabel;
    
    
    UIButton *rightScoreLabel=[[UIButton alloc] init];
    rightScoreLabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"ganshuluru"]];
    [rightScoreLabel setTitle:@"-" forState:UIControlStateNormal];
    rightScoreLabel.titleLabel.font=[UIFont systemFontOfSize:25];
    rightScoreLabel.tag=23302;
    
    [rightScoreLabel addTarget:self action:@selector(cliclkTheScoreLabel:) forControlEvents:UIControlEventTouchUpInside];
    [scollView addSubview:rightScoreLabel];
    self.rightScoreLabel=rightScoreLabel;
    
    
    UIButton *lastScoreLabel=[[UIButton alloc] init];
    lastScoreLabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"ganshuluru"]];
    [lastScoreLabel setTitle:@"-" forState:UIControlStateNormal];
    lastScoreLabel.titleLabel.font=[UIFont systemFontOfSize:25];
    lastScoreLabel.tag=23303;
    
    [lastScoreLabel addTarget:self action:@selector(cliclkTheScoreLabel:) forControlEvents:UIControlEventTouchUpInside];
    [scollView addSubview:lastScoreLabel];
    self.lastScoreLabel=lastScoreLabel;
    
    //[self layoutIfNeeded];
    
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


//点击了个人成绩
-(void)cliclkTheScoreLabel:(UIButton *)btn
{
    if (self.isClick) {
        [MBProgressHUD showSuccess:@"已经不可以修改数据了"];
    }else{
    ZCOfflinePlayer *player;
    int colorIndex;

    if (btn.tag==23300) {
        self.index=1;
        ZCOfflinePlayer *player1=  self.lasVegasModel.plays[0];
        player=player1;
        colorIndex=1;
    }else if (btn.tag==23301)
    {
        self.index=2;
        ZCOfflinePlayer *player1=  self.lasVegasModel.plays[1];
        player=player1;
        colorIndex=1;
    }else if (btn.tag==23302){
       self.index=3;
        ZCOfflinePlayer *player1=  self.lasVegasModel.plays[2];
        player=player1;
        colorIndex=2;
    }else
    {
        self.index=4;
        ZCOfflinePlayer *player1=  self.lasVegasModel.plays[3];
        player=player1;
        colorIndex=2;
    }
    
    ZCKeyboardView *keyboardView=[[ZCKeyboardView alloc] init];
    
    keyboardView.frame=[UIScreen mainScreen].bounds;
    keyboardView.imageStr=player.portrait;
    keyboardView.name=player.nickname;
    keyboardView.colorIndex=colorIndex;
    keyboardView.delegate=self;
    UIWindow *wd = [[UIApplication sharedApplication].delegate window];
    [wd addSubview:keyboardView];
    }
}


//par的键盘代理方法
-(void)ParKeyboardViewConfirmThatTheInput:(NSString *)number
{
    int intNum=[number intValue];
    
    if (self.lasVegasModel.isSave)
    {
        if (self.lasVegasModel.isSavePar==0) {
             self.lasVegasModel.isSavePar=self.lasVegasModel.par;
        }
       
    }
    self.lasVegasModel.par=intNum;

    
    [self.scoreLabel setTitle:number forState:UIControlStateNormal];
    
    //通知控制器数据已经修改重新计算成绩
    ZCSingletonTool *tool=[ZCSingletonTool sharedEventUuidTool];
    tool.isModify=YES;
}



//输入键盘代理方法
-(void)keyboardViewConfirmThatTheInput:(NSString *)number{
    
    
    int intNum=[number intValue];
   
   if (self.lasVegasModel.isSave) {
      
       if (self.index==1) {
           [self.liftScoreLabel setTitle:number forState:UIControlStateNormal];
           ZCOfflinePlayer *player=  self.lasVegasModel.plays[0];
           //用于修改取消修改后的成绩
           if (player.isSaveStroke==0) {
               player.isSaveStroke=player.stroke;
           }

           player.stroke=intNum;
           ZCLog(@"%ld",(long)player.stroke);
       }else if (self.index==2){
           [self.middleScoreLabel setTitle:number forState:UIControlStateNormal];
           ZCOfflinePlayer *player=  self.lasVegasModel.plays[1];
           //用于修改取消修改后的成绩
           if (player.isSaveStroke==0) {
               player.isSaveStroke=player.stroke;
           }

           player.stroke=intNum;
           ZCLog(@"%ld",(long)player.stroke);
       }else if (self.index==3)
       {
           
           [self.rightScoreLabel setTitle:number forState:UIControlStateNormal];
           ZCOfflinePlayer *player=  self.lasVegasModel.plays[2];
           //用于修改取消修改后的成绩
           if (player.isSaveStroke==0) {
               player.isSaveStroke=player.stroke;
           }

           player.stroke=intNum;
           ZCLog(@"%ld",(long)player.stroke);
       }else
       {
           [self.lastScoreLabel setTitle:number forState:UIControlStateNormal];
           ZCOfflinePlayer *player=  self.lasVegasModel.plays[3];
           //用于修改取消修改后的成绩
           if (player.isSaveStroke==0) {
               player.isSaveStroke=player.stroke;
           }

           player.stroke=intNum;
           ZCLog(@"%ld",(long)player.stroke);
       }

       
       
   }else{
    if (self.index==1) {
        [self.liftScoreLabel setTitle:number forState:UIControlStateNormal];
        ZCOfflinePlayer *player=  self.lasVegasModel.plays[0];
        player.stroke=intNum;
        ZCLog(@"%ld",(long)player.stroke);
    }else if (self.index==2){
        [self.middleScoreLabel setTitle:number forState:UIControlStateNormal];
        ZCOfflinePlayer *player=  self.lasVegasModel.plays[1];
        player.stroke=intNum;
        ZCLog(@"%ld",(long)player.stroke);
    }else if (self.index==3)
    {
        
        [self.rightScoreLabel setTitle:number forState:UIControlStateNormal];
        ZCOfflinePlayer *player=  self.lasVegasModel.plays[2];
        player.stroke=intNum;
        ZCLog(@"%ld",(long)player.stroke);
    }else
    {
        [self.lastScoreLabel setTitle:number forState:UIControlStateNormal];
        ZCOfflinePlayer *player=  self.lasVegasModel.plays[3];
        player.stroke=intNum;
        ZCLog(@"%ld",(long)player.stroke);
    }
       
   }
    
    //通知控制器数据已经修改重新计算成绩
    ZCSingletonTool *tool=[ZCSingletonTool sharedEventUuidTool];
    tool.isModify=YES;
    
//    if ([self.delegate respondsToSelector:@selector(doudizhuGameViewDelegateForScore:andForHoleNumber:)]) {
//        [self.delegate doudizhuGameViewDelegateForScore:self.fightTheLandlordModel andForHoleNumber:holeNumber];
//    }
    
    
    
}

-(void)setLasVegasModel:(ZCFightTheLandlordModel *)lasVegasModel
{
    _lasVegasModel=lasVegasModel;

    if (lasVegasModel.par==0) {
         [self.scoreLabel setTitle:@"-" forState:UIControlStateNormal];
    }else{
    
    [self.scoreLabel setTitle:[NSString stringWithFormat:@"%d",lasVegasModel.par] forState:UIControlStateNormal];
    }
    
    self.liftImageView.offlinePlayer=lasVegasModel.plays[0];
    self.middleImageView.offlinePlayer=lasVegasModel.plays[1];
    self.rightImageView.offlinePlayer=lasVegasModel.plays[2];
    self.lastImageView.offlinePlayer=lasVegasModel.plays[3];
    
    
    
    ZCOfflinePlayer *offPlayer1=lasVegasModel.plays[0];
    ZCOfflinePlayer *offPlayer2=lasVegasModel.plays[1];
    ZCOfflinePlayer *offPlayer3=lasVegasModel.plays[2];
    ZCOfflinePlayer *offPlayer4=lasVegasModel.plays[3];
    
    
    
    if (offPlayer1.stroke==0) {
        [self.liftScoreLabel setTitle:@"-" forState:UIControlStateNormal];
    }else{
        [self.liftScoreLabel setTitle:[NSString stringWithFormat:@"%ld",offPlayer1.stroke] forState:UIControlStateNormal];
    }

    
    
    if (offPlayer2.stroke==0) {
        [self.middleScoreLabel setTitle:@"-" forState:UIControlStateNormal];
    }else{
        [self.middleScoreLabel setTitle:[NSString stringWithFormat:@"%ld",offPlayer2.stroke] forState:UIControlStateNormal];
    }

    
    
   
    
    
    if (offPlayer3.stroke==0) {
        [self.rightScoreLabel setTitle:@"-" forState:UIControlStateNormal];
    }else{
        [self.rightScoreLabel setTitle:[NSString stringWithFormat:@"%ld",offPlayer3.stroke] forState:UIControlStateNormal];
    }

    
    if (offPlayer4.stroke==0) {
        [self.lastScoreLabel setTitle:@"-" forState:UIControlStateNormal];
    }else{
        [self.lastScoreLabel setTitle:[NSString stringWithFormat:@"%ld",offPlayer4.stroke] forState:UIControlStateNormal];
    }

    
   
    
    
    
    
    
    
    
    self.liftLabel.text=[NSString stringWithFormat:@"%ld",(long)[lasVegasModel.plays[0] winScore]];
    self.middleLabel.text=[NSString stringWithFormat:@"%ld",(long)[lasVegasModel.plays[1] winScore]];
    self.rightLabel.text=[NSString stringWithFormat:@"%ld",(long)[lasVegasModel.plays[2] winScore]];
    self.lastLabel.text=[NSString stringWithFormat:@"%ld",(long)[lasVegasModel.plays[3] winScore]];
    
    
}




//点击取消后传回修改前的值
-(void)setBeforeTheChangeModel:(ZCFightTheLandlordModel *)beforeTheChangeModel
{
    _beforeTheChangeModel=beforeTheChangeModel;
    
    if (beforeTheChangeModel.isSavePar==0) {
        
    }else{
        
        [self.scoreLabel setTitle:[NSString stringWithFormat:@"%ld",(long)beforeTheChangeModel.isSavePar] forState:UIControlStateNormal];
    }
    
    
    ZCOfflinePlayer *offPlayer1=beforeTheChangeModel.plays[0];
    ZCOfflinePlayer *offPlayer2=beforeTheChangeModel.plays[1];
    ZCOfflinePlayer *offPlayer3=beforeTheChangeModel.plays[2];
    ZCOfflinePlayer *offPlayer4=beforeTheChangeModel.plays[3];
    
    
    
    
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
    
    
    if (offPlayer4.isSaveStroke==0) {
        
    }else{
        [self.lastScoreLabel setTitle:[NSString stringWithFormat:@"%ld",(long)offPlayer4.isSaveStroke] forState:UIControlStateNormal];
    }
    
    
    
}





-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.scollView.frame=self.bounds;
    
    CGFloat holeNumberX=30;
    CGFloat holeNumberY=21;
    CGFloat holeNumberW=100;
    CGFloat holeNumberH=20;
    self.holeNumber.frame=CGRectMake(holeNumberX, holeNumberY, holeNumberW, holeNumberH);
    
    CGFloat nameLabelW=60;
    CGFloat nameLabelH=20;
    CGFloat nameLabelX=(SCREEN_WIDTH-nameLabelW)/2;
    CGFloat nameLabelY=19;
    self.nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    
    CGFloat scoreLabelW=61;
    CGFloat scoreLabelH=61;
    CGFloat scoreLabelX=(SCREEN_WIDTH-scoreLabelW)/2;
    CGFloat scoreLabelY=nameLabelY+nameLabelH+25;
    self.scoreLabel.frame=CGRectMake(scoreLabelX, scoreLabelY, scoreLabelW, scoreLabelH);
    
//    CGFloat promptLabelX=40;
//    CGFloat promptLabelY=scoreLabelY+scoreLabelH+10;
//    CGFloat promptLabelW=SCREEN_WIDTH-2*promptLabelX;
//    CGFloat promptLabelH=[ZCTool getFrame:CGSizeMake(promptLabelW, 2000) content:self.promptLabel.text fontSize:[UIFont systemFontOfSize:18]].size.height;
//    self.promptLabel.frame=CGRectMake(promptLabelX, promptLabelY, promptLabelW, promptLabelH);
    
    CGFloat numberLabelX=10;
    CGFloat numberLabelY=scoreLabelY+scoreLabelH+30;
    CGFloat numberLabelW=(SCREEN_WIDTH-70)/4;
    CGFloat numberLabelH=20;
    self.numberLabel.frame=CGRectMake(numberLabelX, numberLabelY, numberLabelW, numberLabelH);
    
    CGFloat numberLabel2X=numberLabelX+numberLabelW+8;

    CGFloat numberLabel2Y=numberLabelY;
    CGFloat numberLabel2W=numberLabelW;
    CGFloat numberLabel2H=20;
   self.numberLabel2.frame=CGRectMake(numberLabel2X, numberLabel2Y, numberLabel2W, numberLabel2H);
    
    
    CGFloat numberLabel3X=numberLabel2X+numberLabel2W+33;
    CGFloat numberLabel3Y=numberLabelY;
    CGFloat numberLabel3W=numberLabelW;
    CGFloat numberLabel3H=20;
    self.numberLabel3.frame=CGRectMake(numberLabel3X, numberLabel3Y, numberLabel3W, numberLabel3H);
    
    
    CGFloat numberLabel4X=numberLabel3X+numberLabel3W+8;
    CGFloat numberLabel4Y=numberLabelY;
    CGFloat numberLabel4W=numberLabelW;
    CGFloat numberLabel4H=20;
    self.numberLabel4.frame=CGRectMake(numberLabel4X, numberLabel4Y, numberLabel4W, numberLabel4H);
    
    
    CGFloat liftImageViewX=10;
    CGFloat liftImageViewY=scoreLabelY+scoreLabelH+55;
    CGFloat liftImageViewW=(SCREEN_WIDTH-70)/4;
    CGFloat liftImageViewH=120;
    self.liftImageView.frame=CGRectMake(liftImageViewX, liftImageViewY, liftImageViewW, liftImageViewH);
    
    
    
    
    CGFloat middleImageViewY=liftImageViewY;
    CGFloat middleImageViewW=liftImageViewW;
    CGFloat middleImageViewH=liftImageViewH;
    CGFloat middleImageViewX=liftImageViewX+middleImageViewW+8;
    self.middleImageView.frame=CGRectMake(middleImageViewX, middleImageViewY, middleImageViewW, middleImageViewH);
    
    
    CGFloat rightImageViewY=liftImageViewY;
    CGFloat rightImageViewW=liftImageViewW;
    CGFloat rightImageViewH=liftImageViewH;
    CGFloat rightImageViewX=middleImageViewX+middleImageViewW+33;
    self.rightImageView.frame=CGRectMake(rightImageViewX, rightImageViewY, rightImageViewW, rightImageViewH);
    
    CGFloat lastImageViewY=liftImageViewY;
    CGFloat lastImageViewW=liftImageViewW;
    CGFloat lastImageViewH=liftImageViewH;
    CGFloat lastImageViewX=rightImageViewX+rightImageViewW+8;
    self.lastImageView.frame=CGRectMake(lastImageViewX, lastImageViewY, lastImageViewW, lastImageViewH);
    
    
    
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
    
    CGFloat  lastLabelX=lastImageViewX;
    CGFloat  lastLabelY=liftImageViewY+liftImageViewH+10;
    CGFloat  lastLabelW=liftImageViewW;
    CGFloat  lastLabelH=15;
    self.lastLabel.frame=CGRectMake(lastLabelX, lastLabelY, lastLabelW, lastLabelH);
    
    
    
    CGFloat liftScoreLabelY=liftLabelY+liftLabelH+20;
    CGFloat liftScoreLabelW=61;
    CGFloat liftScoreLabelH=61;
    CGFloat liftScoreLabelX=liftImageViewX+(liftImageViewW-liftScoreLabelW)/2;
    self.liftScoreLabel.frame=CGRectMake(liftScoreLabelX, liftScoreLabelY, liftScoreLabelW, liftScoreLabelH);
    
    
    CGFloat middleScoreLabelY=middleLabelY+middleLabelH+20;
    CGFloat middleScoreLabelW=61;
    CGFloat middleScoreLabelH=61;
    CGFloat middleScoreLabelX=middleImageViewX+(middleImageViewW-middleScoreLabelW)/2;
    self.middleScoreLabel.frame=CGRectMake(middleScoreLabelX, middleScoreLabelY, middleScoreLabelW, middleScoreLabelH);
    
    
    CGFloat rightScoreLabelY=liftScoreLabelY;
    CGFloat rightScoreLabelW=61;
    CGFloat rightScoreLabelH=61;
    CGFloat rightScoreLabelX=rightImageViewX+(rightImageViewW-rightScoreLabelW)/2;
    self.rightScoreLabel.frame=CGRectMake(rightScoreLabelX, rightScoreLabelY, rightScoreLabelW, rightScoreLabelH);
    
    
    
    CGFloat lastScoreLabelY=liftScoreLabelY;
    CGFloat lastScoreLabelW=61;
    CGFloat lastScoreLabelH=61;
    CGFloat lastScoreLabelX=lastImageViewX+(lastImageViewW-lastScoreLabelW)/2;
    self.lastScoreLabel.frame=CGRectMake(lastScoreLabelX, lastScoreLabelY, lastScoreLabelW, lastScoreLabelH);
    
    self.scollView.contentSize=CGSizeMake(0, lastScoreLabelY+lastScoreLabelH+50);
    
}


@end
