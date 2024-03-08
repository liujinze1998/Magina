//
//  MAGHalfScreenCellData.h
//  Magina
//
//  Created by AM on 2022/10/10.
//

#import <Foundation/Foundation.h>

@interface MAGHalfScreenCellData : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, assign) NSInteger number;

@end

@interface MAGHalfScreenVCInputData : NSObject

@property (nonatomic, copy) NSArray<MAGHalfScreenCellData *> *itemsArray;

@end
