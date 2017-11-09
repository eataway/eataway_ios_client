//
//  MerchantInfoTableViewCell.m
//  EatAway
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "MerchantInfoTableViewCell.h"

@interface MerchantInfoTableViewCell ()
{
    UIImageView *IVHead;
    UILabel *labelText;
}
@end

@implementation MerchantInfoTableViewCell

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
        IVHead = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 20, 20)];
        [self addSubview:IVHead];
        
        labelText = [[UILabel alloc]initWithFrame:CGRectMake(10 + 20 + 10, 5, WINDOWWIDTH - (10 + 20 + 10 + 30), 40)];
        labelText.font = [UIFont systemFontOfSize:13];
        labelText.numberOfLines = 2;
        [self addSubview:labelText];
        
        UIView *viewDown = [[UIView alloc]initWithFrame:CGRectMake(0, 49, WINDOWWIDTH, 1)];
        viewDown.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
        [self addSubview:viewDown];
    }
    return self;
}
-(void)setContentWithHeadImage:(UIImage *)image text:(NSString *)strText
{
    IVHead.image = image;
    labelText.text = strText;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
