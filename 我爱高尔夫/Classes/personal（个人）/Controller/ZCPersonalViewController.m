//
//  ZCPersonalViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/4/8.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCPersonalViewController.h"
#import "ZCPersonalInformationViewController.h"
@interface ZCPersonalViewController ()
//头像View
@property(nonatomic,weak)UIImageView *headImageView;
//消息View
@property(nonatomic,weak)UIButton *settingsButton;
@end

@implementation ZCPersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建图片View
    [self initImageView];
    
    //设置
    [self initSettingsButton];
    
    


}

//设置
-(void)initSettingsButton
{
    UIButton *settingsButton=[[UIButton alloc] init];
    settingsButton.backgroundColor=[UIColor redColor];
    CGFloat settingsButtonX=10;
    CGFloat settingsButtonY=self.headImageView.frame.size.height+15;
    CGFloat settingsButtonW=SCREEN_WIDTH-(2*settingsButtonX);
    CGFloat settingsButtonH=60;
    settingsButton.frame=CGRectMake(settingsButtonX, settingsButtonY, settingsButtonW, settingsButtonH);
    [self.view addSubview:settingsButton];
    self.settingsButton=settingsButton;
    
    
    UIImageView *image=[[UIImageView alloc] init];
    CGFloat imageX=10;
    
    CGFloat imageW=30;
    CGFloat imageH=30;
    CGFloat imageY=(settingsButtonH-imageH)*0.5;
    image.frame=CGRectMake(imageX, imageY, imageW, imageH);
    
    [settingsButton addSubview:image];
    
    //设置
    UILabel *settingsLabel=[[UILabel alloc] init];
    CGFloat settingsLabelX=imageW+imageX+15;
    CGFloat settingsLabelW=50;
    CGFloat settingsLabelH=30;
    CGFloat settingsLabelY=(settingsButtonH-imageH)*0.5;
    settingsLabel.frame=CGRectMake(settingsLabelX, settingsLabelY, settingsLabelW, settingsLabelH);
    settingsLabel.text=@"设置";
    [settingsButton addSubview:settingsLabel];
    

    //向右箭头
    UIImageView *rightImageView=[[UIImageView alloc] init];
    
    CGFloat rightImageViewW=20;
    CGFloat rightImageViewH=30;
    CGFloat rightImageViewY=(settingsButtonH-rightImageViewH)*0.5;
    CGFloat rightImageViewX=settingsButtonW-rightImageViewW-10;
    rightImageView.frame=CGRectMake(rightImageViewX, rightImageViewY, rightImageViewW, rightImageViewH);
    rightImageView.image=[UIImage imageNamed:@"jfk_youjiantou"];
    
    [settingsButton addSubview:rightImageView];
}




//头部图片View
-(void)initImageView
{
    UIImageView *headImageView=[[UIImageView alloc] init];
    headImageView.userInteractionEnabled=YES;
    CGFloat headImageViewX=0;
    CGFloat headImageViewY=0;
    CGFloat headImageViewW=SCREEN_WIDTH;
    CGFloat headImageViewH=SCREEN_HEIGHT*0.352;
    headImageView.frame=CGRectMake(headImageViewX, headImageViewY, headImageViewW, headImageViewH);
    headImageView.backgroundColor=[UIColor brownColor];
    [self.view addSubview:headImageView];
    self.headImageView=headImageView;
    
    UIImageView *headImage=[[UIImageView alloc] init];
    headImage.image=[UIImage imageNamed:@"20141118042246536.jpg"];
    CGFloat headImageW=75;
    CGFloat headImageH=75;
    CGFloat headImageX=(SCREEN_WIDTH-headImageW)*0.5;
    CGFloat headImageY=21;
    headImage.frame=CGRectMake(headImageX, headImageY, headImageW, headImageH);
    [headImageView addSubview:headImage];
    
    
    //名字
    UILabel *nameLabel=[[UILabel alloc] init];
    nameLabel.text=@"屠你如屠狗";
    nameLabel.textColor=[UIColor whiteColor];
    CGFloat nameLabelW=150;
    CGFloat nameLabelH=25;
    CGFloat nameLabelX=(SCREEN_WIDTH-nameLabelW)*0.5;
    CGFloat nameLabelY=headImageY+headImageH+13;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.textAlignment=NSTextAlignmentCenter;
    [headImageView addSubview:nameLabel];
    
    //心情
    UILabel *moodLabel=[[UILabel alloc] init];
    moodLabel.text=@"我们正是挥霍的年头 你凭什么不快乐";
    moodLabel.textColor=[UIColor whiteColor];
    CGFloat moodLabelW=300;
    CGFloat moodLabelH=25;
    CGFloat moodLabelX=(SCREEN_WIDTH-moodLabelW)*0.5;
    CGFloat moodLabelY=nameLabelY+nameLabelH+15;
    moodLabel.frame=CGRectMake(moodLabelX, moodLabelY, moodLabelW, moodLabelH);

    moodLabel.textAlignment=NSTextAlignmentCenter;
    [headImageView addSubview:moodLabel];
    
    
    //向右的小箭头
    UIButton *rightButton=[[UIButton alloc] init];
    CGFloat rightButtonW=40;
    CGFloat rightButtonH=55;
    CGFloat rightButtonX=SCREEN_WIDTH*0.84;
    CGFloat rightButtonY=(headImageViewH-rightButtonH)*0.5;
    rightButton.frame=CGRectMake(rightButtonX, rightButtonY, rightButtonW, rightButtonH);
    //[rightButton setTitle:@"1212" forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@"jfk_youjiantou"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(clickRightButton) forControlEvents:UIControlEventTouchUpInside];
    [headImageView addSubview:rightButton];

}


-(void)clickRightButton
{
    ZCLog(@"1111");
//    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选取",nil];
//    [sheet showInView:self.view];
    
    ZCPersonalInformationViewController *PersonalInformation=[[ZCPersonalInformationViewController alloc] init];
    [self.navigationController pushViewController:PersonalInformation animated:YES];
    

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
