//
//  ExhibitionHallViewController.m
//  ACustomApp
//
//  Created by Apple on 16/3/30.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ExhibitionHallViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import "GeneralViewCell.h"
@interface ExhibitionHallViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *mytableView;

@property (copy, nonatomic) NSMutableArray *dataArray;

@end

@implementation ExhibitionHallViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"展馆展会";

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
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GeneralViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GeneralViewCell" forIndexPath:indexPath];
//    if (indexPath.row == 0) {
    
        [cell setUpAvatar:@"sousuo" title:@"丝绸之路国际馆" content:@"the insjakl jkniso "];
//    }
    
    return cell;
}
-(void)showLeftSliderVC
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}


@end
