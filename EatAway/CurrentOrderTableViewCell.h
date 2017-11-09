//
//  CurrentOrderTableViewCell.h
//  EatAway
//
//  Created by apple on 2017/7/6.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrentOrderTableViewCell : UITableViewCell

-(void)setContentWithHeadImage:(NSString *)strImage title:(NSString *)strTitle listDic:(NSDictionary *)arrFoodList shippingFee:(NSString *)strShippingFee totalPrice:(NSString *)strTotalPrice orderState:(NSString *)strOrderState distance:(NSString *)strDistance statu:(NSString *)statu;
-(void)changeCellStateWithState:(NSString *)strState;
@property(nonatomic,assign)id delegate;

@end

@protocol CurrentOrderTableViewCellDelegate <NSObject>

@optional
-(void)CurrentOrderTableViewCellReviewsWithCellIndex:(NSInteger)cellIndex;


@required

-(void)CurrentOrderTableViewCellContactWithCellIndex:(NSInteger)cellIndex;
-(void)CurrentOrderTableViewCellCommenttWithCellIndex:(NSInteger)cellIndex;
-(void)CurrentOrderTableViewCellOperationKind:(NSString *)strOperationKind WithCellIndex:(NSInteger)cellIndex;



@end
