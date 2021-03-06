//
//  ZCFightTheLandlordView.m
//  iGolf
//
//  Created by hh on 15/7/21.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//斗地主

#import "ZCFightTheLandlordView.h"
#import "ZCDouModel.h"
@interface ZCFightTheLandlordView()
@property(nonatomic,strong)NSMutableArray *myRects;
@property(nonatomic,strong)NSMutableArray *frames;
@property(nonatomic,weak)UIImageView *personView;
@property(nonatomic,weak)UIImage *personImage;
//机主的名字
@property(nonatomic,copy)NSString *personName;

//拖动时用到的属性，记录最后的选中button的tag
@property(nonatomic,assign)NSInteger tmptag;

@property(nonatomic,assign)NSInteger indexTag;

@property(nonatomic,assign)int isOpen1;
@property(nonatomic,assign)int isOpen2;
@property(nonatomic,assign)int isOpen3;

@property(nonatomic,strong)ZCDouModel *userModel;
@property(nonatomic,strong)ZCDouModel *otherModel;
@property(nonatomic,strong)ZCDouModel *anotherModel;

//哪个被点击跟换头像
@property(nonatomic,assign)int pointLocation;

@property(nonatomic,weak)UIImageView *imageView1;
@property(nonatomic,weak)UIImageView *imageView2;
@property(nonatomic,weak)UIImageView *imageView3;

@property(nonatomic,weak)UIScrollView *scollView;

