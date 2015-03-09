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
        childName.backgroundColor=[UIColor blueColor];
        //居中
        childName.textAlignment=NSTextAlignmentCenter;
        
        
        [self addSubview:childName];
        self.childName=childName;
//
        //右边
        UILabel *TTaiName=[[UILabel alloc] init];
        
        TTaiName.backgroundColor=[UIColor blueColor];
        //居中
        TTaiName.textAlignment=NSTextAlignmentCenter;
        //TTaiName.text=self.cleicedName;
        [self addSubview:TTaiName];
        self.TTaiName=TTaiName;
        //添加图片按钮
        
        
        
        
        UIImageView *imageView=[[UIImageView alloc] init];
        
        
        //[imageView setImage:[UIImage imageNamed:@"navigationbar_arrow_down"]];
        
        [self addSubview:imageView];
        self.imageView=imageView;

       // 添加T台图片
        UIImageView *TTaiImage=[[UIImageView alloc] init];
        // 添加内部的小箭头
        
        [TTaiImage setImage:[UIImage imageNamed:@"main_badge"]];
        [self addSubview:TTaiImage];
        self.TTaiImage=TTaiImage;
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
    self.TTaiName.text=cleicedName;
    
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
    
    
    CGFloat childNameY=0;
    CGFloat childNameW=100;
    CGFloat childNameX=20;
    CGFloat childNameH=60;
    
//    self.childName.frame=CGRectMake(childNameX, childNameY, childNameW, childNameH);
    self.childName.frame=CGRectMake(childNameX, childNameY, childNameW, childNameH);

    CGFloat TTaiImageY=0;
    CGFloat TTaiImageW=30;
    CGFloat TTaiImageX=140;
    CGFloat TTaiImageH=self.frame.size.height;
    
    self.TTaiImage.frame=CGRectMake(TTaiImageX, TTaiImageY, TTaiImageW, TTaiImageH);
    
    CGFloat TTaiNameY=0;
    CGFloat TTaiNameW=50;
    CGFloat TTaiNameX=200;
    CGFloat TTaiNameH=self.frame.size.height;
    
    self.TTaiName.frame=CGRectMake(TTaiNameX, TTaiNameY, TTaiNameW, TTaiNameH);
    

    
    CGFloat imageViewY=0;
    CGFloat imageViewW=50;
    CGFloat imageViewX=300;
    CGFloat imageViewH=self.frame.size.height;


    self.imageView.frame=CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
}


@end
