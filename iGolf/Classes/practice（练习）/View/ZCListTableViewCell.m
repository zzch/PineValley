//
//  ZCListTableViewCell.m
//  iGolf
//
//  Created by hh on 15/5/18.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCListTableViewCell.h"
#import "UIImageView+WebCache.h"
@interface ZCListTableViewCell()
@property(nonatomic,weak)UILabel *rankingLabel;
@property(nonatomic,weak)UIImageView *userImageView;
@property(nonatomic,weak)UILabel *userLabel;
@property(nonatomic,weak)UILabel *resultsLabel;
@property(nonatomic,weak)UILabel *progressLabel;
@end
@implementation ZCListTableViewCell


+(instancetype)cellWithTable:(UITableView *)tableView
{
    static NSString *ID = @"ZCListTableViewCell";
    ZCListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZCListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return  cell;
}




-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addControls];
        
        
    }
    return self;
}

//添加控件
-(void)addControls
{

    //排名的图片
    UILabel *rankingLabel=[[UILabel alloc ] init];
    [self.contentView addSubview:rankingLabel];
    self.rankingLabel=rankingLabel;
    
    //用户头像
    UIImageView *userImageView=[[UIImageView alloc] init];
    [self.contentView addSubview:userImageView];
    self.userImageView=userImageView;
    
    //用户名字
    UILabel *userLabel=[[UILabel alloc] init];
    [self.contentView addSubview:userLabel];
    self.userLabel=userLabel;
    
    //成绩
    UILabel *resultsLabel=[[UILabel alloc] init];
    [self.contentView addSubview:resultsLabel];
    resultsLabel.textAlignment=NSTextAlignmentCenter;
    self.resultsLabel=resultsLabel;
    
    
    //进度
    UILabel *progressLabel=[[UILabel alloc] init];
    [self.contentView addSubview:progressLabel];
    progressLabel.textAlignment=NSTextAlignmentCenter;
    self.progressLabel=progressLabel;

    progressLabel.backgroundColor=[UIColor redColor];
}



-(void)setListModel:(ZCListModel *)listModel
{
    _listModel=listModel;
    
    self.rankingLabel.text=[NSString stringWithFormat:@"%@",listModel.position];
    
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",listModel.user.portrait]] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    
    
    self.userLabel.text=[NSString stringWithFormat:@"%@",listModel.user.nickname];
    self.resultsLabel.text=[NSString stringWithFormat:@"%@",listModel.total];
    self.progressLabel.text=[NSString stringWithFormat:@"%@/18",listModel.recorded_scorecards_count];
    
    
    if ([[NSString stringWithFormat:@"%@",listModel.isself] isEqual:@"1"]) {
        
        self.backgroundColor=[UIColor redColor];
    }

}






-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat  rankingLabelX=0;
    CGFloat  rankingLabelY=0;
    CGFloat  rankingLabelW=45;
    CGFloat  rankingLabelH=self.frame.size.height;
    self.rankingLabel.frame=CGRectMake(rankingLabelX, rankingLabelY, rankingLabelW, rankingLabelH);
    
    
    CGFloat  userImageViewX=rankingLabelW+5;
    CGFloat  userImageViewY=0;
    CGFloat  userImageViewW=self.frame.size.width*0.219;
    CGFloat  userImageViewH=self.frame.size.height;
    self.userImageView.frame=CGRectMake(userImageViewX, userImageViewY, userImageViewW, userImageViewH);
    
    
    CGFloat  userLabelX=userImageViewX+userImageViewW+5;
    CGFloat  userLabelY=0;
    CGFloat  userLabelW=70;
    CGFloat  userLabelH=self.frame.size.height;
    self.userLabel.frame=CGRectMake(userLabelX, userLabelY, userLabelW, userLabelH);


    
    CGFloat  resultsLabelX=self.frame.size.width-70;
    CGFloat  resultsLabelW=70;
    CGFloat  resultsLabelH=40;
    CGFloat  resultsLabelY=(self.frame.size.height/2)-resultsLabelH;
    self.resultsLabel.frame=CGRectMake(resultsLabelX, resultsLabelY, resultsLabelW, resultsLabelH);
    
    
    CGFloat  progressLabelX=self.frame.size.width-70;
    CGFloat  progressLabelW=70;
    CGFloat  progressLabelH=30;
    CGFloat  progressLabelY=resultsLabelY+resultsLabelH;
    self.progressLabel.frame=CGRectMake(progressLabelX, progressLabelY, progressLabelW, progressLabelH);
    

}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
