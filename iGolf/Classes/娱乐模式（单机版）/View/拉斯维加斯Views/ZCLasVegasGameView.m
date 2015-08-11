//
//  ZCLasVegasGameView.m
//  iGolf
//
//  Created by hh on 15/7/23.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCLasVegasGameView.h"
#import "ZCHeadPortrait.h"
#import "ZCKeyboardView.h"
#import "ZCParKeyboardView.h"
#import "ZCFightTheLandlordModel.h"
#import "ZCOfflinePlayer.h"

@interface ZCLasVegasGameView()<ZCKeyboardViewDelegate,ZCParKeyboardViewDelegate>
@property(nonatomic,weak)UILabel *holeNumber;
@property(nonatomic,weak)UILabel *nameLabel;
@property(nonatomic,weak)UIButton *scoreLabel;
@property(nonatomic,weak)UILabel *promptLabel;
@property(nonatomic,weak)ZCHeadPortrait *liftImageView;
@property(nonatomic,weak)ZCHeadPortrait *middleImageView;
@property(nonatomic,weak)ZCHeadPortrait *rightImageView;
@property(nonatomic,weak)ZCHeadPortrait *lastImageView;
@property(nonatomic,weak)UIButton *liftScoreLabel;
@property(nonatomic,weak)UIButton *middleScoreLabel;
@property(nonatomic,weak)UIButton *rightScoreLabel;
@property(nonatomic,weak)UIButton *lastScoreLabel;
@property(nonatomic,weak)UIImageView *VSImage;

@property(nonatomic,weak)UILabel *liftLabel;
@property(nonatomic,weak)UILabel *middleLabel;
@property(nonatomic,weak)UILabel *rightLabel;
@property(nonatomic,weak)UILabel *lastLabel;


// 1为点击左边的成绩   2为点击中左间的成绩  3 为点击中右边的成绩 4为最右边
@property(nonatomic,assign)int index;

@end

@implementation ZCLasVegasGameView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor redColor];
        [self addControls];
        
    }
    return self;
}


