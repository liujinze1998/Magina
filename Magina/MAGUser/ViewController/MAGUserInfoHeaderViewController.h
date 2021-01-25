//
//  MAGUserInfoHeaderViewController.h
//  dd
//
//  Created by bytedance on 2020/10/21.
//

#import <UIKit/UIKit.h>
#import "People.h"
NS_ASSUME_NONNULL_BEGIN

@interface MAGUserInfoHeaderViewController : UIViewController

@property (nonatomic) UILabel *nameLab;
@property (nonatomic) UILabel *dNumLab;

- (instancetype)initWithParentView:(UIView *)view navHeight:(CGFloat)height;
- (void)homePageDidScroll:(CGFloat)dropValue;

@end

NS_ASSUME_NONNULL_END
