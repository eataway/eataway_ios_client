//
//  OrderDetailFoodsTableViewCell.m
//  EatAway
//
//  Created by apple on 2017/7/7.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "OrderDetailFoodsTableViewCell.h"


#import <UIImageView+WebCache.h>

@interface OrderDetailFoodsTableViewCell ()
{
    UIView *viewBG;
    UIImageView *IVHead;
    UILabel *labelTitle;
    UIView *viewFoodListBG;
    UILabel *labelFee;
    UILabel *labelFeeNum;
    UILabel *labelDistance;
    UIView *viewDown2;
    UILabel *labelTotalNum;
}
@end

@implementation OrderDetailFoodsTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
        
        viewBG = [[UIView alloc]initWithFrame:CGRectMake(10, 0, WINDOWWIDTH - 20, 160)];
        viewBG.clipsToBounds = YES;
        viewBG.layer.cornerRadius = 7;
        viewBG.backgroundColor = [UIColor whiteColor];
        [self addSubview:viewBG];
        
        IVHead = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 20, 20)];
        IVHead.clipsToBounds = YES;
        IVHead.layer.cornerRadius = 10;
        [viewBG addSubview:IVHead];
        
        labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(10 + 20 + 10 , 15, WINDOWWIDTH - (10 + 20 + 10 +10 + 10), 20)];
        labelTitle.font = [UIFont systemFontOfSize:15];
        [viewBG addSubview:labelTitle];
        labelTitle.textColor = [UIColor colorWithWhite:166/255.0 alpha:1];
        
        UIView *viewDown = [[UIView alloc]initWithFrame:CGRectMake(0, 49, WINDOWWIDTH, 1)];
        viewDown.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
        [viewBG addSubview:viewDown];
        
        viewFoodListBG = [[UIView alloc]initWithFrame:CGRectMake(0, 50, WINDOWWIDTH - 20, 1)];
        viewFoodListBG.backgroundColor = [UIColor whiteColor];
        [viewBG addSubview:viewFoodListBG];
        
        labelFee = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 100, 20)];
        labelFee.font = [UIFont systemFontOfSize:13];
        labelFee.text = ZEString(@"配送费", @"Delivery fee");
        [viewBG addSubview:labelFee];
        
        labelFeeNum = [[UILabel alloc]initWithFrame:CGRectMake(WINDOWWIDTH - 10 - 10 - 10 - 50, 50 + 5, 50, 15)];
        labelFeeNum.font = [UIFont systemFontOfSize:12];
        labelFeeNum.textAlignment = NSTextAlignmentRight;
        [viewBG addSubview:labelFeeNum];
        
        labelDistance = [[UILabel alloc]initWithFrame:CGRectMake(WINDOWWIDTH - 10 - 10 -10 - 100, 50 + 5 + 15 + 5, 100, 20)];
        labelDistance.textColor = [UIColor colorWithWhite:190/255.0 alpha:1];
        labelDistance.font = [UIFont systemFontOfSize:10];
        labelDistance.textAlignment = NSTextAlignmentRight;
        [viewBG addSubview:labelDistance];
        
        viewDown2 = [[UIView alloc]initWithFrame:CGRectMake(0, 50 + 49, WINDOWWIDTH, 1)];
        viewDown2.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
        [viewBG addSubview:viewDown2];
        
        labelTotalNum = [[UILabel alloc]initWithFrame:CGRectMake(10, 50 + 50, WINDOWWIDTH - 10 - 10 - 10 - 10, 60)];
        labelTotalNum.font = [UIFont systemFontOfSize:13];
        labelTotalNum.textAlignment = NSTextAlignmentRight;
        [viewBG addSubview:labelTotalNum];
        
        
    }
    return self;
    
}
-(void)setContentWithHeadImage:(NSString *)strImage title:(NSString *)strTitle listDic:(NSDictionary *)arrFoodList shippingFee:(NSString *)strShippingFee totalPrice:(NSString *)strTotalPrice distance:(NSString *)strDistance
{
    [IVHead sd_setImageWithURL:[NSURL URLWithString:strImage] placeholderImage:[UIImage imageNamed:@"placehoder1.png"]];
    labelTitle.text = strTitle;
    
    for (UIView *aView in viewFoodListBG.subviews)
    {
        [aView removeFromSuperview];
    }
    NSArray *arrIDs = arrFoodList.allKeys;
    for (int a = 0; a < arrIDs.count; a ++)
    {
        NSString *strKey = arrIDs[a];
        NSDictionary *dic = arrFoodList[strKey];
        
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, a * 70 + 10, 75, 50)];
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        imageV.clipsToBounds = YES;
        [imageV sd_setImageWithURL:[NSURL URLWithString:dic[@"image"]] placeholderImage:[UIImage imageNamed:@"placehoder2.png"]];
        [viewFoodListBG addSubview:imageV];
        
        UILabel *labelFoodName = [[UILabel alloc]initWithFrame:CGRectMake(10 + 75 + 10, a * 70 + 10, WINDOWWIDTH - (10 +10 + 75 + 10 + 60 + 10 + 10), 30)];
        labelFoodName.numberOfLines = 2;
        labelFoodName.font = [UIFont systemFontOfSize:13];
        labelFoodName.text = dic[@"name"];
        [viewFoodListBG addSubview:labelFoodName];
        
        UILabel *labelCount = [[UILabel alloc]initWithFrame:CGRectMake(10 + 75 + 10, a * 70 + 10 + 30 + 5, WINDOWWIDTH - (10 +10 + 75 + 10 + 60 + 10 + 10), 15)];
        labelCount.font = [UIFont systemFontOfSize:12];
        labelCount.textColor = [UIColor colorWithWhite:143/255.0 alpha:1];
        [viewFoodListBG addSubview:labelCount];
        labelCount.text = [NSString stringWithFormat:@"x  %@",dic[@"count"]];
        
        UILabel *labelPrice = [[UILabel alloc]initWithFrame:CGRectMake(WINDOWWIDTH - 10 - 10 - 10- 60, a * 70 + 10, 60, 30)];
        labelPrice.font = [UIFont systemFontOfSize:12];
        labelPrice.textAlignment = NSTextAlignmentRight;
        labelPrice.text = [NSString stringWithFormat:@"$%@",dic[@"price"]];
        [viewFoodListBG addSubview:labelPrice];
        
        UIView *viewDown = [[UIView alloc]initWithFrame:CGRectMake(0, a * 70 + 69, WINDOWWIDTH, 1)];
        viewDown.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
        [viewFoodListBG addSubview:viewDown];
        
        
    }
    viewFoodListBG.frame = CGRectMake(0, 50 , WINDOWWIDTH - 20, arrFoodList.count * 70);
    labelFee.frame = CGRectMake(10,50 + arrFoodList.count * 70 + 15 , 100, 20);
    labelFeeNum.frame = CGRectMake(WINDOWWIDTH - 10 - 10 - 10 - 50, 50 + arrFoodList.count * 70 + 5, 50, 15);
    labelFeeNum.text = [NSString stringWithFormat:@"$%@",strShippingFee];
    labelDistance.text = [NSString stringWithFormat:@"%@:%@",ZEString(@"距离", @"Distance"),strDistance];
    labelDistance.frame = CGRectMake(WINDOWWIDTH - 10 - 10 -10 - 100, 50 + arrFoodList.count * 70 + 5 + 15 + 5, 100, 20);
    viewDown2.frame = CGRectMake(0, 50 + arrFoodList.count * 70 + 49, WINDOWWIDTH, 1);
    
    NSString *strTotal = [NSString stringWithFormat:@"%@： $%@",ZEString(@"总计",@"Total"),strTotalPrice];
    NSMutableAttributedString *strTotalNum = [[NSMutableAttributedString alloc]initWithString:strTotal];
    NSRange range = [strTotal rangeOfString:[NSString stringWithFormat:@"$%@",strTotalPrice]];
    [strTotalNum addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    labelTotalNum.attributedText = strTotalNum;
    labelTotalNum.frame = CGRectMake(10, 50 + arrFoodList.count * 70 +  50, WINDOWWIDTH - 10 - 10 - 10 - 10, 60);
    viewBG.frame = CGRectMake(10, 0, WINDOWWIDTH - 20, 50 + arrFoodList.count * 70 + 50 + 60);
    
    self.frame = CGRectMake(0, 0, WINDOWWIDTH, 50 + arrFoodList.count * 70 + 50 + 60);
    
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
