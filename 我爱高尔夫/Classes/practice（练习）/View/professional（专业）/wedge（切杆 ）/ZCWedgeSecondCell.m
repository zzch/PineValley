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
    CGFloat numberLabelX=10;
    CGFloat numberLabelY=0;
    CGFloat numberLabelW=60;
    CGFloat numberLabelH=self.frame.size.height;
    numberLabel.frame=CGRectMake(numberLabelX, numberLabelY, numberLabelW, numberLabelH);
    [self.contentView addSubview:numberLabel];
    self.numberLabel=numberLabel;
    
    UILabel *nameLabel=[[UILabel alloc] init];
    CGFloat nameLabelX=numberLabelX+numberLabelW+10;
    CGFloat nameLabelY=0;
    CGFloat nameLabelW=60;
    CGFloat nameLabelH=self.frame.size.height;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.text=@"距离果岭";
    [self.contentView addSubview:nameLabel];
    
    
    
    UILabel *codeLabel=[[UILabel alloc] init];
    CGFloat codeLabelX=nameLabelX+nameLabelW+10;
    CGFloat codeLabelY=0;
    CGFloat codeLabelW=60;
    CGFloat codeLabelH=self.frame.size.height;
    codeLabel.frame=CGRectMake(codeLabelX, codeLabelY, codeLabelW, codeLabelH);
    [self.contentView addSubview:codeLabel];
    self.codeLabel=codeLabel;
    
    
    UILabel *nameLabel2=[[UILabel alloc] init];
    CGFloat nameLabel2X=codeLabelX+codeLabelW+10;
    CGFloat nameLabel2Y=0;
    CGFloat nameLabel2W=60;
    CGFloat nameLabel2H=self.frame.size.height;
    nameLabel2.frame=CGRectMake(nameLabel2X, nameLabel2Y, nameLabel2W, nameLabel2H);
    nameLabel2.text=@"推杆距离";
    [self.contentView addSubview:nameLabel2];
    
    
    
    UILabel *codeLabel2=[[UILabel alloc] init];
    codeLabel2.backgroundColor=[UIColor redColor];
    CGFloat codeLabel2X=nameLabel2X+nameLabel2W+10;
    CGFloat codeLabel2Y=0;
    CGFloat codeLabel2W=60;
    CGFloat codeLabel2H=self.frame.size.height;
    codeLabel2.frame=CGRectMake(codeLabel2X, codeLabel2Y, codeLabel2W, codeLabel2H);
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
    self.numberLabel.text=[NSString stringWithFormat:@"%ld",indexPath.row-1];

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
