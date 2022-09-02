//
//  MAGAlertView.h
//  Magina
//
//  Created by liujinze on 2021/7/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MAGAlertView : UIView

+ (void)showAlertOnView:(UIView *)view
              withTitle:(nullable NSString *)title
     confirmButtonTitle:(nullable NSString *)confirmTitle
      cancelButtonTitle:(nullable NSString *)cancelTitle
           confirmBlock:(nullable dispatch_block_t)actionBlock
            cancelBlock:(nullable dispatch_block_t)cancelBlock;

@end

NS_ASSUME_NONNULL_END
