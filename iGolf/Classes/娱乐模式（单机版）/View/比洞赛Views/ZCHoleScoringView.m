//
//  ZCHoleScoringView.m
//  iGolf
//
//  Created by hh on 15/7/22.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCHoleScoringView.h"
#import "ZCHeadPortrait.h"
#import "ZCKeyboardView.h"
#import "ZCParKeyboardView.h"
#import "ZCHoleModel.h"
@interface ZCHoleScoringView()<ZCKeyboardViewDelegate,ZCParKeyboardViewDelegate>
@property(nonatomic,weak)UIScrollView *scollView;
@property(nonatomic,weak)UILabel *holeNumber;
@property(nonatomic,weak)UILabel *nameLabel;
@property(nonatomic,weak)UIButton *scoreLabel;
@property(nonatomic,weak)UILabel *promptLabel;
@property(nonatomic,weak)ZCHeadPortrait *liftImageView;
@property(nonatomic,weak)ZCHeadPortrait *rightImageView;
@property(nonatomic,weak)UIButton *liftScoreLabel;
@property(nonatomic,weak)UIButton *rightScoreLabel;
@property(nonatomic,strong)ZCHoleModel *holeModel;
@property(nonatomic,weak)UILabel *liftLabel;
@property(nonatomic,weak)UILabel *rightLabel;
//判断是点击哪个按钮 1为左边 2为右边
@property(nonatomic,assign)int index;


//标准杆
@property(nonatomic,assign)int par;
//本机主的成绩
@property(nonatomic,assign)int userScore;
//添加人的成绩
@property(nonatomic,assign)int otherScore;




@end
@implementation ZCHoleScoringView


-(ZCHoleModel *)holeModel{

    if (_holeModel==nil) {
        _holeModel=[[ZCHoleModel alloc] init];
    }
    return _holeModel;
}

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
    
    //计分成绩
    UIButton *scoreLabel=[[UIButton alloc] init];
    scoreLabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"ganshuluru"]];
    [scoreLabel setTitle:@"-" forState:UIControlStateNormal];
    scoreLabel.titleLabel.font=[UIFont systemFontOfSize:25];
//    scoreLabel.textColor=[UIColor whiteColor];
    [scollView addSubview:scoreLabel];
    self.scoreLabel=scoreLabel;
    [scoreLabel addTarget:self action:@selector(cliclkThescoreLabel) forControlEvents:UIControlEventTouchUpInside];
    
    // 显示提示语
    UILabel *promptLabel=[[UILabel alloc] init];
    promptLabel.hidden=YES;
    promptLabel.text=@"上3洞打平均数累计本洞获胜方将获得4洞的分数";
    //自动折行设置
   // promptLabel.lineBreakMode = UILineBreakModeWordWrap;
    promptLabel.numberOfLines = 0;
    [scollView addSubview:promptLabel];
    self.promptLabel=promptLabel;
    
    
    ZCHeadPortrait *liftImageView=[[ZCHeadPortrait alloc] init];
    liftImageView.indexColor=1;
    [scollView addSubview:liftImageView];
    self.liftImageView=liftImageView;
    
    
    ZCHeadPortrait *rightImageView=[[ZCHeadPortrait alloc] init];
    rightImageView.indexColor=2;
    [scollView addSubview:rightImageView];
    self.rightImageView=rightImageView;
    
    
    
    UILabel *liftLabel=[[UILabel alloc] init];
    liftLabel.textAlignment=NSTextAlignmentCenter;
    [scollView addSubview:liftLabel];
    self.liftLabel=liftLabel;
    
    
    UILabel *rightLabel=[[UILabel alloc] init];
    rightLabel.textAlignment=NSTextAlignmentCenter;
    [scollView addSubview:rightLabel];
    self.rightLabel=rightLabel;
    
    
    UIButton *liftScoreLabel=[[UIButton alloc] init];
    
    
    liftScoreLabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"ganshuluru"]];
    [liftScoreLabel setTitle:@"-" forState:UIControlStateNormal];
    liftScoreLabel.titleLabel.font=[UIFont systemFontOfSize:25];

    [liftScoreLabel addTarget:self action:@selector(cliclkTheScore:) forControlEvents:UIControlEventTouchUpInside];
    liftScoreLabel.tag=23001;
    [scollView addSubview:liftScoreLabel];
    self.liftScoreLabel=liftScoreLabel;
    
    
    UIButton *rightScoreLabel=[[UIButton alloc] init];
    rightScoreLabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"ganshuluru"]];
    [rightScoreLabel setTitle:@"-" forState:UIControlStateNormal];
    rightScoreLabel.titleLabel.font=[UIFont systemFontOfSize:25];

    rightScoreLabel.tag=23002;
    
    [rightScoreLabel addTarget:self action:@selector(cliclkTheScore:) forControlEvents:UIControlEventTouchUpInside];
    [scollView addSubview:rightScoreLabel];
    self.rightScoreLabel=rightScoreLabel;
    
    //[self layoutIfNeeded];

}

