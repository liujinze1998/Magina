//
//  MAGUserViewController.h
//  Magina
//
//  Created by liujinze on 2020/10/26.
//

#import <UIKit/UIKit.h>
#import "MyHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface MAGUserViewController : UIViewController

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) NSString *ImaName;
@property (nonatomic,assign) NSInteger num;

@end

NS_ASSUME_NONNULL_END
