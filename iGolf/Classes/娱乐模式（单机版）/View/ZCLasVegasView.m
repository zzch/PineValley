//
//  ZCLasVegasView.m
//  iGolf
//
//  Created by hh on 15/7/21.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCLasVegasView.h"
#import "ZCDouModel.h"
@interface ZCLasVegasView()
@property(nonatomic,strong)NSMutableArray *myRects;
@property(nonatomic,strong)NSMutableArray *frames;
//机主的照片
@property(nonatomic,weak)UIImage *personImage;
//机主的名字
@property(nonatomic,copy)NSString *personName;
@property(nonatomic,weak)UIView *photoView;

//拖动时用到的属性，记录最后的选中button的tag
@property(nonatomic,assign)NSInteger tmptag;

@property(nonatomic,assign)NSInteger indexTag;


@property(nonatomic,assign)int isOpen1;
@property(nonatomic,assign)int isOpen2;
@property(nonatomic,assign)int isOpen3;


@property(nonatomic,weak)UIImageView *imageView1;
@property(nonatomic,weak)UIImageView *imageView2;
@property(nonatomic,weak)UIImageView *imageView3;
@property(nonatomic,weak)UIImageView *imageView4;

//哪个被点击跟换头像
@property(nonatomic,assign)int pointLocation;

@end
@implementation ZCLasVegasView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=ZCColor(237, 237, 237);
        
        //初始化两个数组
        self.myRects = [NSMutableArray arrayWithCapacity:4];
        self.frames = [NSMutableArray arrayWithCapacity:4];

        [self addControls];
        
    }
    return self;
}


//添加控件
-(void)addControls
{
    
    // 获取路劲 取出图片
    NSString *path=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"personImage.png"];
    NSData *imageData=[NSData dataWithContentsOfFile:path];
    UIImage *image=[[UIImage alloc] initWithData:imageData];
    self.personImage=image;
    
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    self.personName=account.nickname;

    
    
    
    
    
    UILabel *numberLabel=[[UILabel alloc] init];
    CGFloat numberLabelX=15;
    CGFloat numberLabelY=17;
    CGFloat numberLabelW=(SCREEN_WIDTH-30-47)/4;
    CGFloat numberLabelH=20;
    numberLabel.frame=CGRectMake(numberLabelX, numberLabelY, numberLabelW, numberLabelH);
    numberLabel.text=@"1号发球";
    numberLabel.font=[UIFont systemFontOfSize:12];
    numberLabel.textAlignment=NSTextAlignmentCenter;
    [self addSubview:numberLabel];
    
    UILabel *numberLabel2=[[UILabel alloc] init];
    CGFloat numberLabel2X=numberLabelX+numberLabelW;
    CGFloat numberLabel2Y=17;
    CGFloat numberLabel2W=(SCREEN_WIDTH-30)/4;
    CGFloat numberLabel2H=20;
    numberLabel2.frame=CGRectMake(numberLabel2X, numberLabel2Y, numberLabel2W, numberLabel2H);
    numberLabel2.text=@"4号发球";
    numberLabel2.font=[UIFont systemFontOfSize:12];
    numberLabel2.textAlignment=NSTextAlignmentCenter;
    [self addSubview:numberLabel2];
    
    UILabel *numberLabel3=[[UILabel alloc] init];
    CGFloat numberLabel3X=numberLabel2X+numberLabel2W+27;
    CGFloat numberLabel3Y=17;
    CGFloat numberLabel3W=(SCREEN_WIDTH-30)/4;
    CGFloat numberLabel3H=20;
    numberLabel3.frame=CGRectMake(numberLabel3X, numberLabel3Y, numberLabel3W, numberLabel3H);
    numberLabel3.text=@"2号发球";
    numberLabel3.font=[UIFont systemFontOfSize:12];
    numberLabel3.textAlignment=NSTextAlignmentCenter;
    [self addSubview:numberLabel3];
    
    
    UILabel *numberLabel4=[[UILabel alloc] init];
    CGFloat numberLabel4X=numberLabel3X+numberLabel3W;
    CGFloat numberLabel4Y=17;
    CGFloat numberLabel4W=(SCREEN_WIDTH-30)/4;
    CGFloat numberLabel4H=20;
    numberLabel4.frame=CGRectMake(numberLabel4X, numberLabel4Y, numberLabel4W, numberLabel4H);
    numberLabel4.text=@"3号发球";
    numberLabel4.font=[UIFont systemFontOfSize:12];
    numberLabel4.textAlignment=NSTextAlignmentCenter;
    [self addSubview:numberLabel4];
    
    
    
    
    
    
    UIImageView *photoView=[[UIImageView alloc] init];
    photoView.frame=CGRectMake(10, numberLabelY+numberLabelH+10, SCREEN_WIDTH-20, 136);
    photoView.image=[ZCTool imagePullLitre:@"taimian"];
    photoView.userInteractionEnabled=YES;
    [self addSubview:photoView];
    self.photoView=photoView;
    [self addView:photoView];
    
    
