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
