//
//  AddressAddNewViewController.h
//  EatAway
//
//  Created by apple on 2017/6/26.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressAddNewViewController : UIViewController

@property(nonatomic,assign)id delegate;
@property(nonatomic,assign)NSString *reset;
@property(nonatomic,assign)NSDictionary *dicAdd;

@end

@protocol AddressAddNewViewControllerDelegate <NSObject>

@required

-(void)AddressAddNewAddressSucceed;

@end
