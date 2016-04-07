//
//  SettingViewController.m
//  ACustomApp
//
//  Created by Apple on 16/3/30.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "SettingViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import "GeneralViewCell.h"
#import "NSTimer+Common.h"
@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *mytableView;

@property (copy, nonatomic) NSMutableArray *dataArray;

@end

@implementation SettingViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"设置";

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
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GeneralViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GeneralViewCell" forIndexPath:indexPath];

        if (indexPath.row == 0) {
    
    [cell setUpAvatar:@"messageAT" title:@"清除缓存" content:@"Clear cache"];
        }else{
            [cell setUpAvatar:@"messageSystem" title:@"版本更新" content:@"Version update"];
 
            
        }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        
        [self showWaittingProgress];
        
        [NSTimer scheduledTimerWithTimeInterval:1.5 block:^{
            [self hideLoadingProgress];
            [self showTosat:@"缓存已清除"];
        } repeats:NO];
    }else{
        
        [self showWaittingProgress];
        
        [NSTimer scheduledTimerWithTimeInterval:1.5 block:^{
            [self hideLoadingProgress];
//            [self showTosat:@"缓存已清除"];
        } repeats:NO];
    }

}
-(void)showLeftSliderVC
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

@end
