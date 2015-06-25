//
//  ZCEventCell.m
//  我爱高尔夫
//
//  Created by hh on 15/3/18.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCEventCell.h"
@interface ZCEventCell()
/**
 总杆数uilabel
 
 */

@property (weak, nonatomic)  UILabel *scoreLabel;
/**
 球场名称
 
 */
@property (weak, nonatomic)  UILabel *nameLabel;
/**
 开始的时间
 */
@property (weak, nonatomic)  UILabel *startedAtLabel;
/**
 赛事的类型
 */
@property (weak, nonatomic)  UILabel *typeLabel;
@property (weak, nonatomic)  UIImageView *typeLabelView;
/**
 记录的记分卡数量
 */

@property (weak, nonatomic)  UILabel *recorded_scorecards_count_label;
@property (weak, nonatomic)  UIImageView *recorded_scorecards_count_label_View;
/**
 成绩背景图片
 */
@property(weak,nonatomic) UIImageView *scoreImageView;
/**
 时间前的图片
 */
@property(weak,nonatomic) UIImageView *timeImage;
/**
 向右图片
 */
@property(weak,nonatomic) UIImageView *rightImage;
/**
 创建者的图片
 */
@property(nonatomic,weak)UIImageView *createImage;
/**
 比赛类型的图片
 */
@property(nonatomic,weak)UIImageView *scoringImage;
@end

@implementation ZCEventCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        //设置背景图片
        //self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"suoyou_bj_02"]];
       // self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"suoyou_bj_02"]];
        self.selectedBackgroundView=[[UIView alloc] initWithFrame:self.frame];
        self.selectedBackgroundView.backgroundColor=ZCColor(204, 204, 204);
        
        
        //self.selectedBackgroundView
        
        
        UIImageView *createImage=[[UIImageView alloc] init];
        [self.contentView addSubview:createImage];
        self.createImage=createImage;
        
        
        UIImageView *scoreImageView=[[UIImageView alloc] init];
        scoreImageView.image=[UIImage imageNamed:@"jjbs_lsbs"];
        [self.contentView addSubview:scoreImageView];
        self.scoreImageView=scoreImageView;
        //总杆数
        UILabel *scoreLabel=[[UILabel alloc] init];
        
        [scoreImageView addSubview:scoreLabel];
        self.scoreLabel=scoreLabel;
        scoreLabel.textAlignment=NSTextAlignmentCenter;
        scoreLabel.font=[UIFont systemFontOfSize:36 ];
        scoreLabel.textColor=ZCColor(255, 150, 29);
        
        //计分类型
        UIImageView *scoringImage=[[UIImageView alloc] init];
        [self.contentView addSubview:scoringImage];
        self.scoringImage=scoringImage;
        
        
        //球场名称
        UILabel *nameLabel=[[UILabel alloc] init];
        [self.contentView addSubview:nameLabel];
        self.nameLabel=nameLabel;
        nameLabel.textColor=ZCColor(34, 34, 34);
       // scoreLabel.textAlignment=NSTextAlignmentCenter;

        //创建时间
        UILabel *startedAtLabel=[[UILabel alloc] init];
        [self.contentView addSubview:startedAtLabel];
        self.startedAtLabel=startedAtLabel;
        startedAtLabel.font=[UIFont systemFontOfSize:13 ];
         startedAtLabel.textColor=ZCColor(85, 85, 85);
        //赛事类型
        
        UIImageView *typeLabelView=[[UIImageView alloc] init];
        self.typeLabelView=typeLabelView;
        typeLabelView.image=[UIImage imageNamed:@"jjbs_renshu_icon"];
        [self.contentView addSubview:typeLabelView];
        
        
        UILabel *typeLabel=[[UILabel alloc] init];
        [self.typeLabelView addSubview:typeLabel];
        self.typeLabel=typeLabel;
