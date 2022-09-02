//
//  MAGCaptureAlbumManager.m
//  Magina
//
//  Created by liujinze on 2021/2/22.
//

#import "MAGCaptureAlbumManager.h"
#import "MAGDeviceAuth.h"

#import <MobileCoreServices/MobileCoreServices.h>
#import <Photos/Photos.h>

@interface MAGCaptureAlbumManager () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, weak) UIViewController *currentVC;

@end

@implementation MAGCaptureAlbumManager

+ (instancetype)sharedManager
{
    static MAGCaptureAlbumManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MAGCaptureAlbumManager alloc] init];
    });
    return manager;
}

//打开相册
- (void)replaceImageFromAlbumWithCurrentController:(UIViewController *)currentVC
{
    self.currentVC = currentVC;
    if (currentVC == nil) {
        NSLog(@"打开相册父view是空");
        return;
    }
    
    [MAGDeviceAuth requestPhotoLibraryPermission:^(BOOL success) {
        if (success) {
            [self enterSelectAlbumController];
        } else {
            UIAlertController *photoPermissionAlert =  [UIAlertController alertControllerWithTitle:@"提醒" message:@"相册权限被禁用，请到设置中授予Magina允许访问相册权限" preferredStyle:UIAlertControllerStyleAlert];
            [photoPermissionAlert addAction:[UIAlertAction actionWithTitle:@"立即去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
            }]];
            [photoPermissionAlert addAction:[UIAlertAction actionWithTitle:@"之后自己设置" style:UIAlertActionStyleDefault handler:nil]];
            [self.currentVC presentViewController:photoPermissionAlert animated:YES completion:nil];
        }
    }];
}

//打开相机
- (void)replaceImageFromCaptureWithCurrentController:(UIViewController *)currentVC
{
    self.currentVC = currentVC;
    if (currentVC == nil) {
        NSLog(@"打开相机的父view是空");
        return;
    }
    if ([MAGDeviceAuth currentAuth] == AVAuthorizationStatusNotDetermined){
        __weak typeof(self) weakSelf = self;
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                [strongSelf enterCaptureController];
            }
        }];
    } else if ([MAGDeviceAuth currentAuth] == AVAuthorizationStatusAuthorized){
        [self enterCaptureController];
    } else {
        NSString *messageText = @"请在iPhone的“设置”-“隐私”-“相机”功能中，找到“Magina”打开相机访问权限";
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"相机无权限" message:messageText preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil]];
        [self.currentVC presentViewController:alertController animated:YES completion:nil];
        return;
    }
}

- (void)enterSelectAlbumController
{
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        NSLog(@"不支持相册图库");
        return;
    }
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    imagePicker.navigationBar.translucent = NO;
    [self.currentVC presentViewController:imagePicker animated:YES completion:nil];
}

- (void)enterCaptureController
{
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        NSLog(@"不支持相机");
        return;
    }
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.allowsEditing = NO;//拍完编辑
    imagePicker.showsCameraControls = YES;//系统工具
    imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;//后置摄像头
    imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
    imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
    imagePicker.navigationBar.translucent = NO;//使导航栏背景色无偏差 无毛玻璃效果
    imagePicker.delegate = self;
    [self.currentVC presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - imagePickerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        [PHAssetChangeRequest creationRequestForAssetFromImage:image];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        NSLog(@"success = %d, error = %@", success, error);
    }];
    [self.currentVC dismissViewControllerAnimated:YES completion:^{
        if (self.delegate && [self.delegate respondsToSelector:@selector(didFinishPickingImage:)]) {
            [self.delegate didFinishPickingImage:image];
        }
    }];
}


#pragma mark

@end
