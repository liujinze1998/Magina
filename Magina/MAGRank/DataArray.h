//
//  DataArray.h
//  MyTableView
//
//  Created by bytedance on 2020/10/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataArray : NSObject

@property (nonatomic, readonly) NSArray *dataList;

+ (DataArray *)sharedInstance;

- (instancetype)init;

- (void)addData;

@end

NS_ASSUME_NONNULL_END
