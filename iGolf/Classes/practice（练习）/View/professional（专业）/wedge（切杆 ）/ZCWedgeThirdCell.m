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
//    UIImageView *personImage=[[UIImageView alloc] init];
//    CGFloat personImageX=30;
//    CGFloat personImageY=10;
//    CGFloat personImageW=20;
//    CGFloat personImageH=20;
//    personImage.frame=CGRectMake(personImageX, personImageY, personImageW, personImageH);
//    personImage.image=[UIImage imageNamed:@"20141118042246536.jpg"];
//    [self.contentView addSubview:personImage];
//    
    UILabel *nameLabel=[[UILabel alloc] init];
    CGFloat nameLabelX=20;
    CGFloat nameLabelY=10;
    CGFloat nameLabelW=200;
    CGFloat nameLabelH=20;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.text=@"切杆进洞";
    [self.contentView addSubview:nameLabel];
//    //提示按钮
//    UIButton *promptBtn=[[UIButton alloc] init];
//    CGFloat promptBtnX=nameLabelX+nameLabelW+10;
//    CGFloat promptBtnY=personImageY;
//    CGFloat promptBtnW=20;
//    CGFloat promptBtnH=20;
//    promptBtn.frame=CGRectMake(promptBtnX, promptBtnY, promptBtnW, promptBtnH);
//    [promptBtn setImage:[UIImage imageNamed:@"20141118042246536.jpg"]
//               forState:UIControlStateNormal];
//    //promptBtn.tag=1006;
//    [promptBtn addTarget:self action:@selector(clickpromptishi:) forControlEvents:UIControlEventTouchUpInside];
//    [self.contentView addSubview:promptBtn];
//    
    
    UILabel *firstNumberLaber=[[UILabel alloc] init];
    CGFloat  firstNumberLaberX=0;
    CGFloat  firstNumberLaberY=nameLabelY+nameLabelH+10;
    CGFloat  firstNumberLaberW=SCREEN_WIDTH/2-0.5;
    CGFloat  firstNumberLaberH=35;
    firstNumberLaber.frame=CGRectMake(firstNumberLaberX, firstNumberLaberY, firstNumberLaberW, firstNumberLaberH);
    firstNumberLaber.textAlignment=NSTextAlignmentCenter;
   // firstNumberLaber.text=[NSString stringWithFormat:@"%@",self.wedgeModel[@"up_and_downs_count"]];
    firstNumberLaber.font=[UIFont systemFontOfSize:27];
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
    firstNameLaber.textColor=ZCColor(85, 85, 85);
    [self.contentView addSubview:firstNameLaber];
    
    
    
    UIView *biView=[[UIView alloc] initWithFrame:CGRectMake(firstNumberLaberW, firstNumberLaberY+10, 0.5, 70)];
    
    biView.backgroundColor=ZCColor(102, 102, 102);
    [self.contentView addSubview:biView];
    
    //第二组
    UILabel *secondNumberLaber=[[UILabel alloc] init];
    CGFloat  secondNumberLaberX=firstNumberLaberX+firstNumberLaberW+0.5;
    CGFloat  secondNumberLaberY=firstNumberLaberY;
    CGFloat  secondNumberLaberW=SCREEN_WIDTH/2-0.5;
    CGFloat  secondNumberLaberH=35;
    secondNumberLaber.frame=CGRectMake(secondNumberLaberX, secondNumberLaberY, secondNumberLaberW, secondNumberLaberH);
    secondNumberLaber.textAlignment=NSTextAlignmentCenter;
   // secondNumberLaber.text=[NSString stringWithFormat:@"%@",self.wedgeModel[@"shots_within_100"]];
    secondNumberLaber.font=[UIFont systemFontOfSize:27];
    
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
    secondNameLaber.textColor=ZCColor(85, 85, 85);
    [self.contentView addSubview:secondNameLaber];
    
    
}


-(void)setWedgeModel:(NSDictionary *)wedgeModel
{
    _wedgeModel=wedgeModel;
    
    if ([self _valueOrNil:wedgeModel[@"chip_ins"]]==nil) {
         self.firstNumberLaber.text=@"-";
    }else
    {
    self.firstNumberLaber.text=[NSString stringWithFormat:@"%@",wedgeModel[@"chip_ins"]];
    }
    
    
    
    if ([self _valueOrNil:wedgeModel[@"longest_chip_ins_length"]]==nil) {
       self.secondNumberLaber.text=@"-";
    }else
    {
        self.secondNumberLaber.text=[NSString stringWithFormat:@"%@",wedgeModel[@"longest_chip_ins_length"]];
        

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

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
