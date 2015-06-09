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
    CGFloat topViewH=100;
    topView.frame=CGRectMake(topViewX, topViewY, topViewW, topViewH);
    topView.backgroundColor=ZCColor(60, 57, 78);
    [self.contentView addSubview:topView];
    //添加中间按钮
    [self addTopViewControls:topView];
}


//添加中间View内容
-(void)addTopViewControls:(UIView *)view
{
    
//    UIImageView *personImage=[[UIImageView alloc] init];
//    CGFloat personImageX=30;
//    CGFloat personImageY=10;
//    CGFloat personImageW=20;
//    CGFloat personImageH=20;
//    personImage.frame=CGRectMake(personImageX, personImageY, personImageW, personImageH);
//    personImage.image=[UIImage imageNamed:@"20141118042246536.jpg"];
//    [view addSubview:personImage];
//    
//    UILabel *nameLabel=[[UILabel alloc] init];
//    CGFloat nameLabelX=personImageX+personImageW+10;
//    CGFloat nameLabelY=personImageY;
//    CGFloat nameLabelW=200;
//    CGFloat nameLabelH=20;
//    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
//    nameLabel.text=@"一切一推";
//    [view addSubview:nameLabel];
//    //提示按钮
//    UIButton *promptBtn=[[UIButton alloc] init];
//    CGFloat promptBtnX=nameLabelX+nameLabelW+10;
//    CGFloat promptBtnY=personImageY;
//    CGFloat promptBtnW=20;
//    CGFloat promptBtnH=20;
//    promptBtn.frame=CGRectMake(promptBtnX, promptBtnY, promptBtnW, promptBtnH);
//    [promptBtn setImage:[UIImage imageNamed:@"20141118042246536.jpg"]
//               forState:UIControlStateNormal];
//    promptBtn.tag=1006;
//    [promptBtn addTarget:self action:@selector(clickpromptishi:) forControlEvents:UIControlEventTouchUpInside];
//    [view addSubview:promptBtn];
    
    
    UILabel *firstNumberLaber=[[UILabel alloc] init];
    CGFloat  firstNumberLaberX=0;
    CGFloat  firstNumberLaberY=25;
    CGFloat  firstNumberLaberW=SCREEN_WIDTH/3-1;
    CGFloat  firstNumberLaberH=20;
    firstNumberLaber.frame=CGRectMake(firstNumberLaberX, firstNumberLaberY, firstNumberLaberW, firstNumberLaberH);
    firstNumberLaber.textAlignment=NSTextAlignmentCenter;
    firstNumberLaber.textColor=[UIColor whiteColor];
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
    firstNameLaber.textColor=[UIColor whiteColor];
    [view addSubview:firstNameLaber];
    
    
    
    
    //竖条背景色
    UIView *bjView=[[UIView alloc] initWithFrame:CGRectMake(firstNumberLaberW, 25, 0.5, 50)];
    bjView.backgroundColor=[UIColor whiteColor];
    [view addSubview:bjView];

    
    
    //第二组
    UILabel *secondNumberLaber=[[UILabel alloc] init];
    CGFloat  secondNumberLaberX=firstNumberLaberX+firstNumberLaberW+0.5;
    CGFloat  secondNumberLaberY=firstNumberLaberY;
    CGFloat  secondNumberLaberW=SCREEN_WIDTH/3-1;
    CGFloat  secondNumberLaberH=20;
    secondNumberLaber.frame=CGRectMake(secondNumberLaberX, secondNumberLaberY, secondNumberLaberW, secondNumberLaberH);
    secondNumberLaber.textAlignment=NSTextAlignmentCenter;
   // secondNumberLaber.text=[NSString stringWithFormat:@"%@",self.wedgeModel[@"shots_within_100"]];
    secondNumberLaber.textColor=[UIColor whiteColor];
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
    secondNameLaber.textColor=[UIColor whiteColor];
    [view addSubview:secondNameLaber];
    
    
    
    //竖条背景色
    UIView *bjView2=[[UIView alloc] initWithFrame:CGRectMake(secondNameLaberX+secondNameLaberW+0.5, 25, 0.5, 50)];
    bjView2.backgroundColor=[UIColor whiteColor];
    [view addSubview:bjView2];

    
    //第三组
    UILabel *thirdNumberLaber=[[UILabel alloc] init];
    CGFloat  thirdNumberLaberX=secondNumberLaberX+secondNumberLaberW;
    CGFloat  thirdNumberLaberY=firstNumberLaberY;
    CGFloat  thirdNumberLaberW=SCREEN_WIDTH/3-1;
    CGFloat  thirdNumberLaberH=20;
    thirdNumberLaber.frame=CGRectMake(thirdNumberLaberX, thirdNumberLaberY, thirdNumberLaberW, thirdNumberLaberH);
    thirdNumberLaber.textAlignment=NSTextAlignmentCenter;
    //thirdNumberLaber.text=[NSString stringWithFormat:@"%@",self.wedgeModel[@"up_and_downs_percentage"]];
    thirdNumberLaber.textColor=[UIColor whiteColor];
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
    thirdNameLaber.textColor=[UIColor whiteColor];
    [view addSubview:thirdNameLaber];
    
    
}

-(void)setWedgeModel:(NSDictionary *)wedgeModel
{
    _wedgeModel=wedgeModel;
    
    if ([self _valueOrNil:self.wedgeModel[@"up_and_downs_count"]]==nil) {
        self.firstNumberLaber.text=@"-";
    }else{
    self.firstNumberLaber.text=[NSString stringWithFormat:@"%@",self.wedgeModel[@"up_and_downs_count"]];
    }
    
    
    
    if ([self _valueOrNil:self.wedgeModel[@"shots_within_100"]]==nil) {
        self.secondNumberLaber.text=@"-";
    }else{
    
    self.secondNumberLaber.text=[NSString stringWithFormat:@"%@",self.wedgeModel[@"shots_within_100"]];
    }
    
    
    
    if ([self _valueOrNil:self.wedgeModel[@"up_and_downs_percentage"]]==nil) {
        self.thirdNumberLaber.text=@"-";
    }else
    {
    self.thirdNumberLaber.text=[NSString stringWithFormat:@"%@",self.wedgeModel[@"up_and_downs_percentage"]];
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
