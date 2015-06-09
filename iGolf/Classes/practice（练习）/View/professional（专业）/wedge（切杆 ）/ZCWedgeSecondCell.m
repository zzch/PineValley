//
//  ZCWedgeSecondCell.m
//  我爱高尔夫
//
//  Created by hh on 15/4/17.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCWedgeSecondCell.h"
@interface ZCWedgeSecondCell()
@property(nonatomic,weak)UILabel *numberLabel;
@property(nonatomic,weak)UILabel *codeLabel;
@property(nonatomic,weak)UILabel *codeLabel2;
@property(nonatomic,weak)UILabel *nameLabel;
@property(nonatomic,weak)UILabel *nameLabel2;
@end
@implementation ZCWedgeSecondCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addcontrols];
        
    }
    return self;

}

//添加控件
-(void)addcontrols
{
    
    UILabel *numberLabel=[[UILabel alloc] init];
    numberLabel.textColor=ZCColor(85, 85, 85);
    numberLabel.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:numberLabel];
    self.numberLabel=numberLabel;
    
    UILabel *nameLabel=[[UILabel alloc] init];
    nameLabel.text=@"距离果岭";
    nameLabel.textColor=ZCColor(85, 85, 85);
    nameLabel.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:nameLabel];
    self.nameLabel=nameLabel;
    
    
    UILabel *codeLabel=[[UILabel alloc] init];
    codeLabel.textColor=ZCColor(85, 85, 85);
    codeLabel.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:codeLabel];
    self.codeLabel=codeLabel;
    
    
    UILabel *nameLabel2=[[UILabel alloc] init];
    nameLabel2.textColor=ZCColor(85, 85, 85);
    nameLabel2.textAlignment=NSTextAlignmentCenter;
    nameLabel2.text=@"推杆距离";
    [self.contentView addSubview:nameLabel2];
    self.nameLabel2=nameLabel2;
    
    
    UILabel *codeLabel2=[[UILabel alloc] init];
    codeLabel2.textColor=ZCColor(85, 85, 85);
    codeLabel2.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:codeLabel2];
    self.codeLabel2=codeLabel2;
    

}



-(void)setWedgeModel:(ZCWedgeModel *)wedgeModel
{
    _wedgeModel=wedgeModel;
    self.codeLabel.text=[NSString stringWithFormat:@"%@码",wedgeModel.distance_from_hole];
     self.codeLabel2.text=[NSString stringWithFormat:@"%@码",wedgeModel.putt_length];
   
}

-(void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath=indexPath;
    self.numberLabel.text=[NSString stringWithFormat:@"%d",indexPath.row];

}



-(void)layoutSubviews
{
    CGFloat numberLabelX=0;
    CGFloat numberLabelY=0;
    CGFloat numberLabelW=self.frame.size.width*0.105;
    CGFloat numberLabelH=self.frame.size.height;
    self.numberLabel.frame=CGRectMake(numberLabelX, numberLabelY, numberLabelW, numberLabelH);


    
    CGFloat nameLabelX=numberLabelX+numberLabelW;
    CGFloat nameLabelY=0;
    CGFloat nameLabelW=self.frame.size.width*0.2236;
    CGFloat nameLabelH=self.frame.size.height;
    self.nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);

    
    
    
    CGFloat codeLabelX=nameLabelX+nameLabelW;
    CGFloat codeLabelY=0;
    CGFloat codeLabelW=self.frame.size.width*0.132;
    CGFloat codeLabelH=self.frame.size.height;
    self.codeLabel.frame=CGRectMake(codeLabelX, codeLabelY, codeLabelW, codeLabelH);
    
    
    CGFloat nameLabel2X=codeLabelX+codeLabelW+self.frame.size.width*0.15;
    CGFloat nameLabel2Y=0;
    CGFloat nameLabel2W=self.frame.size.width*0.23;
    CGFloat nameLabel2H=self.frame.size.height;
    self.nameLabel2.frame=CGRectMake(nameLabel2X, nameLabel2Y, nameLabel2W, nameLabel2H);
    
    
    
    CGFloat codeLabel2X=nameLabel2X+nameLabel2W;
    CGFloat codeLabel2Y=0;
    CGFloat codeLabel2W=self.frame.size.width*0.157;
    CGFloat codeLabel2H=self.frame.size.height;
    self.codeLabel2.frame=CGRectMake(codeLabel2X, codeLabel2Y, codeLabel2W, codeLabel2H);
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
