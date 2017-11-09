//
//  OrderDetailInfomationTableViewCell.m
//  EatAway
//
//  Created by apple on 2017/7/7.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "OrderDetailInfomationTableViewCell.h"


@interface OrderDetailInfomationTableViewCell ()
{
    UILabel *labelDeliveryTimeResult;
    UILabel *labelOrderNumResult;
    UILabel *labelAddressResult;
    UILabel *labelRemarksResult;
    
}
@end

@implementation OrderDetailInfomationTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
        
        UIView *viewBG = [[UIView alloc]initWithFrame:CGRectMake(10, 10, WINDOWWIDTH - 20, 250)];
        viewBG.backgroundColor = [UIColor whiteColor];
        viewBG.clipsToBounds = YES;
        viewBG.layer.cornerRadius = 7;
        [self addSubview:viewBG];
        
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 20, 20)];
        imageV.image = [UIImage imageNamed:@"3.1.1_icon_02.png"];
        [viewBG addSubview:imageV];
        
        UILabel *labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(10 + 20 + 10, 15, WINDOWWIDTH - 20 - 40 - 10, 20)];
        labelTitle.textColor = [UIColor colorWithWhite:150/255.0 alpha:1];
        labelTitle.font = [UIFont systemFontOfSize:13];
        [viewBG addSubview:labelTitle];
        labelTitle.text = ZEString(@"其他信息", @"Other information");
        
        UIView *viewDown0 = [[UIView alloc]initWithFrame:CGRectMake(0, 49, WINDOWWIDTH - 20, 1)];
        viewDown0.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
        [viewBG addSubview:viewDown0];
        
        
        
        
        
        UILabel *labelDeliveryTime = [[UILabel alloc]initWithFrame:CGRectMake(10, 50 + 10, WINDOWWIDTH - 20 - 20, 30)];
        labelDeliveryTime.font = [UIFont systemFontOfSize:13];
        labelDeliveryTime.text = ZEString(@"配送时间", @"Delivery time");
        [viewBG addSubview:labelDeliveryTime];
        
        labelDeliveryTimeResult = [[UILabel alloc]initWithFrame:CGRectMake(10, 50 + 10, WINDOWWIDTH - 20 - 20, 30)];
        labelDeliveryTimeResult.font = [UIFont systemFontOfSize:13];
        labelDeliveryTimeResult.textAlignment = NSTextAlignmentRight;
        labelDeliveryTimeResult.textColor = [UIColor colorWithWhite:150/255.0 alpha:1];
        [viewBG addSubview:labelDeliveryTimeResult];
        
        
        UIView *viewDown1 = [[UIView alloc]initWithFrame:CGRectMake(0,50 + 49, WINDOWWIDTH - 20, 1)];
        viewDown1.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
        [viewBG addSubview:viewDown1];
        
        
        
        
        
        UILabel *labelOrderNum = [[UILabel alloc]initWithFrame:CGRectMake(10, 50 * 2 + 10, WINDOWWIDTH - 20 - 20, 30)];
        labelOrderNum.font = [UIFont systemFontOfSize:13];
        labelOrderNum.text = ZEString(@"订单号", @"Order number");
        [viewBG addSubview:labelOrderNum];
        
        labelOrderNumResult = [[UILabel alloc]initWithFrame:CGRectMake(10, 50* 2 + 10, WINDOWWIDTH - 20 - 20, 30)];
        labelOrderNumResult.font = [UIFont systemFontOfSize:13];
        labelOrderNumResult.textAlignment = NSTextAlignmentRight;
        labelOrderNumResult.textColor = [UIColor colorWithWhite:150/255.0 alpha:1];
        [viewBG addSubview:labelOrderNumResult];
        
        
        UIView *viewDown2 = [[UIView alloc]initWithFrame:CGRectMake(0,50* 2 + 49, WINDOWWIDTH - 20, 1)];
        viewDown2.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
        [viewBG addSubview:viewDown2];
        
        
        
        
        UILabel *labelAddress = [[UILabel alloc]initWithFrame:CGRectMake(10, 50 * 3 + 10, WINDOWWIDTH - 20 - 20, 30)];
        labelAddress.font = [UIFont systemFontOfSize:13];
        labelAddress.text = ZEString(@"配送地址", @"Delivery address");
        [viewBG addSubview:labelAddress];
        
        labelAddressResult = [[UILabel alloc]initWithFrame:CGRectMake(10, 50* 3 + 10, WINDOWWIDTH - 20 - 20, 30)];
        labelAddressResult.font = [UIFont systemFontOfSize:13];
        labelAddressResult.textAlignment = NSTextAlignmentRight;
        labelAddressResult.textColor = [UIColor colorWithWhite:150/255.0 alpha:1];
        [viewBG addSubview:labelAddressResult];
        
        
        UIView *viewDown3 = [[UIView alloc]initWithFrame:CGRectMake(0,50* 3 + 49, WINDOWWIDTH - 20, 1)];
        viewDown3.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
        [viewBG addSubview:viewDown3];
        
        
        
        
        
        UILabel *labelRemarks = [[UILabel alloc]initWithFrame:CGRectMake(10, 50 * 4 + 10, WINDOWWIDTH - 20 - 20, 30)];
        labelRemarks.font = [UIFont systemFontOfSize:13];
        labelRemarks.text = ZEString(@"备注", @"Remarks");
        [viewBG addSubview:labelRemarks];
        
        labelRemarksResult = [[UILabel alloc]initWithFrame:CGRectMake(90, 50* 4 + 10, WINDOWWIDTH - 20 - 20 - 80, 30)];
        labelRemarksResult.font = [UIFont systemFontOfSize:13];
        labelRemarksResult.textAlignment = NSTextAlignmentRight;
        labelRemarksResult.textColor = [UIColor colorWithWhite:150/255.0 alpha:1];
        [viewBG addSubview:labelRemarksResult];
        
        

        
        
    }
    return self;
}
-(void)setContentWithDeliveryTime:(NSString *)strDeliveryTime orderNum:(NSString *)strOrderNum address:(NSString *)strAddress remarks:(NSString *)strRemarks
{
    labelDeliveryTimeResult.text = strDeliveryTime;
    labelOrderNumResult.text = strOrderNum;
    labelAddressResult.text = strAddress;
    labelRemarksResult.text = strRemarks;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
