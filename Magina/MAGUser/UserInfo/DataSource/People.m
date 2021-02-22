//
//  People.m
//  dd
//
//  Created by bytedance on 2020/10/21.
//

#import "People.h"
static People* sharedSingleton = nil;
@implementation People
+ (People*)SharedInstance{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedSingleton = [[self alloc]init];
    });
    return sharedSingleton;
}

-(instancetype)init{
    //NSUserDefaults 持久化 信息替换为
    // 获取Document目录
//    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
//
//    // 获取Cache目录
//    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
//
//    // 获取Library目录
//    NSString *path = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;

    self = [super init];
    self.name = @"隔壁的热心老王";
    self.DNum = @"wzyh2004";
    self.getCompliments = 21;
    self.follow = 16;
    self.fans = 168;
    self.works = 15;
    self.dyna = 21;
    self.like = 83;
    return  self;
}
@end
