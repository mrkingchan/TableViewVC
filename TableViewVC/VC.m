//
//  VC.m
//  TableViewVC
//
//  Created by Macx on 2018/4/27.
//  Copyright © 2018年 Chan. All rights reserved.
//

#import "VC.h"

@interface VC ()

@end

@implementation VC

- (void)viewDidLoad {
    [super viewDidLoad];
    for (int i = 0 ; i< 20; i ++) {
        [self.dataArray addObject:[NSString stringWithFormat:@"--%i",i]];
    }
    self.showRefreshHeader = YES;
    self.showRefreshFooter = YES;
    [self tableViewRefreshHeaderAction];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kCellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:kCellID];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableViewRefreshHeaderAction {
    [self tableViewDidFinishTriggerHeader:YES reloadData:YES];
}

- (void)tableViewRefreshFooterAction {
    for (int i = 0; i < 10; i ++) {
        [self.dataArray addObject:[NSString stringWithFormat:@"%i",i]];
    }
    [self tableViewDidFinishTriggerHeader:NO reloadData:YES];
}
@end
