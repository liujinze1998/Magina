//
//  MAGCaptureAlbumManager.h
//  Magina
//
//  Created by liujinze on 2021/2/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol MAGImagePickerDelegate <NSObject>

- (void)didFinishPickingImage:(nullable UIImage *)image;

@end

NS_ASSUME_NONNULL_BEGIN

@interface MAGCaptureAlbumManager : NSObject

+ (instancetype)sharedManager;

@property (nonatomic, weak) id<MAGImagePickerDelegate> delegate;

@property (nonatomic, assign) BOOL isPHAuthorization;
@property (nonatomic, assign) BOOL isApplyingAuthorization;

- (void)replaceImageFromAlbumWithCurrentController:(UIViewController *)currentVC;
- (void)replaceImageFromCaptureWithCurrentController:(UIViewController *)currentVC;

@end

NS_ASSUME_NONNULL_END
