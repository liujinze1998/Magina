//
//  MyHeader.h
//  dd
//
//  Created by bytedance on 2020/10/21.
//

#import <UIKit/UIKit.h>
#import "People.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyHeader : UIViewController
@property(nonatomic)People* peo;
@property(nonatomic)UIView* fatherView;
@property(nonatomic)UILabel* nameLab;
@property(nonatomic)UILabel* dNumLab;
@end

NS_ASSUME_NONNULL_END
