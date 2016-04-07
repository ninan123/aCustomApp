//
//  BusinessServicesViewController.m
//  ACustomApp
//
//  Created by Apple on 16/3/30.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "BusinessServicesViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import "GeneralViewCell.h"
@interface BusinessServicesViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *mytableView;

@property (copy, nonatomic) NSMutableArray *dataArray;

@end

@implementation BusinessServicesViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"会员服务";

    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"leftNav"] style:UIBarButtonItemStylePlain target:self action:@selector(showLeftSliderVC)] animated:YES];

    
    if (!_mytableView) {
        
        _mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
        _mytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mytableView.delegate = self;
        _mytableView.dataSource = self;
        _mytableView.backgroundColor = [UIColor whiteColor];
        [_mytableView registerNib:[UINib nibWithNibName:@"GeneralViewCell" bundle:nil] forCellReuseIdentifier:kCellIdentifier_GeneralViewCell];
        [self.view addSubview:_mytableView];
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GeneralViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GeneralViewCell" forIndexPath:indexPath];
        if (indexPath.row == 0) {
    
    [cell setUpAvatar:@"messageAT" title:@"工作机构" content:@"Working machanism"];
        }else if (indexPath.row == 1) {
            
            [cell setUpAvatar:@"messageAT" title:@"服务指南" content:@"Service Information"];
        }else if (indexPath.row == 2) {
            
            [cell setUpAvatar:@"messageAT" title:@"展位分布" content:@"Booth distribution"];
        }else if (indexPath.row == 3) {
            
            [cell setUpAvatar:@"messageAT" title:@"证件管理" content:@"Document management"];
        }else if (indexPath.row == 4) {
            
            [cell setUpAvatar:@"messageAT" title:@"参展须知" content:@"Notice of participation"];
        }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)showLeftSliderVC
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}


@end
