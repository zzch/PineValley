//
//  ZCRankingTableViewCell.m
//  我爱高尔夫
//
//  Created by hh on 15/4/28.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCRankingTableViewCell.h"
@interface ZCRankingTableViewCell()
@property(nonatomic,weak)UIImageView *rankingImage;
@property(nonatomic,weak)UIImageView *nicknameImage;
@property(nonatomic,weak)UILabel *nicknameLabel;
@property(nonatomic,weak)UILabel *distanceLabel;
@property(nonatomic,weak)UILabel *holeLabel;
@property(nonatomic,weak)UILabel *numberLabel;
@property(nonatomic,weak)UIImageView *rightImage;
@end
@implementation ZCRankingTableViewCell


+(instancetype)cellWithTable:(UITableView *)tableView
{
    static NSString *ID = @"ZCRankingTableViewCell.h";
    ZCRankingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZCRankingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    UIImageView *rankingImage=[[UIImageView alloc] init];
    [self.contentView addSubview:rankingImage];
    self.rankingImage=rankingImage;
    
    UIImageView *nicknameImage=[[UIImageView alloc] init];
    [self.contentView addSubview:nicknameImage];
    self.nicknameImage=nicknameImage;

    
    UILabel *nicknameLabel=[[UILabel alloc] init];
    
    [self.contentView addSubview:nicknameLabel];
    self.nicknameLabel=nicknameLabel;
    
    
    UILabel *distanceLabel=[[UILabel alloc] init];
   
    [self.contentView addSubview:distanceLabel];
    self.distanceLabel=distanceLabel;

    
    UILabel *holeLabel=[[UILabel alloc] init];
    [self.contentView addSubview:holeLabel];
    self.holeLabel=holeLabel;
    
    
    UILabel *numberLabel=[[UILabel alloc] init];
    [self.contentView addSubview:numberLabel];
    self.numberLabel=numberLabel;
    
    
    UIImageView *rightImage=[[UIImageView alloc] init];
    [self.contentView addSubview:rightImage];
    self.rightImage=rightImage;

}





-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    
    CGFloat rankingImageW=50;
    CGFloat rankingImageH=50;
    CGFloat rankingImageY=(self.frame.size.height-rankingImageH)/2;
    CGFloat rankingImageX=10;
    
    self.rankingImage.frame=CGRectMake(rankingImageX, rankingImageY, rankingImageW, rankingImageH);
    
    CGFloat nicknameImageW=70;
    CGFloat nicknameImageH=70;
    CGFloat nicknameImageY=(self.frame.size.height-nicknameImageH)/2;
    CGFloat nicknameImageX=rankingImageX+rankingImageW+10;
    self.nicknameImage.frame=CGRectMake(nicknameImageX, nicknameImageY, nicknameImageW, nicknameImageH);

    
    CGFloat nicknameLabelX=nicknameImageX+nicknameImageW+10;
    CGFloat nicknameLabelY=20;
    CGFloat nicknameLabelW=70;
    CGFloat nicknameLabelH=20;
    self.nicknameLabel.frame=CGRectMake(nicknameLabelX, nicknameLabelY, nicknameLabelW, nicknameLabelH);
    
    
    CGFloat distanceLabelX=nicknameLabelX;
    CGFloat distanceLabelY=nicknameLabelY+nicknameLabelH+10;
    CGFloat distanceLabelW=80;
    CGFloat distanceLabelH=20;
    self.distanceLabel.frame=CGRectMake(distanceLabelX, distanceLabelY, distanceLabelW, distanceLabelH);
    
    CGFloat holeLabelX=nicknameLabelX;
    CGFloat holeLabelY=distanceLabelY+distanceLabelH+10;
    CGFloat holeLabelW=80;
    CGFloat holeLabelH=20;
    self.holeLabel.frame=CGRectMake(holeLabelX, holeLabelY, holeLabelW, holeLabelH);
    
    
    
    CGFloat numberLabelW=40;
    CGFloat numberLabelH=40;
    CGFloat numberLabelY=(self.frame.size.height-numberLabelH)/2;
    CGFloat numberLabelX=nicknameLabelX+nicknameLabelW+10;
    self.numberLabel.frame=CGRectMake(numberLabelX, numberLabelY, numberLabelW, numberLabelH);
    
    
    CGFloat rightImageW=40;
    CGFloat rightImageH=40;
    CGFloat rightImageY=(self.frame.size.height-rightImageH)/2;
    CGFloat rightImageX=numberLabelX+numberLabelW+10;
    self.rightImage.frame=CGRectMake(rightImageX, rightImageY, rightImageW, rightImageH);


}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
