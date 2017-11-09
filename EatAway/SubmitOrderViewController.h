//
//  SubmitOrderViewController.h
//  EatAway
//
//  Created by apple on 2017/6/22.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubmitOrderViewController : UIViewController

@property(nonatomic,copy)NSDictionary *dicOrder;
@property(nonatomic,assign)CGFloat PSFee;
@property(nonatomic,assign)CGFloat totalPrice;
@property(nonatomic,assign)CGFloat totalPriceWithoutPS;
@property(nonatomic,copy)NSString *strShopName;
@property(nonatomic,copy)NSString *strHeadImageURL;
@property(nonatomic,copy)NSString *strShopID;


@end
