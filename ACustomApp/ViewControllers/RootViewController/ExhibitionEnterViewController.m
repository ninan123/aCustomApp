//
//  ExhibitionEnterViewController.m
//  ACustomApp
//
//  Created by Apple on 16/3/30.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ExhibitionEnterViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import "ProjectHearderView.h"
#import "ZSYPopoverListView.h"

@interface ExhibitionEnterViewController ()<UITableViewDataSource,UITableViewDelegate,ZSYPopoverListDatasource,ZSYPopoverListDelegate>
@property (strong, nonatomic) UITableView *mytableView;
@property (strong, nonatomic) UIButton *button1;
@property (strong, nonatomic) UIButton *button2;
@property (strong, nonatomic) UITextField *textField;

@property (assign, nonatomic) BOOL isFirstButton;
@property (strong, nonatomic) ZSYPopoverListView *listView1;
@property (strong, nonatomic) ZSYPopoverListView *listView2;

@property (copy, nonatomic) NSArray *cityArr;

@property (copy, nonatomic) NSMutableArray *dataArray;

@end

@implementation ExhibitionEnterViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"参会企业";

    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"leftNav"] style:UIBarButtonItemStylePlain target:self action:@selector(showLeftSliderVC)] animated:YES];
    _cityArr = @[@"北京市",@"天津市",@"重庆市",@"上海市",@"河北省",@"山西省",@"辽宁省",@"吉林省",@"黑龙江省",@"江苏省",@"浙江省",@"安徽省",@"福建省",@"江西省",@"山东省",@"河南省",@"湖北省",@"湖南省",@"广东省",@"海南省",@"四川省",@"贵州省",@"云南省",@"陕西省",@"甘肃省",@"青海省",@"内蒙古自治区",@"广西壮族自治区",@"西藏自治区",@"宁夏回族自治区",@"新疆维吾尔自治区",@"香港特别行政区",@"澳门特别行政区",@"台湾省"];

    
    if (!_mytableView) {
        
        _mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
        _mytableView.delegate = self;
        _mytableView.dataSource = self;
        _mytableView.backgroundColor = [UIColor whiteColor];
        [_mytableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        [self.view addSubview:_mytableView];
    }
    ProjectHearderView *hearderView = [[ProjectHearderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
    [hearderView configFirstSre:@"省份" button1:@"全国" label2:@"企业" button2:@"全部"];
    _mytableView.tableHeaderView = hearderView;
    hearderView.Button1itemDidSelected =^(UIButton *button){
        _button1 = button;
        _isFirstButton = YES;
        [self villageAction];
    };
    hearderView.Button2itemDidSelected =^(UIButton *button){
        _button2 = button;
        _isFirstButton = NO;
        [self villageAction1];
    };
    hearderView.searchButtonitemDidSelected =^(NSString *str){
        [_textField resignFirstResponder];

    };
    hearderView.textFieldBeginEdit =^(UITextField *textField){
        _textField = textField;
    };
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
   cell.textLabel.text = @"西安半导体产业园生产大楼建设项目";
   cell.textLabel.font = [UIFont systemFontOfSize:15.5];
    
    return cell;
}
-(void)showLeftSliderVC
{
    [_textField resignFirstResponder];

    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
-(void)villageAction
{
    
    _listView1 = [[ZSYPopoverListView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-50, SCREEN_HEIGHT-200)];
    _listView1.datasource = self;
    _listView1.delegate = self;
    _listView1.titleName.text = @"请选择省份";
    [_listView1 show];
}
-(void)villageAction1
{
    
    _listView2 = [[ZSYPopoverListView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-60, SCREEN_HEIGHT-200)];
    _listView2.datasource = self;
    _listView2.delegate = self;
    _listView2.titleName.text = @"请选择分类";
    [_listView2 show];
}
#pragma mark -
- (NSInteger)popoverListView:(ZSYPopoverListView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _listView1) {
        return _cityArr.count;
    }
    return 5;
}

- (UITableViewCell *)popoverListView:(ZSYPopoverListView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusablePopoverCellWithIdentifier:identifier];
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (tableView ==_listView1) {
        cell.textLabel.text = _cityArr[indexPath.row];

    }else{
    cell.textLabel.text = [NSString stringWithFormat:@"我是第%ld行",indexPath.row];
    }
    return cell;
}
-(void)popoverListView:(ZSYPopoverListView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)popoverListView:(ZSYPopoverListView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView popoverCellForRowAtIndexPath:indexPath];
    DLog(@"%@",cell.textLabel.text);
    if (_isFirstButton) {
        [_button1 setTitle:cell.textLabel.text forState:UIControlStateNormal];
    }else{
        [_button2 setTitle:cell.textLabel.text forState:UIControlStateNormal];
    }
    [tableView dismiss];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_textField resignFirstResponder];
}
@end
