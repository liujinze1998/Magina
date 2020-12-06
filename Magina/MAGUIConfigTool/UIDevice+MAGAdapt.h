//
//  UIDevice+MAGAdapt.h
//  Magina
//
//  Created by liujinze on 2020/12/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (MAGAdapt)

+ (BOOL)isSafeAreaDevice;//判断是不是全面屏

+ (CGFloat)safeAreaTopInset;//全面屏的顶部

@end

NS_ASSUME_NONNULL_END
