//
//  SubmitOrderTimeTableViewCell.m
//  EatAway
//
//  Created by apple on 2017/6/22.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "SubmitOrderTimeTableViewCell.h"

@interface SubmitOrderTimeTableViewCell ()
{
    UILabel *labelLocation;
}
@end

@implementation SubmitOrderTimeTableViewCell

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
        //50
        
        self.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, WINDOWWIDTH - 20, 50)];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.clipsToBounds = YES;
        bgView.layer.cornerRadius = 7;
        [self addSubview:bgView];
        
        UIView *viewCorner1 = [[UIView alloc]initWithFrame:CGRectMake(10, 0, 8, 8)];
        viewCorner1.backgroundColor = [UIColor whiteColor];
        [self addSubview:viewCorner1];
        
        UIView *viewCorner2 = [[UIView alloc]initWithFrame:CGRectMake(WINDOWWIDTH - 10 - 8, 0, 8, 8)];
        viewCorner2.backgroundColor = [UIColor whiteColor];
        [self addSubview:viewCorner2];
        
        
        
        UIImageView *IVLocation = [[UIImageView alloc]initWithFrame:CGRectMake(10 , 15, 20, 20)];
        IVLocation.image = [UIImage imageNamed:@"2.2.3_icon_time.png"];
        [bgView addSubview:IVLocation];
        
        labelLocation = [[UILabel alloc]initWithFrame:CGRectMake(10 + 20 + 10, 15, WINDOWWIDTH - 10 - (10 + 20 + 10) - 30 - 10, 20)];
        labelLocation.font = [UIFont systemFontOfSize:13];
        [bgView addSubview:labelLocation];
        

        
    }
    return self;
}
-(void)setContentWithTime:(NSString *)strTime
{
    labelLocation.text = [NSString stringWithFormat:@"%@：%@",ZEString(@"配送时间",@"Delivery time"),strTime];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
