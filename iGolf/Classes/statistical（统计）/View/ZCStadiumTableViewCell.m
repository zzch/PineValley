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
        
        
      //  self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"suoyou_bj_02"]];
        self.selectedBackgroundView=[[UIView alloc] initWithFrame:self.frame];
        self.selectedBackgroundView.backgroundColor=ZCColor(194, 194, 194);
        
        
        UILabel *nameLabel=[[UILabel alloc] init];
        nameLabel.textColor=ZCColor(85, 85, 85);
        self.nameLabel=nameLabel;
        [self.contentView addSubview:nameLabel];
        
        
        UILabel *addressLabel=[[UILabel alloc] init];
        addressLabel.textColor=ZCColor(85, 85, 85);
        self.addressLabel=addressLabel;
        [self.contentView addSubview:addressLabel];

        
        UIImageView *typeImage=[[UIImageView alloc] init];
        typeImage.image=[UIImage imageNamed:@"xzqc_weizhi_iocn"];
        self.typeImage=typeImage;
        [self.contentView addSubview:typeImage];
        
        
        UILabel *typeLabel=[[UILabel alloc] init];
        typeLabel.textColor=ZCColor(85, 85, 85);
        self.typeLabel=typeLabel;
        [self.contentView addSubview:typeLabel];
        
        
        
    }
    return self;

}


-(void)setHistoryCoursesModel:(ZCHistoryCoursesModel *)historyCoursesModel
{
    _historyCoursesModel=historyCoursesModel;
    
    self.nameLabel.text=[NSString stringWithFormat:@"%@",historyCoursesModel.name];
    self.typeLabel.text=[NSString stringWithFormat:@"%@次",historyCoursesModel.played_count];
    
    
    
    if ([historyCoursesModel.address isKindOfClass:[NSNull class]]) {
        self.typeImage.hidden=YES;
        
    }else
    {
    self.addressLabel.text=[NSString stringWithFormat:@"%@",historyCoursesModel.address];
    }
}



-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat nameLabelX=20;
    CGFloat nameLabelY=20;
    CGFloat nameLabelW=280;
    CGFloat nameLabelH=30;
    
    self.nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    
    
    
    CGFloat typeImageX=nameLabelX;;
    CGFloat typeImageY=nameLabelY+nameLabelH+5;
    CGFloat typeImageW=10;
    CGFloat typeImageH=14;
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
