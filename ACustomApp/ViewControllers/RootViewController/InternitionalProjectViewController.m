//
//  InternitionalProjectViewController.m
//  ACustomApp
//
//  Created by Apple on 16/3/30.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "InternitionalProjectViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import "ActionModel.h"
#import "ActiveTableViewCell.h"
#import "ZSYPopoverListView.h"
@interface InternitionalProjectViewController ()<UITableViewDataSource,UITableViewDelegate,ZSYPopoverListDatasource,ZSYPopoverListDelegate>
@property (strong, nonatomic) UITableView *mytableView;
@property (strong, nonatomic) UIButton *seleButton;

@property (copy, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) ZSYPopoverListView  *listView1;

@end

@implementation InternitionalProjectViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"国际项目";

    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"leftNav"] style:UIBarButtonItemStylePlain target:self action:@selector(showLeftSliderVC)] animated:YES];
    
    _dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    if (!_mytableView) {
        
        _mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
        _mytableView.delegate = self;
        _mytableView.dataSource = self;
        _mytableView.backgroundColor = [UIColor whiteColor];
        [_mytableView registerClass:[ActiveTableViewCell class] forCellReuseIdentifier:kCellIdentifier_ActiveTableViewCell];
        [self.view addSubview:_mytableView];
    }
    _mytableView.tableHeaderView = [self setTableHearderView];
    
    ActionModel *model1 = [[ActionModel alloc]init];
    model1.id = @"世博动态";
    model1.content = @"据中国经济网3月30日报道，两会上住建部长陈政高指出，部分二线城市春节后房价";
    model1.title = @"二线城市地价频创新高 房价涨势直逼北上深";
    model1.time = @"2013.12.24";
    model1.classTyle = @"世博动态";
    model1.image = nil;
    
    
    ActionModel *model2 = [[ActionModel alloc]init];
    model2.id = @"心里说得好";
    model2.content = @"月29日下午3点，南京市国土局上演了一场有史以来最激烈的土拍大战，9块地50家房企争抢，四块地王诞生。被誉为准地王的河西G68地块，最终被上海建工经过87轮竞价夺得，楼面地价42561元/㎡，河西未来房价将进入8万元/㎡时代月29日下午3点，南京市国土局上演了一场有史以来最激烈的土拍大战，9块地50家房企争抢，四块地王诞生。被誉为准地王的河西G68地块，最终被上海建工经过87轮竞价夺得，楼面地价42561元/㎡，河西未来房价将进入8万元/㎡时代";
    model2.title = @"多次一天诞生数块“地王” 未来房价将8万元+";
    model2.time = @"2013.12.24";
    model2.classTyle = @"心里说得好";
    model2.image = @"1";
    
    [_dataArray addObject:model1];
    [_dataArray addObject:model2];
    [_dataArray addObject:model2];
    [_dataArray addObject:model2];
    [_dataArray addObject:model2];
    [_dataArray addObject:model2];
    [_dataArray addObject:model2];
    [_dataArray addObject:model2];
    
    [_mytableView reloadData];
    
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ActiveTableViewCell cellHeightWithObj:_dataArray[indexPath.row]];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_ActiveTableViewCell forIndexPath:indexPath];
    cell.curModel = _dataArray[indexPath.row];
    return cell;
}
-(void)showLeftSliderVC
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
-(UIView *)setTableHearderView
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    bgView.backgroundColor = BGCOLOR;
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:whiteView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 40, 25)];
    label.text = @"分类";
    label.textColor = RGBColor(77, 92, 150);
    label.font = [UIFont boldSystemFontOfSize:16];
    [whiteView addSubview:label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(label.right, 30, SCREEN_WIDTH-80, 30);
    [button setTitle:@"全部国家" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [button setTitleColor:RGBColor(77, 92, 150) forState:UIControlStateNormal];
    button.layer.cornerRadius = 3;
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [whiteView addSubview:button];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    button.centerY = label.centerY;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"button点击事件");
        [self villageAction];
    }];
    _seleButton = button;
    
    return bgView;
    
}
-(void)villageAction
{
    
    _listView1 = [[ZSYPopoverListView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-60, SCREEN_HEIGHT/2)];
    _listView1.datasource = self;
    _listView1.delegate = self;
    _listView1.titleName.text = @"请选择分类";
    [_listView1 show];
}

#pragma mark -
- (NSInteger)popoverListView:(ZSYPopoverListView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(void)popoverListView:(ZSYPopoverListView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (UITableViewCell *)popoverListView:(ZSYPopoverListView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusablePopoverCellWithIdentifier:identifier];
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"我是第%ld行",indexPath.row];
    
    return cell;
}

- (void)popoverListView:(ZSYPopoverListView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView popoverCellForRowAtIndexPath:indexPath];
    [_seleButton setTitle:cell.textLabel.text forState:UIControlStateNormal];
    [tableView dismiss];
}

@end
