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
    bjView.backgroundColor=ZCColor(237, 237, 237);
    bjView.alpha=1.0;
    bjView.layer.cornerRadius=5;//设置圆角的半径为10
    
    bjView.layer.masksToBounds=YES;
    [self addSubview:bjView];
    self.bjView=bjView;
    
    
    UILabel *nameLabel=[[UILabel alloc] init];
    nameLabel.text=@"昵称";
    nameLabel.textColor=ZCColor(85, 85, 85);
    [bjView addSubview:nameLabel];
    self.nameLabel=nameLabel;
    
    UITextField *nameTextField=[[UITextField alloc] init];
    [bjView addSubview:nameTextField];
    self.nameTextField=nameTextField;
    
    
    UIView *bjColorView=[[UIView alloc] init];
    bjColorView.backgroundColor=ZCColor(163, 163, 163);
    [bjView addSubview:bjColorView];
    self.bjColorView=bjColorView;
    
    UILabel *photoLabel=[[UILabel alloc] init];
    photoLabel.text=@"头像";
    photoLabel.textColor=ZCColor(85, 85, 85);
    [bjView addSubview:photoLabel];
    self.photoLabel=photoLabel;
    
    UIImageView *photoImage=[[UIImageView alloc] init];
    photoImage.image=[UIImage imageNamed:@"photography"];
    [bjView addSubview:photoImage];
    self.photoImage=photoImage;
    
    UIButton *paiButton=[[UIButton alloc] init];
    paiButton.tag=20995;
    [paiButton setBackgroundImage:[UIImage imageNamed:@"paizhao_anniu"] forState:UIControlStateNormal];
    [paiButton setTitle:@"拍照" forState:UIControlStateNormal];
    [paiButton setTitleColor:ZCColor(85, 85, 85) forState:UIControlStateNormal];
    [paiButton addTarget:self action:@selector(clickTheButton:) forControlEvents:UIControlEventTouchUpInside];
    [bjView addSubview:paiButton];
    self.paiButton=paiButton;
    
    UIButton *photoButton=[[UIButton alloc] init];
    photoButton.tag=20996;
    [photoButton setBackgroundImage:[UIImage imageNamed:@"paizhao_anniu"] forState:UIControlStateNormal];
    [photoButton setTitle:@"相册" forState:UIControlStateNormal];
    [photoButton setTitleColor:ZCColor(85, 85, 85) forState:UIControlStateNormal];
    [photoButton addTarget:self action:@selector(clickTheButton:) forControlEvents:UIControlEventTouchUpInside];
    [bjView addSubview:photoButton];
    self.photoButton=photoButton;
    
    UIView *bjColorView2=[[UIView alloc] init];
    bjColorView2.backgroundColor=ZCColor(163, 163, 163);
    [bjView addSubview:bjColorView2];
    self.bjColorView2=bjColorView2;
    
    
    UIView *bjColorView3=[[UIView alloc] init];
    bjColorView3.backgroundColor=ZCColor(163, 163, 163);
    [bjView addSubview:bjColorView3];
    self.bjColorView3=bjColorView3;
    
    UIButton *cancelButton=[[UIButton alloc] init];
    cancelButton.tag=20997;
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:ZCColor(21, 126, 251) forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(clickTheButton:) forControlEvents:UIControlEventTouchUpInside];
    [bjView addSubview:cancelButton];
    self.cancelButton=cancelButton;
    
    UIButton *determineButton=[[UIButton alloc] init];
    determineButton.tag=20998;
    [determineButton setTitle:@"好" forState:UIControlStateNormal];
    [determineButton setTitleColor:ZCColor(21, 126, 251) forState:UIControlStateNormal];
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
    CGFloat bjViewH=207;
    CGFloat bjViewY=(SCREEN_HEIGHT-bjViewH)/2;
    
    self.bjView.frame=CGRectMake(bjViewX, bjViewY, bjViewW, bjViewH);
    
    
    CGFloat nameLabelX=18;
    CGFloat nameLabelY=38;
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
    CGFloat photoLabelH=100;
    self.photoLabel.frame=CGRectMake(photoLabelX, photoLabelY, photoLabelW, photoLabelH);
    
    CGFloat photoImageX=photoLabelX+photoLabelW+20;
    CGFloat photoImageY=bjColorViewY+15;
    CGFloat photoImageW=70;
    CGFloat photoImageH=70;
    self.photoImage.frame=CGRectMake(photoImageX, photoImageY, photoImageW, photoImageH);

    
    CGFloat paiButtonW=76;
    CGFloat paiButtonH=26;
    CGFloat paiButtonX=photoImageX+photoImageW+SCREEN_WIDTH*0.065;
    CGFloat paiButtonY=bjColorViewY+(100-paiButtonH*2-8)/2;
    self.paiButton.frame=CGRectMake(paiButtonX, paiButtonY, paiButtonW, paiButtonH);
    
    
    CGFloat photoButtonW=76;
    CGFloat photoButtonH=26;
    CGFloat photoButtonX=paiButtonX;
    CGFloat photoButtonY=paiButtonY+paiButtonH+8;
    self.photoButton.frame=CGRectMake(photoButtonX, photoButtonY, photoButtonW, photoButtonH);
    
    CGFloat bjColorView2X=0;
    CGFloat bjColorView2Y=photoLabelY+photoLabelH;
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
    CGFloat bjColorView3H=cancelButtonH+5;
    self.bjColorView3.frame=CGRectMake(bjColorView3X, bjColorView3Y, bjColorView3W, bjColorView3H);
    
    
    CGFloat determineButtonX=bjColorView3X+0.5;
    CGFloat determineButtonY=bjColorView2Y+1;
    CGFloat determineButtonW=(bjViewW-0.5)/2;
    CGFloat determineButtonH=30;
    self.determineButton.frame=CGRectMake(determineButtonX, determineButtonY, determineButtonW, determineButtonH);
    
}

@end
