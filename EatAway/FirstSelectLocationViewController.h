//
//  FirstSelectLocationViewController.h
//  EatAway
//
//  Created by apple on 2017/7/6.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstSelectLocationViewController : UIViewController

@property(nonatomic,copy)NSString *strTitle;
@property(nonatomic,assign)BOOL isSelectAddress;
@property(nonatomic,assign)id delegate;

@end

@protocol FirstSelectLocationViewControllerDelegate <NSObject>

@optional
-(void)FirstSelectLocationViewControllerSelectAddressWithDictionary:(NSDictionary *)dicAddress;

@end
