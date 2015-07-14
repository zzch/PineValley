//
//  ZCScorecarTableViewCell.m
//  我爱高尔夫
//
//  Created by hh on 15/2/4.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCScorecarTableViewCell.h"
#import "ZCNilButtom.h"
#import "ZCShowButton.h"
@interface ZCScorecarTableViewCell()
/*
 创建球洞
 */
@property(nonatomic,weak) UILabel *numberLabel;
/*
 标准杆label
 */
@property(nonatomic,weak) UILabel *parLabel;
/*
距离球洞位置
 */
@property(nonatomic,weak) UILabel *distanceLabel;
/*
 小P的Label
 */
@property(nonatomic,weak) UILabel *PLabel;
/*
 小Y的Label
 */
@property(nonatomic,weak) UILabel *YLabel;
/*
  parLabel
 */
@property(nonatomic,weak) UILabel *numberparLabel;



/*
 加号图片
 */
@property(nonatomic,weak) ZCNilButtom *nilButtom;

/*
 显示值的按钮
 */
@property(nonatomic,weak) ZCShowButton *showButton;





/*
  左边view
 */
@property(nonatomic,weak) UIView *liftView;

/*
 中间view
 */
@property(nonatomic,weak) UIView *middleView;

@property(nonatomic,weak) UIImageView *image1;
/**
 *  小圆点
 */
@property(nonatomic,weak) UIImageView *dotImage;



@end
@implementation ZCScorecarTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //背景
        self.backgroundColor=ZCColor(237, 237, 237);
        // self.backgroundView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jifenka_yihangbeijing"]];
        //self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"suoyou_bj_02"]];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        self.selectedBackgroundView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jfk_anxia_bj"]];
        
        //左边view
        UIView *liftView=[[UIView alloc] init];
        [self.contentView addSubview:liftView];
        self.liftView=liftView;
        
        //中间view
        UIView *middleView=[[UIView alloc] init];
        [self.contentView addSubview:middleView];
        self.middleView=middleView;
       // self.middleView.backgroundColor=RGBACOLOR(170, 170, 170, 0.6);

        
        //创建球洞编号
        UILabel *numberLabel=[[UILabel alloc] init];
        [self.liftView addSubview:numberLabel];
        numberLabel.textAlignment=NSTextAlignmentCenter;
        //ballLabel.font=[UIFont fontWithName:@"Helvetica" size:20];
        
        numberLabel.font=[UIFont systemFontOfSize:38];
        
        
       // UIColor *col=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jfk_dong"]];
        //numberLabel.backgroundColor=col;
       // numberLabel.textColor=ZCColor(240, 208, 122);
     
        self.numberLabel=numberLabel;
       
        
        UILabel *numberparLabel=[[UILabel alloc] init];
        numberparLabel.textAlignment=NSTextAlignmentCenter;
        numberparLabel.textColor=ZCColor(85, 85, 85);
        numberparLabel.font=[UIFont systemFontOfSize:16];
        [self.liftView addSubview:numberparLabel];
        self.numberparLabel=numberparLabel;
        
        
//        //创建标准杆
//        UILabel *parLabel=[[UILabel alloc] init];
//        [self.liftView addSubview:parLabel];
//        parLabel.textColor=ZCColor(240, 208, 122);
//        parLabel.textAlignment=NSTextAlignmentCenter;
//       // parLabel.font=[UIFont systemFontOfSize:26];
//        parLabel.font=[UIFont fontWithName:@"Arial" size:26];
//        self.parLabel=parLabel;
        
        
        //创建离球洞距离的Label
        UILabel *distanceLabel=[[UILabel alloc] init];
        [self.liftView addSubview:distanceLabel];
        distanceLabel.font=[UIFont systemFontOfSize:16];
        self.distanceLabel=distanceLabel;
       // self.distanceLabel.font=[UIFont fontWithName:@"Arial" size:20];
        distanceLabel.textColor=ZCColor(85, 85, 85);
        distanceLabel.textAlignment=NSTextAlignmentCenter;
        self.distanceLabel=distanceLabel;
        
        //创建小P label
        UILabel *PLabel=[[UILabel alloc] init];
        [self.liftView addSubview:PLabel];
        PLabel.text=@"P";
        PLabel.textColor= ZCColor(85, 85, 85);
        PLabel.font=[UIFont systemFontOfSize:10];
        self.PLabel=PLabel;

        //创建小Y label
        UILabel *YLabel=[[UILabel alloc] init];
        [self.liftView addSubview:YLabel];
        YLabel.text=@"Y";
        YLabel.font=[UIFont systemFontOfSize:10];
        YLabel.textColor=ZCColor(85, 85, 85);
        self.YLabel=YLabel;
        
        
        
        //创建小圆点
        UIImageView *dotImage=[[UIImageView alloc] init];
        [self addSubview:dotImage];
        self.dotImage=dotImage;
