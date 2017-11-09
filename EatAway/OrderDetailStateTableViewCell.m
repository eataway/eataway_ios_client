//
//  OrderDetailStateTableViewCell.m
//  EatAway
//
//  Created by apple on 2017/7/7.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "OrderDetailStateTableViewCell.h"

@interface OrderDetailStateTableViewCell ()
{
    UILabel *labelState;
    UILabel *labelTime;
}
@end

@implementation OrderDetailStateTableViewCell

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
        
        UIView *viewBG = [[UIView alloc]initWithFrame:CGRectMake(10, 10, WINDOWWIDTH - 20, 70)];
        viewBG.backgroundColor = [UIColor whiteColor];
        viewBG.clipsToBounds = YES;
        viewBG.layer.cornerRadius = 7;
        [self addSubview:viewBG];
        
        labelState = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, WINDOWWIDTH - 20 - 20, 25)];
        labelState.font = [UIFont systemFontOfSize:15];
        [viewBG addSubview:labelState];
        
        labelTime = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, WINDOWWIDTH - 20 - 20, 25)];
        labelTime.textColor = [UIColor colorWithWhite:151/255.0 alpha:1];
        labelTime.font = [UIFont systemFontOfSize:13];
        labelTime.textAlignment = NSTextAlignmentRight;
        [viewBG addSubview:labelTime];
        
        UILabel *labelTips = [[UILabel alloc]initWithFrame:CGRectMake(10, 10 + 25 , WINDOWWIDTH - 20 - 20, 35)];
        labelTips.font = [UIFont systemFontOfSize:13];
        labelTips.numberOfLines = 2;
        [viewBG addSubview:labelTips];
        labelTips.text = ZEString(@"如果有什么意见或建议，请点击右上方联系我们", @"If you have any comments or suggestions, please leave feedback here");
        
        
    }
    return self;
}
-(void)setContentWithOrderState:(NSString *)strState time:(NSString *)strTime
{
    labelState.text = strState;
    labelTime.text = strTime;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
