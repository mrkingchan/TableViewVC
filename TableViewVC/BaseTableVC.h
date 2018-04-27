//
//  BaseTableVC.h
//  TableViewVC
//
//  Created by Macx on 2018/4/27.
//  Copyright © 2018年 Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableVC : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,assign) BOOL showRefreshHeader;

@property(nonatomic,assign) BOOL showRefreshFooter;


/**
 初始化构造方法

 @param style tableView的格式
 @return
 */
- (instancetype)initWithStyle:(UITableViewStyle)style;


/**
  头部刷新方法
 */
- (void)tableViewRefreshHeaderAction;


/**
 尾部刷新方法
 */
- (void)tableViewRefreshFooterAction;


/**
 是否是头部 下拉刷新结束处理

 @param isHeader 是否是header
 @param reloadData 是否刷新数据源 
 */
- (void)tableViewDidFinishTriggerHeader:(BOOL)isHeader reloadData:(BOOL)reloadData;


@end
