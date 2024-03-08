//
//  MAGTextEditAlertView.h
//  Magina
//
//  Created by AM on 2021/7/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef BOOL(^TextEditConfirmAction)(NSString *content);

@interface MAGTextEditAlertView : UIView

@property (nonatomic, copy) TextEditConfirmAction confirmAction;
@property (nonatomic, copy) dispatch_block_t cancelAction;

+ (void)showAlertOnView:(UIView *)view
              withTitle:(nullable NSString *)title
     confirmButtonTitle:(nullable NSString *)confirmTitle
      cancelButtonTitle:(nullable NSString *)cancelTitle
           confirmBlock:(TextEditConfirmAction)actionBlock
            cancelBlock:(nullable dispatch_block_t)cancelBlock;

@end

NS_ASSUME_NONNULL_END
