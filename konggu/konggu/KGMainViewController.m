//
//  KGMainViewController.m
//  konggu
//
//  Created by zhaoliang on 15/3/8.
//  Copyright (c) 2015年 zhaoliang. All rights reserved.
//

#import "KGMainViewController.h"
#import "TabHomeViewController.h"
#import "TabTrendViewController.h"
#import "TabMessageViewController.h"
#import "TabMeViewController.h"

@implementation KGMainViewController

- (instancetype)initWithStyle
{
    self = [super init];
    if (self) {
        //设置tabbar属性
        TabHomeViewController *homeTab = [[TabHomeViewController alloc] init];
        homeTab.title = @"时间线";
        UINavigationController *homeVC = [[UINavigationController alloc] initWithRootViewController:homeTab];
        homeVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"时间线" image:[UIImage imageNamed:@"tabbar_home"]
                                                  selectedImage:[UIImage imageNamed:@"tabbar_home_selected"]];
        homeVC.tabBarItem.selectedImage = [homeVC.tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        homeVC.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -4);
        
        
        TabTrendViewController *trendTab = [[TabTrendViewController alloc] init];
        trendTab.title = @"话题";
        UINavigationController *trendVC = [[UINavigationController alloc] initWithRootViewController:trendTab];
        trendVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"话题" image:[UIImage imageNamed:@"tabbar_discover"]
                                                   selectedImage:[UIImage imageNamed:@"tabbar_discover_selected"]];
        trendVC.tabBarItem.selectedImage = [trendVC.tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        trendVC.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -4);
        
        TabMessageViewController *messageTab = [[TabMessageViewController alloc] init];
        messageTab.title = @"消息";
        UINavigationController *messageVC = [[UINavigationController alloc] initWithRootViewController:messageTab];
        messageVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"消息" image:[UIImage imageNamed:@"tabbar_message_center"]
                                                     selectedImage:[UIImage imageNamed:@"tabbar_message_center_selected"]];
        messageVC.tabBarItem.selectedImage = [messageVC.tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        messageVC.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -4);
        
        TabMeViewController *meTab = [[TabMeViewController alloc] init];
        meTab.title = @"我";
        UINavigationController *meVC = [[UINavigationController alloc] initWithRootViewController:meTab];
        meVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我" image:[UIImage imageNamed:@"tabbar_profile"]
                                                selectedImage:[UIImage imageNamed:@"tabbar_profile_selected"]];
        meVC.tabBarItem.selectedImage = [meVC.tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        meVC.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -4);
        
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor orangeColor], NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor], NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
        
        self.viewControllers = @[homeVC, trendVC, messageVC, meVC];
    }
    return self;
}

@end
