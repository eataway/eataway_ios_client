//
//  SelectPaymentTableViewCell.m
//  EatAway
//
//  Created by apple on 2017/6/30.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "SelectPaymentTableViewCell.h"

@interface SelectPaymentTableViewCell ()
{
    UIImageView *IVHead;
    UILabel *labelTitle;
}
@end

@implementation SelectPaymentTableViewCell

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
        
        UIView *viewBG = [[UIView alloc]initWithFrame:CGRectMake(0, 15, WINDOWWIDTH, 60)];
        viewBG.backgroundColor = [UIColor whiteColor];
        [self addSubview:viewBG];
        
        IVHead = [[UIImageView alloc]initWithFrame:CGRectMake(12, 18, 24, 24)];
        [viewBG addSubview:IVHead];
        
        labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(12 + 24 + 12, 15, 100, 30)];
        labelTitle.font = [UIFont systemFontOfSize:13];
        [viewBG addSubview:labelTitle];
        
        
    }
    return self;
}
-(void)setcontentWithImage:(UIImage *)image title:(NSString *)strTitle
{
    IVHead.image = image;
    labelTitle.text = strTitle;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