@end
@implementation ZCFightTheLandlordView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        //初始化两个数组
     self.myRects = [NSMutableArray arrayWithCapacity:3];
     self.frames = [NSMutableArray arrayWithCapacity:3];
        
        // 获取路劲 取出图片
        NSString *path=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"personImage.png"];
        NSData *imageData=[NSData dataWithContentsOfFile:path];
        UIImage *image=[[UIImage alloc] initWithData:imageData];
        self.personImage=image;
        
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
        ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
        self.personName=account.nickname;
        
        self.backgroundColor=ZCColor(237, 237, 237);
        
        
        
        UIScrollView *scollView=[[UIScrollView  alloc] init];
        scollView.backgroundColor=ZCColor(237, 237, 237);
        
        
        scollView.bounces=NO;
        [self addSubview:scollView];
        self.scollView=scollView;

        
        
        UILabel *farmersLabel=[[UILabel alloc] init];
        CGFloat farmersLabelX=15;
        CGFloat farmersLabelY=17;
        CGFloat farmersLabelW=(SCREEN_WIDTH-30)/3;
        CGFloat farmersLabelH=20;
        farmersLabel.frame=CGRectMake(farmersLabelX, farmersLabelY, farmersLabelW, farmersLabelH);
        farmersLabel.text=@"平民";
        farmersLabel.textColor=ZCColor(34, 34, 34);
        farmersLabel.textAlignment=NSTextAlignmentCenter;
        [scollView addSubview:farmersLabel];
        
        UILabel *numberLabel=[[UILabel alloc] init];
        numberLabel.frame=CGRectMake(farmersLabelX, farmersLabelY+farmersLabelH+5, farmersLabelW, farmersLabelH);
        numberLabel.text=@"1号发球";
        numberLabel.font=[UIFont systemFontOfSize:12];
        numberLabel.textAlignment=NSTextAlignmentCenter;
        [scollView addSubview:numberLabel];
        
        
        
        UILabel *diZhuLabel=[[UILabel alloc] init];
        CGFloat diZhuLabelX=farmersLabelX+farmersLabelW;
        CGFloat diZhuLabelY=17;
        CGFloat diZhuLabelW=(SCREEN_WIDTH-20)/3;
        CGFloat diZhuLabelH=20;
        diZhuLabel.frame=CGRectMake(diZhuLabelX, diZhuLabelY, diZhuLabelW, diZhuLabelH);
        diZhuLabel.text=@"地主";
        diZhuLabel.textColor=ZCColor(34, 34, 34);
        diZhuLabel.textAlignment=NSTextAlignmentCenter;
        [scollView addSubview:diZhuLabel];
        
        UILabel *numberLabel2=[[UILabel alloc] init];
        numberLabel2.frame=CGRectMake(diZhuLabelX, farmersLabelY+farmersLabelH+5, farmersLabelW, farmersLabelH);
        numberLabel2.text=@"2号发球";
        numberLabel2.font=[UIFont systemFontOfSize:12];
        numberLabel2.textAlignment=NSTextAlignmentCenter;
        [scollView addSubview:numberLabel2];

        
        
        
        UILabel *farmersLabel2=[[UILabel alloc] init];
        CGFloat farmersLabel2X=diZhuLabelX+diZhuLabelW;
        CGFloat farmersLabel2Y=17;
        CGFloat farmersLabel2W=(SCREEN_WIDTH-20)/3;
        CGFloat farmersLabel2H=20;
        farmersLabel2.frame=CGRectMake(farmersLabel2X, farmersLabel2Y, farmersLabel2W, farmersLabel2H);
        farmersLabel2.text=@"平民";
        farmersLabel2.textColor=ZCColor(34, 34, 34);
        farmersLabel2.textAlignment=NSTextAlignmentCenter;
        [scollView addSubview:farmersLabel2];
        
        UILabel *numberLabel3=[[UILabel alloc] init];
        numberLabel3.frame=CGRectMake(farmersLabel2X, farmersLabelY+farmersLabelH+5, farmersLabelW, farmersLabelH);
        numberLabel3.text=@"3号发球";
        numberLabel3.font=[UIFont systemFontOfSize:12];
        numberLabel3.textAlignment=NSTextAlignmentCenter;
        [scollView addSubview:numberLabel3];

        
        
        
        
        
        
        
        
        
        UIImageView *personView=[[UIImageView alloc] init];
        personView.frame=CGRectMake(10, farmersLabel2Y+50, SCREEN_WIDTH-20, 136);
        personView.image=[ZCTool imagePullLitre:@"taimian"];
        personView.userInteractionEnabled=YES;
        [scollView addSubview:personView];
        [self addView:personView];
        self.personView=personView;
        
        
        UILabel *textLabel=[[UILabel alloc] init];
        textLabel.frame=CGRectMake(0, personView.frame.size.height+personView.frame.origin.y, SCREEN_WIDTH, 35);
        textLabel.textColor=ZCColor(34, 34, 34);
        textLabel.textAlignment=NSTextAlignmentCenter;
        textLabel.text=@"拖动头像来改变发球的顺序";
        textLabel.font=[UIFont systemFontOfSize:13];
        [scollView addSubview:textLabel];
        
        
        CGFloat firstViewY=textLabel.frame.size.height+textLabel.frame.origin.y;
        UIView *firstView=[[UIView alloc] init];
        firstView.frame=CGRectMake(0, firstViewY, SCREEN_WIDTH, 40);
        firstView.backgroundColor=[UIColor whiteColor];
        [scollView addSubview:firstView];
        
        [self addView:firstView andNameLabelText:@"小鸟球翻一倍"];
        
        CGFloat secondViewY=firstViewY+40+1;

        UIView *secondView=[[UIView alloc] init];
        secondView.frame=CGRectMake(0, secondViewY, SCREEN_WIDTH, 40);
        secondView.backgroundColor=[UIColor whiteColor];
        [scollView addSubview:secondView];
       // self.secondView=secondView;
        [self addView:secondView andNameLabelText:@"老鹰球翻两倍"];
        
        CGFloat thirdViewY=secondViewY+40+1;
        UIView *thirdView=[[UIView alloc] init];
        thirdView.frame=CGRectMake(0, thirdViewY, SCREEN_WIDTH, 40);
        thirdView.backgroundColor=[UIColor whiteColor];
        [scollView addSubview:thirdView];
        //self.thirdView=thirdView;
        [self addView:thirdView andNameLabelText:@"打平进入下一洞"];
        
        
        scollView.contentSize = CGSizeMake(0,thirdViewY+50 );

    }
    return self;
}


//开关
-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        switch (switchButton.tag) {
            case 14001:
                self.isOpen1=1;
                break;
            case 14002:
                self.isOpen2=1;
                break;
            case 14003:
                self.isOpen3=1;
                break;
            default:
                break;
        }
        
        
    }else {
       
        switch (switchButton.tag) {
            case 14001:
                self.isOpen1=0;
                break;
            case 14002:
                self.isOpen2=0;
                break;
            case 14003:
                self.isOpen3=0;
                break;
            default:
                break;
        }

        
        
    }
    
    [self agentByValue];
}


//默认值
-(void)theDefaultValue
{
    
    self.isOpen1=1;
    self.isOpen2=1;
    self.isOpen3=1;
    
   
   
    [self agentByValue];
}

//代理传值回控制器
-(void)agentByValue
{
   
    if ([self.delegate respondsToSelector:@selector(switchButtonIsOpen:andSwitch2:andSwitch3:andUserDict:andOtherDict:andAnotherDict:)]) {
        
        [self.delegate switchButtonIsOpen:self.isOpen1 andSwitch2:self.isOpen2 andSwitch3:self.isOpen3 andUserDict:self.userModel andOtherDict:self.otherModel andAnotherDict:self.anotherModel];
    }
    
}



