
//
//  BaseTableVC.m
//  TableViewVC
//
//  Created by Macx on 2018/4/27.
//  Copyright © 2018年 Chan. All rights reserved.
//

#import "BaseTableVC.h"
#import <MJRefresh/MJRefresh.h>
#import <ReactiveCocoa.h>
#define iPhoneX_BOTTOM_HEIGHT  ([UIScreen mainScreen].bounds.size.height==812?34:0)
#define kCellDefaultHeight 60

@interface BaseTableVC () {
    UITableViewStyle _style;
}

@end

@implementation BaseTableVC

-(instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _style = style;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray new];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    if (@available(iOS 11.0, *)) {
        self.additionalSafeAreaInsets = UIEdgeInsetsMake(0, 0, iPhoneX_BOTTOM_HEIGHT, 0);
    }
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:_style];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    
    [self setShowRefreshHeader:NO];
    [self setShowRefreshFooter:NO];
}


- (void)setShowRefreshHeader:(BOOL)showRefreshHeader {
    _showRefreshHeader = showRefreshHeader;
    if (showRefreshHeader) {
        @weakify(self);
        [self->_tableView  addLegendHeaderWithRefreshingBlock:^{
            @strongify(self);
            [self tableViewRefreshHeaderAction];
        }];
        [self tableViewDidFinishTriggerHeader:YES reloadData:YES];
    }
}

- (void)setShowRefreshFooter:(BOOL)showRefreshFooter {
    _showRefreshFooter = showRefreshFooter;
    if (showRefreshFooter) {
        @weakify(self);
        [_tableView addLegendFooterWithRefreshingBlock:^{
            @strongify(self);
            [self tableViewRefreshFooterAction];
        }];
        [self tableViewDidFinishTriggerHeader:NO reloadData:YES];
    }
}

#pragma mark  -- 交给子类去重写
- (void)tableViewRefreshHeaderAction {
    
}

- (void)tableViewRefreshFooterAction {
    
}

- (void)tableViewDidFinishTriggerHeader:(BOOL)isHeader reloadData:(BOOL)reloadData {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (isHeader) {
            [_tableView.header endRefreshing];
        } else {
            [_tableView.footer endRefreshing];
        }
        if (reloadData) {
            [_tableView reloadData];
        }
    });
}

#pragma mark  -- UITableViewDataSource &Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kCellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kCellDefaultHeight;
}
@end
