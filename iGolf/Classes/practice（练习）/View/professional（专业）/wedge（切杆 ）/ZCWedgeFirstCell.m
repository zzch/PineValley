//
//  ZCWedgeFirstCell.m
//  我爱高尔夫
//
//  Created by hh on 15/4/17.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCWedgeFirstCell.h"
@interface ZCWedgeFirstCell()
@property(nonatomic,weak)UILabel *firstNumberLaber;
@property(nonatomic,weak)UILabel *secondNumberLaber;
@property(nonatomic,weak)UILabel *thirdNumberLaber;
@end
@implementation ZCWedgeFirstCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
      [self addControls];  
        
        
        
        
    }


    return self;
}



-(void)addControls
{
    UIView *topView=[[UIView alloc] init];
    CGFloat topViewX=0;
    CGFloat topViewY=0;
    CGFloat topViewW=SCREEN_WIDTH;
    CGFloat topViewH=200;
    topView.frame=CGRectMake(topViewX, topViewY, topViewW, topViewH);
    [self.contentView addSubview:topView];
    //添加中间按钮
    [self addTopViewControls:topView];
}


//添加中间View内容
-(void)addTopViewControls:(UIView *)view
{
    
    UIImageView *personImage=[[UIImageView alloc] init];
    CGFloat personImageX=30;
    CGFloat personImageY=10;
    CGFloat personImageW=20;
    CGFloat personImageH=20;
    personImage.frame=CGRectMake(personImageX, personImageY, personImageW, personImageH);
    personImage.image=[UIImage imageNamed:@"20141118042246536.jpg"];
    [view addSubview:personImage];
    
    UILabel *nameLabel=[[UILabel alloc] init];
    CGFloat nameLabelX=personImageX+personImageW+10;
    CGFloat nameLabelY=personImageY;
    CGFloat nameLabelW=200;
    CGFloat nameLabelH=20;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.text=@"一切一推";
    [view addSubview:nameLabel];
    //提示按钮
    UIButton *promptBtn=[[UIButton alloc] init];
    CGFloat promptBtnX=nameLabelX+nameLabelW+10;
    CGFloat promptBtnY=personImageY;
    CGFloat promptBtnW=20;
    CGFloat promptBtnH=20;
    promptBtn.frame=CGRectMake(promptBtnX, promptBtnY, promptBtnW, promptBtnH);
    [promptBtn setImage:[UIImage imageNamed:@"20141118042246536.jpg"]
               forState:UIControlStateNormal];
    promptBtn.tag=1006;
    [promptBtn addTarget:self action:@selector(clickpromptishi:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:promptBtn];
    
    
    UILabel *firstNumberLaber=[[UILabel alloc] init];
    CGFloat  firstNumberLaberX=0;
    CGFloat  firstNumberLaberY=personImageY+personImageH+10;
    CGFloat  firstNumberLaberW=SCREEN_WIDTH/3;
    CGFloat  firstNumberLaberH=30;
    firstNumberLaber.frame=CGRectMake(firstNumberLaberX, firstNumberLaberY, firstNumberLaberW, firstNumberLaberH);
    firstNumberLaber.textAlignment=NSTextAlignmentCenter;
    //firstNumberLaber.text=[NSString stringWithFormat:@"%@",self.wedgeModel[@"up_and_downs_count"]];
    [view addSubview:firstNumberLaber];
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
    [view addSubview:firstNameLaber];
    
    
    //第二组
    UILabel *secondNumberLaber=[[UILabel alloc] init];
    CGFloat  secondNumberLaberX=firstNumberLaberX+firstNumberLaberW;
    CGFloat  secondNumberLaberY=firstNumberLaberY;
    CGFloat  secondNumberLaberW=SCREEN_WIDTH/3;
    CGFloat  secondNumberLaberH=30;
    secondNumberLaber.frame=CGRectMake(secondNumberLaberX, secondNumberLaberY, secondNumberLaberW, secondNumberLaberH);
    secondNumberLaber.textAlignment=NSTextAlignmentCenter;
   // secondNumberLaber.text=[NSString stringWithFormat:@"%@",self.wedgeModel[@"shots_within_100"]];
    [view addSubview:secondNumberLaber];
    self.secondNumberLaber=secondNumberLaber;
    
    UILabel *secondNameLaber=[[UILabel alloc] init];
    CGFloat  secondNameLaberX=secondNumberLaberX;
    CGFloat  secondNameLaberY=secondNumberLaberY+secondNumberLaberH+10;
    CGFloat  secondNameLaberW=firstNumberLaberW;
    CGFloat  secondNameLaberH=20;
    secondNameLaber.frame=CGRectMake(secondNameLaberX, secondNameLaberY, secondNameLaberW, secondNameLaberH);
    secondNameLaber.textAlignment=NSTextAlignmentCenter;
    secondNameLaber.text=@"总计";
    [view addSubview:secondNameLaber];
    
    
    //第三组
    UILabel *thirdNumberLaber=[[UILabel alloc] init];
    CGFloat  thirdNumberLaberX=secondNumberLaberX+secondNumberLaberW;
    CGFloat  thirdNumberLaberY=firstNumberLaberY;
    CGFloat  thirdNumberLaberW=SCREEN_WIDTH/3;
    CGFloat  thirdNumberLaberH=30;
    thirdNumberLaber.frame=CGRectMake(thirdNumberLaberX, thirdNumberLaberY, thirdNumberLaberW, thirdNumberLaberH);
    thirdNumberLaber.textAlignment=NSTextAlignmentCenter;
    //thirdNumberLaber.text=[NSString stringWithFormat:@"%@",self.wedgeModel[@"up_and_downs_percentage"]];
    [view addSubview:thirdNumberLaber];
    self.thirdNumberLaber=thirdNumberLaber;
    
    UILabel *thirdNameLaber=[[UILabel alloc] init];
    CGFloat  thirdNameLaberX=thirdNumberLaberX;
    CGFloat  thirdNameLaberY=thirdNumberLaberY+thirdNumberLaberH+10;
    CGFloat  thirdNameLaberW=firstNumberLaberW;
    CGFloat  thirdNameLaberH=20;
    thirdNameLaber.frame=CGRectMake(thirdNameLaberX, thirdNameLaberY, thirdNameLaberW, thirdNameLaberH);
    thirdNameLaber.textAlignment=NSTextAlignmentCenter;
    thirdNameLaber.text=@"成功率";
    [view addSubview:thirdNameLaber];
    
    
}

-(void)setWedgeModel:(NSDictionary *)wedgeModel
{
    _wedgeModel=wedgeModel;
    
    self.firstNumberLaber.text=[NSString stringWithFormat:@"%@",self.wedgeModel[@"up_and_downs_count"]];
    self.secondNumberLaber.text=[NSString stringWithFormat:@"%@",self.wedgeModel[@"shots_within_100"]];
    self.thirdNumberLaber.text=[NSString stringWithFormat:@"%@",self.wedgeModel[@"up_and_downs_percentage"]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
