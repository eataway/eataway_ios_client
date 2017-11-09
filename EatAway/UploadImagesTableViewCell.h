//
//  UploadImagesTableViewCell.h
//  UniTrader
//
//  Created by Wolf.Wang on 2016/12/9.
//  Copyright © 2016年 youfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UploadImagesTableViewCell : UITableViewCell

@property(nonatomic,assign)id delegate;
@property(assign,nonatomic)NSUInteger maxImageNum;

-(void)addImage:(UIImage *)image;

@end

@protocol  UploadImagesTableViewCellDelegate<NSObject>

@required

-(void)tableViewUploadImageClick;
-(void)tableViewDeleteImageWithTag:(NSInteger)imageTag;

@end
