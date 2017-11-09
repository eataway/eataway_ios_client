//
//  TeastTableViewCell.m
//  EatAway
//
//  Created by apple on 2017/6/24.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "TeastTableViewCell.h"

@interface TeastTableViewCell ()
{
    UILabel *labelTips;
}
@end

@implementation TeastTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //50
        
        self.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, WINDOWWIDTH - 20, 50)];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.clipsToBounds = YES;
        bgView.layer.cornerRadius = 7;
        [self addSubview:bgView];
        
        UIView *viewCorner1 = [[UIView alloc]initWithFrame:CGRectMake(10, 42, 8, 8)];
        viewCorner1.backgroundColor = [UIColor whiteColor];
        [self addSubview:viewCorner1];
        
        UIView *viewCorner2 = [[UIView alloc]initWithFrame:CGRectMake(WINDOWWIDTH - 10 - 8, 42, 8, 8)];
        viewCorner2.backgroundColor = [UIColor whiteColor];
        [self addSubview:viewCorner2];
        
        
        
        labelTips = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, WINDOWWIDTH - 10 - (10 + 20 + 10) - 30 - 10, 20)];
        labelTips.font = [UIFont systemFontOfSize:13];
        labelTips.text = ZEString(@"口味备注", @"Remarks");
        [bgView addSubview:labelTips];
        
        _detailLabelThis = [[UILabel alloc]initWithFrame:CGRectMake(WINDOWWIDTH - 30 - 100, 0, 100, 50)];
        _detailLabelThis.textColor = [UIColor blackColor];
        _detailLabelThis.textAlignment = NSTextAlignmentRight;
        _detailLabelThis.font = [UIFont systemFontOfSize:13];
        [self addSubview:_detailLabelThis];

        UIView *viewDown = [[UIView alloc]initWithFrame:CGRectMake(0, 49, WINDOWWIDTH, 1)];
        viewDown.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
        [self addSubview:viewDown];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
