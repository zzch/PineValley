//
//  ZCHistoryOfCompetitiveTableViewCell.m
//  我爱高尔夫
//
//  Created by hh on 15/4/29.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCHistoryOfCompetitiveTableViewCell.h"
@interface ZCHistoryOfCompetitiveTableViewCell()

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
 球杆图片
 */
@property(weak,nonatomic) UIImageView *qiuganImage;
/**
 时间前的图片
 */
@property(weak,nonatomic) UIImageView *timeImage;
/**
 向右图片
 */
@property(weak,nonatomic) UIImageView *rightImage;

/**
 参加人数
 */
@property(weak,nonatomic) UILabel *personNumberLabel;


@end

@implementation ZCHistoryOfCompetitiveTableViewCell
+(instancetype)cellWithTable:(UITableView *)tableView
{
    static NSString *ID = @"ZCHistoryOfCompetitiveTableViewCell.h";
    ZCHistoryOfCompetitiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZCHistoryOfCompetitiveTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return  cell;
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        //设置背景图片
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bj"]];
        
        self.selectedBackgroundView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lishijifengka_bj_anxia"]];
        // self.selectedBackgroundView.backgroundColor=[UIColor redColor];
        //        self.backgroundColor
        
        
        //总杆数
        UILabel *scoreLabel=[[UILabel alloc] init];
        [self.contentView addSubview:scoreLabel];
        self.scoreLabel=scoreLabel;
        scoreLabel.textAlignment=NSTextAlignmentCenter;
        scoreLabel.font=[UIFont systemFontOfSize:34 ];
        scoreLabel.textColor=[UIColor whiteColor];
        
        //球场名称
        UILabel *nameLabel=[[UILabel alloc] init];
        [self.contentView addSubview:nameLabel];
        self.nameLabel=nameLabel;
        nameLabel.textColor=[UIColor whiteColor];
        // scoreLabel.textAlignment=NSTextAlignmentCenter;
        
        //创建时间
        UILabel *startedAtLabel=[[UILabel alloc] init];
        [self.contentView addSubview:startedAtLabel];
        self.startedAtLabel=startedAtLabel;
        startedAtLabel.textColor=[UIColor whiteColor];
        
        
        //人数
        
        UILabel *personNumberLabel=[[UILabel alloc] init];
        [self.contentView addSubview:personNumberLabel];
        self.personNumberLabel=personNumberLabel;
        personNumberLabel.textColor=[UIColor whiteColor];
        
        
        //赛事类型
        
        UIImageView *typeLabelView=[[UIImageView alloc] init];
        self.typeLabelView=typeLabelView;
        typeLabelView.image=[UIImage imageNamed:@"lianxisai-1"];
        [self.contentView addSubview:typeLabelView];
        
        
        UILabel *typeLabel=[[UILabel alloc] init];
        [self.typeLabelView addSubview:typeLabel];
        self.typeLabel=typeLabel;
        //        UIColor *col1=[UIColor colorWithPatternImage:[UIImage imageNamed:@"lianxisai-1"]];
        //        typeLabel.backgroundColor=col1;
        //typeLabel.backgroundColor=col;
        typeLabel.textAlignment=NSTextAlignmentCenter;
        typeLabel.font=[UIFont fontWithName:@"AppleGothic" size:11];
        // typeLabel.font=[UIFont systemFontOfSize:11 ];
        typeLabel.textColor=[UIColor whiteColor];
        
        //
        UIImageView *recorded_scorecards_count_label_View=[[UIImageView alloc] init];
        recorded_scorecards_count_label_View.image=[UIImage imageNamed:@"lianxisai"];
        
        self.recorded_scorecards_count_label_View=recorded_scorecards_count_label_View;
        [self.contentView addSubview:recorded_scorecards_count_label_View];
        
        UILabel *recorded_scorecards_count_label=[[UILabel alloc] init];
        [self.contentView addSubview:recorded_scorecards_count_label];
        self.recorded_scorecards_count_label=recorded_scorecards_count_label;
        //        UIColor *col=[UIColor colorWithPatternImage:[UIImage imageNamed:@"lianxisai"]];
        //        recorded_scorecards_count_label.backgroundColor=col;
        recorded_scorecards_count_label.textAlignment=NSTextAlignmentCenter;
        recorded_scorecards_count_label.font=[UIFont systemFontOfSize:14 ];
        recorded_scorecards_count_label.textColor=[UIColor whiteColor];
        
        [recorded_scorecards_count_label_View addSubview:recorded_scorecards_count_label];
        
        //球杆图片
        UIImageView *qiuganImage=[[UIImageView alloc] init];
        [self.contentView addSubview:qiuganImage];
        self.qiuganImage=qiuganImage;
        qiuganImage.image=[UIImage imageNamed:@"qiugan"];
        
        
        //时间前图片
        UIImageView *timeImage=[[UIImageView alloc] init];
        [self.contentView addSubview:timeImage];
        self.timeImage=timeImage;
        timeImage.image=[UIImage imageNamed:@"calendar"];
        
        //时间前图片
        UIImageView *rightImage=[[UIImageView alloc] init];
        [self.contentView addSubview:rightImage];
        self.rightImage=rightImage;
        rightImage.image=[UIImage imageNamed:@"icon_arrow"];
        rightImage.contentMode =  UIViewContentModeCenter;
        
        
    }
    return self;
}




