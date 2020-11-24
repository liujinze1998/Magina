//
//  RankData.m
//  MyTableView
//
//  Created by bytedance on 2020/10/15.
//

#import "RankData.h"
int numNow=1;
int dataNumNow = 6000;
@implementation RankData

- (instancetype)init
{
    self = [super init];
    if (self) {
        _name = [[[NSString alloc] initWithFormat:@"Reed%d号",numNow] copy];
        dataNumNow += arc4random() % 1000 + 100;
        _dataNumber = dataNumNow;
        _rankNumber = numNow++;
    }
    return self;
}

@end
