//
//  OrderDetailFoodsTableViewCell.h
//  EatAway
//
//  Created by apple on 2017/7/7.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailFoodsTableViewCell : UITableViewCell

-(void)setContentWithHeadImage:(NSString *)strImage title:(NSString *)strTitle listDic:(NSDictionary *)arrFoodList shippingFee:(NSString *)strShippingFee totalPrice:(NSString *)strTotalPrice distance:(NSString *)strDistance;


@end
