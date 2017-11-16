//
//  SecondViewController.m
//  PlanPlaceholder
//
//  Created by anan on 2017/11/13.
//  Copyright © 2017年 Plan. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"planSecond";
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
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
    static NSString *identifier = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)loadNewUsers
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        sleep(2);
        // Update UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.dataArray removeAllObjects];
            [self.dataArray  addObjectsFromArray:@[@"哪有那么多说走就走的旅行",@"你羡慕的一切",@"只不过是别人的有备而来的假象罢了",@"向往旅行",@"也羡慕远方",@"可是最起码你得先学会出发啊"]];
            // 结束下拉刷新
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
            
        });
    });
}

-(void)loadMoreUsers
{
    sleep(2);
    
    [self.tableView.mj_footer endRefreshing];
    
    
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
