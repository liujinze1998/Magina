//
//  MAGDeviceAuth.m
//  Magina
//
//  Created by liujinze on 2021/2/22.
//

#import "MAGDeviceAuth.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

static NSInteger currentPhotoLibrayAuthorizationStatus = PHAuthorizationStatusNotDetermined;

@implementation MAGDeviceAuth

+ (void)requestPhotoLibraryPermission:(void(^)(BOOL success))completion
{
    if (currentPhotoLibrayAuthorizationStatus == PHAuthorizationStatusNotDetermined) {
        currentPhotoLibrayAuthorizationStatus = [PHPhotoLibrary authorizationStatus];
    }
    PHAuthorizationStatus status = (PHAuthorizationStatus)currentPhotoLibrayAuthorizationStatus;
    switch (status) {
        case PHAuthorizationStatusNotDetermined: {
            //没决定就请求一波
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    switch (status) {
                        case PHAuthorizationStatusAuthorized: {
                            if (completion) {
                                completion(YES);
                            }
                            break;
                        }
                        case PHAuthorizationStatusNotDetermined:
                        case PHAuthorizationStatusRestricted:
                        case PHAuthorizationStatusDenied:
                        default: {
                            if (completion) {
                                completion(NO);
                            }
                        }
                    }
                });
            }];
            break;
        }
        case PHAuthorizationStatusAuthorized: {
            //给过授权了
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    completion(YES);
                }
            });
            break;
        }
        case PHAuthorizationStatusRestricted:
        case PHAuthorizationStatusDenied:
        default: {
            //没权限
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    completion(NO);
                }
            });
        }
    }
}

+ (AVAuthorizationStatus)currentAuth
{
    return [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
}

@end
