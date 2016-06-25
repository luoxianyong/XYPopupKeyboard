//
//  AppDelegate.m
//  XYPopupKeyboard
//
//  Created by 罗显勇 on 16/6/25.
//  Copyright © 2016年 JetLuo. All rights reserved.
//

#import "AppDelegate.h"
#import "DemoTableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[DemoTableViewController alloc] init]];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
