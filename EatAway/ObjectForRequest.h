//
//  ObjectForRequest.h
//  EatAway
//
//  Created by apple on 2017/6/14.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjectForRequest : NSObject

+(id)shareObject;

-(void)requestWithURL:(NSString *)strURL parameter:(NSDictionary *)dicPara resultBlock:(void(^)(NSDictionary *resultDic))resultBlock;


-(void)requestPostWithFullURL:(NSString *)strURL parameter:(NSDictionary *)dicPara resultBlock:(void(^)(NSDictionary *resultDic))resultBlock;
-(void)requestGetWithFullURL:(NSString *)strURL resultBlock:(void(^)(NSDictionary *resultDic))resultBlock;


-(void)requestWithURLString:(NSString *)urlStr images:(NSArray *)arrImages Parameters:(NSDictionary *)paraDic resultBlock:(void(^)(NSDictionary *resultDic))resultBlock;
-(void)requestToUploadHeadImageWithURLString:(NSString *)urlStr image:(NSArray *)images Parameters:(NSDictionary *)paraDic resultBlock:(void(^)(NSDictionary *resultDic))resultBlock;
@end