//        UIColor *col1=[UIColor colorWithPatternImage:[UIImage imageNamed:@"lianxisai-1"]];
//        typeLabel.backgroundColor=col1;
        //typeLabel.backgroundColor=col;
        typeLabel.textAlignment=NSTextAlignmentCenter;
        typeLabel.font=[UIFont fontWithName:@"AppleGothic" size:12];
       // typeLabel.font=[UIFont systemFontOfSize:11 ];
         typeLabel.textColor=ZCColor(102, 102, 102);

        //
        UIImageView *recorded_scorecards_count_label_View=[[UIImageView alloc] init];
        recorded_scorecards_count_label_View.image=[UIImage imageNamed:@"jjbs_renshu_icon"];
        
        self.recorded_scorecards_count_label_View=recorded_scorecards_count_label_View;
        [self.contentView addSubview:recorded_scorecards_count_label_View];
        
        UILabel *recorded_scorecards_count_label=[[UILabel alloc] init];
        [self.contentView addSubview:recorded_scorecards_count_label];
        self.recorded_scorecards_count_label=recorded_scorecards_count_label;
//        UIColor *col=[UIColor colorWithPatternImage:[UIImage imageNamed:@"lianxisai"]];
//        recorded_scorecards_count_label.backgroundColor=col;
        recorded_scorecards_count_label.textAlignment=NSTextAlignmentCenter;
        recorded_scorecards_count_label.font=[UIFont systemFontOfSize:12 ];
         recorded_scorecards_count_label.textColor=ZCColor(85, 85, 85);
        [recorded_scorecards_count_label_View addSubview:recorded_scorecards_count_label];
        
//        //球杆图片
//        UIImageView *qiuganImage=[[UIImageView alloc] init];
//        [self.contentView addSubview:qiuganImage];
//        self.qiuganImage=qiuganImage;
//        qiuganImage.image=[UIImage imageNamed:@"lsjfk_qiugan_iocn"];
        
      
        //时间前图片
        UIImageView *timeImage=[[UIImageView alloc] init];
        [self.contentView addSubview:timeImage];
        self.timeImage=timeImage;
        timeImage.image=[UIImage imageNamed:@"jjbs_rl_iocn"];
        
        //时间前图片
        UIImageView *rightImage=[[UIImageView alloc] init];
        [self.contentView addSubview:rightImage];
        self.rightImage=rightImage;
        rightImage.image=[UIImage imageNamed:@"icon_arrow3"];
        rightImage.contentMode =  UIViewContentModeCenter;

        
        }
    return self;
}



//判断<nill> 和（null）转换
- (id) _valueOrNil:(id)obj {
    if (!obj) {
        return nil;
    }
    if (obj == [NSNull null]) {
        return nil;
    }
    return obj;
}


-(void)setEvent:(ZCHistoricalEventsModel *)event
{
    _event=event;
    
    ZCLog(@"%@",self.event.player.strokes);
    
    
    if ([[NSString stringWithFormat:@"%@",event.player.owned] isEqual:@"0"]) {
       
      self.createImage.image=[UIImage imageNamed:@""];
    }else
    {
         self.createImage.image=[UIImage imageNamed:@"zhu_icon"];
    }
    
    
    
    if ([self _valueOrNil:self.event.player.strokes]==nil) {
        self.scoreLabel.text=@"未完成";
        self.scoreLabel.font=[UIFont systemFontOfSize:18];
    }else
    {
    self.scoreLabel.text=[NSString stringWithFormat:@"%@",self.event.player.strokes ];
    }
    
    
    if ([event.player.scoring_type isEqual:@"simple"]) {
        self.scoringImage.image=[UIImage imageNamed:@"jian_icon"];
    }else{
    self.scoringImage.image=[UIImage imageNamed:@"zhuan_icon"];
    }
  
    self.nameLabel.text=self.event.venue.name;
    
    //时间卓转成想要的格式
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"yyyy年MM月dd日 "];
    NSDate *confromTimesp=[NSDate dateWithTimeIntervalSince1970:self.event.started_at];
    NSString *confromTimespStr=[fmt stringFromDate:confromTimesp];
    
    self.startedAtLabel.text=confromTimespStr;
    
//    if ([self.event.type isEqual:@"practice"]) {
//        self.typeLabel.text=@"练习赛";
//    }else if([self.event.type isEqual:@"professional"]){
//    self.typeLabel.text=@"专业赛";
//    }
    self.typeLabel.text=[NSString stringWithFormat:@"%@人",self.event.players_count];
    self.recorded_scorecards_count_label.text=[NSString stringWithFormat:@"%@/18",self.event.player.recorded_scorecards_count ];
    

    
    
}









