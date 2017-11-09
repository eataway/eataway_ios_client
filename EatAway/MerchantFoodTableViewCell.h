//
//  OrderFoodTableViewCell.h
//  EatAway
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MerchantFoodTableViewCell : UITableViewCell

@property(strong,nonatomic) UILabel *labelTitle;
@property(nonatomic,retain)UILabel *labelNum;
@property(nonatomic,copy)NSString *strFoodID;
@property(nonatomic,assign)id delegate;

-(void)setContentWithTitle:(NSString *)strTitle image:(NSString *)strImageURL num:(NSString *)strNum price:(NSString *)strPrice foodID:(NSString *)strFoodID saling:(NSString *)isSaling;

@end

@protocol MerchantFoodTableViewCellDelegate <NSObject>

@required

-(void)MerchantFoodTableViewCellChangeFoodNumber:(NSInteger)strNum foodID:(NSString *)strFoodID foodName:(NSString *)strFoodName foodPrice:(NSString *)strFoodPrice imageURL:(NSString *)strImageURL;

@end