-(void)addView:(UIView *)view andNameLabelText:(NSString *)nameStr
{
    [self layoutIfNeeded];
    
    UILabel *nameLabel=[[UILabel alloc] init];
    CGFloat nameLabelX=10;
    CGFloat nameLabelY=0;
    CGFloat nameLabelW=view.frame.size.width*0.6;
    CGFloat nameLabelH=view.frame.size.height;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.text=nameStr;
    [view addSubview:nameLabel];
    
    
    self.indexTag++;
    ZCLog(@"%ld",(long)self.indexTag);
    
    UISwitch *switchView=[[UISwitch alloc] init];
    CGFloat switchViewW=40;
    CGFloat switchViewH=view.frame.size.height-10;
    CGFloat switchViewX=SCREEN_WIDTH-switchViewW-20;
    CGFloat switchViewY=5;
    switchView.frame=CGRectMake(switchViewX, switchViewY, switchViewW, switchViewH);
    switchView.on=YES;
    switchView.tag=14000+self.indexTag;
    
    [switchView addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
      [view addSubview:switchView];
    
}




-(void)addView:(UIView *)view
{
    CGFloat spacing=SCREEN_WIDTH*0.05625;
     UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat buttonX=10+spacing;
    CGFloat buttonY=25;
    CGFloat buttonW=(view.frame.size.width-20)/4;
    CGFloat buttonH=view.frame.size.height-2*buttonY;
    button.frame = CGRectMake(buttonX , buttonY, buttonW,buttonH);
    
    button.tag = 0;
   
     [self addPersonView:button andPersonImage:self.personImage andPersonName:[NSString stringWithFormat:@"%@",self.personName]];
    [self.myRects addObject:button];
    
    NSString * str = [NSString stringWithFormat:@"%@",NSStringFromCGRect(button.frame)];
    [self.frames addObject:str];
    
    //拖动手势
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragButton:)];
    [button addGestureRecognizer:pan];

    [view addSubview:button];
    
    
    
    
    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat button2X=buttonX+buttonW+spacing;
    CGFloat button2Y=25;
    CGFloat button2W=buttonW;
    CGFloat button2H=buttonH;
    button2.frame = CGRectMake(button2X , button2Y, button2W,button2H);
    button2.tag = 1;
    
    [self addPersonView:button2 andPersonImage:[UIImage imageNamed:@"yule_touxiang"] andPersonName:@"玩家1"];
    [self.myRects addObject:button2];
    
    NSString * str2 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(button2.frame)];
    [button2 addTarget:self action:@selector(clickTheButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.frames addObject:str2];
    
    
    
    //拖动手势
   UIPanGestureRecognizer * pan2 = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragButton:)];
    [button2 addGestureRecognizer:pan2];
    
    [view addSubview:button2];
    //给背景view加点击事件，用于终止选中动画
//    UITapGestureRecognizer * tapView2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView)];
//    [view addGestureRecognizer:tapView2];
    
    
    
    
    
    UIButton * button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat button3X=button2X+button2W+spacing;
    CGFloat button3Y=25;
    CGFloat button3W=buttonW;
    CGFloat button3H=buttonH;
    button3.frame = CGRectMake(button3X , button3Y, button3W,button3H);
    button3.tag = 2;
    [self addPersonView:button3 andPersonImage:[UIImage imageNamed:@"yule_touxiang"] andPersonName:@"玩家2"];
    [self.myRects addObject:button3];
    
    NSString * str3 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(button3.frame)];
    [self.frames addObject:str3];
    
    //拖动手势
    UIPanGestureRecognizer * pan3 = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragButton:)];
    [button3 addGestureRecognizer:pan3];
    [button3 addTarget:self action:@selector(clickTheButton:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button3];
//    //给背景view加点击事件，用于终止选中动画
//    UITapGestureRecognizer * tapView3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView)];
//    [view addGestureRecognizer:tapView3];


    
}

