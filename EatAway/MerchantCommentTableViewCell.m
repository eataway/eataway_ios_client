//
//  OrderCommentTableViewCell.m
//  EatAway
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "MerchantCommentTableViewCell.h"

#import <UIImageView+WebCache.h>

@interface MerchantCommentTableViewCell ()
{
    UIImageView *IVHead;
    UILabel *labelDate;
    UILabel *labelNickname;
    UIView *viewStar;
    UILabel *labelContent;
    UIScrollView *SVImages;
    UIView *viewReplyBG;
    UILabel *labelReply;
    UIView *viewDown;
    
}
@end

@implementation MerchantCommentTableViewCell

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
        IVHead = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 44, 44)];
        IVHead.clipsToBounds = YES;
        IVHead.layer.cornerRadius = 22;
        [self addSubview:IVHead];
        
        labelDate = [[UILabel alloc]initWithFrame:CGRectMake(WINDOWWIDTH - 10 - 70, 10, 70, 15)];
        labelDate.font = [UIFont systemFontOfSize:12];
        labelDate.textColor = [UIColor colorWithWhite:170/255.0 alpha:1];
        labelDate.textAlignment = NSTextAlignmentRight;
        [self addSubview:labelDate];
        
        labelNickname = [[UILabel alloc]initWithFrame:CGRectMake(10 + 44 + 10, 10, WINDOWWIDTH - (10 + 44 + 10 + 10 + 70 + 10), 15)];
        labelNickname.font = [UIFont systemFontOfSize:14];
        [self addSubview:labelNickname];
        
        viewStar = [[UIView alloc]initWithFrame:CGRectMake(10 + 44 + 10, 10 + 28, 100 , 16)];
        [self addSubview:viewStar];
        
        labelContent = [[UILabel alloc]initWithFrame:CGRectMake(10 + 45 + 10, 10 + 45 + 10, WINDOWWIDTH - (10 + 45 + 10 + 10), 20)];
        labelContent.numberOfLines = MAXFLOAT;
        labelContent.font = [UIFont systemFontOfSize:13];
        [self addSubview:labelContent];
        
        SVImages = [[UIScrollView alloc]initWithFrame:CGRectMake(10 + 45 + 10, 10 + 45 + 10 + 20 + 10, WINDOWWIDTH - (10 + 45 + 10 + 10), 70)];
        SVImages.showsHorizontalScrollIndicator = NO;
        [self addSubview:SVImages];
        
        viewReplyBG = [[UIView alloc]initWithFrame:CGRectMake(10 + 45 + 10, 10 + 45 + 10 + 20 + 10 + 70 + 10, WINDOWWIDTH - (10 + 45 + 10 + 10), 30)];
        viewReplyBG.backgroundColor = [UIColor colorWithWhite:242/255.0 alpha:1];
        [self addSubview:viewReplyBG];
        
        labelReply = [[UILabel alloc]initWithFrame:CGRectMake(10, 10,viewReplyBG.frame.size.width - 20,viewReplyBG.frame.size.height - 20)];
        labelReply.font = [UIFont systemFontOfSize:12];
        labelReply.numberOfLines = MAXFLOAT;
        [viewReplyBG addSubview:labelReply];
        
        viewDown = [[UIView alloc]initWithFrame:CGRectMake(0, 10 + 45 + 10 + 20 + 10 + 70 + 10 + 30 + 9, WINDOWWIDTH, 1)];
        viewDown.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
        [self addSubview:viewDown];
    }
    return self;
}
-(void)setContentWithTitle:(NSString *)strName headImage:(NSString *)strImageURL time:(NSString *)strTime level:(NSString *)strLevel content:(NSString *)strContent images:(NSArray *)arrImages reply:(NSString *)strReply
{
    [IVHead sd_setImageWithURL:[NSURL URLWithString:strImageURL] placeholderImage:[UIImage imageNamed:@"placehoder1.png"]];
    labelDate.text = strTime;
    labelNickname.text = strName;
    
    NSInteger starNum = [strLevel integerValue];

    if(starNum > 5)
    {
        starNum = 5;
    }
    else if (starNum < 0)
    {
        starNum = 0;
    }
    for (UIView *aView in viewStar.subviews)
    {
        [aView removeFromSuperview];
    }
    for (int a = 0; a < starNum; a++)
    {
        UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"2.3.0_pic_star.png"]];
        imageV.frame = CGRectMake(a * (15 + 5), 0, 15, 15);
        [viewStar addSubview:imageV];
    }
    
    _cellHeight = 10 + 45 + 10;
    
    CGSize labelContentSize = [self sizeOfString:strContent fontSize:13 maxWidth:WINDOWWIDTH - (10 + 45 + 10 + 10)] ;
    labelContent.text = strContent;
    labelContent.frame = CGRectMake(10 + 45 + 10, 10 + 45 + 10, WINDOWWIDTH - (10 + 45 + 10 + 10), labelContentSize.height + 10);
    
    _cellHeight = _cellHeight + labelContentSize.height + 10 + 10;
    
    for (UIView *aView in SVImages.subviews)
    {
        [aView removeFromSuperview];
    }
    if (arrImages.count == 0)
    {
        SVImages.hidden = YES;
    }
    else
    {
        SVImages.hidden = NO;
        SVImages.contentSize = CGSizeMake(arrImages.count * 70 + (arrImages.count - 1) * 10, 70);
        SVImages.frame = CGRectMake(10 + 45 + 10, _cellHeight, WINDOWWIDTH - (10 + 45 + 10 + 10), 70);
        for (int a = 0; a < arrImages.count; a ++)
        {
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(a * (70 + 10), 0, 70, 70)];
            [imageV sd_setImageWithURL:[NSURL URLWithString:arrImages[a]] placeholderImage:[UIImage imageNamed:@"placehoder2.png"]];
            imageV.clipsToBounds = YES;
            imageV.contentMode = UIViewContentModeScaleAspectFill;
            [SVImages addSubview:imageV];
        }
        _cellHeight = _cellHeight + 70 + 10;

    }
    
    if (strReply == nil || [strReply isEqualToString:@""])
    {
        viewReplyBG.hidden = YES;
        labelReply.hidden = YES;
    }
    else
    {
        viewReplyBG.hidden = NO;
        labelReply.hidden = NO;
        NSString *strTotalReply = [NSString stringWithFormat:@"%@:%@",ZEString(@"商家回复", @"Reply"),strReply];
        CGSize sizeForReply = [self sizeOfString:strTotalReply fontSize:12 maxWidth:labelReply.frame.size.width];
        labelReply.text = strTotalReply;
        viewReplyBG.frame = CGRectMake(viewReplyBG.frame.origin.x, _cellHeight, viewReplyBG.frame.size.width, sizeForReply.height + 20);
        labelReply.frame = CGRectMake(10, 10,viewReplyBG.frame.size.width - 20,viewReplyBG.frame.size.height - 20);
        
        _cellHeight = _cellHeight + sizeForReply.height + 20 + 10;
    }

    
    viewDown.frame = CGRectMake(0, _cellHeight - 1, WINDOWWIDTH, 1);
    
//    self.frame = CGRectMake(0, 0, WINDOWWIDTH, _cellHeight);
    
    
}
-(CGSize)sizeOfString:(NSString *)string fontSize:(NSInteger)fontSize maxWidth:(CGFloat)width
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize], NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [string boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return labelSize;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
