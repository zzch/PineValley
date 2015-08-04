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
@property(nonatomic,weak)UIView *personView;
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



@property(nonatomic,weak)UIImageView *imageView1;
@property(nonatomic,weak)UIImageView *imageView2;
@property(nonatomic,weak)UIImageView *imageView3;
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
        
        
        UIView *personView=[[UIView alloc] init];
        personView.frame=CGRectMake(0, 30, SCREEN_WIDTH, 130);
        [self addSubview:personView];
        [self addView:personView];
        self.personView=personView;
        
        
        UIView *firstView=[[UIView alloc] init];
        firstView.frame=CGRectMake(0, 170, SCREEN_WIDTH, 30);
        [self addSubview:firstView];
        //self.firstView=firstView;
        [self addView:firstView andNameLabelText:@"小鸟球翻一倍"];
        
        
        UIView *secondView=[[UIView alloc] init];
        secondView.frame=CGRectMake(0, 201, SCREEN_WIDTH, 30);
        [self addSubview:secondView];
       // self.secondView=secondView;
        [self addView:secondView andNameLabelText:@"老鹰球翻两倍"];
        
        UIView *thirdView=[[UIView alloc] init];
        thirdView.frame=CGRectMake(0, 232, SCREEN_WIDTH, 30);
        [self addSubview:thirdView];
        //self.thirdView=thirdView;
        [self addView:thirdView andNameLabelText:@"打平进入下一洞"];
        
        


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
     UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(30 , 5, 80, 120);
    button.layer.cornerRadius = 5;
    button.tag = 0;
    button.backgroundColor = [UIColor brownColor];
   // [button setTitle:[NSString stringWithFormat:@"btn 1"] forState:UIControlStateNormal];
     [self addPersonView:button andPersonImage:self.personImage andPersonName:[NSString stringWithFormat:@"%@",self.personName]];
    [self.myRects addObject:button];
    
    NSString * str = [NSString stringWithFormat:@"%@",NSStringFromCGRect(button.frame)];
    [self.frames addObject:str];
    
    //拖动手势
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragButton:)];
    [button addGestureRecognizer:pan];

    [view addSubview:button];
//    //给背景view加点击事件，用于终止选中动画
//    UITapGestureRecognizer * tapView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView)];
//    [view addGestureRecognizer:tapView];
    
    
    
    
    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(150 , 5, 80, 120);
    button2.layer.cornerRadius = 5;
    button2.tag = 1;
    button2.backgroundColor = [UIColor brownColor];
    [button2 setTitle:[NSString stringWithFormat:@"btn 2"] forState:UIControlStateNormal];
    UIImage * image=[UIImage imageNamed:@"20141118042246536.jpg"];
    [self addPersonView:button2 andPersonImage:image andPersonName:[NSString stringWithFormat:@"%@",self.personName]];
    [self.myRects addObject:button2];
    
    NSString * str2 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(button2.frame)];
    
    [self.frames addObject:str2];
    
    //拖动手势
   UIPanGestureRecognizer * pan2 = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragButton:)];
    [button2 addGestureRecognizer:pan2];
    
    [view addSubview:button2];
    //给背景view加点击事件，用于终止选中动画
//    UITapGestureRecognizer * tapView2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView)];
//    [view addGestureRecognizer:tapView2];
    
    
    
    
    
    UIButton * button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(270 , 5, 80, 120);
    button3.layer.cornerRadius = 5;
    button3.tag = 2;
    button3.backgroundColor = [UIColor brownColor];
    //[button3 setTitle:[NSString stringWithFormat:@"btn 3"] forState:UIControlStateNormal];
    [self addPersonView:button3 andPersonImage:self.personImage andPersonName:@"编辑名称"];
    [self.myRects addObject:button3];
    
    NSString * str3 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(button3.frame)];
    [self.frames addObject:str3];
    
    //拖动手势
    UIPanGestureRecognizer * pan3 = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragButton:)];
    [button3 addGestureRecognizer:pan3];
    
    [view addSubview:button3];
