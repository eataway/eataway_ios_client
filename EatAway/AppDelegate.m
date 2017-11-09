//
//  AppDelegate.m
//  EatAway
//
//  Created by apple on 2017/6/6.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "AppDelegate.h"

#import "FirstViewController.h"
#import "FirstNavigationController.h"


#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "WXApi.h"

#import <HyphenateLite/HyphenateLite.h>
#import <EaseUI.h>

#import <FBSDKCoreKit/FBSDKCoreKit.h>


//Google地图
@import GooglePlaces;
@import GoogleMaps;




@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self dataInit];
    
    
    FirstViewController *FVC = [[FirstViewController alloc]init];
    FirstNavigationController *Navi = [[FirstNavigationController alloc]initWithRootViewController:FVC];
    self.window.rootViewController = Navi;
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    [self mapInit];
    [self shareSDKInit];
    [self brainTreeInit];
    [self huanxinInit:launchOptions application:application];
    return YES;
}

-(void)dataInit
{
    if (!ISCHINESE) {
         [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"language"];
    }else {
         [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"language"];
    }
    
    
    
    
    
}
-(void)huanxinInit:(NSDictionary *)option application:(UIApplication *)application
{
    EMOptions *options = [EMOptions optionsWithAppkey:@"1134170510178165#australiandelivery"];
    options.apnsCertName = @"production";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    
    [[EaseSDKHelper shareHelper] hyphenateApplication:application
                        didFinishLaunchingWithOptions:option
                                               appkey:@"1134170510178165#australiandelivery"
                                         apnsCertName:@"production"
                                          otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
}
-(void)mapInit
{
    //    [GMSPlacesClient provideAPIKey:@"AIzaSyBe352yZw5xQPCY6Xbhwyyb4rzVAcTPm8s"];
    [GMSPlacesClient provideAPIKey:@"AIzaSyDEYjEKkuUp1iTDW-xDAnEIyE65vO2cmjc"];
    [GMSServices provideAPIKey:@"AIzaSyDEYjEKkuUp1iTDW-xDAnEIyE65vO2cmjc"];
    
}
-(void)brainTreeInit
{
    [[ObjectForRequest shareObject] requestGetWithFullURL:@"https://braintree-sample-merchant.herokuapp.com/client_token" resultBlock:^(NSDictionary *resultDic) {
        if (resultDic != nil)
        {
            [[NSUserDefaults standardUserDefaults] setObject:resultDic[@"client_token"] forKey:@"braintreetoken"];
        }
        else
        {
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"braintreetoken"];
        }
    }];
}
-(void)shareSDKInit
{
    [ShareSDK registerActivePlatforms:@[
                                        @(SSDKPlatformTypeWechat),
                                        @(SSDKPlatformTypeFacebook),
                                        ]
                             onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             default:
                 break;
         }
     }
                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx816a6a0aeca0e887"
                                       appSecret:@"7ea18dfc54fe7f525b1f02ca286855da"];
                 break;
             case SSDKPlatformTypeFacebook:
                 [appInfo SSDKSetupFacebookByApiKey:@"326294461145995"
                                          appSecret:@"a13e8bfc35ee174b4526a24a61f75873"
                                        displayName:@"EatAway"
                                           authType:SSDKAuthTypeBoth];
                 break;
            default:
                   break;
                   }
        }];
}
//- (BOOL)application:(UIApplication *)application
//            openURL:(NSURL *)url
//  sourceApplication:(NSString *)sourceApplication
//         annotation:(id)annotation {
//    return [[FBSDKApplicationDelegate sharedInstance] application:application
//                                                          openURL:url
//                                                sourceApplication:sourceApplication
//                                                       annotation:annotation];
//}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:sourceApplication
                                                               annotation:annotation
                    ];
    // Add any custom logic here.
    return handled;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [[EMClient sharedClient] applicationDidEnterBackground:application];

}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [[EMClient sharedClient] applicationWillEnterForeground:application];

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBSDKAppEvents activateApp];

    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
