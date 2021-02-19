//
//  AppDelegate.m
//  Magina
//
//  Created by liujinze on 2020/10/26.
//

#import "AppDelegate.h"
#import "MAGRootViewController.h"
#import "MAGLaunchView.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [NSThread sleepForTimeInterval:1.0];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    MAGRootViewController *rootVC = [[MAGRootViewController alloc] init];
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
    [self showLaunchAnimation];
    return YES;
}

#pragma mark - launch
- (void)showLaunchAnimation
{
    MAGLaunchView *launchView = [[MAGLaunchView alloc] initLaunchView];
    [self.window addSubview:launchView];
    [self.window bringSubviewToFront:launchView];
    [launchView startAnimation];
}

@end
