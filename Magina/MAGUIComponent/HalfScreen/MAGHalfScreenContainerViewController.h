//
//  MAGHalfScreenContainerViewController.h
//  Magina
//
//  Created by AM on 2022/10/10.
//

#import "MAGHalfScreenBaseViewController.h"
#import "MAGHalfScreenCellData.h"

typedef void (^MAGHalfScreenContainerSelectBlock)(NSInteger number);

@interface MAGHalfScreenContainerViewController : MAGHalfScreenBaseViewController

@property (nonatomic, copy) MAGHalfScreenContainerSelectBlock selectBlock;
- (instancetype)initWithInputData:(MAGHalfScreenVCInputData *)inputData;

@end