-(void)addControls
{
    UILabel *holeNumber=[[UILabel alloc] init];
    [self addSubview:holeNumber];
    self.holeNumber=holeNumber;
    
    UILabel *nameLabel=[[UILabel alloc] init];
    nameLabel.text=@"标准杆";
    [self addSubview:nameLabel];
    self.nameLabel=nameLabel;
    
    //计分成绩cliclkThescoreButton
    UIButton *scoreLabel=[[UIButton alloc] init];
    scoreLabel.backgroundColor=[UIColor redColor];
    
    [scoreLabel setTitle:@"-" forState:UIControlStateNormal];
    [scoreLabel addTarget:self action:@selector(cliclkThescoreButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:scoreLabel];
    self.scoreLabel=scoreLabel;
    
    
    // 显示提示语
    UILabel *promptLabel=[[UILabel alloc] init];
    promptLabel.text=@"上3洞打平均数累计本洞获胜方将获得4洞的分数";
    //自动折行设置
   // promptLabel.lineBreakMode = UILineBreakModeWordWrap;
    promptLabel.numberOfLines = 0;
    [self addSubview:promptLabel];
    self.promptLabel=promptLabel;
    
    
    ZCHeadPortrait *liftImageView=[[ZCHeadPortrait alloc] init];
    liftImageView.backgroundColor=[UIColor yellowColor];
    [self addSubview:liftImageView];
    self.liftImageView=liftImageView;
    
    
    ZCHeadPortrait *middleImageView=[[ZCHeadPortrait alloc] init];
    middleImageView.backgroundColor=[UIColor yellowColor];
    [self addSubview:middleImageView];
    self.middleImageView=middleImageView;
    
    ZCHeadPortrait *rightImageView=[[ZCHeadPortrait alloc] init];
    rightImageView.backgroundColor=[UIColor yellowColor];
    [self addSubview:rightImageView];
    self.rightImageView=rightImageView;
    
    ZCHeadPortrait *lastImageView=[[ZCHeadPortrait alloc] init];
    lastImageView.backgroundColor=[UIColor yellowColor];
    [self addSubview:lastImageView];
    self.lastImageView=lastImageView;
    
    
    
    UILabel *liftLabel=[[UILabel alloc] init];
    //liftLabel.text=@"+5";
    [self addSubview:liftLabel];
    self.liftLabel=liftLabel;
    
    UILabel *middleLabel=[[UILabel alloc] init];
    // middleLabel.text=@"+5";
    [self addSubview:middleLabel];
    self.middleLabel=middleLabel;
    
    UILabel *rightLabel=[[UILabel alloc] init];
    // rightLabel.text=@"+5";
    [self addSubview:rightLabel];
    self.rightLabel=rightLabel;
    
    
    UILabel *lastLabel=[[UILabel alloc] init];
    // rightLabel.text=@"+5";
    [self addSubview:lastLabel];
    self.lastLabel=lastLabel;
    
    
    UIButton *liftScoreLabel=[[UIButton alloc] init];
    liftScoreLabel.backgroundColor=[UIColor redColor];
    liftScoreLabel.tag=23300;
    [liftScoreLabel setTitle:@"-" forState:UIControlStateNormal];
    [liftScoreLabel addTarget:self action:@selector(cliclkTheScoreLabel:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:liftScoreLabel];
    self.liftScoreLabel=liftScoreLabel;
    
    
    UIButton *middleScoreLabel=[[UIButton alloc] init];
    middleScoreLabel.backgroundColor=[UIColor redColor];
    middleScoreLabel.tag=23301;
    [middleScoreLabel setTitle:@"-" forState:UIControlStateNormal];
    [middleScoreLabel addTarget:self action:@selector(cliclkTheScoreLabel:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:middleScoreLabel];
    self.middleScoreLabel=middleScoreLabel;
    
    
    UIButton *rightScoreLabel=[[UIButton alloc] init];
    rightScoreLabel.backgroundColor=[UIColor redColor];
    rightScoreLabel.tag=23302;
    [rightScoreLabel setTitle:@"-" forState:UIControlStateNormal];
    [rightScoreLabel addTarget:self action:@selector(cliclkTheScoreLabel:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightScoreLabel];
    self.rightScoreLabel=rightScoreLabel;
    
    
    UIButton *lastScoreLabel=[[UIButton alloc] init];
    lastScoreLabel.backgroundColor=[UIColor redColor];
    lastScoreLabel.tag=23303;
    [lastScoreLabel setTitle:@"-" forState:UIControlStateNormal];
    [lastScoreLabel addTarget:self action:@selector(cliclkTheScoreLabel:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:lastScoreLabel];
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
    
    ZCParKeyboardView *ParKeyboardView=[[ZCParKeyboardView alloc] init];
    ParKeyboardView.frame=[UIScreen mainScreen].bounds;
    ParKeyboardView.delegate=self;
    UIWindow *wd = [[UIApplication sharedApplication].delegate window];
    [wd addSubview:ParKeyboardView];
    
}


//点击了个人成绩
-(void)cliclkTheScoreLabel:(UIButton *)btn
{
    if (btn.tag==23300) {
        self.index=1;
    }else if (btn.tag==23301)
    {
        self.index=2;
    }else if (btn.tag==23302){
       self.index=3;
    }else
    {
        self.index=4;
    }
    
    ZCKeyboardView *keyboardView=[[ZCKeyboardView alloc] init];
    keyboardView.frame=[UIScreen mainScreen].bounds;
    keyboardView.delegate=self;
    UIWindow *wd = [[UIApplication sharedApplication].delegate window];
    [wd addSubview:keyboardView];
    
}


//par的键盘代理方法
-(void)ParKeyboardViewConfirmThatTheInput:(NSString *)number
{
    int intNum=[number intValue];
    //int holeNumber=[self.number intValue];
    self.lasVegasModel.par=intNum;
//    if ([self.delegate respondsToSelector:@selector(doudizhuGameViewDelegateForScore:andForHoleNumber:)]) {
//        [self.delegate doudizhuGameViewDelegateForScore:self.fightTheLandlordModel andForHoleNumber:holeNumber];
//    }
    
    [self.scoreLabel setTitle:number forState:UIControlStateNormal];
}



//输入键盘代理方法
-(void)keyboardViewConfirmThatTheInput:(NSString *)number{
    
    
    int intNum=[number intValue];
    //int holeNumber=[self.number intValue];
    
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
    
    
    
//    if ([self.delegate respondsToSelector:@selector(doudizhuGameViewDelegateForScore:andForHoleNumber:)]) {
//        [self.delegate doudizhuGameViewDelegateForScore:self.fightTheLandlordModel andForHoleNumber:holeNumber];
//    }
    
    
    
}

-(void)setLasVegasModel:(ZCFightTheLandlordModel *)lasVegasModel
{
    _lasVegasModel=lasVegasModel;

    [self.scoreLabel setTitle:[NSString stringWithFormat:@"%d",lasVegasModel.par] forState:UIControlStateNormal];
    
    
    self.liftImageView.offlinePlayer=lasVegasModel.plays[0];
    self.middleImageView.offlinePlayer=lasVegasModel.plays[1];
    self.rightImageView.offlinePlayer=lasVegasModel.plays[2];
    self.lastImageView.offlinePlayer=lasVegasModel.plays[3];
    
    
    
    ZCOfflinePlayer *offPlayer1=lasVegasModel.plays[0];
    ZCOfflinePlayer *offPlayer2=lasVegasModel.plays[1];
    ZCOfflinePlayer *offPlayer3=lasVegasModel.plays[2];
    ZCOfflinePlayer *offPlayer4=lasVegasModel.plays[3];
    
    [self.liftScoreLabel setTitle:[NSString stringWithFormat:@"%ld",offPlayer1.stroke] forState:UIControlStateNormal];
    
    [self.middleScoreLabel setTitle:[NSString stringWithFormat:@"%ld",offPlayer2.stroke] forState:UIControlStateNormal];
    
    [self.rightScoreLabel setTitle:[NSString stringWithFormat:@"%ld",offPlayer3.stroke] forState:UIControlStateNormal];
    
    [self.lastScoreLabel setTitle:[NSString stringWithFormat:@"%ld",offPlayer4.stroke] forState:UIControlStateNormal];
    
    
    
    self.liftLabel.text=[NSString stringWithFormat:@"%ld",(long)[lasVegasModel.plays[0] winScore]];
    self.middleLabel.text=[NSString stringWithFormat:@"%ld",(long)[lasVegasModel.plays[1] winScore]];
    self.rightLabel.text=[NSString stringWithFormat:@"%ld",(long)[lasVegasModel.plays[2] winScore]];
    self.lastLabel.text=[NSString stringWithFormat:@"%ld",(long)[lasVegasModel.plays[3] winScore]];
    
    
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat holeNumberX=30;
    CGFloat holeNumberY=10;
    CGFloat holeNumberW=100;
    CGFloat holeNumberH=20;
    self.holeNumber.frame=CGRectMake(holeNumberX, holeNumberY, holeNumberW, holeNumberH);
    
    CGFloat nameLabelW=60;
    CGFloat nameLabelH=20;
    CGFloat nameLabelX=(SCREEN_WIDTH-nameLabelW)/2;
    CGFloat nameLabelY=10;
    self.nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    
    CGFloat scoreLabelW=40;
    CGFloat scoreLabelH=40;
    CGFloat scoreLabelX=(SCREEN_WIDTH-scoreLabelW)/2;
    CGFloat scoreLabelY=nameLabelY+nameLabelH+20;
    self.scoreLabel.frame=CGRectMake(scoreLabelX, scoreLabelY, scoreLabelW, scoreLabelH);
    
    CGFloat promptLabelX=40;
    CGFloat promptLabelY=scoreLabelY+scoreLabelH+10;
    CGFloat promptLabelW=SCREEN_WIDTH-2*promptLabelX;
    CGFloat promptLabelH=[ZCTool getFrame:CGSizeMake(promptLabelW, 2000) content:self.promptLabel.text fontSize:[UIFont systemFontOfSize:18]].size.height;
    self.promptLabel.frame=CGRectMake(promptLabelX, promptLabelY, promptLabelW, promptLabelH);
    
    
    
    CGFloat liftImageViewX=10;
    CGFloat liftImageViewY=promptLabelY+promptLabelH+30;
    CGFloat liftImageViewW=(SCREEN_WIDTH-80)/4;
    CGFloat liftImageViewH=100;
    self.liftImageView.frame=CGRectMake(liftImageViewX, liftImageViewY, liftImageViewW, liftImageViewH);
    
    
    
    
    CGFloat middleImageViewY=liftImageViewY;
    CGFloat middleImageViewW=liftImageViewW;
    CGFloat middleImageViewH=100;
    CGFloat middleImageViewX=(SCREEN_WIDTH-middleImageViewW*3-60);
    self.middleImageView.frame=CGRectMake(middleImageViewX, middleImageViewY, middleImageViewW, middleImageViewH);
    
    
    CGFloat rightImageViewY=liftImageViewY;
    CGFloat rightImageViewW=liftImageViewW;
    CGFloat rightImageViewH=liftImageViewH;
    CGFloat rightImageViewX=SCREEN_WIDTH-rightImageViewW*2-20;
    self.rightImageView.frame=CGRectMake(rightImageViewX, rightImageViewY, rightImageViewW, rightImageViewH);
    
    CGFloat lastImageViewY=liftImageViewY;
    CGFloat lastImageViewW=liftImageViewW;
    CGFloat lastImageViewH=liftImageViewH;
    CGFloat lastImageViewX=SCREEN_WIDTH-rightImageViewW-10;
    self.lastImageView.frame=CGRectMake(lastImageViewX, lastImageViewY, lastImageViewW, lastImageViewH);
    
    
    
    CGFloat  liftLabelX=liftImageViewX;
    CGFloat  liftLabelY=liftImageViewY+liftImageViewH+10;
    CGFloat  liftLabelW=liftImageViewW;
    CGFloat  liftLabelH=20;
    self.liftLabel.frame=CGRectMake(liftLabelX, liftLabelY, liftLabelW, liftLabelH);
    
    
    CGFloat  middleLabelX=middleImageViewX;
    CGFloat  middleLabelY=liftImageViewY+liftImageViewH+10;
    CGFloat  middleLabelW=liftImageViewW;
    CGFloat  middleLabelH=20;
    self.middleLabel.frame=CGRectMake(middleLabelX, middleLabelY, middleLabelW, middleLabelH);
    
    CGFloat  rightLabelX=rightImageViewX;
    CGFloat  rightLabelY=liftImageViewY+liftImageViewH+10;
    CGFloat  rightLabelW=liftImageViewW;
    CGFloat  rightLabelH=20;
    self.rightLabel.frame=CGRectMake(rightLabelX, rightLabelY, rightLabelW, rightLabelH);
    
    CGFloat  lastLabelX=lastImageViewX;
    CGFloat  lastLabelY=liftImageViewY+liftImageViewH+10;
    CGFloat  lastLabelW=liftImageViewW;
    CGFloat  lastLabelH=20;
    self.lastLabel.frame=CGRectMake(lastLabelX, lastLabelY, lastLabelW, lastLabelH);
    
    
    
    CGFloat liftScoreLabelX=liftImageViewX;
    CGFloat liftScoreLabelY=liftImageViewY+liftImageViewH+30;
    CGFloat liftScoreLabelW=liftImageViewW;
    CGFloat liftScoreLabelH=liftImageViewW;
    self.liftScoreLabel.frame=CGRectMake(liftScoreLabelX, liftScoreLabelY, liftScoreLabelW, liftScoreLabelH);
    
    
    CGFloat middleScoreLabelX=middleImageViewX;
    CGFloat middleScoreLabelY=middleImageViewY+middleImageViewH+30;
    CGFloat middleScoreLabelW=liftImageViewW;
    CGFloat middleScoreLabelH=liftImageViewW;
    self.middleScoreLabel.frame=CGRectMake(middleScoreLabelX, middleScoreLabelY, middleScoreLabelW, middleScoreLabelH);
    
    
    CGFloat rightScoreLabelX=rightImageViewX;
    CGFloat rightScoreLabelY=rightImageViewY+liftImageViewH+30;
    CGFloat rightScoreLabelW=liftImageViewW;
    CGFloat rightScoreLabelH=liftImageViewW;
    self.rightScoreLabel.frame=CGRectMake(rightScoreLabelX, rightScoreLabelY, rightScoreLabelW, rightScoreLabelH);
    
    
    CGFloat lastScoreLabelX=lastImageViewX;
    CGFloat lastScoreLabelY=rightImageViewY+liftImageViewH+30;
    CGFloat lastScoreLabelW=liftImageViewW;
    CGFloat lastScoreLabelH=liftImageViewW;
    self.lastScoreLabel.frame=CGRectMake(lastScoreLabelX, lastScoreLabelY, lastScoreLabelW, lastScoreLabelH);
    
}


@end
