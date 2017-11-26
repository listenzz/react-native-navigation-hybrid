//
//  AppDelegate.m
//  Navigation
//
//  Created by Listen on 2017/11/18.
//  Copyright © 2017年 Listen. All rights reserved.
//

#import "AppDelegate.h"
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
#import <React/RCTLog.h>

#import <NavigationHybrid/HBDReactBridgeManager.h>
#import <NavigationHybrid/HBDNavigator.h>

#import "NativeNavigationViewController.h"
#import "NativeResultViewController.h"


@interface AppDelegate ()

@property(nonatomic, strong) RCTBridge *bridge;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[NSNotificationCenter defaultCenter] addObserverForName:RCTJavaScriptWillStartLoadingNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull note) {
        NSLog(@"RCTJavaScriptWillStartLoadingNotification");
    }];

    [[NSNotificationCenter defaultCenter] addObserverForName:RCTJavaScriptDidLoadNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull note) {
        NSLog(@"RCTJavaScriptDidLoadNotification");
//
//        RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:_bridge moduleName:@"Navigator" initialProperties:nil];
//        rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
//        UIViewController *rootViewController = [UIViewController new];
//        rootViewController.view = rootView;
 //       self.window.rootViewController = rootViewController;
       
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:RCTBridgeWillReloadNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull note) {
        NSLog(@"RCTBridgeWillReloadNotification");
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:RCTBridgeWillDownloadScriptNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull note) {
        NSLog(@"RCTBridgeWillDownloadScriptNotification");
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:RCTBridgeDidDownloadScriptNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull note) {
        NSLog(@"RCTBridgeDidDownloadScriptNotification");
    }];
    
    NSURL *jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"playground/index.ios" fallbackResource:nil];
    [[HBDReactBridgeManager instance] installWithJsCodeLocation:jsCodeLocation launchOptions:launchOptions];
    _bridge = [HBDReactBridgeManager instance].bridge;
    
    // 注册 native 模块
    [[HBDReactBridgeManager instance] registerNativeModule:@"NativeNavigation" forController:[NativeNavigationViewController class]];
    [[HBDReactBridgeManager instance] registerNativeModule:@"Navigation" forController:[NativeNavigationViewController class]];
    [[HBDReactBridgeManager instance] registerNativeModule:@"NativeResult" forController:[NativeResultViewController class]];
    
    HBDNavigator *navigator = [[HBDNavigator alloc] initWithRootModule:@"NativeNavigation" props:nil options:nil reactBridgeManager:[HBDReactBridgeManager instance]];
    
    [[HBDReactBridgeManager instance] registerNavigator:navigator];
    self.window.rootViewController = navigator.navigationController;
    
//    UIViewController *vc = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
//    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
