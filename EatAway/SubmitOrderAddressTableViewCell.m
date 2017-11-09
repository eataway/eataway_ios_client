//
//  OrderAddressTableViewCell.m
//  EatAway
//
//  Created by apple on 2017/6/22.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "SubmitOrderAddressTableViewCell.h"

@interface SubmitOrderAddressTableViewCell ()
{
    UILabel *labelLocation;
    UILabel *labelNameAndPhone;
}
@end

@implementation SubmitOrderAddressTableViewCell

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
        //80
        
        self.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, WINDOWWIDTH - 20, 80)];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.clipsToBounds = YES;
        bgView.layer.cornerRadius = 7;
        [self addSubview:bgView];
        
        UIView *viewCorner1 = [[UIView alloc]initWithFrame:CGRectMake(10, 72, 8, 8)];
        viewCorner1.backgroundColor = [UIColor whiteColor];
        [self addSubview:viewCorner1];
        
        UIView *viewCorner2 = [[UIView alloc]initWithFrame:CGRectMake(WINDOWWIDTH - 10 - 8, 72, 8, 8)];
        viewCorner2.backgroundColor = [UIColor whiteColor];
        [self addSubview:viewCorner2];
        
        UIView *viewDown = [[UIView alloc]initWithFrame:CGRectMake(0, 79, WINDOWWIDTH, 1)];
        viewDown.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
        [self addSubview:viewDown];
        
        
        UIImageView *IVLocation = [[UIImageView alloc]initWithFrame:CGRectMake(10 , 15, 20, 20)];
        IVLocation.image = [UIImage imageNamed:@"2.2.3_icon_location.png"];
        [bgView addSubview:IVLocation];
        
        labelLocation = [[UILabel alloc]initWithFrame:CGRectMake(10 + 20 + 10, 15, WINDOWWIDTH - 10 - (10 + 20 + 10) - 30 - 10, 20)];
        labelLocation.font = [UIFont systemFontOfSize:13];
        [bgView addSubview:labelLocation];
        
        labelNameAndPhone = [[UILabel alloc]initWithFrame:CGRectMake(10 + 20 + 10, 15 + 20 + 15, WINDOWWIDTH - 10 - 40 - 30 - 10 , 15)];
        labelNameAndPhone.font = [UIFont systemFontOfSize:12];
        labelNameAndPhone.textColor = [UIColor colorWithWhite:152/255.0 alpha:1];
        [bgView addSubview:labelNameAndPhone];
        
    }
    return self;
}
-(void)setContentWithAddress:(NSString *)strAddress name:(NSString *)strName sex:(NSString *)strSex phoneNum:(NSString *)strPhoneNum
{
    labelLocation.text = strAddress;
    NSString *strSexCall = @"";
    if ([strSex isEqualToString:@"1"])
    {
        strSexCall = ZEString(@"先生", @"Mr.");
    }
    else if ([strSex isEqualToString:@""])
    {
        strSexCall = @"";
    }
    else
    {
        strSexCall = ZEString(@"女士", @"Ms.");
    }
    if (ISCHINESE)
    {
        labelNameAndPhone.text = [NSString stringWithFormat:@"%@ %@ %@",strName,strSexCall,strPhoneNum];
    }
    else
    {
        labelNameAndPhone.text = [NSString stringWithFormat:@"%@ %@ %@",strSexCall,strName,strPhoneNum];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
