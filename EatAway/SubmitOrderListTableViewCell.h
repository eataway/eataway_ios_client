//
//  SubmitOrderListTableViewCell.h
//  EatAway
//
//  Created by apple on 2017/6/24.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubmitOrderListTableViewCell : UITableViewCell

-(void)setContentWithHeadImage:(NSString *)strImage title:(NSString *)strTitle listDic:(NSDictionary *)arrFoodList totalPrice:(NSString *)strTotalPrice;
-(void)setPSFee:(NSString *)strShippingFee distance:(NSString *)strDistance totalPrice:(NSString *)strTotalPrice;

@end
