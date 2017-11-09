//
//  AddressTableViewCell.h
//  EatAway
//
//  Created by apple on 2017/6/26.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressTableViewCell : UITableViewCell

@property(nonatomic,assign)id delegate;

-(void)setcontentWithAddress:(NSString *)strAddress name:(NSString *)strName sex:(NSString *)strSex phoneNumber:(NSString *)strPhoneNum selected:(BOOL)isSelected selectOrWrite:(NSInteger)modeIndex;

@end

@protocol AddressTableViewCellDelegate <NSObject>

@required
-(void)AddressTableViewCellChangeAddressWithIndex:(NSInteger)cellIndex;

@end