//-(void)setHistoryOfCompetitiveModel:(ZCHistoryOfCompetitiveModel *)historyOfCompetitiveModel
//
//{
//    _historyOfCompetitiveModel=historyOfCompetitiveModel;
//    
//    if ([self.historyOfCompetitiveModel.score isKindOfClass:[NSNull class]]) {
//        self.scoreLabel.text=@"未记录";
//        self.scoreLabel.font=[UIFont systemFontOfSize:25];
//    }else
//    {
//        self.scoreLabel.text=[NSString stringWithFormat:@"%@",self.historyOfCompetitiveModel.score ];
//    }
//    
//    self.nameLabel.text=self.historyOfCompetitiveModel.venue.name;
//    
//    //时间卓转成想要的格式
//    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    [fmt setDateFormat:@"yyyy年MM月dd日 "];
//    NSDate *confromTimesp=[NSDate dateWithTimeIntervalSince1970:self.historyOfCompetitiveModel.started_at];
//    NSString *confromTimespStr=[fmt stringFromDate:confromTimesp];
//    
//    self.startedAtLabel.text=confromTimespStr;
//    
//    
//    self.personNumberLabel.text=[NSString stringWithFormat:@"(%@人)",self.historyOfCompetitiveModel.players_count];
//    
//    if ([self.historyOfCompetitiveModel.type isEqual:@"tournament"]) {
//        self.typeLabel.text=@"竞技赛";
//    }else if([self.historyOfCompetitiveModel.type isEqual:@"professional"]){
//        self.typeLabel.text=@"专业赛";
//    }
//    // if (![self.event.recorded_scorecards_count isKindOfClass:[NSNull class]]) {
//    
//    // }
//    self.recorded_scorecards_count_label.text=[NSString stringWithFormat:@"%@/18",self.historyOfCompetitiveModel.recorded_scorecards_count ];
//    
//    
//    
//    
//}









-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //成绩frame
    CGFloat scoreLabelX=0;
    CGFloat scoreLabelY=15;
    CGFloat scoreLabelW=self.frame.size.width*0.34;
    CGFloat scoreLabelH=self.frame.size.height*0.7;
    self.scoreLabel.frame=CGRectMake(scoreLabelX, scoreLabelY, scoreLabelW, scoreLabelH);
    
    //球杆图片frame
    
    CGFloat qiuganImageX=scoreLabelW*0.53;
    CGFloat qiuganImageY=scoreLabelH+5;
    CGFloat qiuganImageW=32;
    CGFloat qiuganImageH=23;
    
    self.qiuganImage.frame=CGRectMake(qiuganImageX, qiuganImageY, qiuganImageW, qiuganImageH);
    
    
    
    //nameLabel frame
    
    CGFloat nameLabelX=scoreLabelW;
    CGFloat nameLabelY=10;
    CGFloat nameLabelW=self.frame.size.width*0.6;
    CGFloat nameLabelH=23;
    
    self.nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    
    //timeImage frame
    
    CGFloat timeImageX=scoreLabelW;
    CGFloat timeImageY=nameLabelY+nameLabelH+5;
    CGFloat timeImageW=17;
    CGFloat timeImageH=15;
    
    self.timeImage.frame=CGRectMake(timeImageX, timeImageY, timeImageW, timeImageH);
    
    
    
    
    
    
    //startedAtLabel frame
    
    CGFloat startedAtLabelX=timeImageX+timeImageW+5;
    CGFloat startedAtLabelY=timeImageY;
    CGFloat startedAtLabelW=130;
    CGFloat startedAtLabelH=15;
    
    self.startedAtLabel.frame=CGRectMake(startedAtLabelX, startedAtLabelY, startedAtLabelW, startedAtLabelH);
    
    
    //personNumberLabel frame
    CGFloat personNumberLabelX=startedAtLabelX+startedAtLabelW+5;
    CGFloat personNumberLabelY=timeImageY;
    CGFloat personNumberLabelW=70;
    CGFloat personNumberLabelH=15;
    
    self.personNumberLabel.frame=CGRectMake(personNumberLabelX, personNumberLabelY, personNumberLabelW, personNumberLabelH);
    
    
    //typeLabel frame
    
    CGFloat typeLabelX=timeImageX;
    CGFloat typeLabelY=timeImageY+timeImageH+10;
    CGFloat typeLabelW=75;
    CGFloat typeLabelH=20;
    
    self.typeLabelView.frame=CGRectMake(typeLabelX, typeLabelY, typeLabelW, typeLabelH);
    
    self.typeLabel.frame=self.typeLabelView.bounds;
    //recorded_scorecards_count_label frame
    
    CGFloat countLabelX=typeLabelX+typeLabelW+10;
    CGFloat countLabelY=timeImageY+timeImageH+10;
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



@end
