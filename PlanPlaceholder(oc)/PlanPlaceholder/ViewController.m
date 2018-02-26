//
//  ViewController0.m
//  PlanPlaceholder
//
//  Created by anan on 2017/11/8.
//  Copyright © 2017年 Plan. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *dataArray;
//测试三种数据源方式
@property (nonatomic,assign) NSInteger i;
//记录加载总计数据
@property (nonatomic,assign) NSInteger totoalCount;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"plan";
    self.totoalCount = 8;
    self.i = 0;
    
     // 设置导航栏背景颜色
    [self.navigationController.navigationBar setBackgroundColor:[UIColor lightGrayColor]];
    
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellid"];
}


#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SecondViewController *second = [[SecondViewController alloc]init];
    
    [self.navigationController pushViewController:second animated:YES];
    
}

- (void)loadNewUsers
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        sleep(2);
        // 这里只需要把数据源按照网络请求的去处理就好了
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.dataArray removeAllObjects];
            //模拟网络请求
            if (self.i%3 == 0 ) {
                //空白数据添加占位图
                [self showTableViewPlaceholder:Empty_Holder];
            }else if(self.i%3 == 1){
                //网络异常添加占位图
                [self showTableViewPlaceholder:NoNetwork_Holder];
            }else{
                //正常数据不需要添加
                 [self showTableViewPlaceholder:FillData_holder];
                 [self.dataArray  addObjectsFromArray:@[@"我们",@"为什么总在说努力"]];
            }
            // 结束下拉刷新
            [self.tableView.mj_header endRefreshing];
            
            [self.tableView reloadData];
            self.i ++ ;
         
        });
    });
}

-(void)loadMoreUsers
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        sleep(2);
        dispatch_async(dispatch_get_main_queue(), ^{
         
            [self.dataArray  addObjectsFromArray:@[@"不过是为了",@"遇见自己喜欢的人",@"能够有勇气说一句喜欢你",@"可是自己还没有变优秀",@"他就已经消失在人海",@"再也不见了"]];
            [self.tableView reloadData];
            if (self.dataArray.count == self.totoalCount ) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.tableView.mj_footer endRefreshing];
            }
        });
    });
}

#pragma mark 按钮事件

-(NSMutableArray *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