//添加拖拽里面的内容
-(void)addPersonView:(UIButton *)button
      andPersonImage:(UIImage *)image andPersonName:(NSString *)nameStr
{
    //[self layoutIfNeeded];
    
    UIImageView *imageView=[[UIImageView alloc] init];
    imageView.frame=CGRectMake(0, 0, button.frame.size.width, button.frame.size.width);
    imageView.layer.cornerRadius=button.frame.size.width/2;
    imageView.layer.masksToBounds=YES;
    imageView.layer.borderWidth=3;
    imageView.image=image;
    [button addSubview:imageView ];
    if (button.tag==0) {
        imageView.tag=2031;
     imageView.layer.borderColor=ZCColor(69, 226, 57).CGColor;
    }else if (button.tag==1){
    imageView.layer.borderColor=ZCColor(45, 219, 254) .CGColor;
    }else{
    imageView.layer.borderColor=ZCColor(69, 226, 57).CGColor;
    }
    
    
    UILabel *nameLabel=[[UILabel alloc] init];
    nameLabel.frame=CGRectMake(0, button.frame.size.width+5, button.frame.size.width, 20);
    nameLabel.text=nameStr;
    nameLabel.textAlignment=NSTextAlignmentCenter;
    nameLabel.textColor=[UIColor redColor];
    nameLabel.font=[UIFont systemFontOfSize:14];
    [button addSubview:nameLabel];
    
    if (button.tag==1) {
        nameLabel.textColor=ZCColor(45, 219, 254) ;
    }else{
    nameLabel.textColor=ZCColor(69, 226, 57);
    }
    
}





//拖动手势的回调方法
-(void)dragButton:(UIPanGestureRecognizer*)pan
{
    //NSLog(@"drag");
    //获取手势在该视图上得偏移量
    CGPoint translation = [pan translationInView:self.personView];
    
    //一下分别为拖动时的三种状态：开始，变化，结束
    if (pan.state == UIGestureRecognizerStateBegan)
    {
        NSLog(@"drag begin");
        //开始时拖动的view更改透明度
        pan.view.alpha = 0.7;
    }
    else if(pan.state == UIGestureRecognizerStateChanged)
    {
        NSLog(@"grag change");
        //使拖动的view跟随手势移动
        pan.view.center = CGPointMake(pan.view.center.x + translation.x,
                                      pan.view.center.y + translation.y);
        [pan setTranslation:CGPointZero inView:self.personView];
        
        //遍历9个view看移动到了哪个view区域，使其为选中状态.并更新选中view的tag值，使其永远为最新的
        for (int i = 0; i< self.myRects.count; i++)
        {
            UIButton * btn = self.myRects[i];
            NSString* tmprect = self.frames[i];
            if (CGRectContainsPoint(CGRectFromString(tmprect), pan.view.center))
            {
                
                _tmptag = btn.tag;
                // NSLog(@"tmptag ==> %d",tmptag);
//                btn.layer.borderWidth = 3;
//                btn.layer.borderColor = [[UIColor redColor]CGColor];
                return;
            }
            else
            {
                btn.layer.borderWidth = 0;
                btn.layer.borderColor = [[UIColor clearColor]CGColor];
            }
        }
        
        
    }
    else if (pan.state == UIGestureRecognizerStateEnded)
    {
        //NSLog(@"drag end");
        //拖动结束的时候，将拖动的view的透明度还原
        pan.view.alpha = 1;
        [UIView animateWithDuration:1 animations:^
         {
             //结束时将选中view的边框还原
             NSInteger a=_tmptag;
             UIButton * btn = self.myRects[a];
             btn.layer.borderWidth = 0;
             btn.layer.borderColor = [[UIColor clearColor]CGColor];
             
             //获取需要交换的两个view的frame，并交换
             NSString * rect1 = self.frames[btn.tag];
             NSString * rect2 = self.frames[pan.view.tag];
             
             pan.view.frame = CGRectFromString(rect1);
             btn.frame = CGRectFromString(rect2);
             
             //并交换其tag值及在数组中得位置
             NSInteger tmp = pan.view.tag;
             pan.view.tag = _tmptag;
             btn.tag = tmp;
             //NSLog(@"%d  %d",pan.view.tag,btn.tag);
             
             [self.myRects exchangeObjectAtIndex:pan.view.tag withObjectAtIndex:btn.tag];
             
             
         } completion:^(BOOL finished)
         {
             ZCLog(@"已交换");
             //完成动画后还原btn的状态
             for (int i = 0; i< self.myRects.count; i++)
             {
                 
                 UIButton * btn = self.myRects[i];
                 btn.layer.borderColor = [[UIColor clearColor]CGColor];
                 btn.layer.borderWidth = 0;
                // NSLog(@"ttttr%d",btn.tag);
                 
                 if (btn.tag==1  ) {
                     for (id view in btn.subviews) {
                         UIImageView *image;
                         UILabel *nameLabel;
                         if ([view isKindOfClass:[UIImageView class]]) {
                             image=view;
                         }
                         if ([view isKindOfClass:[UILabel class]]) {
                             nameLabel=view;
                         }

                         image.layer.borderColor=[ZCColor(45, 219, 254)  CGColor];
                         nameLabel.textColor=ZCColor(45, 219, 254)  ;
                     }
                 }else
                 {
                 
                     for (id view in btn.subviews) {
                         UIImageView *image;
                         UILabel *nameLabel;
                         if ([view isKindOfClass:[UIImageView class]]) {
                             image=view;
                         }
                         if ([view isKindOfClass:[UILabel class]]) {
                             nameLabel=view;
                         }

                         image.layer.borderColor=[ZCColor(69, 226, 57) CGColor];
                         nameLabel.textColor=ZCColor(69, 226, 57);
                     }

                 
                 }
                 
             }
         }];
        
        
        
          }
    
    
    
    
}


