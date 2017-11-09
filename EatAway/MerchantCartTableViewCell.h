//
//  MerchantCartTableViewCell.h
//  EatAway
//
//  Created by apple on 2017/6/26.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MerchantCartTableViewCell : UITableViewCell

@property(nonatomic,retain)UILabel *labelNum;
@property(nonatomic,assign)id delegate;
@property(nonatomic,copy)NSString *strFoodID;

-(void)setContentWithTitle:(NSString *)strTitle num:(NSString *)strNum price:(NSString *)strPrice foodID:(NSString *)strFoodID image:(NSString *)strImageURL;

@end

@protocol MerchantCartTableViewCellDelegate <NSObject>

@required

-(void)MerchantCartTableViewCellChangeFoodNumber:(NSInteger)strNum foodID:(NSString *)strFoodID foodName:(NSString *)strFoodName foodPrice:(NSString *)strFoodPrice imageURL:(NSString *)strImageURL;

@end

