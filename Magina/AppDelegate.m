//
//  AppDelegate.m
//  Magina
//
//  Created by liujinze on 2020/10/26.
//

#import "AppDelegate.h"
#import "MAGRootViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    MAGRootViewController *rootVC = [[MAGRootViewController alloc] init];
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
