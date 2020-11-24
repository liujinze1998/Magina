//
//  DataArray.m
//  MyTableView
//
//  Created by bytedance on 2020/10/15.
//

#import "DataArray.h"
#import "RankData.h"

static DataArray *sharedSingleton = nil;

@interface DataArray ()

@property (nonatomic, strong) NSMutableArray *p_dataList;

@end

@implementation DataArray

- (instancetype)init
{
    self = [super init];
    _p_dataList = [[NSMutableArray alloc] init];
    return self;
}
 
+ (DataArray *)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedSingleton = [[self alloc] init];
    });
    return sharedSingleton;
}

- (void)addData
{
    RankData *item = [[RankData alloc] init];
    if (item) {
        [self.p_dataList addObject:item];
    }
    
}

- (NSArray *)dataList
{
    return [self.p_dataList copy];
}

@end
