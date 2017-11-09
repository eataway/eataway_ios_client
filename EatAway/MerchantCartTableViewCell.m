//
//  MerchantCartTableViewCell.m
//  EatAway
//
//  Created by apple on 2017/6/26.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "MerchantCartTableViewCell.h"


@interface MerchantCartTableViewCell ()
{
    UIButton *btnJian;
    UIButton *btnJia;
    
    UILabel *labelTitle;
    UILabel *labelPrice;
    
    NSString *_strImageURL;

}
@end

@implementation MerchantCartTableViewCell

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
        CGFloat cellWidth = WINDOWWIDTH;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        btnJian = [UIButton buttonWithType:UIButtonTypeCustom];
        btnJian.frame = CGRectMake(cellWidth - 10 - 20 - 25 - 20, 15 , 20, 20);
        [btnJian setImage:[UIImage imageNamed:@"2.2.0_icon_reduce.png"] forState:UIControlStateNormal];
        btnJian.adjustsImageWhenHighlighted = NO;
        btnJian.tag = 1;
        [btnJian addTarget:self action:@selector(btnChangeNumClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnJian];
        btnJian.hidden = YES;
        
        _labelNum = [[UILabel alloc]initWithFrame:CGRectMake(cellWidth - 10 - 20 - 25, 15 , 25, 20)];
        _labelNum.text = @"0";
        _labelNum.font = [UIFont systemFontOfSize:15];
        _labelNum.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_labelNum];
        
        btnJia = [UIButton buttonWithType:UIButtonTypeCustom];
        btnJia.frame = CGRectMake(cellWidth - 10 - 20 , 15 , 20, 20);
        [btnJia setImage:[UIImage imageNamed:@"2.2.0_icon_plus.png"] forState:UIControlStateNormal];
        btnJia.adjustsImageWhenHighlighted = NO;
        btnJia.tag = 2;
        [btnJia addTarget:self action:@selector(btnChangeNumClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnJia];
        
        labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(10 , 10, cellWidth - (10 + 80 + 10 + 75 + 5), 30)];
        labelTitle.font = [UIFont systemFontOfSize:13];
        [self addSubview:labelTitle];
        
        labelPrice = [[UILabel alloc]initWithFrame:CGRectMake(WINDOWWIDTH - 75 - 10 - 75 , 10 , 75, 30)];
        labelPrice.font = [UIFont systemFontOfSize:13];
        labelPrice.textAlignment = NSTextAlignmentRight;
        labelPrice.textColor = [UIColor blackColor];
        [self addSubview:labelPrice];
        
        UIView *viewDown = [[UIView alloc]initWithFrame:CGRectMake(0, 49, WINDOWWIDTH, 1)];
        viewDown.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
        [self addSubview:viewDown];
        
        
        
    }
    return self;
}
-(void)setContentWithTitle:(NSString *)strTitle num:(NSString *)strNum price:(NSString *)strPrice foodID:(NSString *)strFoodID image:(NSString *)strImageURL
{
    labelTitle.text = strTitle;
    _labelNum.text = strNum;
    NSInteger num = [strNum integerValue];
    if (num <= 0)
    {
        btnJian.hidden = YES;
    }
    else
    {
        btnJian.hidden = NO;
    }
    labelPrice.text = [NSString stringWithFormat:@"$%@/份",strPrice];
    self.strFoodID = strFoodID;
    
    _strImageURL = strImageURL;

    
}

-(void)btnChangeNumClick:(UIButton *)btn
{
    NSString *strNum = _labelNum.text;
    NSInteger num = [strNum integerValue];
    if (btn.tag == 1 && num >0)
    {
        num = num - 1;
    }
    else if(btn.tag == 2)
    {
        num = num + 1;
    }
    if (num <= 0)
    {
        btnJian.hidden = YES;
    }
    else
    {
        btnJian.hidden = NO;
    }
    NSString *strNumChanged = [NSString stringWithFormat:@"%ld",(long)num];
    _labelNum.text = strNumChanged;
    
    NSArray *arr1 = [labelPrice.text componentsSeparatedByString:@"/"];
    NSString *str1 = [arr1 firstObject];
    NSArray *arr2 = [str1 componentsSeparatedByString:@"$"];
    NSString *str2 = [arr2 lastObject];
    
    [self.delegate MerchantCartTableViewCellChangeFoodNumber:num foodID:self.strFoodID foodName:labelTitle.text foodPrice:str2 imageURL:_strImageURL];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
