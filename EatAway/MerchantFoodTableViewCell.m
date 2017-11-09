//
//  OrderFoodTableViewCell.m
//  EatAway
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "MerchantFoodTableViewCell.h"

#import <UIImageView+WebCache.h>

@interface MerchantFoodTableViewCell ()
{
    UIButton *btnJian;
    UIButton *btnJia;
    
//    UILabel *labelTitle;
    UILabel *labelPrice;
    UIImageView *IVHead;
    UIButton *btnAlpha;
    
    NSString *_strImageURL;
}
@end

@implementation MerchantFoodTableViewCell

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
        CGFloat cellWidth = WINDOWWIDTH * (1 -170/750.0);
        
        IVHead = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 60)];
        IVHead.contentMode = UIViewContentModeScaleAspectFill;
        IVHead.clipsToBounds = YES;
        [self addSubview:IVHead];
        
        btnJian = [UIButton buttonWithType:UIButtonTypeCustom];
        btnJian.frame = CGRectMake(cellWidth - 10 - 20 - 25 - 20, (80 - 20)/2 +20, 20, 20);
        [btnJian setImage:[UIImage imageNamed:@"2.2.0_icon_reduce.png"] forState:UIControlStateNormal];
        btnJian.adjustsImageWhenHighlighted = NO;
        btnJian.tag = 1;
        [btnJian addTarget:self action:@selector(btnChangeNumClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnJian];
        btnJian.hidden = YES;
        
        _labelNum = [[UILabel alloc]initWithFrame:CGRectMake(cellWidth - 10 - 20 - 25, (80 - 20)/2 + 20, 25, 20)];
        _labelNum.text = @"0";
        _labelNum.font = [UIFont systemFontOfSize:15];
        _labelNum.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_labelNum];
        
        btnJia = [UIButton buttonWithType:UIButtonTypeCustom];
        btnJia.frame = CGRectMake(cellWidth - 10 - 20 , (80 - 20)/2 + 20, 20, 20);
        [btnJia setImage:[UIImage imageNamed:@"2.2.0_icon_plus.png"] forState:UIControlStateNormal];
        btnJia.adjustsImageWhenHighlighted = NO;
        btnJia.tag = 2;
        [btnJia addTarget:self action:@selector(btnChangeNumClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnJia];
        
        self.labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(10 + 80 + 10, 10, cellWidth - (10 + 80 + 10 + 5), 32)];
        self.labelTitle.font = [UIFont systemFontOfSize:11];
        self.labelTitle.numberOfLines = 2;
        [self addSubview:self.labelTitle];

        labelPrice = [[UILabel alloc]initWithFrame:CGRectMake(10 + 80 + 10, 10 + 42, cellWidth - (10 + 80 + 10 + 75 + 5), 18)];
        labelPrice.font = [UIFont systemFontOfSize:13];
        labelPrice.textColor = MAINCOLOR;
        [self addSubview:labelPrice];
        
        UIView *viewDown = [[UIView alloc]initWithFrame:CGRectMake(0, 79, cellWidth, 1)];
        viewDown.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
        [self addSubview:viewDown];

        btnAlpha = [UIButton buttonWithType:UIButtonTypeCustom];
        btnAlpha.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
        btnAlpha.frame = CGRectMake(0, 0, cellWidth, 80);
        [btnAlpha setTitle:ZEString(@"已售完", @"Sold out") forState:UIControlStateNormal];
        btnAlpha.titleLabel.font = [UIFont systemFontOfSize:13];
        [btnAlpha setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnAlpha addTarget:self action:@selector(btnAlphaCLick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnAlpha];
        btnAlpha.hidden = YES;
        
    }
    return self;
}
-(void)setContentWithTitle:(NSString *)strTitle image:(NSString *)strImageURL num:(NSString *)strNum price:(NSString *)strPrice foodID:(NSString *)strFoodID saling:(NSString *)isSaling
{
    CGFloat cellWidth = WINDOWWIDTH * (1 -170/750.0);
    CGSize size = [self sizeOfString:strTitle fontSize:11 width:self.labelTitle.frame.size.width];
    self.labelTitle.text = strTitle;
    self.labelTitle.frame = CGRectMake(10 + 80 + 10, 10, cellWidth - (10 + 80 + 10+ 5), size.height);
    [IVHead sd_setImageWithURL:[NSURL URLWithString:strImageURL] placeholderImage:[UIImage imageNamed:@"placehoder1.png"]];
    _strImageURL = strImageURL;
    _labelNum.text = strNum;
    NSInteger num = [strNum integerValue];
    if ([isSaling isEqualToString:@"1"])
    {
        btnAlpha.hidden = YES;
    }
    else
    {
        btnAlpha .hidden = NO;
    }
    if (num <= 0)
    {
        btnJian.hidden = YES;
    }
    else
    {
        btnJian.hidden = NO;
    }
    labelPrice.text = [NSString stringWithFormat:ZEString(@"$%@/份", @"$%@"),strPrice];
    
    self.strFoodID = strFoodID;
}
-(void)btnAlphaCLick
{
    
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
    
    [self.delegate MerchantFoodTableViewCellChangeFoodNumber:num foodID:self.strFoodID foodName:self.labelTitle.text foodPrice:str2 imageURL:_strImageURL];

}
-(CGSize)sizeOfString:(NSString *)string fontSize:(NSInteger)fontSize width:(CGFloat)width
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize], NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [string boundingRectWithSize:CGSizeMake(width,32) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return labelSize;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
