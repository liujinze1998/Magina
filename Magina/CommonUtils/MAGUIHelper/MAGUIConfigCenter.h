//
//  MAGUIConfigCenter.h
//  Magina
//
//  Created by AM on 2020/12/6.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kScreenRect [[UIScreen mainScreen] bounds]
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#define scanAreaX 300
#define scanBorderX ((kScreenWidth - scanAreaX) / 2)
#define scanBorderY ((kScreenHeight - scanAreaX) / 2)

@interface MAGUIConfigCenter : NSObject

+ (BOOL)isDarkMode;

@end

