//
//  BaseTableViewController1.h
//  PlanPlaceholder
//
//  Created by anan on 2017/11/10.
//  Copyright © 2017年 Plan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

typedef enum{
    Empty_Holder,        //无数据
    NoNetwork_Holder,    //无网络
    FillData_holder      //有数据
    
}PlanPlaceholder;

@interface BaseTableViewController : UIViewController

@property (nonatomic,strong)UITableView *tableView;
////等待视图
//@property (nonatomic,strong)FeHourGlass *hourGlass;

//初次加载数据
- (void)loadNewUsers;

//加载更多数据
- (void)loadMoreUsers;

//数据异常占位图
- (void)showTableViewPlaceholder:(PlanPlaceholder)Placeholder;


@end
