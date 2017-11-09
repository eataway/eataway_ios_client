//
//  ObjectForRequest.m
//  EatAway
//
//  Created by apple on 2017/6/14.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "ObjectForRequest.h"

#import <AFNetworking.h>


static ObjectForRequest * mainObj;

@implementation ObjectForRequest



+(ObjectForRequest *)shareObject
{
    if (!mainObj)
    {
        mainObj = [[ObjectForRequest alloc]init];
    }
    return mainObj;
}

-(void)requestWithURL:(NSString *)strURL parameter:(NSDictionary *)dicPara resultBlock:(void(^)(NSDictionary *resultDic))resultBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer new];
    [manager POST:[NSString stringWithFormat:@"%@/%@",HTTPHOST,strURL] parameters:dicPara progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        resultBlock(dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        resultBlock(nil);
        
    }];
}
-(void)requestPostWithFullURL:(NSString *)strURL parameter:(NSDictionary *)dicPara resultBlock:(void(^)(NSDictionary *resultDic))resultBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer new];
    [manager POST:[NSString stringWithFormat:@"%@",strURL] parameters:dicPara progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        resultBlock(dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        resultBlock(nil);
    }];
}
-(void)requestGetWithFullURL:(NSString *)strURL resultBlock:(void(^)(NSDictionary *resultDic))resultBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer new];
    [manager GET:[NSString stringWithFormat:@"%@",strURL] parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        resultBlock(dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        resultBlock(nil);
    }];
}
//上传图片
-(void)requestWithURLString:(NSString *)urlStr images:(NSArray *)arrImages Parameters:(NSDictionary *)paraDic resultBlock:(void(^)(NSDictionary *resultDic))resultBlock
{
    
    // 基于AFN3.0+ 封装的HTPPSession句柄
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 30;
    manager.responseSerializer = [AFHTTPResponseSerializer new];
    
    // 在parameters里存放照片以外的对象
    [manager POST:[NSString stringWithFormat:@"%@/%@",HTTPHOST,urlStr] parameters:paraDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i = 0; i < arrImages.count; i++) {
            
            UIImage *image = arrImages[i];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统事件作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *dateString = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString  stringWithFormat:@"%@%ld.jpg", dateString,(long)i];
            
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"myFile%d",i+1] fileName:fileName mimeType:@"image/jpeg"]; //
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        resultBlock(dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        resultBlock(nil);
        
    }];
}
//上传头像
-(void)requestToUploadHeadImageWithURLString:(NSString *)urlStr image:(NSArray *)images Parameters:(NSDictionary *)paraDic resultBlock:(void(^)(NSDictionary *resultDic))resultBlock
{
    
    // 基于AFN3.0+ 封装的HTPPSession句柄
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 30;
    manager.responseSerializer = [AFHTTPResponseSerializer new];
    
    // 在parameters里存放照片以外的对象
    [manager POST:[NSString stringWithFormat:@"%@/%@",HTTPHOST,urlStr] parameters:paraDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
        UIImage *image = [images firstObject];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *dateString = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
            
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"photo"] fileName:fileName mimeType:@"image/jpeg"]; //

        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        resultBlock(dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        resultBlock(nil);
        
    }];
}
@end
