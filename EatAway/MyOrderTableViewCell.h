//
//  MyOrderTableViewCell.h
//  EatAway
//
//  Created by BossWang on 17/7/4.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyOrderModel;

@protocol MyOrderDelegate <NSObject>

- (void)affirmReceiving;
- (void)againOrder;

@end
@interface MyOrderTableViewCell : UITableViewCell

@property (nonatomic, assign)id<MyOrderDelegate>myOrderDelegate;
@property (nonatomic, strong) MyOrderModel *orderModel;

@end
