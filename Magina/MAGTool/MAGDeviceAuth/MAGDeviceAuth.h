//
//  MAGDeviceAuth.h
//  Magina
//
//  Created by liujinze on 2021/2/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MAGDeviceAuth : NSObject

+ (void)requestPhotoLibraryPermission:(void(^)(BOOL success))completion;//请求相册权限

+ (BOOL)hasMicroPhoneAuth;//判断是否有麦克风权限

+ (BOOL)hasCameraAuth;//判断是否有相机权限

@end

NS_ASSUME_NONNULL_END
