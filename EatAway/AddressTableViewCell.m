//
//  AddressTableViewCell.m
//  EatAway
//
//  Created by apple on 2017/6/26.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "AddressTableViewCell.h"

@interface AddressTableViewCell ()
{
    UIImageView *IVLeftSelect;
    UILabel *labelAddress;
    UILabel *labelName;
    UIView *viewl;
    UIButton *btnWrite;
}
@end

@implementation AddressTableViewCell

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
        
        UIView *viewBG = [[UIView alloc]initWithFrame:CGRectMake(10, 0, WINDOWWIDTH - 20, 70)];
        viewBG.backgroundColor = [UIColor whiteColor];
        viewBG.clipsToBounds = YES;
        viewBG.layer.cornerRadius = 7;
        [self.contentView addSubview:viewBG];
        
        IVLeftSelect = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 45, 45)];
        IVLeftSelect.image = [UIImage imageNamed:@"2.2.4_tag_sel.png"];
        [self.contentView addSubview:IVLeftSelect];
        
        labelAddress = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, WINDOWWIDTH - 40 - 55, 45)];
        labelAddress.numberOfLines = 2;
        labelAddress.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:labelAddress];
        
        labelName = [[UILabel alloc]initWithFrame:CGRectMake(40, 45, WINDOWWIDTH - 40 - 55, 15)];
        labelName.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:labelName];
        
        viewl = [[UIView alloc]initWithFrame:CGRectMake(WINDOWWIDTH - 50, 10, 1, 50)];
        viewl.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
        [self.contentView addSubview:viewl];
        
        
        btnWrite = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnWrite setImage:[UIImage imageNamed:@"2.2.4_icon_change.png"] forState:UIControlStateNormal];
        btnWrite.frame = CGRectMake(WINDOWWIDTH - 10 - 10 - 20, 25, 20, 20);
        [btnWrite addTarget:self action:@selector(btnChangeAddressClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btnWrite];
        
    }
    return self;
}
-(void)setcontentWithAddress:(NSString *)strAddress name:(NSString *)strName sex:(NSString *)strSex phoneNumber:(NSString *)strPhoneNum selected:(BOOL)isSelected selectOrWrite:(NSInteger)modeIndex
{
    labelAddress.text = strAddress;
    if(ISCHINESE)
    {
        labelName.text = [NSString stringWithFormat:@"%@  %@  %@",strName,([strSex isEqualToString:@"1"]?@"先生":@"女士"),strPhoneNum];
    }
    else
    {
        labelName.text = [NSString stringWithFormat:@"%@%@  %@",([strSex isEqualToString:@"1"]?@"Mr.":@"Ms."),strName,strPhoneNum];
    }
}
-(void)btnChangeAddressClick
{
    [self.delegate AddressTableViewCellChangeAddressWithIndex:self.tag];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
