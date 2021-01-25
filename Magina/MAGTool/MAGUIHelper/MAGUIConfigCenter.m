//
//  MAGUIConfigCenter.m
//  Magina
//
//  Created by liujinze on 2020/12/6.
//

#import "MAGUIConfigCenter.h"

@implementation MAGUIConfigCenter

+ (BOOL)isDarkMode
{
    return [UIScreen mainScreen].traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark;
}

@end
