//
//  ZCLasVegasGameView.m
//  iGolf
//
//  Created by hh on 15/7/23.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCLasVegasGameView.h"
#import "ZCHeadPortrait.h"
@interface ZCLasVegasGameView()
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
    
    //计分成绩
    UIButton *scoreLabel=[[UIButton alloc] init];
    scoreLabel.backgroundColor=[UIColor redColor];
    
    [scoreLabel setTitle:@"-" forState:UIControlStateNormal];
    [self addSubview:scoreLabel];
    self.scoreLabel=scoreLabel;
    
    
    // 显示提示语
    UILabel *promptLabel=[[UILabel alloc] init];
    promptLabel.text=@"上3洞打平均数累计本洞获胜方将获得4洞的分数";
    //自动折行设置
    promptLabel.lineBreakMode = UILineBreakModeWordWrap;
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
    
    
    UIButton *liftScoreLabel=[[UIButton alloc] init];
    liftScoreLabel.backgroundColor=[UIColor redColor];
    
    [liftScoreLabel setTitle:@"3" forState:UIControlStateNormal];
    [self addSubview:liftScoreLabel];
    self.liftScoreLabel=liftScoreLabel;
    
    
    UIButton *middleScoreLabel=[[UIButton alloc] init];
    middleScoreLabel.backgroundColor=[UIColor redColor];
   
    [middleScoreLabel setTitle:@"4" forState:UIControlStateNormal];
    [self addSubview:middleScoreLabel];
    self.middleScoreLabel=middleScoreLabel;
    
    
    UIButton *rightScoreLabel=[[UIButton alloc] init];
    rightScoreLabel.backgroundColor=[UIColor redColor];
    
    [rightScoreLabel setTitle:@"5" forState:UIControlStateNormal];
    [self addSubview:rightScoreLabel];
    self.rightScoreLabel=rightScoreLabel;
    
    
    UIButton *lastScoreLabel=[[UIButton alloc] init];
    lastScoreLabel.backgroundColor=[UIColor redColor];
    
    [lastScoreLabel setTitle:@"6" forState:UIControlStateNormal];
    [self addSubview:lastScoreLabel];
    self.lastScoreLabel=lastScoreLabel;
    
    //[self layoutIfNeeded];
    
}


-(void)setNumber:(NSString *)number

{
    _number=number;
    
    self.holeNumber.text=[NSString stringWithFormat:@"球洞%@",number];
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
    
    
    CGFloat liftScoreLabelX=liftImageViewX;
    CGFloat liftScoreLabelY=liftImageViewY+liftImageViewH+20;
    CGFloat liftScoreLabelW=liftImageViewW;
    CGFloat liftScoreLabelH=liftImageViewW;
    self.liftScoreLabel.frame=CGRectMake(liftScoreLabelX, liftScoreLabelY, liftScoreLabelW, liftScoreLabelH);
    
    
    CGFloat middleScoreLabelX=middleImageViewX;
    CGFloat middleScoreLabelY=middleImageViewY+middleImageViewH+20;
    CGFloat middleScoreLabelW=liftImageViewW;
    CGFloat middleScoreLabelH=liftImageViewW;
    self.middleScoreLabel.frame=CGRectMake(middleScoreLabelX, middleScoreLabelY, middleScoreLabelW, middleScoreLabelH);
    
    
    CGFloat rightScoreLabelX=rightImageViewX;
    CGFloat rightScoreLabelY=rightImageViewY+liftImageViewH+20;
    CGFloat rightScoreLabelW=liftImageViewW;
    CGFloat rightScoreLabelH=liftImageViewW;
    self.rightScoreLabel.frame=CGRectMake(rightScoreLabelX, rightScoreLabelY, rightScoreLabelW, rightScoreLabelH);
    
    
    CGFloat lastScoreLabelX=lastImageViewX;
    CGFloat lastScoreLabelY=rightImageViewY+liftImageViewH+20;
    CGFloat lastScoreLabelW=liftImageViewW;
    CGFloat lastScoreLabelH=liftImageViewW;
    self.lastScoreLabel.frame=CGRectMake(lastScoreLabelX, lastScoreLabelY, lastScoreLabelW, lastScoreLabelH);
    
}


@end
