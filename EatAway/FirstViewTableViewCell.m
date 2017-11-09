//
//  FirstViewTableViewCell.m
//  EatAway
//
//  Created by apple on 2017/6/7.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "FirstViewTableViewCell.h"

#import <UIImageView+WebCache.h>

@interface FirstViewTableViewCell ()
{
    UIImageView *IVHead;
    UILabel *labelTips;
    UIImageView *IVMain;
    UILabel *labelTitle;
    UILabel *labelDistance;
    UIImageView *IVOpenStatus;
    UIImageView *IVGray;
}
@end

@implementation FirstViewTableViewCell

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
        self.backgroundColor = [UIColor colorWithWhite:243/255.0 alpha:1];
        
        //背景
        UIView *BGView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, WINDOWWIDTH - 20, 140)];
        BGView.backgroundColor = [UIColor whiteColor];
        BGView.clipsToBounds = YES;
        BGView.layer.cornerRadius = 5;
        [self addSubview:BGView];
        
        //头像
        IVHead = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 25, 25)];
        IVHead.clipsToBounds = YES;
        IVHead.layer.cornerRadius = 12.5;
        [BGView addSubview:IVHead];
        
        UIView *viewBorder1 = [[UIView alloc]initWithFrame:CGRectMake(10 + 25 + 5, 5, 1, 25)];
        viewBorder1.backgroundColor = GRAYLINECOLOR;
        [BGView addSubview:viewBorder1];
        
        //标签
        labelTips = [[UILabel alloc]initWithFrame:CGRectMake(10 + 25 + 5 + 10, 0, WINDOWWIDTH -(10 + 25+5+10+10+10), 35)];
        labelTips.font = [UIFont systemFontOfSize:12];
        [BGView addSubview:labelTips];
        
        //是否开店
        IVOpenStatus = [[UIImageView alloc]initWithFrame:CGRectMake(BGView.frame.size.width - 40, 0, 40, 40)];
        IVOpenStatus.image = [UIImage imageNamed:@"2.1.0_tag_on.png"];
        [BGView addSubview:IVOpenStatus];
        
        //分割件
        UIView *viewLineMiddle = [[UIView alloc]initWithFrame:CGRectMake(10, 5+25+5, WINDOWWIDTH - 10 - 10 - 10 - 10, 1)];
        viewLineMiddle.backgroundColor = GRAYLINECOLOR;
        [BGView addSubview:viewLineMiddle];
        
        //主图
        IVMain = [[UIImageView alloc]initWithFrame:CGRectMake(10, 40, WINDOWWIDTH - 40, 90)];
        IVMain.contentMode = UIViewContentModeScaleAspectFill;
        IVMain.clipsToBounds = YES;
        [BGView addSubview:IVMain];
        
        //标题背景
        UIView *viewTitleBG = [[UIView alloc]initWithFrame:CGRectMake(10,40 + 60, WINDOWWIDTH - 40, 30)];
        viewTitleBG.backgroundColor = [UIColor blackColor];
        viewTitleBG.alpha = 0.4;
        [BGView addSubview:viewTitleBG];
        
        //标题
        labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(10 + 55 , 40 + 60, WINDOWWIDTH - 40 - 55 *2, 30)];
        labelTitle.textColor = [UIColor whiteColor];
        labelTitle.textAlignment = NSTextAlignmentCenter;
        labelTitle.font = [UIFont systemFontOfSize:14];
        [BGView addSubview:labelTitle];
        
        //距离
        labelDistance = [[UILabel alloc]initWithFrame:CGRectMake(WINDOWWIDTH - 10 - 10 - 10 - 55, 40 + 60, 50, 30)];
        labelDistance.textColor = [UIColor whiteColor];
        labelDistance.textAlignment = NSTextAlignmentRight;
        labelDistance.font = [UIFont systemFontOfSize:10];
        [BGView addSubview:labelDistance];
        
        //未营业遮挡View
        IVGray = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, 150)];
        IVGray.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
        IVGray.hidden = YES;
        [self addSubview:IVGray];
        
        
        
        
    }
    
    return self;
    
}
-(void)setContentWithHeadImage:(NSString *)strHeadURL tips:(NSString *)strTips backgroundImage:(NSString *)strBGImageURL title:(NSString *)strTitle distance:(NSString *)strDistance isOpen:(BOOL)isOpen
{
    //头像
    [IVHead sd_setImageWithURL:[NSURL URLWithString:strHeadURL] placeholderImage:[UIImage imageNamed:@"placehoder1.png"]];
    //标签
    labelTips.text = strTips;
    //主图
    [IVMain sd_setImageWithURL:[NSURL URLWithString:strBGImageURL] placeholderImage:[UIImage imageNamed:@"placehoder2.png"]];
    //标题
    labelTitle.text = strTitle;
    //距离
    labelDistance.text = strDistance;
    
    
    //是否营业
    if (isOpen)
    {
        IVOpenStatus.image = [UIImage imageNamed:ZEString(@"2.1.0_tag_on.png", @"2.1.310_tag_open")];
        IVGray.hidden = YES;
    }
    else
    {
        IVOpenStatus.image = [UIImage imageNamed:ZEString(@"2.1.0_tag_off.png", @"2.1.310_tag_close")];
        IVGray.hidden = NO;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