-(void)cliclkThescoreLabel
{

    ZCParKeyboardView *ParKeyboardView=[[ZCParKeyboardView alloc] init];
    ParKeyboardView.frame=[UIScreen mainScreen].bounds;
    ParKeyboardView.delegate=self;
    UIWindow *wd = [[UIApplication sharedApplication].delegate window];
    [wd addSubview:ParKeyboardView];
    
}

//par的键盘代理方法
-(void)ParKeyboardViewConfirmThatTheInput:(NSString *)number
{
    int intNum=[number intValue];
    self.fightTheLandlordModel.par=intNum;
    if ([self.delegate respondsToSelector:@selector(holeScoringViewForScore:)]) {
        [self.delegate holeScoringViewForScore:self.holeModel];
    }

    [self.scoreLabel setTitle:number forState:UIControlStateNormal];
}


//输入键盘代理方法
-(void)keyboardViewConfirmThatTheInput:(NSString *)number{

   

    int intNum=[number intValue];
    self.holeModel.holeNumber=[self.number intValue]+1;

    if (self.index==1) {
        [self.liftScoreLabel setTitle:number forState:UIControlStateNormal];
        ZCOfflinePlayer *player=  self.fightTheLandlordModel.plays[0];
        player.stroke=intNum;
       
    }else
    {
    [self.rightScoreLabel setTitle:number forState:UIControlStateNormal];
        ZCOfflinePlayer *player=  self.fightTheLandlordModel.plays[1];
        player.stroke=intNum;
    }
    
    
    
        if ([self.delegate respondsToSelector:@selector(holeScoringViewForScore:)]) {
            [self.delegate holeScoringViewForScore:self.holeModel];
        }

    
    
}



