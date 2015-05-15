//
//  ZCCompetitiveTableViewCell.m
//  我爱高尔夫
//
//  Created by hh on 15/4/24.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCCompetitiveTableViewCell.h"
@interface ZCCompetitiveTableViewCell()
@property(nonatomic,weak)UILabel *nameLabel;
@property(nonatomic,weak)UILabel *scoreNameLabel;
@property(nonatomic,weak)UILabel *scoreLabel;
@property(nonatomic,weak)UILabel *rankingNameLabel;
@property(nonatomic,weak)UILabel *rankingLabel;
@property(nonatomic,weak)UILabel *distanceParNameLabel;
@property(nonatomic,weak)UILabel *distanceParLabel;
@property(nonatomic,weak)UIImageView *personImageView;
@property(nonatomic,weak)UIButton *rankingButton;
@property(nonatomic,weak)UIButton *statisticalButton;
@end
@implementation ZCCompetitiveTableViewCell




+(instancetype)cellWithTable:(UITableView *)tableView
{
    static NSString *ID = @"ZCCompetitiveTableViewCell";
    ZCCompetitiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZCCompetitiveTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return  cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        UILabel *nameLabel=[[UILabel alloc] init];
        [self.contentView addSubview:nameLabel];
        self.nameLabel=nameLabel;
        
        UILabel *scoreNameLabel=[[UILabel alloc] init];
        scoreNameLabel.text=@"总杆";
        [self.contentView addSubview:scoreNameLabel];
        self.scoreNameLabel=scoreNameLabel;
        
        UILabel *scoreLabel=[[UILabel alloc] init];
        [self.contentView addSubview:scoreLabel];
        self.scoreLabel=scoreLabel;
        
        UILabel *rankingNameLabel=[[UILabel alloc] init];
        rankingNameLabel.text=@"排名";
        [self.contentView addSubview:rankingNameLabel];
        self.rankingNameLabel=rankingNameLabel;
        
        UILabel *rankingLabel=[[UILabel alloc] init];
        [self.contentView addSubview:rankingLabel];
        self.rankingLabel=rankingLabel;

        
        UILabel *distanceParNameLabel=[[UILabel alloc] init];
        distanceParNameLabel.text=@"距离标准杆";
        [self.contentView addSubview:distanceParNameLabel];
        self.distanceParNameLabel=distanceParNameLabel;
        
        UILabel *distanceParLabel=[[UILabel alloc] init];
        [self.contentView addSubview:distanceParLabel];
        self.distanceParLabel=distanceParLabel;


        UIImageView *personImageView=[[UIImageView alloc] init];
        
        [self.contentView addSubview:personImageView];
        self.personImageView=personImageView;
        
        
        UIButton *rankingButton=[[UIButton alloc] init];
        rankingButton.backgroundColor=[UIColor redColor];
        [rankingButton addTarget:self action:@selector(clickRankingButton:) forControlEvents:UIControlEventTouchUpInside];
        [rankingButton setTitle:@"查看排名" forState:UIControlStateNormal];
        [self.contentView addSubview:rankingButton];
        self.rankingButton=rankingButton;
        
        UIButton *statisticalButton=[[UIButton alloc] init];
        statisticalButton.backgroundColor=[UIColor blueColor];
        [statisticalButton setTitle:@"技术统计" forState:UIControlStateNormal];
        [self.contentView addSubview:statisticalButton];
        self.statisticalButton=statisticalButton;
        
    }
    return self;
}



-(void)setPlayerModel:(ZCPlayerModel *)playerModel
{
    _playerModel=playerModel;
    
    
    self.nameLabel.text=[NSString stringWithFormat:@"%@",playerModel.user.nickname];
   // self.scoreLabel.text=[NSString stringWithFormat:@"%@",playerModel.score];
    self.rankingLabel.text=[NSString stringWithFormat:@"%@",playerModel.position];
   // self.distanceParLabel.text=[NSString stringWithFormat:@"%@",playerModel.status];
    

}
//点击排名
-(void)clickRankingButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(ZCCompetitiveTableViewCell:didClickrankingButton:)]) {
        
        
        [self.delegate ZCCompetitiveTableViewCell:self didClickrankingButton:button];
    }
}



