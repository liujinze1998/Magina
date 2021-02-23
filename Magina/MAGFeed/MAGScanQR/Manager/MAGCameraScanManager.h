//
//  MAGCameraScanManager.h
//  Magina
//
//  Created by liujinze on 2021/2/4.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MAGCameraScanManager;

@protocol MAGCameraScanManagerDelegate <NSObject>

// 二维码扫描获取数据的回调方法 (metadataObjects: 扫描二维码数据信息) */
- (void)QRCodeScanManager:(MAGCameraScanManager *)scanManager didOutputMetadataObjects:(NSArray *)metadataObjects;

// 根据光线强弱值回调
- (void)QRCodeScanManager:(MAGCameraScanManager *)scanManager brightnessValue:(CGFloat)brightnessValue;
@end


@interface MAGCameraScanManager : NSObject

@property (nonatomic, weak) id<MAGCameraScanManagerDelegate> delegate;

//懂得都懂嗷
+ (MAGCameraScanManager *)sharedCameraScanManager;

- (void)createCameraSessionWith:(nonnull UIViewController *)currentController;

- (void)startRunning;

- (void)stopRunning;

//SampleBuffer代理 目前用于回调光照
- (void)startSampleBufferDelegate;

- (void)cancelSampleBufferDelegate;

@end

NS_ASSUME_NONNULL_END
