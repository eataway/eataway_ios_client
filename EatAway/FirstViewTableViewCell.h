//
//  FirstViewTableViewCell.h
//  EatAway
//
//  Created by apple on 2017/6/7.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewTableViewCell : UITableViewCell

-(void)setContentWithHeadImage:(NSString *)strHeadURL tips:(NSString *)strTips backgroundImage:(NSString *)strBGImageURL title:(NSString *)strTitle distance:(NSString *)strDistance isOpen:(BOOL)isOpen;

@end
