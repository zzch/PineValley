//
//  ZCSettingHeadView.m
//  我爱高尔夫
//
//  Created by hh on 15/3/2.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCSettingHeadView.h"
@interface ZCSettingHeadView()


@property (nonatomic, weak) UILabel *childName;
@property (nonatomic, weak) UIImageView *TTaiImage;
@property (nonatomic, weak) UILabel *TTaiName;
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UIView *bjview;

@end
@implementation ZCSettingHeadView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    static NSString *ID=@"header";
    ZCSettingHeadView *headerView=[tableView  dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (headerView==nil) {
        headerView=[[ZCSettingHeadView alloc] initWithReuseIdentifier:ID];
    }
    return headerView;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.backgroundView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"suoyou_bj_02"]];
        
          //self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"suoyou_bj_02"]];
        
        //添加子控件
        //1.添加按钮
        UIButton *nameButton=[UIButton buttonWithType:UIButtonTypeCustom];
       
        //        // 添加内部的小箭头
        //       [nameButton setImage:[UIImage imageNamed:@"tabbar_home"] forState:UIControlStateNormal];
        //
        //
        [nameButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //
        //        // 设置按钮的内容左对齐
        nameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //
        //      //
        // 设置按钮的内边距
        // 设置里面所有内容左边距10
        nameButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        // 设置按钮里面文字的内边距
        nameButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
        
        //
        //        // 监听按钮的点击
        [nameButton addTarget:self action:@selector(nameButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        //
        //        // 设置按钮的内部的imageView的内容居中
        //        nameButton.imageView.contentMode = UIViewContentModeRight;
        //
        // 超出边框的部分 不需要裁剪
        nameButton.imageView.clipsToBounds = NO;
        
        [self addSubview:nameButton];
        self.nameButton=nameButton;
        
        
        
        //添加选中显示的值
        UILabel *childName=[[UILabel alloc] init];
        //childName.backgroundColor=[UIColor blueColor];
        //居中
       // childName.textAlignment=NSTextAlignmentCenter;
        childName.textColor=ZCColor(240, 208, 122);
        
        [self addSubview:childName];
        self.childName=childName;
//
        //右边
        UILabel *TTaiName=[[UILabel alloc] init];
        
       TTaiName.textColor=ZCColor(240, 208, 122);
        //居中
        TTaiName.textAlignment=NSTextAlignmentRight;
        
        [self addSubview:TTaiName];
        self.TTaiName=TTaiName;
        
        
        //添加图片按钮
      
        UIImageView *imageView=[[UIImageView alloc] init];
        [self addSubview:imageView];
        self.imageView=imageView;

       // 添加T台图片
        UIImageView *TTaiImage=[[UIImageView alloc] init];
        // 添加内部的小箭头
    
        [self addSubview:TTaiImage];
        self.TTaiImage=TTaiImage;
        
        
        UIView *bjview=[[UIView alloc] init];
        bjview.backgroundColor=ZCColor(136, 119, 73);
        [self addSubview:bjview];
        self.bjview=bjview;
        
    }
    return self;
    
}


-(void)nameButtonClick:(UIButton *)button
{
    
   
    
    //刷新表格
    if ([self.delegate respondsToSelector:@selector(headerViewDidClicked:didClickButton:)]) {
        [self.delegate headerViewDidClicked:self didClickButton:button];
    }
    
    
}


//当某个子控件加载到父控件上得时候调用
//- (void)didMoveToSuperview
//{
//    if (self.setting.opened) {
//        self.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);// 90°
//    } else {
//        self.imageView.transform = CGAffineTransformMakeRotation(0);
//    }
//    
//}



-(void)setCleicedName:(NSString *)cleicedName
{
    
     _cleicedName=cleicedName;
    if ([cleicedName isEqual:@"white"]) {
        [self.TTaiImage setImage:[UIImage imageNamed:@"bai"]];
        self.TTaiName.text=@"白色T台";
    }else if([cleicedName isEqual:@"red"])
    {
       [self.TTaiImage setImage:[UIImage imageNamed:@"hong"]];
        self.TTaiName.text=@"红色T台";
    }else if([cleicedName isEqual:@"blue"])
    {
      [self.TTaiImage setImage:[UIImage imageNamed:@"lan"]];
       self.TTaiName.text=@"蓝色T台";
    }else if ([cleicedName isEqual:@"black"])
    {
      [self.TTaiImage setImage:[UIImage imageNamed:@"hei"]];
        self.TTaiName.text=@"黑色T台";
    }else if ([cleicedName isEqual:@"gold"])
    {
      [self.TTaiImage setImage:[UIImage imageNamed:@"huang"]];
        self.TTaiName.text=@"金色色T台";
    }else
    {
       self.TTaiName.text=cleicedName;
    }
        
    
    
    
    
   
    
    
}
-(void)setLiftName:(NSString *)liftName
{
    _liftName=liftName;
   
    self.childName.text=self.liftName;
}

-(void)setImageName:(NSString *)imageName
{
    _imageName=imageName;
        [self.imageView setImage:[UIImage imageNamed:imageName]];
}



-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置按钮的frame
    self.nameButton.frame=self.bounds;
    
    //设置childName的frame
    
    
    
    CGFloat childNameW=self.frame.size.width*0.35;
    CGFloat childNameX=self.frame.size.width*0.03;
    CGFloat childNameH=40;
    CGFloat childNameY=(self.frame.size.height-childNameH)*0.5;
    
//    self.childName.frame=CGRectMake(childNameX, childNameY, childNameW, childNameH);
    self.childName.frame=CGRectMake(childNameX, childNameY, childNameW, childNameH);

   
    CGFloat TTaiImageW=19;
    CGFloat TTaiImageX=self.frame.size.width*0.62;
    CGFloat TTaiImageH=19;
    CGFloat TTaiImageY=(self.frame.size.height-TTaiImageH)*0.5;
    
    self.TTaiImage.frame=CGRectMake(TTaiImageX, TTaiImageY, TTaiImageW, TTaiImageH);
    
    CGFloat TTaiNameY=childNameY;
    CGFloat TTaiNameW=65;
    CGFloat TTaiNameX=TTaiImageX+TTaiImageW;
    CGFloat TTaiNameH=childNameH;
    
    self.TTaiName.frame=CGRectMake(TTaiNameX, TTaiNameY, TTaiNameW, TTaiNameH);
    

    
    
    CGFloat imageViewW=17;
    CGFloat imageViewX=self.frame.size.width-imageViewW-10;
    CGFloat imageViewH=10;
    CGFloat imageViewY=(self.frame.size.height-imageViewH)*0.5;


    self.imageView.frame=CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    
    
    self.bjview.frame=CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1);
}


@end
