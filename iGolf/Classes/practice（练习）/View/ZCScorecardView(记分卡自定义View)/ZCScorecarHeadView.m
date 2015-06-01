//
//  ZCScorecarHeadView.m
//  iGolf
//
//  Created by hh on 15/5/13.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCScorecarHeadView.h"
@interface ZCScorecarHeadView()
@property(nonatomic,weak)UIImageView *personImageView;
@property(nonatomic,weak)UILabel *nameLabel;
@property(nonatomic,weak)UILabel *rankingLabel;
@property(nonatomic,weak)UILabel *resultsLabel;
@property(nonatomic,weak)UILabel *progressLabel;
@property(nonatomic,weak)UILabel *parLabel;
@property(nonatomic,weak)UIButton *listBtn;
@property(nonatomic,weak)UIButton *InviteFriendsBtn;
@property(nonatomic,weak)UIButton *analysisBtn;
@property(nonatomic,weak)UIView *bjView;
@property(nonatomic,weak)UIView *shuBjView1;
@property(nonatomic,weak)UIView *shuBjView2;
@end
@implementation ZCScorecarHeadView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        
        self.backgroundColor=ZCColor(60, 57, 78);
        
        
        UIImageView *personImageView=[[UIImageView alloc] init];
        personImageView.layer.masksToBounds = YES;
        personImageView.layer.cornerRadius = 35;

        [self addSubview:personImageView];
        self.personImageView=personImageView;

        
        UILabel *nameLabel=[[UILabel alloc] init];
        nameLabel.textColor=[UIColor whiteColor];
        [self addSubview:nameLabel];
        self.nameLabel=nameLabel;

        
        //排名
        UILabel *rankingLabel=[[UILabel alloc] init];
        rankingLabel.textColor=[UIColor whiteColor];
        [self addSubview:rankingLabel];
        self.rankingLabel=rankingLabel;
        
        
        //成绩
        UILabel *resultsLabel=[[UILabel alloc] init];
        resultsLabel.textColor=[UIColor whiteColor];
        [self addSubview:resultsLabel];
        self.resultsLabel=resultsLabel;
        
        //进度
        UILabel *progressLabel=[[UILabel alloc] init];
        progressLabel.textColor=[UIColor whiteColor];        [self addSubview:progressLabel];
        self.progressLabel=progressLabel;
        
        
        //距标准杆
        UILabel *parLabel=[[UILabel alloc] init];
        parLabel.textColor=[UIColor whiteColor];
        [self addSubview:parLabel];
        self.parLabel=parLabel;
        
        
        //背景色横线
        UIView *bjView=[[UIView alloc] init];
        //bjView.backgroundColor=RGBACOLOR(170, 170, 170, 1);
        [self addSubview:bjView];
        self.bjView=bjView;

        
        
        /**
         排行榜
         */
        UIButton *listBtn=[[UIButton alloc] init];
        listBtn.tag=2789;
        [listBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [listBtn setTitle:@"排行榜" forState:UIControlStateNormal];
        listBtn.backgroundColor=ZCColor(90, 190, 99);
        [self addSubview:listBtn];
        self.listBtn=listBtn;
        
        UIView *shuBjView1=[[UIView alloc] init];
        shuBjView1.backgroundColor=RGBACOLOR(170, 170, 170, 1);
        [self addSubview:shuBjView1];
        self.shuBjView1=shuBjView1;

        
         /**
         *  邀请好友  shuBjView1
         */
        UIButton *InviteFriendsBtn=[[UIButton alloc] init];
        [InviteFriendsBtn setTitle:@"邀请好友" forState:UIControlStateNormal];
        InviteFriendsBtn.tag=2790;
        [InviteFriendsBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        InviteFriendsBtn.backgroundColor=ZCColor(234, 173, 67);
        [self addSubview:InviteFriendsBtn];
        self.InviteFriendsBtn=InviteFriendsBtn;
        
        
        UIView *shuBjView2=[[UIView alloc] init];
        shuBjView2.backgroundColor=RGBACOLOR(170, 170, 170, 1);
        [self addSubview:shuBjView2];
        self.shuBjView2=shuBjView2;

        /**
         * 技术分析
         */
        UIButton *analysisBtn=[[UIButton alloc] init];
        [analysisBtn setTitle:@"技术分析" forState:UIControlStateNormal];
        analysisBtn.tag=2791;
        [analysisBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        analysisBtn.backgroundColor=ZCColor(73, 172, 214);
        [self addSubview:analysisBtn];
        self.analysisBtn=analysisBtn;
    }
    return self;
}



-(void)clickButton:(UIButton *)button
{

    if ([self.delegate respondsToSelector:@selector(ZCScorecarHeadView:andClickButton:)]) {
        [self.delegate ZCScorecarHeadView:self andClickButton:button];
    }

}





- (id) _valueOrNil:(id)obj {
    if (!obj) {
        return nil;
    }
    if (obj == [NSNull null]) {
        return nil;
    }
    return obj;
}

-(void)setPlayerModel:(ZCPlayerModel *)playerModel
{
    _playerModel=playerModel;
    
    
    self.nameLabel.text=[NSString stringWithFormat:@"%@",playerModel.user.nickname];
    if ([self _valueOrNil:playerModel.position]==nil) {
         self.rankingLabel.text=[NSString stringWithFormat:@"排名: -"];
    }else
    {
     self.rankingLabel.text=[NSString stringWithFormat:@"排名: %@",playerModel.position];
    }
    
    if ([self _valueOrNil:playerModel.strokes]==nil) {
        self.resultsLabel.text=[NSString stringWithFormat:@"成绩: -"];
    }else{
    self.resultsLabel.text=[NSString stringWithFormat:@"成绩: %@杆",playerModel.strokes];
    }
    
    
    
    if ([self _valueOrNil:playerModel.recorded_scorecards_count]==nil) {
        self.progressLabel.text=[NSString stringWithFormat:@"进度: -/18"];
    }else{
    self.progressLabel.text=[NSString stringWithFormat:@"进度: %@/18",playerModel.recorded_scorecards_count];
    }
    
    
    
    if ([self _valueOrNil:playerModel.total]==nil) {
        self.parLabel.text=[NSString stringWithFormat:@"距标准杆: -"];
    }else{
    self.parLabel.text=[NSString stringWithFormat:@"距标准杆: %@",playerModel.total];
    }
}




-(void)layoutSubviews
{
    [super layoutSubviews];
    /**
     *  头像位置
     */
    CGFloat  personImageViewX=10;
    CGFloat  personImageViewY=10;
    CGFloat  personImageViewW=70;
    CGFloat  personImageViewH=70;
    self.personImageView.frame=CGRectMake(personImageViewX, personImageViewY, personImageViewW, personImageViewH);
    
    
    /**
     *  名字位置
     */
    CGFloat  nameLabelX=personImageViewX+personImageViewW+10;
    CGFloat  nameLabelY=personImageViewY;
    CGFloat  nameLabelW=SCREEN_WIDTH-nameLabelX;
    CGFloat  nameLabelH=25;
    self.nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    
    /**
     *  rankingLabel
     */
    
    CGFloat  rankingLabelX=nameLabelX;
    CGFloat  rankingLabelY=nameLabelY+nameLabelH+10;
    CGFloat  rankingLabelW=(SCREEN_WIDTH-nameLabelX)/2;
    CGFloat  rankingLabelH=20;
    self.rankingLabel.frame=CGRectMake(rankingLabelX, rankingLabelY, rankingLabelW, rankingLabelH);

    /**
     *  resultsLabel
     */
    
    CGFloat  resultsLabelX=nameLabelX;
    CGFloat  resultsLabelY=rankingLabelY+rankingLabelH+10;
    CGFloat  resultsLabelW=(SCREEN_WIDTH-nameLabelX)/2;
    CGFloat  resultsLabelH=20;
    self.resultsLabel.frame=CGRectMake(resultsLabelX, resultsLabelY, resultsLabelW, resultsLabelH);
    
    
    /**
     *  progressLabel
     */
    
    CGFloat  progressLabelX=rankingLabelX+rankingLabelW;
    CGFloat  progressLabelY=rankingLabelY;
    CGFloat  progressLabelW=(SCREEN_WIDTH-nameLabelX)/2;
    CGFloat  progressLabelH=20;
    self.progressLabel.frame=CGRectMake(progressLabelX, progressLabelY, progressLabelW, progressLabelH);
    
    
    
    
    /**
     *  parLabel
     */
    
    CGFloat  parLabelX=progressLabelX;
    CGFloat  parLabelY=resultsLabelY;
    CGFloat  parLabelW=(SCREEN_WIDTH-nameLabelX)/2;
    CGFloat  parLabelH=20;
    self.parLabel.frame=CGRectMake(parLabelX, parLabelY, parLabelW, parLabelH);
    
    
    self.bjView.frame=CGRectMake(0, parLabelY+parLabelH+9, SCREEN_WIDTH, 1);
    
    /**
     *  排行榜
     */
    CGFloat  listBtnX=0;
    CGFloat  listBtnY=parLabelY+parLabelH+10;
    CGFloat  listBtnW=SCREEN_WIDTH/3-1;
    CGFloat  listBtnH=40;
    self.listBtn.frame=CGRectMake(listBtnX, listBtnY, listBtnW, listBtnH);
    
    
     self.shuBjView1.frame=CGRectMake(listBtnW, listBtnY+5, 1, 30);
    
    /**
     *  邀请好友
     */
    CGFloat  InviteFriendsBtnX=listBtnW;
    CGFloat  InviteFriendsBtnY=listBtnY;
    CGFloat  InviteFriendsBtnW=SCREEN_WIDTH/3-1;
    CGFloat  InviteFriendsBtnH=40;
    self.InviteFriendsBtn.frame=CGRectMake(InviteFriendsBtnX, InviteFriendsBtnY, InviteFriendsBtnW, InviteFriendsBtnH);
    
    self.shuBjView2.frame=CGRectMake(InviteFriendsBtnX+InviteFriendsBtnW, listBtnY+5, 1, 30);
    
    /**
     *  技术分析
     */
    CGFloat  analysisBtnX=listBtnW+InviteFriendsBtnW;
    CGFloat  analysisBtnY=listBtnY;
    CGFloat  analysisBtnW=SCREEN_WIDTH/3;
    CGFloat  analysisBtnH=40;
    self.analysisBtn.frame=CGRectMake(analysisBtnX, analysisBtnY, analysisBtnW, analysisBtnH);
}





@end
