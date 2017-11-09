//
//  OrderCommentViewController.h
//  EatAway
//
//  Created by apple on 2017/7/7.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderCommentViewController : UIViewController

@property(nonatomic,assign)id delegate;

@property(nonatomic,copy)NSString *strHeadPhotoURL;
@property(nonatomic,copy)NSString *strShopName;
@property(nonatomic,copy)NSString *strShopImageURL;
@property(nonatomic,copy)NSString *strOrderID;
@property(nonatomic,copy)NSString *strShopID;


-(void)setContentWithHeadPhotoURL:(NSString *)strHeadPhotoURL shopName:(NSString *)strShopName ShopImageURL:(NSString *)strShopImageURL orderid:(NSString *)strOrderID shopID:(NSString *)strShopID;

@end

@protocol OrderCommentViewControllerDelegate <NSObject>

@required

-(void)orderCommentViewControllerSucceed;

@end
