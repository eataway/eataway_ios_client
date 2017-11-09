//
//  AddressPickLocationViewController.h
//  EatAway
//
//  Created by apple on 2017/6/27.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressPickLocationViewController : UIViewController

@property(nonatomic,assign)id delegate;

@end

@protocol AddressPickLocationViewControllerDelegate <NSObject>

@required
-(void)AddressPickLocationViewControllerSelectResult:(NSString *)strResult location:(NSString *)strLocation;

@end
