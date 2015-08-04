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
@interface ZCDoudizhuGameView()<ZCKeyboardViewDelegate,ZCParKeyboardViewDelegate>
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
    
    //计分成绩
    UIButton *scoreButton=[[UIButton alloc] init];
    scoreButton.backgroundColor=[UIColor redColor];
    [scoreButton setTitle:@"-" forState:UIControlStateNormal];
    [scoreButton addTarget:self action:@selector(cliclkThescoreButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:scoreButton];
    self.scoreButton=scoreButton;
    
    
    // 显示提示语
    UILabel *promptLabel=[[UILabel alloc] init];
    promptLabel.hidden=YES;
    promptLabel.text=@"上3洞打平均数累计本洞获胜方将获得4洞的分数";
    //自动折行设置
    //promptLabel.lineBreakMode = UILineBreakModeWordWrap;
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
    
    
    
    UIButton *liftScoreLabel=[[UIButton alloc] init];
    liftScoreLabel.tag=23100;
    liftScoreLabel.backgroundColor=[UIColor redColor];
    [liftScoreLabel setTitle:@"-" forState:UIControlStateNormal];
    [liftScoreLabel addTarget:self action:@selector(cliclkTheScoreLabel:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:liftScoreLabel];
    self.liftScoreLabel=liftScoreLabel;
    
    
    UIButton *middleScoreLabel=[[UIButton alloc] init];
    middleScoreLabel.tag=23101;
    middleScoreLabel.backgroundColor=[UIColor redColor];
    [middleScoreLabel setTitle:@"-" forState:UIControlStateNormal];
    [middleScoreLabel addTarget:self action:@selector(cliclkTheScoreLabel:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:middleScoreLabel];
    self.middleScoreLabel=middleScoreLabel;
    
    
    UIButton *rightScoreLabel=[[UIButton alloc] init];
    rightScoreLabel.tag=23102;
    rightScoreLabel.backgroundColor=[UIColor redColor];
    [rightScoreLabel setTitle:@"-" forState:UIControlStateNormal];
    [rightScoreLabel addTarget:self action:@selector(cliclkTheScoreLabel:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightScoreLabel];
    self.rightScoreLabel=rightScoreLabel;
    
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


//par的键盘代理方法
-(void)ParKeyboardViewConfirmThatTheInput:(NSString *)number
{
    int intNum=[number intValue];
    int holeNumber=[self.number intValue];
    self.fightTheLandlordModel.par=intNum;
    if ([self.delegate respondsToSelector:@selector(doudizhuGameViewDelegateForScore:andForHoleNumber:)]) {
        [self.delegate doudizhuGameViewDelegateForScore:self.fightTheLandlordModel andForHoleNumber:holeNumber];
    }
    
    [self.scoreButton setTitle:number forState:UIControlStateNormal];
}



//输入键盘代理方法
-(void)keyboardViewConfirmThatTheInput:(NSString *)number{
    
    
    int intNum=[number intValue];
   int holeNumber=[self.number intValue];
    
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
    
    
    
    if ([self.delegate respondsToSelector:@selector(doudizhuGameViewDelegateForScore:andForHoleNumber:)]) {
        [self.delegate doudizhuGameViewDelegateForScore:self.fightTheLandlordModel andForHoleNumber:holeNumber];
    }
    
    
    
}

//set方法
-(void)setFightTheLandlordModel:(ZCFightTheLandlordModel *)fightTheLandlordModel
{
    _fightTheLandlordModel=fightTheLandlordModel;
    ZCLog(@"%d",fightTheLandlordModel.par);
    [self.scoreButton setTitle:[NSString stringWithFormat:@"%d",fightTheLandlordModel.par] forState:UIControlStateNormal];
    
    self.liftImageView.offlinePlayer=fightTheLandlordModel.plays[0];
    self.middleImageView.offlinePlayer=fightTheLandlordModel.plays[1];
    self.rightImageView.offlinePlayer=fightTheLandlordModel.plays[2];
    
    
    
    self.liftLabel.text=[NSString stringWithFormat:@"%ld",(long)[fightTheLandlordModel.plays[0] winScore]];
    self.middleLabel.text=[NSString stringWithFormat:@"%ld",(long)[fightTheLandlordModel.plays[1] winScore]];
    self.rightLabel.text=[NSString stringWithFormat:@"%ld",(long)[fightTheLandlordModel.plays[2] winScore]];
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





//点击了个人成绩
-(void)cliclkTheScoreLabel:(UIButton *)btn
{
    if (btn.tag==23100) {
        self.index=1;
    }else if (btn.tag==23101)
    {
        self.index=2;
    }else
    {
        self.index=3;
    }
    
    ZCKeyboardView *keyboardView=[[ZCKeyboardView alloc] init];
    keyboardView.frame=[UIScreen mainScreen].bounds;
    keyboardView.delegate=self;
    UIWindow *wd = [[UIApplication sharedApplication].delegate window];
    [wd addSubview:keyboardView];

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
    self.scoreButton.frame=CGRectMake(scoreLabelX, scoreLabelY, scoreLabelW, scoreLabelH);
    
    CGFloat promptLabelX=40;
    CGFloat promptLabelY=scoreLabelY+scoreLabelH+10;
    CGFloat promptLabelW=SCREEN_WIDTH-2*promptLabelX;
    CGFloat promptLabelH=[ZCTool getFrame:CGSizeMake(promptLabelW, 2000) content:self.promptLabel.text fontSize:[UIFont systemFontOfSize:18]].size.height;
    self.promptLabel.frame=CGRectMake(promptLabelX, promptLabelY, promptLabelW, promptLabelH);
    
    
    
    CGFloat liftImageViewX=20;
    CGFloat liftImageViewY=promptLabelY+promptLabelH+30;
    CGFloat liftImageViewW=60;
    CGFloat liftImageViewH=100;
    self.liftImageView.frame=CGRectMake(liftImageViewX, liftImageViewY, liftImageViewW, liftImageViewH);
    
    
    
    
    CGFloat middleImageViewY=liftImageViewY;
    CGFloat middleImageViewW=60;
    CGFloat middleImageViewH=100;
    CGFloat middleImageViewX=(SCREEN_WIDTH-middleImageViewW)/2;
    self.middleImageView.frame=CGRectMake(middleImageViewX, middleImageViewY, middleImageViewW, middleImageViewH);
    
    
    CGFloat rightImageViewY=liftImageViewY;
    CGFloat rightImageViewW=liftImageViewW;
    CGFloat rightImageViewH=liftImageViewH;
    CGFloat rightImageViewX=SCREEN_WIDTH-rightImageViewW-20;
    self.rightImageView.frame=CGRectMake(rightImageViewX, rightImageViewY, rightImageViewW, rightImageViewH);
    
    
    
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
    
    
    CGFloat liftScoreLabelX=liftImageViewX;
    CGFloat liftScoreLabelY=liftImageViewY+liftImageViewH+40;
    CGFloat liftScoreLabelW=liftImageViewW;
    CGFloat liftScoreLabelH=liftImageViewW;
    self.liftScoreLabel.frame=CGRectMake(liftScoreLabelX, liftScoreLabelY, liftScoreLabelW, liftScoreLabelH);
    
    
    CGFloat middleScoreLabelX=middleImageViewX;
    CGFloat middleScoreLabelY=middleImageViewY+middleImageViewH+40;
    CGFloat middleScoreLabelW=liftImageViewW;
    CGFloat middleScoreLabelH=liftImageViewW;
    self.middleScoreLabel.frame=CGRectMake(middleScoreLabelX, middleScoreLabelY, middleScoreLabelW, middleScoreLabelH);
    
    
    CGFloat rightScoreLabelX=rightImageViewX;
    CGFloat rightScoreLabelY=rightImageViewY+liftImageViewH+40;
    CGFloat rightScoreLabelW=liftImageViewW;
    CGFloat rightScoreLabelH=liftImageViewW;
    self.rightScoreLabel.frame=CGRectMake(rightScoreLabelX, rightScoreLabelY, rightScoreLabelW, rightScoreLabelH);
    
}



@end