//
        //创建可显示信息值的showLabel
        if (self.scorecard.score==nil) {
            
           // ZCLog(@"%@",self.scorecard.score);
            //创建加号图片
            
            ZCNilButtom *nilButtom=[[ZCNilButtom alloc] init];
            
           // UIColor *col=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jifenka_yihangbeijing"]];
            //addImage.backgroundColor=col;
            
//            [nilButtom setImage:[UIImage imageNamed:@"jfk_tianjia"] forState:UIControlStateNormal];
//            [nilButtom setImage:[UIImage imageNamed:@"jfk_tiejia_anxia"] forState:UIControlStateHighlighted];
            [nilButtom addTarget:self action:@selector(addImageClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:nilButtom];
            self.nilButtom=nilButtom;
            
//            UIImageView *image=[[UIImageView alloc] init];
//            
//                       image.image=[UIImage imageNamed:@"tiejia"];
//             [self.addImage addSubview:image];
//            self.image1=image;
            
            
           
        }else{
        ZCShowButton *showButton=[[ZCShowButton alloc] init];
        [self.contentView addSubview:showButton];
        self.showButton=showButton;
        }
        
        
        
        
    }

    return self;
}

//点击addImage
-(void)addImageClick:(UIButton *)sender
{
    
    
   //创建代理，通知控制器+号被点击了或者显示的按钮被点击
    if ([self.delegate respondsToSelector:@selector(addImageDidClick:)]) {
        [self.delegate addImageDidClick:sender];
    }

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




-(void)setScorecard:(ZCscorecard *)scorecard
{
    _scorecard=scorecard;
    
   
    if([self _valueOrNil:scorecard.score])
    {
        if (self.nilButtom) {
          [self.nilButtom removeFromSuperview];
            
          
        }
        if (self.showButton) {
            [self.showButton removeFromSuperview];
        }
        //创建可显示的showLabel
        ZCShowButton *showButton=[[ZCShowButton alloc] init];
        
        showButton.scorecard=scorecard;
        [self.contentView addSubview:showButton];
        [showButton addTarget:self action:@selector(addImageClick:) forControlEvents:UIControlEventTouchUpInside];
        self.showButton=showButton;
        
       
        
    }

    
    self.nilButtom.tee_boxes=scorecard.tee_boxes;
    self.numberLabel.text=[NSString stringWithFormat:@"%@",scorecard.number];
    self.numberparLabel.text=[NSString stringWithFormat:@"%@",scorecard.par];
    
    
    ZCTee_boxes *teeBox;
    NSString *teeColer;
    for (ZCTee_boxes *tee in self.scorecard.tee_boxes) {
        if ([[NSString stringWithFormat:@"%@",tee.used]  isEqual:@"1"]) {
            teeBox=tee;
            teeColer=tee.color;
            break;
        }
    }

    
    
    self.distanceLabel.text=[NSString stringWithFormat:@"%@",teeBox.distance_from_hole];
    
    
    if ([teeColer isEqual:@"white"]) {
        self.dotImage.image=[UIImage imageNamed:@"bai_t"];
    }else if ([teeColer isEqual:@"red"])
    {
        self.dotImage.image=[UIImage imageNamed:@"hong_t"];
    }else if ([teeColer isEqual:@"blue"])
    {
        self.dotImage.image=[UIImage imageNamed:@"lan_t"];
    }else if ([teeColer isEqual:@"black"])
    {
       self.dotImage.image=[UIImage imageNamed:@"hei_t"];
    }else if ([teeColer isEqual:@"gold"])
    {
       self.dotImage.image=[UIImage imageNamed:@"huang_t"];
    }

    
    
    
//    if ([scorecard.tee_box_color isEqual:@"red"]) {
//        UIColor *col=[UIColor colorWithPatternImage:[UIImage imageNamed:@"hongdong"]];
//        self.numberLabel.backgroundColor=col;
//        self.numberLabel.textColor=ZCColor(208, 210, 212);
//        
//    }else if ([scorecard.tee_box_color isEqual:@"white"])
//    {
//      UIColor *col=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jfk_bai"]];
//        self.numberLabel.backgroundColor=col;
//        self.numberLabel.textColor=ZCColor(33, 33, 33);
//    }else if ([scorecard.tee_box_color isEqual:@"blue"])
//    {
//        UIColor *col=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jfk_lan"]];
//        self.numberLabel.backgroundColor=col;
//        self.numberLabel.textColor=ZCColor(208, 210, 212);
//
//    }else if ([scorecard.tee_box_color isEqual:@"black"])
//    {
//        UIColor *col=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jfk_hei"]];
//        self.numberLabel.backgroundColor=col;
//        self.numberLabel.textColor=ZCColor(208, 210, 212);
//
//    }else if ([scorecard.tee_box_color isEqual:@"gold"])
//    {
//        UIColor *col=[UIColor colorWithPatternImage:[UIImage imageNamed:@"jingdong"]];
//        self.numberLabel.backgroundColor=col;
//        self.numberLabel.textColor=ZCColor(33, 33, 33);
//
//    }
//    
   
    
//
//    
//    self.scoreLabel.text=[NSString stringWithFormat:@"%@",scorecard.score];
//    self.puttsLabel.text=[NSString stringWithFormat:@"%@",scorecard.putts];
//    self.penaltiesLabel.text=[NSString stringWithFormat:@"%@",scorecard.penalties];
//    self.driving_distance_label.text=[NSString stringWithFormat:@"%@",scorecard.driving_distance];
//    self.directionLabel.text=[NSString stringWithFormat:@"%@",scorecard.direction];
//    
    
    
}
//-(void)setScorecard:(ZCScorecards *)scorecard
//{
//    _scorecard=scorecard;
//    
//     self.ballLabel.text=scorecard.number;

//    if (scorecard.save) {
//        [self.addImage removeFromSuperview];
//        //移除之前的button按钮
//        [self.showButton removeFromSuperview];
//        //创建可显示信息值的button
//        ZCShowButton *showButton=[[ZCShowButton alloc] init];
//        [self.contentView addSubview:showButton];
//        showButton.backgroundColor=[UIColor redColor];
//        self.showButton=showButton;
//        showButton.scorecard=self.scorecard;
//        //ZCLog(@"000000%@",_scorecard.leftText);
//        [showButton addTarget:self action:@selector(addImageClick:) forControlEvents:UIControlEventTouchUpInside];
//        

 //   }
    
    
   //ZCLog(@"11111111111111111%@",scorecard.leftText);
   
//}


//根据字符串计算出宽高
-(CGRect)getFrame:(CGSize)frame content:(NSString *)content fontSize:(UIFont *)fontSize
{
    CGRect rect = [content boundingRectWithSize:frame options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:fontSize,NSFontAttributeName, nil] context:nil];
    return rect;
}