-(void)cliclkTheScore:(UIButton *)btn
{
    ZCOfflinePlayer *player;
    int colorIndex;
    if (btn.tag==23001) {
        self.index=1;
        ZCOfflinePlayer *player1=  self.fightTheLandlordModel.plays[0];
        player=player1;
        colorIndex=1;
        
    }else
    {
        self.index=2;
        ZCOfflinePlayer *player1=  self.fightTheLandlordModel.plays[1];
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

-(void)setNumber:(NSString *)number

{
    _number=number;
    
    self.holeNumber.text=[NSString stringWithFormat:@"球洞%@",number];
}


////本机成绩
//-(void)setUserWinPoints:(int)userWinPoints
//{
//
//    userWinPoints=userWinPoints;
//    
//    self.liftImageView.score=userWinPoints;
//}

////其他人成绩
//-(void)setOtherWinPoints:(int)otherWinPoints
//{
//    _otherWinPoints=otherWinPoints;
//    self.rightImageView.score=otherWinPoints;
//
//}


-(void)setFightTheLandlordModel:(ZCFightTheLandlordModel *)fightTheLandlordModel
{
    _fightTheLandlordModel=fightTheLandlordModel;
    if (fightTheLandlordModel.par==0) {
        [self.scoreLabel setTitle:@"-" forState:UIControlStateNormal];
    }else{
        
        [self.scoreLabel setTitle:[NSString stringWithFormat:@"%d",fightTheLandlordModel.par] forState:UIControlStateNormal];
    }

    
    ZCOfflinePlayer *offPlayer1=fightTheLandlordModel.plays[0];
    ZCOfflinePlayer *offPlayer2=fightTheLandlordModel.plays[1];
    
    self.liftImageView.offlinePlayer=offPlayer1;
    self.rightImageView.offlinePlayer=offPlayer2;


    if (offPlayer1.stroke==0) {
        [self.liftScoreLabel setTitle:@"-" forState:UIControlStateNormal];
    }else{
    [self.liftScoreLabel setTitle:[NSString stringWithFormat:@"%ld",offPlayer1.stroke] forState:UIControlStateNormal];
    }
    
    if (offPlayer2.stroke==0) {
        [self.rightScoreLabel setTitle:@"-" forState:UIControlStateNormal];
    }else{
    [self.rightScoreLabel setTitle:[NSString stringWithFormat:@"%ld",offPlayer2.stroke] forState:UIControlStateNormal];
    }
    

    self.liftLabel.text=[NSString stringWithFormat:@"%ld",offPlayer1.winScore];
   
    self.rightLabel.text=[NSString stringWithFormat:@"%ld",offPlayer2.winScore];
    
}

-(void)setIsNext:(int)isNext
{
    if (isNext==0) {
        self.promptLabel.hidden=YES;
    }else
    {
        self.promptLabel.hidden=NO;
        self.promptLabel.text=[NSString stringWithFormat:@"上%d洞打平，本洞获胜方将获得%d洞成绩",isNext,isNext];
    }

}

-(void)setClues:(NSString *)clues
{
   self.promptLabel.hidden=NO;
   self.promptLabel.text=clues;
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
    
    CGFloat promptLabelX=40;
    CGFloat promptLabelY=scoreLabelY+scoreLabelH+20;
    CGFloat promptLabelW=SCREEN_WIDTH-2*promptLabelX;
    CGFloat promptLabelH=[ZCTool getFrame:CGSizeMake(promptLabelW, 2000) content:self.promptLabel.text fontSize:[UIFont systemFontOfSize:18]].size.height;
    self.promptLabel.frame=CGRectMake(promptLabelX, promptLabelY, promptLabelW, promptLabelH);
    
    
    
    CGFloat liftImageViewX=15;
    CGFloat liftImageViewY=promptLabelY+promptLabelH+30;
    CGFloat liftImageViewW=115;
    CGFloat liftImageViewH=150;
    self.liftImageView.frame=CGRectMake(liftImageViewX, liftImageViewY, liftImageViewW, liftImageViewH);
    
    
    CGFloat rightImageViewY=liftImageViewY;
    CGFloat rightImageViewW=liftImageViewW;
    CGFloat rightImageViewH=liftImageViewH;
    CGFloat rightImageViewX=SCREEN_WIDTH-rightImageViewW-15;
    self.rightImageView.frame=CGRectMake(rightImageViewX, rightImageViewY, rightImageViewW, rightImageViewH);
    
    CGFloat  liftLabelX=liftImageViewX;
    CGFloat  liftLabelY=liftImageViewY+liftImageViewH+10;
    CGFloat  liftLabelW=liftImageViewW;
    CGFloat  liftLabelH=15;
    self.liftLabel.frame=CGRectMake(liftLabelX, liftLabelY, liftLabelW, liftLabelH);
    
    
    CGFloat  rightLabelX=rightImageViewX;
    CGFloat  rightLabelY=liftImageViewY+liftImageViewH+10;
    CGFloat  rightLabelW=liftImageViewW;
    CGFloat  rightLabelH=15;
    self.rightLabel.frame=CGRectMake(rightLabelX, rightLabelY, rightLabelW, rightLabelH);
    
    
    
    CGFloat liftScoreLabelY=liftLabelY+liftLabelH+20;
    CGFloat liftScoreLabelW=61;
    CGFloat liftScoreLabelH=61;
    CGFloat liftScoreLabelX=liftImageViewX+(liftImageViewW-liftScoreLabelW)/2;
    self.liftScoreLabel.frame=CGRectMake(liftScoreLabelX, liftScoreLabelY, liftScoreLabelW, liftScoreLabelH);
    
    
    
    CGFloat rightScoreLabelY=liftScoreLabelY;
    CGFloat rightScoreLabelW=61;
    CGFloat rightScoreLabelH=61;
    CGFloat rightScoreLabelX=rightImageViewX+(rightImageViewW-rightScoreLabelW)/2;
    self.rightScoreLabel.frame=CGRectMake(rightScoreLabelX, rightScoreLabelY, rightScoreLabelW, rightScoreLabelH);

    self.scollView.contentSize=CGSizeMake(0, rightScoreLabelY+rightScoreLabelH+50);
}


@end
