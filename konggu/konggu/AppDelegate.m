//
//  AppDelegate.m
//  kongku
//
//  Created by zhaoliang on 15/3/7.
//  Copyright (c) 2015年 zhaoliang. All rights reserved.
//

#import "AppDelegate.h"
#import "AccountViewController.h"
#import "KGMainViewController.h"
#import "Account.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    //判断是否进行过授权
    Account *account = [[Account alloc] initWithArchiever];
    if (account && [[NSDate date] compare:account.expiresTime]) {
        //获取登陆用户的信息
        KGMainViewController *mainViewController = [[KGMainViewController alloc] initWithStyle];
        self.window.rootViewController = mainViewController;
    }
    else{
        self.window.rootViewController = [[AccountViewController alloc] init];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
