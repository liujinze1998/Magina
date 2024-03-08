//
//  MAGHalfScreenBaseViewController.h
//  Magina
//
//  Created by AM on 2022/10/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MAGHalfScreenBaseViewController : UIViewController



@property (nonatomic, assign) CGFloat containerWidth;
@property (nonatomic, assign) CGFloat containerHeight;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, strong) UIColor *maskColor;
@property (nonatomic) BOOL onlyTopCornerClips;
@property (nonatomic) BOOL isFullScreen;
@property (nonatomic) BOOL isContentViewScroll;// need to set if isContentViewScroll == YES
@property (nonatomic, assign) BOOL disablePanGes;

@property (nonatomic, strong) UIScrollView *contentView;
@property (nonatomic, strong) dispatch_block_t dismissBlock;

@property (nonatomic, readonly) UIView *containerView;
@property (nonatomic, assign, readonly) BOOL isShowing;

- (void)presentViewController:(void(^_Nullable)(void))completion;
- (void)presentOnViewController:(UIViewController *)viewController;
- (void)showOnView:(UIView *)view;
- (void)dismiss;
- (void)dismiss:(void(^)(void))afterDismissBlock;
- (void)dismissWithDuration:(CGFloat)duration afterDismissBlock:(void(^)(void))afterDismissBlock;
- (void)tapDismiss;
- (void)slideDismiss;

- (NSTimeInterval)defaultShowAnimationDuration;
- (NSTimeInterval)defaultHideAnimationDuration;

@end

NS_ASSUME_NONNULL_END
