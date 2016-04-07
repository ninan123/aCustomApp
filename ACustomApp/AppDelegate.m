//
//  AppDelegate.m
//  ACustomApp
//
//  Created by Apple on 16/3/29.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "Root_LeftViewController.h"
#import "YLNavigationViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    Root_LeftViewController *leftVc = [[Root_LeftViewController alloc]init];
    RootViewController *first = [[RootViewController alloc]init];
    
    YLNavigationViewController *rightNavi = [[YLNavigationViewController alloc]initWithRootViewController:first];
    
    [rightNavi setRestorationIdentifier:@"RightNavigationControllerRestorationKey"];
    
    _drawerController = [[MMDrawerController alloc]
                         
                         initWithCenterViewController:rightNavi
                         
                         leftDrawerViewController:leftVc
                         
                         rightDrawerViewController:nil];
    [self.drawerController setShowsShadow:NO];
    
    [self.drawerController setRestorationIdentifier:@"MMDrawer"];
    
    // 设置右边页面显示宽度，左边同理
    [self.drawerController setMaximumLeftDrawerWidth:SCREEN_WIDTH-80];
    // 左右滑动，三个页面间切换
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    // 设为根视图
    self.window.rootViewController = self.drawerController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];


    // Override point for customization after application launch.
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