//        //添加VS图片
//    UIImageView*VSImage=[[UIImageView alloc] init];
//    CGFloat  VSImageW=
//    CGFloat  VSImageH=
//    CGFloat  VSImageX=
//    CGFloat  VSImageY=
//    
//    VSImage.frame=CGRectMake((SCREEN_WIDTH-20)/2, button.frame.size.height-50, 20, 20);
//    VSImage.backgroundColor=[UIColor redColor];
//    [photoView addSubview:VSImage];

    
    
    UILabel *textLabel=[[UILabel alloc] init];
    textLabel.frame=CGRectMake(0, photoView.frame.size.height+photoView.frame.origin.y, SCREEN_WIDTH, 35);
    textLabel.textColor=ZCColor(34, 34, 34);
    textLabel.textAlignment=NSTextAlignmentCenter;
    textLabel.text=@"拖动头像来改变发球的顺序";
    textLabel.font=[UIFont systemFontOfSize:13];
    [self addSubview:textLabel];
    
    
     CGFloat firstViewY=textLabel.frame.size.height+textLabel.frame.origin.y;
    UIView *firstView=[[UIView alloc] init];
    firstView.frame=CGRectMake(0, firstViewY, SCREEN_WIDTH, 40);
    firstView.backgroundColor=[UIColor whiteColor];
    [self addSubview:firstView];
    //self.firstView=firstView;
    [self addView:firstView andNameLabelText:@"小鸟球和老鹰球翻转"];
    
    CGFloat secondViewY=firstViewY+40+1;
    UIView *secondView=[[UIView alloc] init];
    secondView.frame=CGRectMake(0, secondViewY, SCREEN_WIDTH, 40);
    secondView.backgroundColor=[UIColor whiteColor];
    [self addSubview:secondView];
    // self.secondView=secondView;
    [self addView:secondView andNameLabelText:@"双倍标准杆翻转"];
    
//    UIView *thirdView=[[UIView alloc] init];
//    thirdView.frame=CGRectMake(0, 232, SCREEN_WIDTH, 30);
//    thirdView.backgroundColor=[UIColor whiteColor];
//    [self addSubview:thirdView];
//    //self.thirdView=thirdView;
//    [self addView:thirdView andNameLabelText:@"打平进入下一洞"];
    
//    UIView *fourthView=[[UIView alloc] init];
//    fourthView.frame=CGRectMake(0, 263, SCREEN_WIDTH, 30);
//    fourthView.backgroundColor=[UIColor whiteColor];
//    [self addSubview:fourthView];
//    //self.fourthView=fourthView;
//    [self addView:fourthView andNameLabelText:@"打平进入下一洞"];
    

    self.isOpen1=1;
    self.isOpen2=1;
    self.isOpen3=1;
    
}



-(void)addView:(UIView *)view andNameLabelText:(NSString *)nameStr
{
    
    
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
    
    switchView.tag=15000+self.indexTag;
    
    [switchView addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
     switchView.on=YES;
    [view addSubview:switchView];
    
}


//开关
-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        switch (switchButton.tag) {
            case 15001:
                self.isOpen1=1;
                break;
            case 15002:
                self.isOpen2=1;
                break;
            case 15003:
                self.isOpen3=1;
                break;
            default:
                break;
        }
 
        
        
       
    }else  {
        switch (switchButton.tag) {
            case 15001:
                self.isOpen1=0;
                break;
            case 15002:
                self.isOpen2=0;
                break;
            case 15003:
                self.isOpen3=0;
                break;
            default:
                break;
        }

    }
    
}





