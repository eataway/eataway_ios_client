//
//  OrderDetailInfomationTableViewCell.h
//  EatAway
//
//  Created by apple on 2017/7/7.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailInfomationTableViewCell : UITableViewCell

-(void)setContentWithDeliveryTime:(NSString *)strDeliveryTime orderNum:(NSString *)strOrderNum address:(NSString *)strAddress remarks:(NSString *)strRemarks;


@end
