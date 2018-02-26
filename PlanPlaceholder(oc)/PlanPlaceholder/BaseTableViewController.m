//
//  BaseTableViewController1.m
//  PlanPlaceholder
//
//  Created by anan on 2017/11/10.
//  Copyright © 2017年 Plan. All rights reserved.
//

#import "BaseTableViewController.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define IS_IPHONEX (([[UIScreen mainScreen] bounds].size.height-812)?NO:YES)
#define Height (IS_IPHONEX ? ([[UIScreen mainScreen] bounds].size.height-34):([[UIScreen mainScreen] bounds].size.height))
#define NavHeight (IS_IPHONEX ? (88):(64))

@interface BaseTableViewController ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

//显示空数据页面 默认不显示
@property(nonatomic,assign) BOOL isDisplayEmptyData;

//空数据页面title
@property(nonatomic,copy) NSString *emptyDataTitle;

//空数据页面的图片
@property(nonatomic,copy) NSString *emptyDataImage;

//空数据页面详情title
@property(nonatomic,copy) NSString *emptyDataDetail;

//占位按钮标题、图片二选一
@property(nonatomic,copy) NSString *buttonTitle;

@property(nonatomic,copy) NSString *buttonImageName;

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}

-(void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.isDisplayEmptyData = NO;
    // 让用户表格进入下拉刷新状态
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)showTableViewPlaceholder:(PlanPlaceholder)Placeholder
{
    
    self.isDisplayEmptyData = YES;
    if (Placeholder == Empty_Holder)
    {
        self.emptyDataImage = @"empty";
        self.emptyDataTitle = @"暂时没有数据!";
        self.buttonTitle = @"点击刷新";
       
    }else if (Placeholder == NoNetwork_Holder)
    {
        self.emptyDataImage = @"noNetwork";
        self.emptyDataTitle = @"网络环境异常！";
        self.buttonTitle = @"点击刷新";
        
    }else
    {
         self.isDisplayEmptyData = NO;
         self.tableView.mj_footer.hidden = NO;
    }
    
}

- (void)loadNewUsers
{
   
}

-(void)loadMoreUsers
{
}

#pragma mark - DZNEmptyDataSetSource Methods
//主标题
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = self.emptyDataTitle?self.emptyDataTitle:@"亲，暂时没有数据!";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName: [UIColor grayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

//标题详情
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = self.emptyDataDetail;
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return self.emptyDataDetail?[[NSAttributedString alloc] initWithString:text attributes:attributes]:nil;
}

//空数据页面的图片
-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.emptyDataImage)
    {
        return [UIImage imageNamed:[NSString stringWithFormat:@"Planplaceholder.bundle/%@",self.emptyDataImage]];
    }
      return [UIImage imageNamed:@"nodata"];

}

- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;

    return animation;
}

//返回点击的按钮 上面带文字
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName: [UIColor blackColor],
                                 NSStrokeColorAttributeName:[UIColor  redColor],
                                 };
    
    return self.buttonTitle?[[NSAttributedString alloc] initWithString:self.buttonTitle attributes:attributes]:nil;
}

//返回点击的按钮 上面带图片
- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{

    return self.buttonImageName?[UIImage imageNamed:self.buttonImageName]:nil;

}

//返回空白区域的颜色自定义
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{

    return  [UIColor whiteColor];
}


//调整垂直对齐的内容视图(即:有用tableHeaderView时可见):
//返回间距离
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return 0;
    
}

//设置空白页title、description、button等的竖直间隔
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView{

    return  20;
}


#pragma mark - DZNEmptyDataSetDelegate Methods

//空白占位视图是否要显示(默认YES)
- (BOOL)emptyDataSetShouldFadeIn:(UIScrollView *)scrollView{

    return  YES;
}

//要求知道空的状态应该渲染和显示 ( 默认YES) :
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return self.isDisplayEmptyData;
    
}
//是否允许点击 (默认YES)
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}
//是否允许滚动 (默认NO)
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

//占位图片是否动态
- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView
{
    return NO;
}

//空白区域点击事件
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
}

//按钮响应时间
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    [self emptyDataButtonClick];
}

#pragma mark 按钮事件
-(void)emptyDataButtonClick
{
    NSLog(@"点击了按钮");
    [self.tableView.mj_header beginRefreshing];

}

-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, NavHeight, SCREEN_WIDTH, Height-NavHeight)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor =[UIColor whiteColor];
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
        
    }
    return _tableView;
}


@end
