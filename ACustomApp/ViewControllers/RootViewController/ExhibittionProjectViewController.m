//
//  ExhibittionProjectViewController.m
//  ACustomApp
//
//  Created by Apple on 16/3/30.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ExhibittionProjectViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import "ProjectHearderView.h"
#import "ZSYPopoverListView.h"

@interface ExhibittionProjectViewController ()<UITableViewDataSource,UITableViewDelegate,ZSYPopoverListDatasource,ZSYPopoverListDelegate>
@property (strong, nonatomic) UITableView *mytableView;
@property (strong, nonatomic) ZSYPopoverListView  *listView1;
@property (copy, nonatomic) NSMutableArray *dataArray;
@property (assign, nonatomic) BOOL isFirstButton;
@property (strong, nonatomic) UIButton *button1;
@property (strong, nonatomic) UIButton *button2;
@property (strong, nonatomic) UITextField *textField;

@end

@implementation ExhibittionProjectViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"参会项目";
    
    _isFirstButton = YES;

    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"leftNav"] style:UIBarButtonItemStylePlain target:self action:@selector(showLeftSliderVC)] animated:YES];

    if (!_mytableView) {
        
        _mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
        _mytableView.delegate = self;
        _mytableView.dataSource = self;
        _mytableView.backgroundColor = [UIColor whiteColor];
        [_mytableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        [self.view addSubview:_mytableView];
    }
    ProjectHearderView *hearderView = [[ProjectHearderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
    [hearderView configFirstSre:@"省份" button1:@"全国" label2:@"领域" button2:@"全部"];
    _mytableView.tableHeaderView = hearderView;
    hearderView.Button1itemDidSelected =^(UIButton *button){
        _button1 = button;
        _isFirstButton = YES;
        [self villageAction];
    };
    hearderView.Button2itemDidSelected =^(UIButton *button){
        _button2 = button;
        _isFirstButton = NO;
        [self villageAction];

    };
    hearderView.searchButtonitemDidSelected =^(NSString *str){
        [_textField resignFirstResponder];

        DLog(@"%@",str);
    };
    hearderView.textFieldBeginEdit =^(UITextField *textField){
        _textField = textField;
        DLog(@"%@",_textField.text);
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
    
    cell.textLabel.text = @"第十九届西洽会思博会陕西省企业名录";
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
    
    _listView1 = [[ZSYPopoverListView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-60, 300)];
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
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_textField resignFirstResponder];
}
@end