-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //创建左边View的frame
    CGFloat liftViewX=0;
    CGFloat liftViewY=0;
    CGFloat liftViewW=self.frame.size.width*0.236;
    CGFloat liftViewH=self.frame.size.height;
    
    self.liftView.frame=CGRectMake(liftViewX, liftViewY, liftViewW, liftViewH);

    //创建中间的view
    
    CGFloat middleViewX=liftViewW;
    CGFloat middleViewY=0;
    CGFloat middleViewW=1;
    CGFloat middleViewH=self.frame.size.height;

    self.middleView.frame=CGRectMake(middleViewX, middleViewY, middleViewW, middleViewH);
    
    //创建球洞ballLabel的frame
    
    CGFloat ballLabelW=60;
    CGFloat ballLabelH=30;
    CGFloat ballLabelX=(self.liftView.frame.size.width-ballLabelW)*0.5;
    CGFloat ballLabelY=17;

    self.numberLabel.frame=CGRectMake(ballLabelX, ballLabelY, ballLabelW, ballLabelH);
    
    
    
    CGFloat numberparLabelW=20;
    CGFloat numberparLabelH=20;
    CGFloat numberparLabelX=(self.liftView.frame.size.width-70)*0.5;
    CGFloat numberparLabelY=ballLabelY+ballLabelH+7;
    
    self.numberparLabel.frame=CGRectMake(numberparLabelX, numberparLabelY, numberparLabelW, numberparLabelH);

    
    
    
