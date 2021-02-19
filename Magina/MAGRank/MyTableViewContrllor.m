//
//  MyTableViewContrllor.m
//  MyTableView
//
//  Created by bytedance on 2020/10/15.
//

#import "MyTableViewContrllor.h"
#import <Masonry.h>
#import "DataArray.h"
#import "RankData.h"
#import "MyHeaderView.h"
#import "TableViewCell.h"

@interface MyTableViewContrllor ()
@end

@implementation MyTableViewContrllor

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    _header = [[MyHeaderView alloc]init];
    [self.tableView setTableHeaderView:_header];
    self.tableView.rowHeight = 50;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    for(int i=0;i<20;i++){
        [[DataArray sharedInstance] addData];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[DataArray sharedInstance].dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    NSLog(@"he");
    RankData* item = [DataArray sharedInstance].dataList[indexPath.row];
    cell.rankLabel.text = [[NSString alloc] initWithFormat:@"%ld",indexPath.row+1];
    cell.nameLabel.text = item.name;
    NSLog(@"%@",item.name);
    cell.userData.text = [[NSString alloc] initWithFormat:@"%ld",item.dataNumber];
    return cell;
    
    
}

@end