-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    
    
    CGFloat personImageViewW=80;
    CGFloat personImageViewH=80;
    CGFloat personImageViewX=10;
    CGFloat personImageViewY=(self.frame.size.height-personImageViewH)/2;
    
    self.personImageView.frame=CGRectMake(personImageViewX, personImageViewY, personImageViewW, personImageViewH);
    
    
    
    
    CGFloat nameLabelX=personImageViewX+personImageViewW+30;
    CGFloat nameLabelY=10;
    CGFloat nameLabelW=100;
    CGFloat nameLabelH=20;
    self.nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    
    CGFloat scoreNameLabelX=nameLabelX;
    CGFloat scoreNameLabelY=nameLabelY+nameLabelH+10;
    CGFloat scoreNameLabelW=50;
    CGFloat scoreNameLabelH=20;
    self.scoreNameLabel.frame=CGRectMake(scoreNameLabelX, scoreNameLabelY, scoreNameLabelW, scoreNameLabelH);
    
    
    CGFloat scoreLabelX=scoreNameLabelX+scoreNameLabelW+10;
    CGFloat scoreLabelY=scoreNameLabelY;
    CGFloat scoreLabelW=50;
    CGFloat scoreLabelH=20;
    self.scoreLabel.frame=CGRectMake(scoreLabelX, scoreLabelY, scoreLabelW, scoreLabelH);
    
    
    CGFloat rankingNameLabelX=nameLabelX;
    CGFloat rankingNameLabelY=scoreNameLabelY+scoreNameLabelH+10;
    CGFloat rankingNameLabelW=50;
    CGFloat rankingNameLabelH=20;
    self.rankingNameLabel.frame=CGRectMake(rankingNameLabelX, rankingNameLabelY, rankingNameLabelW, rankingNameLabelH);
    
    CGFloat rankingLabelX=rankingNameLabelX+rankingNameLabelW+10;
    CGFloat rankingLabelY=rankingNameLabelY;
    CGFloat rankingLabelW=50;
    CGFloat rankingLabelH=20;
    self.rankingLabel.frame=CGRectMake(rankingLabelX, rankingLabelY, rankingLabelW, rankingLabelH);
    
    
    CGFloat distanceParNameLabelX=nameLabelX;
    CGFloat distanceParNameLabelY=rankingLabelY+rankingLabelH+10;
    CGFloat distanceParNameLabelW=50;
    CGFloat distanceParNameLabelH=20;
    self.distanceParNameLabel.frame=CGRectMake(distanceParNameLabelX, distanceParNameLabelY, distanceParNameLabelW, distanceParNameLabelH);
    
    
    CGFloat distanceParLabelX=nameLabelX+distanceParNameLabelW+10;
    CGFloat distanceParLabelY=distanceParNameLabelY;
    CGFloat distanceParLabelW=50;
    CGFloat distanceParLabelH=20;
    self.distanceParLabel.frame=CGRectMake(distanceParLabelX, distanceParLabelY, distanceParLabelW, distanceParLabelH);
    
    
    
    
   
    
    
    
    
    CGFloat rankingButtonW=SCREEN_WIDTH/2;;
    CGFloat rankingButtonH=40;
    CGFloat rankingButtonX=0;
    CGFloat rankingButtonY=distanceParLabelY+distanceParLabelH+10;
    
    self.rankingButton.frame=CGRectMake(rankingButtonX, rankingButtonY, rankingButtonW, rankingButtonH);
    
    CGFloat statisticalButtonW=SCREEN_WIDTH/2;;
    CGFloat statisticalButtonH=40;
    CGFloat statisticalButtonX=rankingButtonW;
    CGFloat statisticalButtonY=distanceParLabelY+distanceParLabelH+10;
    
    self.statisticalButton.frame=CGRectMake(statisticalButtonX, statisticalButtonY, statisticalButtonW, statisticalButtonH);
    

}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
