//
//  MAGDeviceAuth.h
//  Magina
//
//  Created by AM on 2021/2/22.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface MAGDeviceAuth : NSObject

+ (void)requestPhotoLibraryPermission:(void(^)(BOOL success))completion;//请求相册权限

+ (AVAuthorizationStatus)currentAuth;//判断是否有相机权限

@end

NS_ASSUME_NONNULL_END