-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat createImageX=0;
    
    CGFloat createImageY=0;
    CGFloat createImageW=27;
    CGFloat createImageH=27;
    
    self.createImage.frame=CGRectMake(createImageX, createImageY, createImageW, createImageH);
    
    //成绩frame
    CGFloat scoreLabelX=17;
    
    CGFloat scoreLabelW=75;
    CGFloat scoreLabelH=75;
    CGFloat scoreLabelY=(self.frame.size.height-scoreLabelH)/2;
    self.scoreImageView.frame=CGRectMake(scoreLabelX, scoreLabelY, scoreLabelW, scoreLabelH);
    
    //球杆图片frame
    
//    CGFloat qiuganImageX=scoreLabelW*0.53;
//    CGFloat qiuganImageY=scoreLabelH+5;
//    CGFloat qiuganImageW=32;
//    CGFloat qiuganImageH=23;
    
    self.scoreLabel.frame=CGRectMake(0, 0, self.scoreImageView.frame.size.width, self.scoreImageView.frame.size.height);
    
    
    
    
    CGFloat scoringImageX=self.frame.size.width*0.34;
    CGFloat scoringImageY=13;
    CGFloat scoringImageW=16;
    CGFloat scoringImageH=16;
    self.scoringImage.frame=CGRectMake(scoringImageX, scoringImageY, scoringImageW, scoringImageH);
    
    //nameLabel frame
    
    CGFloat nameLabelX=scoringImageX+scoringImageW+10;
    CGFloat nameLabelY=10;
    CGFloat nameLabelW=self.frame.size.width*0.6;
    CGFloat nameLabelH=23;
    
    self.nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);


    //timeImage frame
    
    CGFloat timeImageX=scoringImageX;
    CGFloat timeImageY=nameLabelY+nameLabelH+6;
    CGFloat timeImageW=17;
    CGFloat timeImageH=15;
    
    self.timeImage.frame=CGRectMake(timeImageX, timeImageY, timeImageW, timeImageH);
    

    
    //startedAtLabel frame
    
    CGFloat startedAtLabelX=timeImageX+timeImageW+6;
    CGFloat startedAtLabelY=timeImageY;
    CGFloat startedAtLabelW=170;
    CGFloat startedAtLabelH=15;
    
    self.startedAtLabel.frame=CGRectMake(startedAtLabelX, startedAtLabelY, startedAtLabelW, startedAtLabelH);
    

    
    //typeLabel frame
    
    CGFloat typeLabelX=timeImageX;
    CGFloat typeLabelY=timeImageY+timeImageH+12;
    CGFloat typeLabelW=75;
    CGFloat typeLabelH=20;
    
    self.typeLabelView.frame=CGRectMake(typeLabelX, typeLabelY, typeLabelW, typeLabelH);
    
    self.typeLabel.frame=CGRectMake(0, 2, self.typeLabelView.frame.size.width, self.typeLabelView.frame.size.height);
    //recorded_scorecards_count_label frame
    
    CGFloat countLabelX=typeLabelX+typeLabelW+10;
    CGFloat countLabelY=timeImageY+timeImageH+12;
    CGFloat countLabelW=75;
    CGFloat countLabelH=20;
    
   // self.recorded_scorecards_count_label.frame=CGRectMake(countLabelX, countLabelY, countLabelW, countLabelH);
    self.recorded_scorecards_count_label_View.frame=CGRectMake(countLabelX, countLabelY, countLabelW, countLabelH);
    //图片上文字的位置
    self.recorded_scorecards_count_label.frame=self.recorded_scorecards_count_label_View.bounds;

     //向右的图片
    
    CGFloat rightImageX=self.frame.size.width-self.frame.size.width*0.1;
    CGFloat rightImageY=(self.frame.size.height-17)*0.5;
    CGFloat rightImageW=10;
    CGFloat rightImageH=17;
    
    self.rightImage.frame=CGRectMake(rightImageX, rightImageY, rightImageW, rightImageH);


}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
   
}

@end
