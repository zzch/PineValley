//
//  ZCSwingCell.m
//  我爱高尔夫
//
//  Created by hh on 15/4/1.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCSwingCell.h"
@interface ZCSwingCell()



@property(nonatomic,weak) UIView *valueView;
/**
 码数
 */

@property(nonatomic,weak) UILabel *codeLable;
/**
 状态
 */
@property(nonatomic,weak)UILabel *stateLable;
/**
 罚杆
 */
@property(nonatomic,weak)UILabel *penaltyLable;
/**
 球杆
 */
@property(nonatomic,weak)UILabel *cueLable;
/**
 序号
 */
@property(nonatomic,weak)UILabel *sequenceLabel;


/**
 加号
 */
@property(nonatomic,weak)UIImageView *addImage;



@end
@implementation ZCSwingCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

       // self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"suoyou_bj_02"]];
        //取消点击效果
        self.selectionStyle=UITableViewCellSelectionStyleNone;

        
        UIView *valueView=[[UIView alloc] init];
        
        
        self.valueView=valueView;
        [self.contentView addSubview:valueView];
        
        //序号
        UILabel *sequenceLabel=[[UILabel alloc] init];
        sequenceLabel.textColor=ZCColor(85, 85, 85);
        sequenceLabel.textAlignment=NSTextAlignmentCenter;
        [valueView addSubview:sequenceLabel];
        self.sequenceLabel=sequenceLabel;
        
        
        //码数
        UILabel *codeLable=[[UILabel alloc] init];
       codeLable.textAlignment=NSTextAlignmentCenter;
        codeLable.textColor=ZCColor(85, 85, 85);
        codeLable.font=[UIFont systemFontOfSize:16];
        self.codeLable=codeLable;
        [valueView addSubview:codeLable];
        
        
        //状态stateLable
        UILabel *stateLable=[[UILabel alloc] init];
        stateLable.textColor=ZCColor(85, 85, 85);
        stateLable.textAlignment=NSTextAlignmentCenter;
        stateLable.font=[UIFont systemFontOfSize:16];
        self.stateLable=stateLable;
        [valueView addSubview:stateLable];
        
        //罚杆penaltyLable
        UILabel *penaltyLable=[[UILabel alloc] init];
        penaltyLable.textColor=ZCColor(85, 85, 85);
        penaltyLable.textAlignment=NSTextAlignmentCenter;
        penaltyLable.font=[UIFont systemFontOfSize:16];
        self.penaltyLable=penaltyLable;
        [valueView addSubview:penaltyLable];
        
        
        //球杆cueLable
        UILabel *cueLable=[[UILabel alloc] init];
        cueLable.textAlignment=NSTextAlignmentCenter;
        cueLable.textColor=ZCColor(85, 85, 85);
        cueLable.font=[UIFont systemFontOfSize:16];
        self.cueLable=cueLable;
        [valueView addSubview:cueLable];

        
      //  }else{

        //如果没值显示加号jfk_tianjia
        
        UIImageView *addImage=[[UIImageView alloc] init];
            addImage.frame=CGRectMake((self.frame.size.width-30)/2, (self.frame.size.height-30)/2, 30, 30);
        addImage.image=[UIImage imageNamed:@"zyjf_tiejia"];
        //addLabel.text=@"+++++++++++++";
            
        [self addSubview:addImage];
        self.addImage=addImage;
    //    }
        
    }

    return self;

}




-(void)setSelectTheDisplay:(ZCSelectTheDisplay *)selectTheDisplay
{
    _selectTheDisplay=selectTheDisplay;
    
    if (self.selectTheDisplay.distance_from_hole) {
        self.addImage.hidden=YES;
        self.valueView.hidden=NO;
    }else
    {
        self.valueView.hidden=YES;
    self.addImage.hidden=NO;
    }
    
    if ([[NSString stringWithFormat:@"%@",self.selectTheDisplay.distance_from_hole] isEqual:@"0"]) {
        self.codeLable.text=@"进洞";
    }else{
    self.codeLable.text=[NSString stringWithFormat:@"%@",self.selectTheDisplay.distance_from_hole];
    }
    
    
    //球道的转换
    if ([[NSString stringWithFormat:@"%@",self.selectTheDisplay.point_of_fall] isEqual:@"fairway"]) {
        self.stateLable.text=@"球道";
    }else if ([[NSString stringWithFormat:@"%@",self.selectTheDisplay.point_of_fall] isEqual:@"green"])
    {
    self.stateLable.text=@"果岭";
    }else if ([[NSString stringWithFormat:@"%@",self.selectTheDisplay.point_of_fall] isEqual:@"hole"])
    {
        self.stateLable.text=@"进洞";
    }else if ([[NSString stringWithFormat:@"%@",self.selectTheDisplay.point_of_fall] isEqual:@"left_rough"])
    {
        self.stateLable.text=@"球道外左侧";
    }else if ([[NSString stringWithFormat:@"%@",self.selectTheDisplay.point_of_fall] isEqual:@"right_rough"])
    {
        self.stateLable.text=@"球道外右侧";
    }else if ([[NSString stringWithFormat:@"%@",self.selectTheDisplay.point_of_fall] isEqual:@"bunker"])
    {
        self.stateLable.text=@"沙坑";
    }else if ([[NSString stringWithFormat:@"%@",self.selectTheDisplay.point_of_fall] isEqual:@"unplayable"])
    {
        self.stateLable.text=@"不可打";
    }else
    {
    self.stateLable.text=[NSString stringWithFormat:@"%@",self.selectTheDisplay.point_of_fall];
    
    }





    
    
    
    
    
    //罚杆数的转换
    if ([[NSString stringWithFormat:@"%@",self.selectTheDisplay.penalties] isEqual:@"(null)"]) {
        self.penaltyLable.text=@"0";
    }else
    {
    self.penaltyLable.text=[NSString stringWithFormat:@"%@",self.selectTheDisplay.penalties];
    }
    
    
    self.cueLable.text=[NSString stringWithFormat:@"%@",self.selectTheDisplay.club];
   // self.sequenceLabel.text=[NSString stringWithFormat:@"%@",self.selectTheDisplay.sequence];

}

-(void)setSequence:(long)sequence
{
    _sequence=sequence;
    self.sequenceLabel.text=[NSString stringWithFormat:@"%ld",sequence];


}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.valueView.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    //序号
   self.sequenceLabel.frame=CGRectMake(0, 0, self.frame.size.width*0.153, self.frame.size.height);
    
    //码数
    self.codeLable.frame=CGRectMake(self.sequenceLabel.frame.size.width+self.sequenceLabel.frame.origin.x, 0, self.frame.size.width*0.297-5, self.valueView.frame.size.height);
    //状态
    self.stateLable.frame=CGRectMake(self.codeLable.frame.size.width+self.codeLable.frame.origin.x-5, 0, self.frame.size.width*0.227+10, self.frame.size.height);
    //罚杆
     self.penaltyLable.frame=CGRectMake(self.stateLable.frame.size.width+self.stateLable.frame.origin.x, 0, self.frame.size.width*0.172, self.frame.size.height);
    
    //球杆
    self.cueLable.frame=CGRectMake(self.penaltyLable.frame.size.width+self.penaltyLable.frame.origin.x, 0, SCREEN_WIDTH-(self.penaltyLable.frame.origin.x+self.penaltyLable.frame.size.width), self.frame.size.height);

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