//    
//    //parLabel的frame
//    CGFloat parLabelX=self.liftView.frame.size.width*0.192;
//    CGFloat parLabelY=ballLabelY+ballLabelH+10;
//    CGFloat parLabelW=22;
//    CGFloat parLabelH=22;
//    
//    self.parLabel.frame=CGRectMake(parLabelX, parLabelY, parLabelW, parLabelH);
//
//    
    //小P得PLabel的frame
    CGFloat PLabelW=10;
    CGFloat PLabelH=15;
    CGFloat PLabelX=numberparLabelX+numberparLabelW-3;
    CGFloat PLabelY=numberparLabelY+numberparLabelH-PLabelH;
    
    self.PLabel.frame=CGRectMake(PLabelX, PLabelY, PLabelW, PLabelH);
    //距离球洞的距离distanceLabel的frame
    
    CGFloat distanceLabelX=PLabelX+PLabelW+1;
    CGFloat distanceLabelY=numberparLabelY;
    CGFloat distanceLabelW=[self getFrame:CGSizeMake(1000, 20) content:self.distanceLabel.text fontSize:[UIFont systemFontOfSize:16]].size.width;
    CGFloat distanceLabelH=20;
    self.distanceLabel.frame=CGRectMake(distanceLabelX, distanceLabelY, distanceLabelW, distanceLabelH);
    //小Y得YLabel的frame
    CGFloat YLabelX=distanceLabelX+distanceLabelW;
    CGFloat YLabelY=PLabelY;
    CGFloat YLabelW=[self getFrame:CGSizeMake(1000, 15) content:@"Y" fontSize:[UIFont systemFontOfSize:10]].size.width;
    CGFloat YLabelH=15;
    self.YLabel.frame=CGRectMake(YLabelX, YLabelY, YLabelW, YLabelH);
    
    
    
    CGFloat dotImageX=YLabelX+YLabelW+2;
    CGFloat dotImageY=PLabelY+YLabelH-9;
    CGFloat dotImageW=7;
    CGFloat dotImageH=7;
    self.dotImage.frame=CGRectMake(dotImageX, dotImageY, dotImageW, dotImageH);
    
    
    //showButton的frame
    CGFloat showLabelX=middleViewX+middleViewW;
    CGFloat showLabelY=0;
    CGFloat showLabelW=self.frame.size.width-showLabelX;
    CGFloat showLabelH=self.frame.size.height;
    self.showButton.frame=CGRectMake(showLabelX, showLabelY, showLabelW, showLabelH);
    
    
    //addImage的frame
   // self.addImage.frame=self.showButton.bounds;
    
    //showButton的frame
    CGFloat addImageX=middleViewX+middleViewW;
    CGFloat addImageY=0;
    CGFloat addImageW=self.frame.size.width-addImageX;
    CGFloat addImageH=self.frame.size.height;
    self.nilButtom.frame=CGRectMake(addImageX, addImageY, addImageW, addImageH);
    
    
    
    
//    CGFloat  imageX=(self.nilButtom.frame.size.width-self.addImage.frame.size.width*0.117)*0.5;
//    CGFloat  imageY=(self.nilButtom.frame.size.height-self.addImage.frame.size.height*0.24)*0.5;
//    CGFloat  imageW=self.nilButtom.frame.size.width*0.117;
//    CGFloat  imageH=self.nilButtom.frame.size.height*0.24;
//    self.image1.frame=CGRectMake(imageX, imageY, imageW, imageH);

    
//    //成绩frame
//    self.resultsView.frame=CGRectMake(0, 0, self.frame.size.width-40, 70);
//    
//    // distanceLabel的frame
//    self.drivingImage.frame=CGRectMake(10, 70, 15, 15);
//    
//    //求道frame
//    self.driving_distance_label.frame=CGRectMake(30, 70, 40, 30);
//    //求道方向前图片
//    self.directionImage.frame=CGRectMake(70, 70, 20, 20);
//    //求道的值frame
//    self.directionLabel.frame=CGRectMake(100, 70, 50, 30);
//    
//    //向右箭头的图片
//    self.rightImage.frame=CGRectMake(self.frame.size.width-30, 20, 40, 30);
//    
//

}






- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

@end
