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
@property(nonatomic,weak)UILabel *addLabel;



@end
@implementation ZCSwingCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        
       // if (self.selectTheDisplay.club==nil) {
            
     

        
        UIView *valueView=[[UIView alloc] init];
        
        valueView.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        self.valueView=valueView;
        [self.contentView addSubview:valueView];
        
        //序号
        UILabel *sequenceLabel=[[UILabel alloc] init];
        sequenceLabel.frame=CGRectMake(0, 0, 60, self.valueView.frame.size.height);
        [valueView addSubview:sequenceLabel];
        self.sequenceLabel=sequenceLabel;
        
        
        //码数
        UILabel *codeLable=[[UILabel alloc] init];
        codeLable.backgroundColor=[UIColor brownColor];
        codeLable.frame=CGRectMake(60, 0, 80, self.valueView.frame.size.height);
        self.codeLable=codeLable;
        [valueView addSubview:codeLable];
        
        
        //状态stateLable
        UILabel *stateLable=[[UILabel alloc] init];
        stateLable.backgroundColor=[UIColor blueColor];
        stateLable.frame=CGRectMake(150, 0, 80, self.frame.size.height);
        self.stateLable=stateLable;
        [valueView addSubview:stateLable];
        
        //罚杆penaltyLable
        UILabel *penaltyLable=[[UILabel alloc] init];
        penaltyLable.backgroundColor=[UIColor yellowColor];

        penaltyLable.frame=CGRectMake(240, 0, 70, self.frame.size.height);
        self.penaltyLable=penaltyLable;
        [valueView addSubview:penaltyLable];
        
        
        //球杆cueLable
        UILabel *cueLable=[[UILabel alloc] init];
        cueLable.backgroundColor=[UIColor redColor];
        cueLable.frame=CGRectMake(310, 0, 60, self.frame.size.height);
        self.cueLable=cueLable;
        [valueView addSubview:cueLable];

        
      //  }else{

        //如果没值显示加号
        
        UILabel *addLabel=[[UILabel alloc] init];
            addLabel.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        addLabel.text=@"+++++++++++++";
            
        [self addSubview:addLabel];
        self.addLabel=addLabel;
    //    }
        
    }

    return self;

}




-(void)setSelectTheDisplay:(ZCSelectTheDisplay *)selectTheDisplay
{
    _selectTheDisplay=selectTheDisplay;
    
    if (self.selectTheDisplay.distance_from_hole) {
        self.addLabel.hidden=YES;
        self.valueView.hidden=NO;
    }else
    {
        self.valueView.hidden=YES;
    self.addLabel.hidden=NO;
    }
    
    self.codeLable.text=[NSString stringWithFormat:@"%@",self.selectTheDisplay.distance_from_hole];
    self.stateLable.text=[NSString stringWithFormat:@"%@",self.selectTheDisplay.point_of_fall];
    self.penaltyLable.text=[NSString stringWithFormat:@"%@",self.selectTheDisplay.penalties];
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
    //self.addLabel.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
