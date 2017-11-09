//
//  FoodDetailViewController.h
//  EatAway
//
//  Created by apple on 2017/6/30.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodDetailViewController : UIViewController
@property(nonatomic,retain)UILabel *labelNum;
@property(nonatomic,assign)id delegate;

-(void)setContentWithTitle:(NSString *)strTitle image:(NSString *)strImageURL num:(NSString *)strNum price:(NSString *)strPrice foodID:(NSString *)strFoodID foodDetails:(NSString *)strFoodDetails;


@end

@protocol FoodDetailViewControllerDelegate <NSObject>

@required
-(void)FoodDetailViewControllerChangeFoodNumber:(NSInteger)strNum foodID:(NSString *)strFoodID foodName:(NSString *)strFoodName foodPrice:(NSString *)strFoodPrice imageURL:(NSString *)strImageURL ;


@end
