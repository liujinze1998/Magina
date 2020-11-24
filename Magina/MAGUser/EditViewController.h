//
//  EditViewController.h
//  dd
//
//  Created by bytedance on 2020/10/21.
//

#import <UIKit/UIKit.h>
#import "People.h"
NS_ASSUME_NONNULL_BEGIN

@interface EditViewController : UIViewController
@property(nonatomic)People* peo;
@property(nonatomic)UITextField* nameTF;
@property(nonatomic)UITextField* dNumTF;
@property(nonatomic)UILabel* nameLab;
@property(nonatomic)UILabel* dNum;

@end

NS_ASSUME_NONNULL_END
