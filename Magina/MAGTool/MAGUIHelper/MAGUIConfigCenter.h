//
//  MAGUIConfigCenter.h
//  Magina
//
//  Created by liujinze on 2020/12/6.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define kScreenRect [[UIScreen mainScreen] bounds]
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width


@interface MAGUIConfigCenter : NSObject

+ (BOOL)isDarkMode;

@end