-(NSMutableArray *)obtainCompetitorInformation
{
    NSMutableArray *teamArray=[NSMutableArray array];
    UIButton *playBtn1=_myRects[0];
    UIButton *playBtn2=_myRects[1];
    UIButton *playBtn3=_myRects[2];

    UIImageView *image1;
    UILabel *label1;
    for (id view in playBtn1.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            image1=view;
        }
        
        if ([view isKindOfClass:[UILabel class]]) {
            label1=view;
        }

    }
    
    
    UIImageView *image2;
    UILabel *label2;
    for (id view in playBtn2.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            image2=view;
        }
        if ([view isKindOfClass:[UILabel class]]) {
            label2=view;
        }
    }

    
    UIImageView *image3;
    UILabel *label3;
    for (id view in playBtn3.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            image3=view;
        }
        if ([view isKindOfClass:[UILabel class]]) {
            label3=view;
        }

    }

    
    if (image1.tag==2031) {
        ZCDouModel *userModel=[[ZCDouModel alloc] init];
        userModel.isUser=1;
        userModel.name=label1.text;
        userModel.personImage=image1.image;
        self.userModel=userModel;
        [teamArray addObject:userModel];
    }else
    {
        ZCDouModel *userModel=[[ZCDouModel alloc] init];
        userModel.isUser=0;
        userModel.name=label1.text;
        userModel.personImage=image1.image;
        self.userModel=userModel;
        [teamArray addObject:userModel];
    
    }
    
    
    
    
    if (image2.tag==2031) {
        ZCDouModel *userModel=[[ZCDouModel alloc] init];
        userModel.isUser=1;
        userModel.name=label2.text;
        userModel.personImage=image2.image;
        self.userModel=userModel;
        [teamArray addObject:userModel];
    }else
    {
        ZCDouModel *userModel=[[ZCDouModel alloc] init];
        userModel.isUser=0;
        userModel.name=label2.text;
        userModel.personImage=image2.image;
        self.userModel=userModel;
        [teamArray addObject:userModel];
        
    }

    
    if (image3.tag==2031) {
        ZCDouModel *userModel=[[ZCDouModel alloc] init];
        userModel.isUser=1;
        userModel.name=label3.text;
        userModel.personImage=image3.image;
        self.userModel=userModel;
        [teamArray addObject:userModel];
    }else
    {
        ZCDouModel *userModel=[[ZCDouModel alloc] init];
        userModel.isUser=0;
        userModel.name=label3.text;
        userModel.personImage=image3.image;
        self.userModel=userModel;
        [teamArray addObject:userModel];
        
    }

    
    

    
    
    return teamArray;
}

//点击按钮
-(void)clickTheButton:(UIButton *)btn
{
    UILabel *textLabel;
    for (id view in btn.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            textLabel=view;
            break;
        }
    }
    
    
    if ([self.delegate respondsToSelector:@selector(buttonIsClickerForFightTheLandlordView:)]) {
        [self.delegate buttonIsClickerForFightTheLandlordView:textLabel.text];
    }

    
    if (btn.tag==1) {
        self.pointLocation=1;
    }else if(btn.tag==2){
     self.pointLocation=2;
    }else{
    self.pointLocation=0;
    }
    
    
}




//控制器传值过来
-(void)acceptPersonalInformationForFightTheLandlordView:(UIImage *)image andName:(NSString *)name
{
    UIButton *playBtn1=_myRects[self.pointLocation];
    
    
    UIImageView *image1;
    UILabel *nameLabel;
    for (id view in playBtn1.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            image1=view;
        }
        if ([view isKindOfClass:[UILabel class]]) {
            nameLabel=view;
        }

    }
    
    
    
    
    if (image==nil) {
    }else{
         image1.image=image;
    }
    if (name.length==0) {
    }else{
       nameLabel.text=name;
    }

    
    
    
   
    
    

}





-(void)layoutSubviews
{
    [super layoutSubviews];
    self.scollView.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);

}


@end
