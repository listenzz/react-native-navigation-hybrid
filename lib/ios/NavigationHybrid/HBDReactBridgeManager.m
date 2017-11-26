//
//  HBDReactBridgeManager.m
//  Pods
//
//  Created by Listen on 2017/11/25.
//

#import "HBDReactBridgeManager.h"
#import <React/RCTLog.h>
#import "HBDNavigator.h"

@interface HBDReactBridgeManager() <RCTBridgeDelegate>

@property(nonatomic, copy) NSURL *jsCodeLocation;
@property(nonatomic, strong) NSMutableDictionary *nativeModules;
@property(nonatomic, strong) NSMutableDictionary *reactModules;
@property(nonatomic, strong) NSMutableDictionary *navigators;
@property(nonatomic, assign) BOOL isReactModuleInRegistry;

@end

@implementation HBDReactBridgeManager

+ (instancetype)instance {
    static dispatch_once_t onceToken;
    static HBDReactBridgeManager *manager;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (void)dealloc {
    // FIXME 反注册通知
}

- (instancetype)init {
    if (self = [super init]) {
        _nativeModules = [[NSMutableDictionary alloc] init];
        _reactModules = [[NSMutableDictionary alloc] init];
        _navigators = [[NSMutableDictionary alloc] init];
        _isReactModuleInRegistry = NO;
    }
    return self;
}

- (void)installWithJsCodeLocation:(NSURL *)location launchOptions:(NSDictionary *)launchOptions {
    _jsCodeLocation = location;
    _bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:launchOptions];
}

- (void)registerNativeModule:(NSString *)moduleName forController:(Class)clazz {
    [_nativeModules setObject:clazz forKey:moduleName];
}

- (BOOL)hasNativeModule:(NSString *)moduleName {
    return [_nativeModules objectForKey:moduleName] != nil;
}

- (Class)nativeModuleClassFromName:(NSString *)moduleName {
    return [_nativeModules objectForKey:moduleName];
}

- (void)registerReactModule:(NSString *)moduleName options:(NSDictionary *)options {
    NSCAssert(self.isReactModuleInRegistry, @"非法操作，你应该先调用 `startRegisterReactModule`");
    [_reactModules setObject:options forKey:moduleName];
}

- (NSDictionary *)reactModuleOptionsForKey:(NSString *)moduleName {
    return [_reactModules objectForKey:moduleName];
}

- (BOOL)hasReactModuleForName:(NSString *)moduleName {
    return [_reactModules objectForKey:moduleName] != nil;
}

- (BOOL)isReactModuleInRegistry {
    return _isReactModuleInRegistry;
}

- (void)startRegisterReactModule {
    [_reactModules removeAllObjects];
    _isReactModuleInRegistry = YES;
}

- (void)endRegisterReactModule {
    _isReactModuleInRegistry = NO;
    if (self.delegate != nil) {
        [self.delegate reactModuleRegistryDidCompleted:self];
    }
}

- (void)registerNavigator:(HBDNavigator *)navigator {
    [_navigators setObject:navigator forKey:navigator.navId];
}

- (void)unregisterNavigator:(HBDNavigator *)navigator {
    [_navigators removeObjectForKey:navigator.navId];
}

- (HBDNavigator *)navigatorForNavId:(NSString *)navId {
    return [_navigators objectForKey:navId];
}

#pragma mark - bridge delegate

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge {
    return _jsCodeLocation;
}

@end
