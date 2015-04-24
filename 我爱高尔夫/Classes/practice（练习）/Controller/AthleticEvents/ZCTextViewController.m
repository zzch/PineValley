//
//  ZCTextViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/4/23.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCTextViewController.h"
#import "UIBarButtonItem+DC.h"
@interface ZCTextViewController ()

@property(nonatomic,weak)UITextView *textView;

@end

@implementation ZCTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    //返回
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barBtnItemWithNormalImageName:@"fanhui" hightImageName:@"fanhui-anxia" action:@selector(liftBthClick:) target:self];
    
    
    
    
    UITextView *textView=[[UITextView alloc] init];
    
    textView.frame=CGRectMake(0, 20, SCREEN_WIDTH, 100);
    [self.view addSubview:textView];
    self.textView=textView;

    
    // Do any additional setup after loading the view.
}




-(void)liftBthClick:(UIButton *)button
{

    if ([self.ZCdelegate respondsToSelector:@selector(textViewDidClickedleftButton:textViewTextStr:)]) {
        [self.ZCdelegate textViewDidClickedleftButton:self textViewTextStr:self.textView.text];
    }
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
