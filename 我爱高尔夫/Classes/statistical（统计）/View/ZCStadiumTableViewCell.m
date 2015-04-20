//
//  ZCStadiumTableViewCell.m
//  我爱高尔夫
//
//  Created by hh on 15/4/20.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCStadiumTableViewCell.h"
@interface ZCStadiumTableViewCell()
@property(nonatomic,weak)UILabel *nameLabel;
@property(nonatomic,weak)UILabel *addressLabel;
@property(nonatomic,weak)UIImageView *typeImage;
@property(nonatomic,weak)UILabel *typeLabel;
@property(nonatomic,weak)UIImageView *rightImage;
@end
@implementation ZCStadiumTableViewCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *nameLabel=[[UILabel alloc] init];
        self.nameLabel=nameLabel;
        [self.contentView addSubview:nameLabel];
        
        
        UILabel *addressLabel=[[UILabel alloc] init];
        self.addressLabel=addressLabel;
        [self.contentView addSubview:addressLabel];

        
        UIImageView *typeImage=[[UIImageView alloc] init];
        typeImage.image=[UIImage imageNamed:@"weizhi"];
        self.typeImage=typeImage;
        [self.contentView addSubview:typeImage];
        
        
        UILabel *typeLabel=[[UILabel alloc] init];
        self.typeLabel=typeLabel;
        [self.contentView addSubview:typeLabel];
        
        
        
    }
    return self;

}


-(void)setHistoryCoursesModel:(ZCHistoryCoursesModel *)historyCoursesModel
{
    _historyCoursesModel=historyCoursesModel;
    
    self.nameLabel.text=[NSString stringWithFormat:@"%@",historyCoursesModel.name];
    self.typeLabel.text=[NSString stringWithFormat:@"%@次",historyCoursesModel.visited_count];
    
    self.addressLabel.text=[NSString stringWithFormat:@"%@",historyCoursesModel.address];
}



-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat nameLabelX=10;
    CGFloat nameLabelY=0;
    CGFloat nameLabelW=119;
    CGFloat nameLabelH=30;
    
    self.nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    
    
    
    CGFloat typeImageX=nameLabelX;;
    CGFloat typeImageY=nameLabelY+nameLabelH+5;
    CGFloat typeImageW=11;
    CGFloat typeImageH=20;
    self.typeImage.frame=CGRectMake(typeImageX, typeImageY, typeImageW, typeImageH);
    
    
    CGFloat addressLabelX=typeImageX+10;;
    CGFloat addressLabelY=typeImageY;
    CGFloat addressLabelW=110;
    CGFloat addressLabelH=20;
    self.addressLabel.frame=CGRectMake(addressLabelX, addressLabelY, addressLabelW, addressLabelH);
    
    CGFloat rightImageW=40;
    CGFloat rightImageH=25;
    CGFloat rightImageX=SCREEN_WIDTH-rightImageW-10;
    CGFloat rightImageY=(self.frame.size.height-rightImageH)/2;
   
    self.typeLabel.frame=CGRectMake(rightImageX, rightImageY, rightImageW, rightImageH);
    

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
