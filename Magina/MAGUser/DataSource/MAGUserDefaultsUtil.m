//
//  MAGUserDefaultsUtil.m
//  Magina
//
//  Created by liujinze on 2021/3/1.
//

#import "MAGUserDefaultsUtil.h"

static NSString *const kUserName = @"userName";
static NSString *const kSex = @"sex";
static NSString *const kMaginaNum = @"maginaNum";
static NSString *const kSignature = @"signature";

@implementation MAGUserDefaultsUtil


#pragma mark - setter
+ (void)setUserName:(NSString *)newName
{
    [[NSUserDefaults standardUserDefaults] setObject:newName forKey:kUserName];
}

+ (void)setSex:(NSString *)sex
{
    [[NSUserDefaults standardUserDefaults] setObject:sex forKey:kSex];
}

+ (void)setMaginaNum:(NSString *)newNum
{
    [[NSUserDefaults standardUserDefaults] setObject:newNum forKey:kMaginaNum];
}

+ (void)setSignature:(NSString *)signature
{
    [[NSUserDefaults standardUserDefaults] setObject:signature forKey:kSignature];
}

#pragma mark - getter
+ (NSString *)userName
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:kUserName];
}

+ (NSString *)sex
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:kSex];
}

+ (NSString *)maginaNum
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:kMaginaNum];
}

+ (NSString *)signature
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:kSignature];
}

@end
