//
//  People.h
//  dd
//
//  Created by bytedance on 2020/10/21.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface People : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *DNum;
@property(nonatomic,assign)NSInteger getCompliments;
@property(nonatomic,assign)NSInteger follow;
@property(nonatomic,assign)NSInteger fans;
@property(nonatomic,assign)NSInteger works;
@property(nonatomic,assign)NSInteger dyna;
@property(nonatomic,assign)NSInteger like;
+ (People*)SharedInstance;
@end

NS_ASSUME_NONNULL_END