-(void)addView:(UIView *)view
{   //间距
    CGFloat spacing=SCREEN_WIDTH*0.016;
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat buttonX=10+spacing;
    CGFloat buttonY=25;
    CGFloat buttonW=(view.frame.size.width-20-47-6*spacing)/4;
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
    
    
    [self addPersonView:button2 andPersonImage:[UIImage imageNamed:@"morentouxiang"] andPersonName:@"玩家1"];
    [self.myRects addObject:button2];
    
    NSString * str2 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(button2.frame)];
    [button2 addTarget:self action:@selector(clickTheButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.frames addObject:str2];
    
    //拖动手势
    UIPanGestureRecognizer * pan2 = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragButton:)];
    [button2 addGestureRecognizer:pan2];
    
    [view addSubview:button2];
    
    
    
            //添加VS图片
     UIImageView*VSImage=[[UIImageView alloc] init];
    CGFloat  VSImageW=47;
    CGFloat  VSImageH=20;
    CGFloat  VSImageX=(view.frame.size.width-VSImageW)/2;
    CGFloat  VSImageY=(view.frame.size.height-VSImageH)/2;
    
    VSImage.frame=CGRectMake(VSImageX, VSImageY, VSImageW, VSImageH);
    VSImage.image=[UIImage imageNamed:@"vs"];
    [view addSubview:VSImage];
    
    
    UIButton * button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat button3X=VSImageX+VSImageW+spacing;
    CGFloat button3Y=25;
    CGFloat button3W=buttonW;
    CGFloat button3H=buttonH;
    button3.frame = CGRectMake(button3X , button3Y, button3W,button3H);
   button3.tag = 2;
    
    [self addPersonView:button3 andPersonImage:[UIImage imageNamed:@"morentouxiang"] andPersonName:@"玩家2"];
    [self.myRects addObject:button3];
    [button3 addTarget:self action:@selector(clickTheButton:) forControlEvents:UIControlEventTouchUpInside];
    NSString * str3 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(button3.frame)];
    [self.frames addObject:str3];
    
    //拖动手势
    UIPanGestureRecognizer * pan3 = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragButton:)];
    [button3 addGestureRecognizer:pan3];
    
    [view addSubview:button3];
    
    
    
    
    UIButton * button4 = [UIButton buttonWithType:UIButtonTypeCustom];
   
    CGFloat button4X=button3X+button3W+spacing;
    CGFloat button4Y=25;
    CGFloat button4W=buttonW;
    CGFloat button4H=buttonH;
    button4.frame = CGRectMake(button4X , button4Y, button4W,button4H);
    button4.tag = 3;
   
    [self addPersonView:button4 andPersonImage:[UIImage imageNamed:@"morentouxiang"] andPersonName:@"玩家3"];
    [self.myRects addObject:button4];
    [button4 addTarget:self action:@selector(clickTheButton:) forControlEvents:UIControlEventTouchUpInside];
    NSString * str4 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(button4.frame)];
    [self.frames addObject:str4];
    
    //拖动手势
    UIPanGestureRecognizer * pan4 = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragButton:)];
    [button4 addGestureRecognizer:pan4];
    
    [view addSubview:button4];

    
    
}

//添加拖拽里面的内容
-(void)addPersonView:(UIButton *)button
      andPersonImage:(UIImage *)image andPersonName:(NSString *)nameStr
{
   
    
    UIImageView *imageView=[[UIImageView alloc] init];
    
    imageView.frame=CGRectMake(0, 7, button.frame.size.width, button.frame.size.width);
    imageView.layer.cornerRadius=button.frame.size.width/2;
    imageView.layer.masksToBounds=YES;
    imageView.image=image;
    imageView.layer.borderWidth=2;
    [button addSubview:imageView ];
    
    
    
    
    UILabel *nameLabel=[[UILabel alloc] init];
    nameLabel.frame=CGRectMake(0, button.frame.size.width+15, button.frame.size.width, 20);
    nameLabel.text=nameStr;
    nameLabel.textAlignment=NSTextAlignmentCenter;
    nameLabel.font=[UIFont systemFontOfSize:12];
    [button addSubview:nameLabel];

    
    
    if (button.tag==0) {
        imageView.tag=2032;
        imageView.layer.borderColor=[UIColor redColor].CGColor;
        nameLabel.textColor=[UIColor redColor];
    }else if (button.tag==1)
    {
        imageView.layer.borderColor=[UIColor redColor].CGColor;
        nameLabel.textColor=[UIColor redColor];
    }else if (button.tag==2){
        imageView.layer.borderColor=[UIColor yellowColor].CGColor;
        nameLabel.textColor=[UIColor yellowColor];
    }else{
        imageView.layer.borderColor=[UIColor yellowColor].CGColor;
        nameLabel.textColor=[UIColor yellowColor];
    }

    
    
}



