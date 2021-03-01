//
//  MAGUserDefaultsUtil.h
//  Magina
//
//  Created by liujinze on 2021/3/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MAGUserDefaultsUtil : NSObject


@property (class, nonatomic, copy) NSString *userName; //昵称
@property (class, nonatomic, copy) NSString *sex; //性别
@property (class, nonatomic, copy) NSString *maginaNum; //magina号
@property (class, nonatomic, copy) NSString *signature; //个性签名

@end

NS_ASSUME_NONNULL_END