//    //给背景view加点击事件，用于终止选中动画
//    UITapGestureRecognizer * tapView3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView)];
//    [view addGestureRecognizer:tapView3];


    
}

//添加拖拽里面的内容
-(void)addPersonView:(UIButton *)button
      andPersonImage:(UIImage *)image andPersonName:(NSString *)nameStr
{
    [self layoutIfNeeded];
    
    UIImageView *imageView=[[UIImageView alloc] init];
    //CGFloat imageViewX=
    imageView.frame=CGRectMake(0, 0, button.frame.size.width, button.frame.size.width);
    imageView.layer.cornerRadius=button.frame.size.width/2;
    imageView.layer.masksToBounds=YES;
    imageView.image=image;
    [button addSubview:imageView ];
    if (button.tag==0) {
        imageView.tag=2031;
        self.imageView1=imageView;
    }else if (button.tag==1)
    {self.imageView2=imageView;
    }else{
    self.imageView3=imageView;
    }
    
    
    UIButton *nameButton=[[UIButton alloc] init];
    nameButton.frame=CGRectMake(0, button.frame.size.width+5, button.frame.size.width, 20);
    [nameButton setTitle:nameStr forState:UIControlStateNormal];
    [nameButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addSubview:nameButton];
    
    
    
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
                btn.layer.borderWidth = 3;
                btn.layer.borderColor = [[UIColor redColor]CGColor];
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
    for (id view in playBtn1.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            image1=view;
        }
    }
    
    
    UIImageView *image2;
    for (id view in playBtn2.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            image2=view;
        }
    }

    
    UIImageView *image3;
    for (id view in playBtn3.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            image3=view;
        }
    }

    
    if (image1.tag==2031) {
        ZCDouModel *userModel=[[ZCDouModel alloc] init];
        userModel.isUser=1;
        userModel.name=self.personName;
        userModel.personImage=image1.image;
        self.userModel=userModel;
        [teamArray addObject:userModel];
    }else
    {
        ZCDouModel *userModel=[[ZCDouModel alloc] init];
        userModel.isUser=0;
        userModel.name=self.personName;
        userModel.personImage=image1.image;
        self.userModel=userModel;
        [teamArray addObject:userModel];
    
    }
    
    
    
    
    if (image2.tag==2031) {
        ZCDouModel *userModel=[[ZCDouModel alloc] init];
        userModel.isUser=1;
        userModel.name=@"张三";
        userModel.personImage=image2.image;
        self.userModel=userModel;
        [teamArray addObject:userModel];
    }else
    {
        ZCDouModel *userModel=[[ZCDouModel alloc] init];
        userModel.isUser=0;
        userModel.name=@"张三";
        userModel.personImage=image2.image;
        self.userModel=userModel;
        [teamArray addObject:userModel];
        
    }

    
    if (image3.tag==2031) {
        ZCDouModel *userModel=[[ZCDouModel alloc] init];
        userModel.isUser=1;
        userModel.name=@"李四";
        userModel.personImage=image3.image;
        self.userModel=userModel;
        [teamArray addObject:userModel];
    }else
    {
        ZCDouModel *userModel=[[ZCDouModel alloc] init];
        userModel.isUser=0;
        userModel.name=@"李四";
        userModel.personImage=image3.image;
        self.userModel=userModel;
        [teamArray addObject:userModel];
        
    }

//
    
    ZCLog(@"%d",[teamArray[0] isUser]) ;
    ZCLog(@"%d",[teamArray[1] isUser]) ;
    ZCLog(@"%d",[teamArray[2] isUser]) ;
    
//    ZCDouModel *otherModel=[[ZCDouModel alloc] init];
//    otherModel.isUser=0;
//    otherModel.name=@"张三";
//    otherModel.personImage=self.personImage;
//    self.otherModel=otherModel;
//    
//    
//    
//    ZCDouModel *anotherModel=[[ZCDouModel alloc] init];
//    anotherModel.isUser=0;
//    anotherModel.name=@"李四";
//    anotherModel.personImage=self.personImage;
//    self.anotherModel=anotherModel;
    
    
    return teamArray;
}




@end
