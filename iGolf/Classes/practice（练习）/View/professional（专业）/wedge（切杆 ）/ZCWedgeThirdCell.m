//
//  ZCWedgeThirdCell.m
//  我爱高尔夫
//
//  Created by hh on 15/4/17.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCWedgeThirdCell.h"
@interface ZCWedgeThirdCell()
@property(nonatomic,weak)UILabel *firstNumberLaber;
@property(nonatomic,weak)UILabel *secondNumberLaber;
@end
@implementation ZCWedgeThirdCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
 
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addControls];
        
    }


    return self;
}


-(void)addControls
{
    UIImageView *personImage=[[UIImageView alloc] init];
    CGFloat personImageX=30;
    CGFloat personImageY=10;
    CGFloat personImageW=20;
    CGFloat personImageH=20;
    personImage.frame=CGRectMake(personImageX, personImageY, personImageW, personImageH);
    personImage.image=[UIImage imageNamed:@"20141118042246536.jpg"];
    [self.contentView addSubview:personImage];
    
    UILabel *nameLabel=[[UILabel alloc] init];
    CGFloat nameLabelX=personImageX+personImageW+10;
    CGFloat nameLabelY=personImageY;
    CGFloat nameLabelW=200;
    CGFloat nameLabelH=20;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.text=@"切杆进洞";
    [self.contentView addSubview:nameLabel];
    //提示按钮
    UIButton *promptBtn=[[UIButton alloc] init];
    CGFloat promptBtnX=nameLabelX+nameLabelW+10;
    CGFloat promptBtnY=personImageY;
    CGFloat promptBtnW=20;
    CGFloat promptBtnH=20;
    promptBtn.frame=CGRectMake(promptBtnX, promptBtnY, promptBtnW, promptBtnH);
    [promptBtn setImage:[UIImage imageNamed:@"20141118042246536.jpg"]
               forState:UIControlStateNormal];
    //promptBtn.tag=1006;
    [promptBtn addTarget:self action:@selector(clickpromptishi:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:promptBtn];
    
    
    UILabel *firstNumberLaber=[[UILabel alloc] init];
    CGFloat  firstNumberLaberX=0;
    CGFloat  firstNumberLaberY=personImageY+personImageH+10;
    CGFloat  firstNumberLaberW=SCREEN_WIDTH/2;
    CGFloat  firstNumberLaberH=30;
    firstNumberLaber.frame=CGRectMake(firstNumberLaberX, firstNumberLaberY, firstNumberLaberW, firstNumberLaberH);
    firstNumberLaber.textAlignment=NSTextAlignmentCenter;
   // firstNumberLaber.text=[NSString stringWithFormat:@"%@",self.wedgeModel[@"up_and_downs_count"]];
    [self.contentView addSubview:firstNumberLaber];
    self.firstNumberLaber=firstNumberLaber;
    
    //没秋冬
    UILabel *firstNameLaber=[[UILabel alloc] init];
    CGFloat  firstNameLaberX=firstNumberLaberX;
    CGFloat  firstNameLaberY=firstNumberLaberY+firstNumberLaberH+10;
    CGFloat  firstNameLaberW=firstNumberLaberW;
    CGFloat  firstNameLaberH=20;
    firstNameLaber.frame=CGRectMake(firstNameLaberX, firstNameLaberY, firstNameLaberW, firstNameLaberH);
    firstNameLaber.textAlignment=NSTextAlignmentCenter;
    firstNameLaber.text=@"成功";
    [self.contentView addSubview:firstNameLaber];
    
    
    //第二组
    UILabel *secondNumberLaber=[[UILabel alloc] init];
    CGFloat  secondNumberLaberX=firstNumberLaberX+firstNumberLaberW;
    CGFloat  secondNumberLaberY=firstNumberLaberY;
    CGFloat  secondNumberLaberW=SCREEN_WIDTH/2;
    CGFloat  secondNumberLaberH=30;
    secondNumberLaber.frame=CGRectMake(secondNumberLaberX, secondNumberLaberY, secondNumberLaberW, secondNumberLaberH);
    secondNumberLaber.textAlignment=NSTextAlignmentCenter;
   // secondNumberLaber.text=[NSString stringWithFormat:@"%@",self.wedgeModel[@"shots_within_100"]];
    [self.contentView addSubview:secondNumberLaber];
    self.secondNumberLaber=secondNumberLaber;
    
    
    UILabel *secondNameLaber=[[UILabel alloc] init];
    CGFloat  secondNameLaberX=secondNumberLaberX;
    CGFloat  secondNameLaberY=secondNumberLaberY+secondNumberLaberH+10;
    CGFloat  secondNameLaberW=firstNumberLaberW;
    CGFloat  secondNameLaberH=20;
    secondNameLaber.frame=CGRectMake(secondNameLaberX, secondNameLaberY, secondNameLaberW, secondNameLaberH);
    secondNameLaber.textAlignment=NSTextAlignmentCenter;
    secondNameLaber.text=@"最远切杆距离";
    [self.contentView addSubview:secondNameLaber];
    
    
}


-(void)setWedgeModel:(NSDictionary *)wedgeModel
{
    _wedgeModel=wedgeModel;
    self.firstNumberLaber.text=[NSString stringWithFormat:@"%@",wedgeModel[@"chip_ins"]];
    self.secondNumberLaber.text=[NSString stringWithFormat:@"%@",wedgeModel[@"longest_chip_ins_length"]];

}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
