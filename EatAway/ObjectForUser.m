//
//  ObjectForUser.m
//  EatAway
//
//  Created by apple on 2017/6/14.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "ObjectForUser.h"

#import <HyphenateLite/HyphenateLite.h>

@implementation ObjectForUser

//清除登录信息
+(void)clearLogin
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userid"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"nickname"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"phonenumber"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"headphoto"];
    
    [[EMClient sharedClient] logout:YES];
    
}
//检查登录信息
+(BOOL)checkLogin
{
    if (USERID == nil || TOKEN == nil)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

@end
