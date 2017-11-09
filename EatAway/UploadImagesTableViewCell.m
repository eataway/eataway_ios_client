//
//  UploadImagesTableViewCell.m
//  UniTrader
//
//  Created by Wolf.Wang on 2016/12/9.
//  Copyright © 2016年 youfeng. All rights reserved.
//

#import "UploadImagesTableViewCell.h"

@interface UploadImagesTableViewCell ()
{
    UIScrollView *SV;
    UIButton *btnUpload;
}
@end

@implementation UploadImagesTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UIView *viewBG = [[UIView alloc]initWithFrame:CGRectMake(10, 0, WINDOWWIDTH - 20, 130)];
        viewBG.backgroundColor = [UIColor whiteColor];
        viewBG.clipsToBounds = YES;
        viewBG.layer.cornerRadius = 7;
        [self addSubview:viewBG];
        
        UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(10, 0, 10, 10)];
        view1.backgroundColor = [UIColor whiteColor];
        [self addSubview:view1];
        
        UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(WINDOWWIDTH - 10 - 10, 0, 10, 10)];
        view2.backgroundColor = [UIColor whiteColor];
        [self addSubview:view2];
        
        SV = [[UIScrollView alloc]initWithFrame:CGRectMake(20, 5, WINDOWWIDTH - 40, 110)];
        [self addSubview:SV];
        SV.contentSize = CGSizeMake(100 + 10, 110);
        SV.bounces = NO;
        btnUpload = [UIButton buttonWithType:UIButtonTypeCustom];
        btnUpload.frame = CGRectMake(0, 10, 100, 100);
        [btnUpload setImage:[UIImage imageNamed:@"3.1.2_icon_add.png"] forState:UIControlStateNormal];
        [btnUpload addTarget:self action:@selector(btnUpLoadClick) forControlEvents:UIControlEventTouchUpInside];
        [SV addSubview:btnUpload];
        

        
    }
    return self;
}
-(void)btnUpLoadClick
{
    [self.delegate tableViewUploadImageClick];
}
-(void)addImage:(UIImage *)image
{
    NSInteger existImageNum =  (SV.subviews.count - 3)/2;
    UIImageView *IV = [[UIImageView alloc]initWithFrame:CGRectMake(existImageNum *(100 + 25), 10, 100, 100)];
    IV.image = image;
    IV.tag = existImageNum + 100;
    IV.contentMode = UIViewContentModeScaleAspectFill;
    IV.clipsToBounds = YES;
    [SV addSubview:IV];
    
    UIButton *btnX = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnX setImage:[UIImage imageNamed:@"jian.png"] forState:UIControlStateNormal];
    btnX.frame = CGRectMake(IV.frame.origin.x + IV.frame.size.width - 10, 0, 20, 20);
    btnX.tag = IV.tag;
    [btnX addTarget:self action:@selector(btnXClick:) forControlEvents:UIControlEventTouchUpInside];
    [SV addSubview:btnX];
    
    btnUpload.center = CGPointMake(btnUpload.center.x + 125, btnUpload.center.y);
    if (existImageNum < (self.maxImageNum > 0 ?self.maxImageNum -1:1))
    {
        btnUpload.hidden = NO;
        SV.contentSize = CGSizeMake(SV.contentSize.width + 125, SV.contentSize.height);
    }
    else
    {
        btnUpload.hidden = YES;
    }
}
-(void)btnXClick:(UIButton *)btn
{
    NSInteger removeTag = btn.tag;
    for (UIView *aView in SV.subviews)
    {
        if (aView.tag == removeTag)
        {
            [aView removeFromSuperview];
        }
        else if(aView.tag>removeTag)
        {
            aView.center = CGPointMake(aView.center.x - 125, aView.center.y);
            aView.tag = aView.tag - 1;
            
        }
        
    }
    if (btnUpload.frame.origin.x < SV.contentSize.width)
    {
        SV.contentSize = CGSizeMake(SV.contentSize.width - 125, SV.contentSize.height);
    }
    btnUpload.center = CGPointMake(btnUpload.center.x - 125, btnUpload.center.y);
    NSLog(@"第%ld个",(long)btn.tag - 100);
    [self.delegate tableViewDeleteImageWithTag:btn.tag - 100];
    
    btnUpload.hidden = NO;

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
