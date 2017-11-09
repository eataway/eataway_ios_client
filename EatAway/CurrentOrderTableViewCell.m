//
//  CurrentOrderTableViewCell.m
//  EatAway
//
//  Created by apple on 2017/7/6.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "CurrentOrderTableViewCell.h"

#import <UIImageView+WebCache.h>

@interface CurrentOrderTableViewCell ()
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
    UILabel *labelState;
    UIButton *btnContact;
    UILabel *labelContact;
    UIButton *btnContact2;
    
    UIButton *btnMain;
    UIButton *btnReviews;
    
    NSString *_strOrderState;
}
@end

@implementation CurrentOrderTableViewCell

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
        
        viewBG = [[UIView alloc]initWithFrame:CGRectMake(10, 10, WINDOWWIDTH - 20, 160)];
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
        
        labelTotalNum = [[UILabel alloc]initWithFrame:CGRectMake(10 , 50 + 50,WINDOWWIDTH - 40, 20)];
        labelTotalNum.font = [UIFont systemFontOfSize:13];
        labelTotalNum.textAlignment = NSTextAlignmentRight;
        [viewBG addSubview:labelTotalNum];
        
        labelState = [[UILabel alloc]initWithFrame:CGRectMake(10 , 50 + 50,WINDOWWIDTH - 40, 20)];
        labelState.font = [UIFont systemFontOfSize:13];
        labelState.textColor = [UIColor orangeColor];
        labelState.textAlignment = NSTextAlignmentLeft;
        [viewBG addSubview:labelState];
        
        btnContact = [UIButton buttonWithType:UIButtonTypeCustom];
        btnContact.frame = CGRectMake(10, 50 + 50, 100, 20);
        btnContact.titleLabel.font = [UIFont systemFontOfSize:12];
        [btnContact setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:ZEString(@"去评价", @"Go to Reviews")];
        NSRange titleRange = {0,[title length]};
        [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
        [title addAttribute:NSForegroundColorAttributeName value:MAINCOLOR range:titleRange];
        [btnContact setAttributedTitle:title forState:UIControlStateNormal];
        [btnContact addTarget:self action:@selector(btnGoToCommentClick) forControlEvents:UIControlEventTouchUpInside];
        [viewBG addSubview:btnContact];
        
        
        labelContact = [[UILabel alloc]initWithFrame:CGRectMake(10, 50 + 50, 100, 20)];
        labelContact.font = [UIFont systemFontOfSize:12];
        labelContact.text = ZEString(@"如需退单 请先", @"Return from please ");
        [viewBG addSubview:labelContact];
        
        
        btnContact2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btnContact2.frame = CGRectMake(10, 50 + 50, 100, 20);
        btnContact2.titleLabel.font = [UIFont systemFontOfSize:12];
        [btnContact2 setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        NSMutableAttributedString *title2 = [[NSMutableAttributedString alloc] initWithString:ZEString(@"联系卖家", @"Contact ther seller")];
        NSRange titleRange2 = {0,[title2 length]};
        [title2 addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange2];
        [title2 addAttribute:NSForegroundColorAttributeName value:MAINCOLOR range:titleRange2];
        [btnContact2 setAttributedTitle:title2 forState:UIControlStateNormal];
        [btnContact2 addTarget:self action:@selector(btnContactMerchantClick) forControlEvents:UIControlEventTouchUpInside];
        [viewBG addSubview:btnContact2];
        
//        btnReviews = [UIButton buttonWithType:UIButtonTypeCustom];
//        btnReviews.frame = CGRectMake(10, 50 + 50, 100, 20);
//        btnReviews.backgroundColor = [UIColor orangeColor];
//        btnReviews.clipsToBounds = YES;
//        btnReviews.layer.cornerRadius = 7;
//        [btnReviews setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        btnReviews.titleLabel.font = [UIFont systemFontOfSize:12];
//        [btnReviews setTitle:ZEString(@"去评价", @"Reviews") forState:UIControlStateNormal];
//        [btnReviews addTarget:self action:@selector(btnReviewsClick) forControlEvents:UIControlEventTouchUpInside];
//        btnReviews.layer.borderColor = [UIColor orangeColor].CGColor;
//        btnReviews.layer.borderWidth = 1;
//        [viewBG addSubview:btnReviews];

        
        
        btnMain = [UIButton buttonWithType:UIButtonTypeCustom];
        btnMain.frame = CGRectMake(10, 50 + 50, 100, 20);
        btnMain.backgroundColor = [UIColor orangeColor];
        btnMain.clipsToBounds = YES;
        btnMain.layer.cornerRadius = 7;
        [btnMain setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btnMain.titleLabel.font = [UIFont systemFontOfSize:12];
        [btnMain setTitle:ZEString(@"确认送达", @"Receipt") forState:UIControlStateNormal];
        [btnMain addTarget:self action:@selector(btnMainCLick) forControlEvents:UIControlEventTouchUpInside];
        btnMain.layer.borderColor = [UIColor orangeColor].CGColor;
        btnMain.layer.borderWidth = 1;
        [viewBG addSubview:btnMain];
    }
    return self;
    
}
-(void)setContentWithHeadImage:(NSString *)strImage title:(NSString *)strTitle listDic:(NSDictionary *)arrFoodList shippingFee:(NSString *)strShippingFee totalPrice:(NSString *)strTotalPrice orderState:(NSString *)strOrderState distance:(NSString *)strDistance statu:(NSString *)statu
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
        [imageV sd_setImageWithURL:[NSURL URLWithString:dic[@"image"]] placeholderImage:[UIImage imageNamed:@"placehoder2.png"]];
        imageV.clipsToBounds = YES;
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
    labelDistance.text = [NSString stringWithFormat:@"%@:%@km",ZEString(@"距离", @"Distance "),strDistance];
    labelDistance.frame = CGRectMake(WINDOWWIDTH - 10 - 10 -10 - 100, 50 + arrFoodList.count * 70 + 5 + 15 + 5, 100, 20);
    viewDown2.frame = CGRectMake(0, 50 + arrFoodList.count * 70 + 49, WINDOWWIDTH, 1);
    
    NSString *strTotal = [NSString stringWithFormat:@"%@： $%@",ZEString(@"总价",@"Total"),strTotalPrice];
    NSMutableAttributedString *strTotalNum = [[NSMutableAttributedString alloc]initWithString:strTotal];
    NSRange range = [strTotal rangeOfString:[NSString stringWithFormat:@"$%@",strTotalPrice]];
    [strTotalNum addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    labelTotalNum.attributedText = strTotalNum;
    labelTotalNum.frame = CGRectMake(10 , 50 + arrFoodList.count * 70 +  50 + 10, WINDOWWIDTH - 40, 20);
    btnContact.hidden = YES;

    _strOrderState = strOrderState;
    
    if ([statu intValue] == 1) {
        labelState.text = ZEString(@"退单中", @"Refunding");
        btnContact.hidden = YES;
        btnContact2.hidden = NO;
        labelContact.hidden = NO;
        btnMain.hidden = YES;
    }
    else if ([statu intValue] == 3)
    {
        labelState.text = ZEString(@"已退单", @"Refunded");
        btnContact.hidden = YES;
        btnContact2.hidden = NO;
        labelContact.hidden = NO;
        btnMain.hidden = YES;
    }
    else{
    if ([strOrderState isEqualToString:@"1"])
    {
        labelState.text = ZEString(@"等待卖家接单", @"Order processing");
        btnContact.hidden = YES;
        btnContact2.hidden = NO;
        labelContact.hidden = NO;
        btnMain.hidden = YES;
//        btnReviews.hidden = YES;
    }
    else if ([strOrderState isEqualToString:@"2"])
    {
        labelState.text = ZEString(@"卖家已接单", @"Order is being prepared");
        btnContact.hidden = YES;
        btnContact2.hidden = NO;
        labelContact.hidden = NO;
        btnMain.hidden = YES;
//        btnReviews.hidden = YES;

    }
    else if ([strOrderState isEqualToString:@"3"])
    {
        labelState.text = ZEString(@"商品已送达", @"order has been delivered");
        btnContact.hidden = YES;
        btnContact2.hidden = YES;
        labelContact.hidden = YES;
        btnMain.hidden = NO;
//        btnReviews.hidden = YES;

        [btnMain setTitle:ZEString(@"确认送达", @"Receipt") forState:UIControlStateNormal];
        [btnMain setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btnMain.backgroundColor = [UIColor orangeColor];

        
    }
    else if ([strOrderState isEqualToString:@"4"])
    {
        labelState.text = ZEString(@"待评价", @"Order complete");
        btnContact.hidden = NO;
        btnContact2.hidden = YES;
        labelContact.hidden = YES;
        btnMain.hidden = NO;
//        btnReviews.hidden = NO;

        [btnMain setTitle:ZEString(@"再来一单", @"Buy again") forState:UIControlStateNormal];
        [btnMain setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        btnMain.backgroundColor = [UIColor whiteColor];

    }
    else if ([strOrderState isEqualToString:@"5"])
    {
        labelState.text = ZEString(@"已完成", @"Order complete");
        btnContact.hidden = YES;
        btnContact2.hidden = YES;
        labelContact.hidden = YES;
        btnMain.hidden = NO;
//        btnReviews.hidden = YES;

        [btnMain setTitle:ZEString(@"再来一单", @"Buy again") forState:UIControlStateNormal];
        [btnMain setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        btnMain.backgroundColor = [UIColor whiteColor];


    }
    else
    {
        labelState.text = ZEString(@"", @"");
    }
    }
    
    labelState.frame = CGRectMake(10 , 50 + arrFoodList.count * 70 +  50 + 10, WINDOWWIDTH - 40, 20);
    
    CGSize sizeContactbtn = [self sizeOfString:btnContact.titleLabel.text fontSize:12];
    btnContact.frame = CGRectMake(10, 50 + arrFoodList.count * 70 +  50 + 10 + 20 + 10 , sizeContactbtn.width, 20);
    
    CGSize sizeContactbtn2 = [self sizeOfString:btnContact2.titleLabel.text fontSize:12];
    btnContact2.frame = CGRectMake((WINDOWWIDTH - 30 - sizeContactbtn2.width), 50 + arrFoodList.count * 70 +  50 + 10 + 20 + 10 , sizeContactbtn2.width, 20);
    
    CGSize sizeContactbtn3 = [self sizeOfString:labelContact.text fontSize:12];
    labelContact.frame = CGRectMake((WINDOWWIDTH - 30 - sizeContactbtn2.width - sizeContactbtn3.width), 50 + arrFoodList.count * 70 +  50 + 10 + 20 + 10 , sizeContactbtn3.width, 20);
    
    CGSize sizeMainBtn = [self sizeOfString:btnMain.titleLabel.text fontSize:12];
    btnMain.frame = CGRectMake(WINDOWWIDTH - 30 - sizeMainBtn.width - 20, 50 + arrFoodList.count * 70 +  50 + 10 + 20 + 10 , sizeMainBtn.width + 20, 30);
    btnReviews.frame = CGRectMake(30, 50 + arrFoodList.count * 70 +  50 + 10 + 20 + 10 , sizeMainBtn.width + 20, 30);
    
    viewBG.frame = CGRectMake(10, 10, WINDOWWIDTH - 20, 50 + arrFoodList.count * 70 + 50 + 80);
    
    self.frame = CGRectMake(0, 10, WINDOWWIDTH,10 + 50 + arrFoodList.count * 70 + 50 + 80);
    
    
    
    
    
}
-(void)changeCellStateWithState:(NSString *)strState
{
    if ([strState isEqualToString:@"1"])
    {
        labelState.text = ZEString(@"等待卖家接单", @"Order processing");
        btnContact.hidden = YES;
        btnContact2.hidden = NO;
        labelContact.hidden = NO;
        btnMain.hidden = YES;
    }
    else if ([strState isEqualToString:@"2"])
    {
        labelState.text = ZEString(@"卖家已接单", @"Order is being prepared");
        btnContact.hidden = YES;
        btnContact2.hidden = NO;
        labelContact.hidden = NO;
        btnMain.hidden = YES;
        
    }
    else if ([strState isEqualToString:@"3"])
    {
        labelState.text = ZEString(@"商品已送达", @"order has been delivered");
        btnContact.hidden = YES;
        btnContact2.hidden = YES;
        labelContact.hidden = YES;
        btnMain.hidden = NO;
        [btnMain setTitle:ZEString(@"确认送达", @"Receipt") forState:UIControlStateNormal];
        [btnMain setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btnMain.backgroundColor = [UIColor orangeColor];
        
        
    }
    else if ([strState isEqualToString:@"4"])
    {
        labelState.text = ZEString(@"待评价", @"Order complete");
        btnContact.hidden = NO;
        btnContact2.hidden = YES;
        labelContact.hidden = YES;
        btnMain.hidden = NO;
        [btnMain setTitle:ZEString(@"再来一单", @"Buy again") forState:UIControlStateNormal];
        [btnMain setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        btnMain.backgroundColor = [UIColor whiteColor];
        
    }
    else if ([strState isEqualToString:@"5"])
    {
        labelState.text = ZEString(@"已完成", @"Order complete");
        btnContact.hidden = YES;
        btnContact2.hidden = YES;
        labelContact.hidden = YES;
        btnMain.hidden = NO;
        [btnMain setTitle:ZEString(@"再来一单", @"Buy again") forState:UIControlStateNormal];
        [btnMain setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        btnMain.backgroundColor = [UIColor whiteColor];
        
        
    }
    _strOrderState = strState;

}
-(void)btnReviewsClick
{
    if ([self.delegate respondsToSelector:@selector(CurrentOrderTableViewCellReviewsWithCellIndex:)])
    {
        [self.delegate CurrentOrderTableViewCellReviewsWithCellIndex:self.tag];
    }
}
-(void)btnGoToCommentClick
{
    [self.delegate CurrentOrderTableViewCellCommenttWithCellIndex:self.tag];
}
-(void)btnContactMerchantClick
{
    [self.delegate CurrentOrderTableViewCellContactWithCellIndex:self.tag];
}
-(void)btnMainCLick
{
    [self.delegate CurrentOrderTableViewCellOperationKind:_strOrderState WithCellIndex:self.tag];
}
-(CGSize)sizeOfString:(NSString *)string fontSize:(NSInteger)fontSize
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize], NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [string boundingRectWithSize:CGSizeMake(999,20) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return labelSize;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
