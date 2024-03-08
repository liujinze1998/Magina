//
//  UIDevice+MAGAdapt.h
//  Magina
//
//  Created by AM on 2020/12/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (MAGAdapt)

+ (BOOL)isSafeAreaDevice;//判断是不是全面屏

+ (CGFloat)safeAreaTopInset;//全面屏的顶部

+ (BOOL)isLandDirect;//是否是横持手机

+ (CGFloat)safeAreaBottomInset;//全面屏的底部

@end

NS_ASSUME_NONNULL_END
