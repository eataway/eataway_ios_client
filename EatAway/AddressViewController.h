//
//  AddressViewController.h
//  EatAway
//
//  Created by apple on 2017/6/26.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressViewController : UIViewController

@property(nonatomic,copy)NSString *strTitle;
@property(nonatomic,assign)BOOL isSelectAddress;
@property(nonatomic,assign)id delegate;

@end

@protocol AddressViewControllerDelegate <NSObject>

@optional
-(void)addressViewControllerSelectAddressWithDictionary:(NSDictionary *)dicAddress;

@end
