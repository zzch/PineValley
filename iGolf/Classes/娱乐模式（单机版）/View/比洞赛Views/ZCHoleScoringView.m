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
@property(nonatomic,weak)UILabel *holeNumber;
@property(nonatomic,weak)UILabel *nameLabel;
@property(nonatomic,weak)UIButton *scoreLabel;
@property(nonatomic,weak)UILabel *promptLabel;
@property(nonatomic,weak)ZCHeadPortrait *liftImageView;
@property(nonatomic,weak)ZCHeadPortrait *rightImageView;
@property(nonatomic,weak)UIButton *liftScoreLabel;
@property(nonatomic,weak)UIButton *rightScoreLabel;
@property(nonatomic,strong)ZCHoleModel *holeModel;

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
    UIButton *scoreLabel=[[UIButton alloc] init];
    scoreLabel.backgroundColor=[UIColor redColor];
    [scoreLabel setTitle:@"-" forState:UIControlStateNormal];
   // scoreLabel.textColor=[UIColor whiteColor];
    [self addSubview:scoreLabel];
    self.scoreLabel=scoreLabel;
    [scoreLabel addTarget:self action:@selector(cliclkThescoreLabel) forControlEvents:UIControlEventTouchUpInside];
    
    // 显示提示语
    UILabel *promptLabel=[[UILabel alloc] init];
    promptLabel.hidden=YES;
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
    
    
    ZCHeadPortrait *rightImageView=[[ZCHeadPortrait alloc] init];
    rightImageView.backgroundColor=[UIColor yellowColor];
    [self addSubview:rightImageView];
    self.rightImageView=rightImageView;
    
    
    UIButton *liftScoreLabel=[[UIButton alloc] init];
    liftScoreLabel.backgroundColor=[UIColor redColor];
    [liftScoreLabel setTitle:@"-" forState:UIControlStateNormal];
    [liftScoreLabel addTarget:self action:@selector(cliclkTheScore:) forControlEvents:UIControlEventTouchUpInside];
    liftScoreLabel.tag=23001;
    [self addSubview:liftScoreLabel];
    self.liftScoreLabel=liftScoreLabel;
    
    
    UIButton *rightScoreLabel=[[UIButton alloc] init];
    rightScoreLabel.tag=23002;
    rightScoreLabel.backgroundColor=[UIColor redColor];
    [rightScoreLabel setTitle:@"-" forState:UIControlStateNormal];
    [rightScoreLabel addTarget:self action:@selector(cliclkTheScore:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightScoreLabel];
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
    self.holeModel.par=intNum;
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
        self.holeModel.userScore=intNum;
    }else
    {
    [self.rightScoreLabel setTitle:number forState:UIControlStateNormal];
     self.holeModel.otherScore=intNum;
    }
    
    
    
        if ([self.delegate respondsToSelector:@selector(holeScoringViewForScore:)]) {
            [self.delegate holeScoringViewForScore:self.holeModel];
        }

    
    
}



-(void)cliclkTheScore:(UIButton *)btn
{
    if (btn.tag==23001) {
        self.index=1;
    }else
    {
    self.index=2;
    }
    ZCKeyboardView *keyboardView=[[ZCKeyboardView alloc] init];
    keyboardView.frame=[UIScreen mainScreen].bounds;
    keyboardView.delegate=self;
    UIWindow *wd = [[UIApplication sharedApplication].delegate window];
    [wd addSubview:keyboardView];
    
   

}

-(void)setNumber:(NSString *)number

{
    _number=number;
    
    self.holeNumber.text=[NSString stringWithFormat:@"球洞%@",number];
}


//本机成绩
-(void)setUserWinPoints:(int)userWinPoints
{

    userWinPoints=userWinPoints;
    
    self.liftImageView.score=userWinPoints;
}

//其他人成绩
-(void)setOtherWinPoints:(int)otherWinPoints
{
    _otherWinPoints=otherWinPoints;
    self.rightImageView.score=otherWinPoints;

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
    
    
    
    CGFloat liftImageViewX=20;
    CGFloat liftImageViewY=promptLabelY+promptLabelH+30;
    CGFloat liftImageViewW=60;
    CGFloat liftImageViewH=100;
    self.liftImageView.frame=CGRectMake(liftImageViewX, liftImageViewY, liftImageViewW, liftImageViewH);
    
    
    CGFloat rightImageViewY=liftImageViewY;
    CGFloat rightImageViewW=liftImageViewW;
    CGFloat rightImageViewH=liftImageViewH;
    CGFloat rightImageViewX=SCREEN_WIDTH-rightImageViewW-20;
    self.rightImageView.frame=CGRectMake(rightImageViewX, rightImageViewY, rightImageViewW, rightImageViewH);
    
    CGFloat liftScoreLabelX=liftImageViewX;
    CGFloat liftScoreLabelY=liftImageViewY+liftImageViewH+20;
    CGFloat liftScoreLabelW=liftImageViewW;
    CGFloat liftScoreLabelH=liftImageViewW;
    self.liftScoreLabel.frame=CGRectMake(liftScoreLabelX, liftScoreLabelY, liftScoreLabelW, liftScoreLabelH);
    
    
    CGFloat rightScoreLabelX=rightImageViewX;
    CGFloat rightScoreLabelY=rightImageViewY+liftImageViewH+20;
    CGFloat rightScoreLabelW=liftImageViewW;
    CGFloat rightScoreLabelH=liftImageViewW;
    self.rightScoreLabel.frame=CGRectMake(rightScoreLabelX, rightScoreLabelY, rightScoreLabelW, rightScoreLabelH);

}


@end
