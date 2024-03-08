//
//  MAGCameraScanManager.m
//  Magina
//
//  Created by AM on 2021/2/4.
//

#import "MAGCameraScanManager.h"
#import <AVFoundation/AVFoundation.h>
#import "MAGUIConfigCenter.h"

@interface MAGCameraScanManager () <AVCaptureMetadataOutputObjectsDelegate, AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureDeviceInput *deviceInput;
@property (nonatomic, strong) AVCaptureMetadataOutput *metadataOutput;
@property (nonatomic, strong) AVCaptureVideoDataOutput *videoDataOutput;

@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;


@property (nonatomic, assign) BOOL enableScan;
@property (nonatomic, assign) BOOL hasZoomed;

@end

@implementation MAGCameraScanManager

+ (MAGCameraScanManager *)sharedCameraScanManager
{
    static MAGCameraScanManager *cameraManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cameraManager = [[MAGCameraScanManager alloc] init];
    });
    return cameraManager;
}


- (void)createCameraSessionWith:(nonnull UIViewController *)currentController
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    if (!device || !self.deviceInput) {
        //设备有毛病
        return;
    }
    
    self.session = [[AVCaptureSession alloc] init];
    self.session.sessionPreset = AVCaptureSessionPresetPhoto;
    [self.session addInput:self.deviceInput];
    
    self.metadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [self.session addOutput:self.metadataOutput]; //识别数据输出
    [self.metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    self.metadataOutput.rectOfInterest = CGRectMake(scanBorderY/ kScreenHeight, scanBorderX / kScreenWidth, scanAreaX / kScreenHeight , scanAreaX / kScreenWidth);
    // 数据输出类型，扫码支持的编码格式(如下设置条形码和二维码兼容)
    NSArray *metadateArray = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    self.metadataOutput.metadataObjectTypes = metadateArray;
    
    self.videoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
    [self.session addOutput:self.videoDataOutput]; //识别光线强弱
    [self.videoDataOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];

    self.videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.videoPreviewLayer.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [currentController.view.layer insertSublayer:self.videoPreviewLayer atIndex:0];

    [self startRunning];
}


#pragma mark - 识别输出
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (!self.enableScan) {
        return;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(QRCodeScanManager:didOutputMetadataObjects:)]) {
        [self.delegate QRCodeScanManager:self didOutputMetadataObjects:metadataObjects];
    }
}

#pragma mark - 回调光亮值
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    CFDictionaryRef metadataDict = CMCopyDictionaryOfAttachments(NULL, sampleBuffer, kCMAttachmentMode_ShouldPropagate);
    NSDictionary *metadata = [[NSMutableDictionary alloc] initWithDictionary:(__bridge NSDictionary*)metadataDict];
    CFRelease(metadataDict);
    NSDictionary *exifMetadata = [[metadata objectForKey:(NSString *)kCGImagePropertyExifDictionary] mutableCopy];
    float brightnessValue = [[exifMetadata objectForKey:(NSString *)kCGImagePropertyExifBrightnessValue] floatValue];

    if (self.delegate && [self.delegate respondsToSelector:@selector(QRCodeScanManager:brightnessValue:)]) {
        [self.delegate QRCodeScanManager:self brightnessValue:brightnessValue];
    }
}

- (void)startRunning
{
    self.enableScan = YES;
    [self.videoPreviewLayer setAffineTransform:CGAffineTransformIdentity];
    self.hasZoomed = NO;
    if (![self.session isRunning]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.session startRunning];
        });
    }
}

- (void)stopRunning
{
    self.enableScan = NO;
    if ([self.session isRunning]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.session stopRunning];
        });
    }
}

- (void)startSampleBufferDelegate
{
    [self.videoDataOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
}

- (void)cancelSampleBufferDelegate
{
    [self.videoDataOutput setSampleBufferDelegate:nil queue:dispatch_get_main_queue()];
}

@end
