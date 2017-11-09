//
//  MerchantCartViewController.h
//  EatAway
//
//  Created by apple on 2017/6/26.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MerchantCartViewController : UIViewController


@property(nonatomic,retain)NSMutableDictionary *dicList;
-(void)refreshListWithCartDic:(NSDictionary *)dic all:(BOOL)allPage;
@property(assign,nonatomic)id delegate;
@end

@protocol MerchantCartViewControllerDelegate <NSObject>

@required
-(void)MerchantCartViewControllerChangeDictonary:(NSDictionary *)dic;

@end
