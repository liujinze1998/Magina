//
//  UIDevice+MAGAdapt.m
//  Magina
//
//  Created by liujinze on 2020/12/6.
//

#import "UIDevice+MAGAdapt.h"

@implementation UIDevice (MAGAdapt)

static NSInteger isNotchedScreen = -1;

+ (BOOL)isSafeAreaDevice
{
    if (isNotchedScreen < 0) {
        if (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone || UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            if (@available(iOS 11.0, *)) {
                UIWindow *mainWindow = [[[UIApplication sharedApplication] windows] firstObject];
                BOOL shouldRemoveWindow = NO;
                if (!mainWindow) {
                    mainWindow = [[UIWindow alloc] init];
                    mainWindow.backgroundColor = [UIColor clearColor];
                    shouldRemoveWindow = YES;
                }
                isNotchedScreen = mainWindow.safeAreaInsets.bottom > 0.0 ? 1 : 0;
                if (shouldRemoveWindow) {
                    [mainWindow removeFromSuperview];
                    mainWindow = nil;
                }
            } else {
                isNotchedScreen = 0;
            }
        } else {
            isNotchedScreen = 0;
        }
    }
    return isNotchedScreen > 0;
}

+ (CGFloat)safeAreaTopInset
{
    if (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone || UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad){
        if (@available(iOS 11.0, *)) {
            UIWindow *mainWindow = [[[UIApplication sharedApplication] windows] firstObject];
            BOOL shouldRemoveWindow = NO;
            if (!mainWindow) {
                mainWindow = [[UIWindow alloc] init];
                mainWindow.backgroundColor = [UIColor clearColor];
                shouldRemoveWindow = YES;
            }
            CGFloat safeAreaTopInset = mainWindow.safeAreaInsets.top;
            if (shouldRemoveWindow) {
                [mainWindow removeFromSuperview];
                mainWindow = nil;
            }
            return safeAreaTopInset;
        } else {
            return 0.0;
        }
    } else {
        return 0.0;
    }
}

@end
