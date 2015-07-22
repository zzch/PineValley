//
//  ZCHoleScoringView.m
//  iGolf
//
//  Created by hh on 15/7/22.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCHoleScoringView.h"
#import "ZCHeadPortrait.h"
@interface ZCHoleScoringView()
@property(nonatomic,weak)UILabel *holeNumber;
@property(nonatomic,weak)UILabel *nameLabel;
@property(nonatomic,weak)UILabel *scoreLabel;
@property(nonatomic,weak)UILabel *promptLabel;
@property(nonatomic,weak)ZCHeadPortrait *liftImageView;
@property(nonatomic,weak)ZCHeadPortrait *rightImageView;
@property(nonatomic,weak)UILabel *liftScoreLabel;
@property(nonatomic,weak)UILabel *rightScoreLabel;
@end
@implementation ZCHoleScoringView

-(instancetype)initWithFrame:(CGRect)frame
{

    if (self=[super initWithFrame:frame]) {
        
        //self.backgroundColor=[UIColor redColor];
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
    UILabel *scoreLabel=[[UILabel alloc] init];
    scoreLabel.backgroundColor=[UIColor redColor];
    scoreLabel.text=@"-";
    scoreLabel.textColor=[UIColor whiteColor];
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
    
    
    ZCHeadPortrait *rightImageView=[[ZCHeadPortrait alloc] init];
    rightImageView.backgroundColor=[UIColor yellowColor];
    [self addSubview:rightImageView];
    self.rightImageView=rightImageView;
    
    
    UILabel *liftScoreLabel=[[UILabel alloc] init];
    liftScoreLabel.backgroundColor=[UIColor redColor];
    liftScoreLabel.text=@"3";
    [self addSubview:liftScoreLabel];
    self.liftScoreLabel=liftScoreLabel;
    
    
    UILabel *rightScoreLabel=[[UILabel alloc] init];
    rightScoreLabel.backgroundColor=[UIColor redColor];
    rightScoreLabel.text=@"-";
    [self addSubview:rightScoreLabel];
    self.rightScoreLabel=rightScoreLabel;
    
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
