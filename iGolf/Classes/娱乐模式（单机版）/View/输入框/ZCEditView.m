//
//  ZCEditView.m
//  iGolf
//
//  Created by hh on 15/8/6.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCEditView.h"
@interface ZCEditView()
@property(nonatomic,weak)UIView *bjView;
@property(nonatomic,weak)UILabel *nameLabel;
@property(nonatomic,weak)UITextField *nameTextField;
@property(nonatomic,weak)UIView *bjColorView;
@property(nonatomic,weak)UIView *bjColorView2;
@property(nonatomic,weak)UIView *bjColorView3;
@property(nonatomic,weak)UILabel *photoLabel;
@property(nonatomic,weak)UIImageView *photoImage;
@property(nonatomic,weak)UIButton *paiButton;
@property(nonatomic,weak)UIButton *photoButton;
@property(nonatomic,weak)UIButton *cancelButton;
@property(nonatomic,weak)UIButton *determineButton;
@end
@implementation ZCEditView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        self.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.4];
        
        [self AddControls];
    }
    return self;

}


//添加控件
-(void)AddControls
{
    UIView *bjView=[[UIView alloc] init];
    bjView.backgroundColor=[UIColor whiteColor];
    bjView.alpha=1.0;
    [self addSubview:bjView];
    self.bjView=bjView;
    
    
    UILabel *nameLabel=[[UILabel alloc] init];
    nameLabel.text=@"姓名";
    [bjView addSubview:nameLabel];
    self.nameLabel=nameLabel;
    
    UITextField *nameTextField=[[UITextField alloc] init];
    [bjView addSubview:nameTextField];
    self.nameTextField=nameTextField;
    
    
    UIView *bjColorView=[[UIView alloc] init];
    bjColorView.backgroundColor=[UIColor redColor];
    [bjView addSubview:bjColorView];
    self.bjColorView=bjColorView;
    
    UILabel *photoLabel=[[UILabel alloc] init];
    photoLabel.text=@"头像";
    [bjView addSubview:photoLabel];
    self.photoLabel=photoLabel;
    
    UIImageView *photoImage=[[UIImageView alloc] init];
    photoImage.image=[UIImage imageNamed:@"20141118042246536.jpg"];
    [bjView addSubview:photoImage];
    self.photoImage=photoImage;
    
    UIButton *paiButton=[[UIButton alloc] init];
    paiButton.tag=20995;
    [paiButton setTitle:@"拍照" forState:UIControlStateNormal];
    [paiButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [paiButton addTarget:self action:@selector(clickTheButton:) forControlEvents:UIControlEventTouchUpInside];
    [bjView addSubview:paiButton];
    self.paiButton=paiButton;
    
    UIButton *photoButton=[[UIButton alloc] init];
    photoButton.tag=20996;
    [photoButton setTitle:@"相册" forState:UIControlStateNormal];
    [photoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [photoButton addTarget:self action:@selector(clickTheButton:) forControlEvents:UIControlEventTouchUpInside];
    [bjView addSubview:photoButton];
    self.photoButton=photoButton;
    
    UIView *bjColorView2=[[UIView alloc] init];
    bjColorView2.backgroundColor=[UIColor redColor];
    [bjView addSubview:bjColorView2];
    self.bjColorView2=bjColorView2;
    
    
    UIView *bjColorView3=[[UIView alloc] init];
    bjColorView3.backgroundColor=[UIColor redColor];
    [bjView addSubview:bjColorView3];
    self.bjColorView3=bjColorView3;
    
    UIButton *cancelButton=[[UIButton alloc] init];
    cancelButton.tag=20997;
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(clickTheButton:) forControlEvents:UIControlEventTouchUpInside];
    [bjView addSubview:cancelButton];
    self.cancelButton=cancelButton;
    
    UIButton *determineButton=[[UIButton alloc] init];
    determineButton.tag=20998;
    [determineButton setTitle:@"确定" forState:UIControlStateNormal];
    [determineButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [determineButton addTarget:self action:@selector(clickTheButton:) forControlEvents:UIControlEventTouchUpInside];
    [bjView addSubview:determineButton];
    self.determineButton=determineButton;
    
    
    
}

//点击拍照
-(void)clickTheButton:(UIButton *)btn
{
    if (btn.tag==20997) {//点击取消
        [self removeFromSuperview];
    }else if (btn.tag==20998)
    {//点击确定
    
        if ([self.delegate respondsToSelector:@selector(editViewPersonalInformation:andName:)]) {
            [self.delegate editViewPersonalInformation:self.photoImage.image andName:self.nameTextField.text];
            [self removeFromSuperview];
        }
        
        
    }else{
        if ([self.delegate respondsToSelector:@selector(editViewButtonIsClicked:)]) {
            [self.delegate editViewButtonIsClicked:btn];
        }

    }

    
}


-(void)setImage:(UIImage *)image
{
    _image=image;
    self.photoImage.image=image;
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //退出键盘
  [self endEditing:YES];
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat bjViewX=20;
    CGFloat bjViewW=self.frame.size.width-2*bjViewX;
    CGFloat bjViewH=160;
    CGFloat bjViewY=(SCREEN_HEIGHT-bjViewH)/2;
    self.bjView.frame=CGRectMake(bjViewX, bjViewY, bjViewW, bjViewH);
    
    
    CGFloat nameLabelX=10;
    CGFloat nameLabelY=25;
    CGFloat nameLabelW=40;
    CGFloat nameLabelH=20;
    self.nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    
    CGFloat nameTextFieldX=nameLabelX+nameLabelW;
    CGFloat nameTextFieldY=nameLabelY;
    CGFloat nameTextFieldW=bjViewW-2*nameLabelX-nameLabelW;
    CGFloat nameTextFieldH=20;
    self.nameTextField.frame=CGRectMake(nameTextFieldX, nameTextFieldY, nameTextFieldW, nameTextFieldH);
    
    CGFloat bjColorViewX=nameLabelX;
    CGFloat bjColorViewY=nameTextFieldY+nameTextFieldH+5;
    CGFloat bjColorViewW=bjViewW-2*bjColorViewX;
    CGFloat bjColorViewH=0.5;
    self.bjColorView.frame=CGRectMake(bjColorViewX, bjColorViewY, bjColorViewW, bjColorViewH);
    
    CGFloat photoLabelX=nameLabelX;
    CGFloat photoLabelY=bjColorViewY+5;
    CGFloat photoLabelW=40;
    CGFloat photoLabelH=60;
    self.photoLabel.frame=CGRectMake(photoLabelX, photoLabelY, photoLabelW, photoLabelH);
    
    CGFloat photoImageX=photoLabelX+photoLabelW;
    CGFloat photoImageY=bjColorViewY+5;
    CGFloat photoImageW=60;
    CGFloat photoImageH=60;
    self.photoImage.frame=CGRectMake(photoImageX, photoImageY, photoImageW, photoImageH);

    
    CGFloat paiButtonW=60;
    CGFloat paiButtonH=30;
    CGFloat paiButtonX=bjViewW-10-paiButtonW;
    CGFloat paiButtonY=photoImageY;
    self.paiButton.frame=CGRectMake(paiButtonX, paiButtonY, paiButtonW, paiButtonH);
    
    
    CGFloat photoButtonW=60;
    CGFloat photoButtonH=30;
    CGFloat photoButtonX=bjViewW-10-paiButtonW;
    CGFloat photoButtonY=paiButtonY+paiButtonH+10;
    self.photoButton.frame=CGRectMake(photoButtonX, photoButtonY, photoButtonW, photoButtonH);
    
    CGFloat bjColorView2X=0;
    CGFloat bjColorView2Y=photoLabelY+photoLabelH+10;
    CGFloat bjColorView2W=bjViewW;
    CGFloat bjColorView2H=0.5;
    self.bjColorView2.frame=CGRectMake(bjColorView2X, bjColorView2Y, bjColorView2W, bjColorView2H);
    
    CGFloat cancelButtonX=0;
    CGFloat cancelButtonY=bjColorView2Y+1;
    CGFloat cancelButtonW=(bjViewW-0.5)/2;
    CGFloat cancelButtonH=30;
    self.cancelButton.frame=CGRectMake(cancelButtonX, cancelButtonY, cancelButtonW, cancelButtonH);
    
    
    CGFloat bjColorView3X=cancelButtonW;
    CGFloat bjColorView3Y=cancelButtonY;
    CGFloat bjColorView3W=0.5;
    CGFloat bjColorView3H=cancelButtonH;
    self.bjColorView3.frame=CGRectMake(bjColorView3X, bjColorView3Y, bjColorView3W, bjColorView3H);
    
    
    CGFloat determineButtonX=bjColorView3X+0.5;
    CGFloat determineButtonY=bjColorView2Y+1;
    CGFloat determineButtonW=(bjViewW-0.5)/2;
    CGFloat determineButtonH=30;
    self.determineButton.frame=CGRectMake(determineButtonX, determineButtonY, determineButtonW, determineButtonH);
    
}

@end
