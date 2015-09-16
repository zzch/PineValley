//
//  ZCGuideViewController.m
//  iGolf
//
//  Created by hh on 15/6/16.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCGuideViewController.h"
#import "ZCAccount.h"
#import "ZCPracticeVController.h"
#import "ZCregisterViewController.h"
@interface ZCGuideViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIPageControl *pageControl;
@end

@implementation ZCGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupScrollView];
    
    
    // 2.添加pageControl
    [self setupPageControl];

}


/**
 *  添加pageControl
 */
- (void)setupPageControl
{
    // 1.添加
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = 4;
    CGFloat centerX = self.view.frame.size.width * 0.5;
    CGFloat centerY = self.view.frame.size.height - 100;
    pageControl.center = CGPointMake(centerX, centerY);
    pageControl.bounds = CGRectMake(0, 0, 100, 30);
    pageControl.userInteractionEnabled = NO;
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
    // 2.设置圆点的颜色
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ydy_xuanzhong"]];
    pageControl.pageIndicatorTintColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"ydy_wxz"]];

    
//    // 2.设置圆点的颜色
//    pageControl.currentPageIndicatorTintColor = ZCColor(253, 98, 42);
//    pageControl.pageIndicatorTintColor = ZCColor(189, 189, 189);
}




/**
 *  添加UISrollView
 */
- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];

    
    
    
    // 2.添加图片
    CGFloat imageW = scrollView.frame.size.width;
    CGFloat imageH = scrollView.frame.size.height;
    for (int index = 0; index<4; index++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        
        // 设置图片
        NSString *name = [NSString stringWithFormat:@"yindaoye_%d", index + 1];
        imageView.image = [UIImage imageNamed:name];
        
        // 设置frame
        CGFloat imageX = index * imageW;
        imageView.frame = CGRectMake(imageX, 0, imageW, imageH);
        
        [scrollView addSubview:imageView];
        
//        // 在最后一个图片上面添加按钮
//        if (index == 3 - 1) {
//            [self setupLastImageView:imageView];
//        }
        
        [self setupLastImageView];
    }
    
    // 3.设置滚动的内容尺寸
    scrollView.contentSize = CGSizeMake(imageW * 4, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
}

/**
 *  添加内容在所有图片上   改版后调用
 */
- (void)setupLastImageView
{
    UIImageView *bjImageView=[[UIImageView alloc] init];
    bjImageView.image=[UIImage imageNamed:@"yindao_dibu"];
    bjImageView.frame=CGRectMake(0, SCREEN_HEIGHT-61, SCREEN_WIDTH, 61);
    [self.view addSubview:bjImageView];
    
    // 0.让imageView能跟用户交互
    bjImageView.userInteractionEnabled = YES;

    
    
    // 1.添加开始按钮
    UIButton *startButton = [[UIButton alloc] init];
    [startButton setBackgroundImage:[UIImage imageNamed:@"yindao_anniu"] forState:UIControlStateNormal];
    
    
    
    // 2.设置frame
    CGFloat centerW =125;
    CGFloat centerH =40;
    CGFloat centerX = (bjImageView.frame.size.width -centerW)/2;
    CGFloat centerY = (bjImageView.frame.size.height -centerH)/2;
    
    //startButton.center = CGPointMake(centerX, centerY);
    //startButton.bounds = (CGRect){CGPointZero, startButton.currentBackgroundImage.size};
    startButton.frame=CGRectMake(centerX, centerY, centerW, centerH);
    // 3.设置文字
    [startButton setTitle:@"立即开始" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    /****************************************/
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [bjImageView addSubview:startButton];


}

/**
 *  添加内容到最后一个图片
 */
- (void)setupLastImageView:(UIImageView *)imageView
{
    CGFloat top = 25; // 顶端盖高度
    CGFloat bottom = 25 ; // 底端盖高度
    CGFloat left = 10; // 左端盖宽度
    CGFloat right = 10; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    UIImage *image1=[UIImage imageNamed:@"ydy_ljks" ];
    // 指定为拉伸模式，伸缩后重新赋值
    image1 = [image1 resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    
    
    // 0.让imageView能跟用户交互
    imageView.userInteractionEnabled = YES;
    
    // 1.添加开始按钮
    UIButton *startButton = [[UIButton alloc] init];
    [startButton setBackgroundImage:image1 forState:UIControlStateNormal];
    [startButton setBackgroundImage:image1 forState:UIControlStateHighlighted];
    
    // 2.设置frame
    CGFloat centerW =imageView.frame.size.width*0.6;
    CGFloat centerH =image1.size.height;
    CGFloat centerX = (imageView.frame.size.width -centerW)/2;
    CGFloat centerY = imageView.frame.size.height * 0.9;
    
    //startButton.center = CGPointMake(centerX, centerY);
    //startButton.bounds = (CGRect){CGPointZero, startButton.currentBackgroundImage.size};
    startButton.frame=CGRectMake(centerX, centerY, centerW, centerH);
    // 3.设置文字
    [startButton setTitle:@"立即开始" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    /****************************************/
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startButton];
    
   



}


- (void)start
{
    // 显示状态栏
   // [UIApplication sharedApplication].statusBarHidden = NO;
    // 切换窗口的根控制器
    //self.view.window.rootViewController = [[IWTabBarViewController alloc] init];
    
    
    //先判断有无存储账号信息
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    
    if (account) {//之前登陆成功
        
        //ZCTabbarViewController *tabbar=[[ZCTabbarViewController alloc] init];
        
        ZCPracticeVController *tabBarVc=[[ZCPracticeVController alloc] init];
        UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:tabBarVc];
        
        self.view.window.rootViewController=nav;
    }else
    {// 之前没有登录成功
        //设置跟控制器
        
        ZCregisterViewController *registerView=[[ZCregisterViewController alloc] init];
        UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:registerView];
        self.view.window.rootViewController=nav;
        
        
    }
    
    

    
}



/**
 *  只要UIScrollView滚动了,就会调用
 *
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 1.取出水平方向上滚动的距离
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 2.求出页码
    double pageDouble = offsetX / scrollView.frame.size.width;
    int pageInt = (int)(pageDouble + 0.5);
    self.pageControl.currentPage = pageInt;
    
    
//    if (pageInt==2) {
//        self.pageControl.hidden=YES ;
//    }else
//    {
//        self.pageControl.hidden=NO;
//    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
