//
//  SubmitOrderTasteTViewController.h
//  EatAway
//
//  Created by apple on 2017/6/30.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubmitOrderTasteTViewController : UIViewController

@property(nonatomic,assign)id delegate;

@end

@protocol SubmitOrderTasteTViewControllerDelegate <NSObject>

@required

-(void)SubmitOrderTasteTViewControllerResult:(NSString *)strResult;

@end
