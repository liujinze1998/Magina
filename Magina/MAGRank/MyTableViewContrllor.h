//
//  MyTableViewContrllor.h
//  MyTableView
//
//  Created by bytedance on 2020/10/15.
//

#import <UIKit/UIKit.h>
#import "MyHeaderView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyTableViewContrllor : UITableViewController

@property(nonatomic , strong)MyHeaderView *header;

-(instancetype)init;

-(instancetype)initWithStyle:(UITableViewStyle)style;

@end

NS_ASSUME_NONNULL_END
