//
//  MerchantInfoFirstTableViewCell.m
//  EatAway
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "MerchantInfoFirstTableViewCell.h"

#import <UIImageView+WebCache.h>

@interface MerchantInfoFirstTableViewCell ()
{
    UIImageView *IVHead;
    UILabel *labelTitle;
    UILabel *labelText;
}
@end

@implementation MerchantInfoFirstTableViewCell

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
        IVHead = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 40, 40)];
        IVHead.clipsToBounds = YES;
        IVHead.layer.cornerRadius = 20;
        [self addSubview:IVHead];
        
        labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(10 + 40 + 10, 15, WINDOWWIDTH - (10 + 20 + 10 + 20), 40)];
        labelTitle.font = [UIFont systemFontOfSize:15];
        [self addSubview:labelTitle];
        
        UIView *viewDown = [[UIView alloc]initWithFrame:CGRectMake(10 + 40 + 10, 15 + 35, WINDOWWIDTH - (10 + 40 + 10 + 30), 1)];
        viewDown.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
        [self addSubview:viewDown];
        
        labelText = [[UILabel alloc]initWithFrame:CGRectMake(10 , 15 + 40 + 10, WINDOWWIDTH -  40, 40)];
        labelText.font = [UIFont systemFontOfSize:13];
        labelText.numberOfLines = 100;
        [self addSubview:labelText];
    }
    return self;
}
-(void)setContentWithHeadImage:(NSString *)strImageURL title:(NSString *)strTitle text:(NSString *)strText
{
    [IVHead sd_setImageWithURL:[NSURL URLWithString:strImageURL] placeholderImage:[UIImage imageNamed:@"placehoder1.png"]];
    labelTitle.text = strTitle;
    labelText.text = strText;
    CGSize textLabelSize = [self sizeOfString:strText fontSize:13];
    CGFloat labelHei = textLabelSize.height > 90?90:textLabelSize.height;
    labelText.frame = CGRectMake(10 , 15 + 40 + 10, WINDOWWIDTH -  40, labelHei);
    self.frame = CGRectMake(0, 0, WINDOWWIDTH, 15 + 40 + 10 + labelHei + 10);
    
}
-(CGSize)sizeOfString:(NSString *)string fontSize:(NSInteger)fontSize
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize], NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [string boundingRectWithSize:CGSizeMake(WINDOWWIDTH -  40,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return labelSize;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
