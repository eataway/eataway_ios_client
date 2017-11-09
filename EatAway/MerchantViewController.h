//
//  MerchantViewController.h
//  EatAway
//
//  Created by apple on 2017/6/20.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MerchantViewController : UIViewController

@property(nonatomic,retain)NSMutableDictionary *dicForSelectedFood;
@property(nonatomic,retain)NSString *shopID;

@property(nonatomic,assign)NSString *userLocation;

@end