//拖动手势的回调方法
-(void)dragButton:(UIPanGestureRecognizer*)pan
{
    //NSLog(@"drag");
    //获取手势在该视图上得偏移量
    CGPoint translation = [pan translationInView:self.photoView];
    
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
        [pan setTranslation:CGPointZero inView:self.photoView];
        
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
        NSLog(@"drag end");
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
                 if (btn.tag==1 ||btn.tag==0 ) {
                     for (id view in btn.subviews) {
                         UIImageView *image;
                         UILabel *nameLabel;
                         if ([view isKindOfClass:[UIImageView class]]) {
                             image=view;
                         }
                         if ([view isKindOfClass:[UILabel class]]) {
                             nameLabel=view;
                         }
                         
                         image.layer.borderColor=[[UIColor redColor]CGColor];
                         nameLabel.textColor=[UIColor redColor];
                     }
                 }else{
                 
                     for (id view in btn.subviews) {
                         UIImageView *image;
                         UILabel *nameLabel;
                         if ([view isKindOfClass:[UIImageView class]]) {
                             image=view;
                         }
                         if ([view isKindOfClass:[UILabel class]]) {
                             nameLabel=view;
                         }
                         
                         image.layer.borderColor=[[UIColor yellowColor]CGColor];
                         nameLabel.textColor=[UIColor yellowColor];
                     }
                 }
             }
         }];
        
        
        
    }
    
    
    
    
}

//返回给控制器开关属性
-(NSMutableDictionary *)TheStateOfTheSwitch
{
    NSMutableDictionary *switchDict=[NSMutableDictionary dictionary];
    switchDict[@"isOpen1"]=@(self.isOpen1);
    switchDict[@"isOpen2"]=@(self.isOpen2);
    switchDict[@"isOpen3"]=@(self.isOpen3);
    
    
    return switchDict;
}

//返回数组头像
-(NSMutableArray *)obtainCompetitorInformation
{
    NSMutableArray *teamArray=[NSMutableArray array];
    UIButton *playBtn1=_myRects[0];
    UIButton *playBtn2=_myRects[1];
    UIButton *playBtn3=_myRects[2];
    UIButton *playBtn4=_myRects[3];
    
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
    
    UIImageView *image4;
    UILabel *label4;
    for (id view in playBtn4.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            image4=view;
        }
        
        if ([view isKindOfClass:[UILabel class]]) {
            label4=view;
        }

    }

    
    if (image1.tag==2032) {
        ZCDouModel *userModel=[[ZCDouModel alloc] init];
        userModel.isUser=1;
        userModel.name=label1.text;
        userModel.personImage=image1.image;
        
        [teamArray addObject:userModel];
    }else
    {
        ZCDouModel *userModel=[[ZCDouModel alloc] init];
        userModel.isUser=0;
        userModel.name=label1.text;
        userModel.personImage=image1.image;
        
        [teamArray addObject:userModel];
        
    }
    
    
    
    
    if (image2.tag==2032) {
        ZCDouModel *userModel=[[ZCDouModel alloc] init];
        userModel.isUser=1;
        userModel.name=label2.text;
        userModel.personImage=image2.image;
        
        [teamArray addObject:userModel];
    }else
    {
        ZCDouModel *userModel=[[ZCDouModel alloc] init];
        userModel.isUser=0;
        userModel.name=label2.text;
        userModel.personImage=image2.image;
        
        [teamArray addObject:userModel];
        
    }
    
    
    if (image3.tag==2032) {
        ZCDouModel *userModel=[[ZCDouModel alloc] init];
        userModel.isUser=1;
        userModel.name=label3.text;
        userModel.personImage=image3.image;
        
        [teamArray addObject:userModel];
    }else
    {
        ZCDouModel *userModel=[[ZCDouModel alloc] init];
        userModel.isUser=0;
        userModel.name=label3.text;
        userModel.personImage=image3.image;
        
        [teamArray addObject:userModel];
        
    }
    
    
    if (image4.tag==2032) {
        ZCDouModel *userModel=[[ZCDouModel alloc] init];
        userModel.isUser=1;
        userModel.name=label4.text;
        userModel.personImage=image4.image;
        
        [teamArray addObject:userModel];
    }else
    {
        ZCDouModel *userModel=[[ZCDouModel alloc] init];
        userModel.isUser=0;
        userModel.name=label4.text;
        userModel.personImage=image4.image;
        
        [teamArray addObject:userModel];
        
    }

    
     return teamArray;

}


//点击按钮
-(void)clickTheButton:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(buttonIsClickerForLasVegasView:)]) {
        [self.delegate buttonIsClickerForLasVegasView:btn];
    }
    
    
    if (btn.tag==1) {
        self.pointLocation=1;
    }else if(btn.tag==2){
        self.pointLocation=2;
    }else if(btn.tag==3){
        self.pointLocation=3;
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
    image1.image=image;
    nameLabel.text=name;
    
    
}



   
@end
