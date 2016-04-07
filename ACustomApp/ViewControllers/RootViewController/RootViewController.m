//
//  RootViewController.m
//  ACustomApp
//
//  Created by Apple on 16/3/29.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "RootViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import "UINavigationBar+Awesome.h"
#import "ActionModel.h"
#import "ActiveTableViewCell.h"
#import "UISearchBar+Common.h"
#import "ZSYPopoverListView.h"
#import "SDCycleScrollView.h"
#import "UITableView+Common.h"
#import "NewsDetailViewController.h"
@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,SDCycleScrollViewDelegate,UISearchDisplayDelegate>
@property (strong, nonatomic) UITableView *mytableView;
@property (strong, nonatomic) UISearchBar *mySearchBar;
@property (strong, nonatomic) UIView *bannerBgView;
@property (strong, nonatomic) UISearchDisplayController *mySearchDisplayController;
@property (copy, nonatomic) NSMutableArray *dataArray;
@property (copy, nonatomic) NSMutableArray *searchArray;

@property (strong, nonatomic) SDCycleScrollView *myBannersView;//Banner
@property (assign, nonatomic) BOOL isSearchButton;



@end

@implementation RootViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];

}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"丝博新闻";
    
    _isSearchButton = NO;
    _dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    _searchArray = [[NSMutableArray alloc] initWithCapacity:0];

//    MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(showLeftSliderVC)];
//    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:
//     YES];
//    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"leftNav"] style:UIBarButtonItemStylePlain target:self action:@selector(showLeftSliderVC)] animated:YES];

    
//    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search_Nav"] style:UIBarButtonItemStylePlain target:self action:@selector(searchItemClicked)] animated:NO];
    
    if (!_mytableView) {
        
        _mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
        _mytableView.delegate = self;
        _mytableView.dataSource = self;
        _mytableView.backgroundColor = [UIColor whiteColor];
        [_mytableView registerClass:[ActiveTableViewCell class] forCellReuseIdentifier:kCellIdentifier_ActiveTableViewCell];
        [self.view addSubview:_mytableView];
    }
    
    
    if (!_mySearchBar) {
        _mySearchBar = ({
            UISearchBar *searchBar = [[UISearchBar alloc] init];
            searchBar.delegate = self;
            [searchBar sizeToFit];
            [searchBar setPlaceholder:@"搜索新闻"];
            [searchBar setTintColor:[UIColor whiteColor]];
            [searchBar insertBGColor:BGCOLOR];
            searchBar;
        });
        _mytableView.tableHeaderView = _mySearchBar;
        [_mySearchBar setY:20];
    }

    _mytableView.contentInset = UIEdgeInsetsMake(-44, 0, 0, 0);


   
//    _mytableView.tableHeaderView = _mySearchBar;
    
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
    model2.image = @"http://m.snrtv.com/v2015/data/thumb/www.snrtv.com/80/2016-03/pic,,attachement,,png,,site1,,20160331,,78e3b59deba11866ba1103((w-640,h-320,q-100,a-0)).png";
    
    [_dataArray addObject:model1];
    [_dataArray addObject:model2];
    [_dataArray addObject:model1];
    [_dataArray addObject:model2];
    [_dataArray addObject:model1];
    [_dataArray addObject:model2];
    [_dataArray addObject:model1];
    [_dataArray addObject:model2];
    
    [_mytableView reloadData];
    
//    [self villageAction];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == _mytableView) {
        return 180;
    }
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == _mytableView) {
        return [self refreshBanner];

    }else{
        return nil;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _mytableView) {
    return _dataArray.count;
     }else{
   return _searchArray.count;
     }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _mytableView) {
    return [ActiveTableViewCell cellHeightWithObj:_dataArray[indexPath.row]];
    }else{
        return [ActiveTableViewCell cellHeightWithObj:_searchArray[indexPath.row]];
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_ActiveTableViewCell forIndexPath:indexPath];
    if (tableView == _mytableView) {
    cell.curModel = _dataArray[indexPath.row];
    }else{
        cell.curModel = _searchArray[indexPath.row];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NewsDetailViewController *vc = [[NewsDetailViewController alloc] init];
    if (tableView == _mytableView) {
    vc.curModel = _dataArray[indexPath.row];
    }else{
        vc.curModel = _searchArray[indexPath.row];
    }
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showLeftSliderVC
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
#pragma mark Banner
- (UIView *)refreshBanner{
    
    NSMutableArray *imagesURLStrings = @[].mutableCopy;
    NSMutableArray *titles = @[].mutableCopy;
    [imagesURLStrings addObject:@"http://m.snrtv.com/v2015/data/thumb/www.snrtv.com/80/2016-03/pic,,attachement,,png,,site1,,20160331,,78e3b59deba11866ba1103((w-640,h-320,q-100,a-0)).png"];
    [imagesURLStrings addObject:@"http://m.snrtv.com/v2015/data/thumb/www.snrtv.com/80/2016-03/pic,,attachement,,png,,site1,,20160331,,78e3b59deba11866ba1103((w-640,h-320,q-100,a-0)).png"];
    [imagesURLStrings addObject:@"http://m.snrtv.com/v2015/data/thumb/www.snrtv.com/80/2016-03/pic,,attachement,,png,,site1,,20160331,,78e3b59deba11866ba1103((w-640,h-320,q-100,a-0)).png"];

    [titles addObject:@"丝绸之路国际电影节"];
    [titles addObject:@"丝绸之路国际电影节"];
    [titles addObject:@"丝绸之路国际电影节"];

     //banner
    if (!_myBannersView) {
        
        _bannerBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
        _bannerBgView.backgroundColor = BGCOLOR;
        
        _myBannersView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 2,SCREEN_WIDTH, 171) imageURLStringsGroup:imagesURLStrings];
        _myBannersView.backgroundColor = [UIColor yellowColor];
        _myBannersView.titlesGroup = titles;
        [_bannerBgView addSubview:_myBannersView];
        
    }
    _myBannersView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _myBannersView.autoScrollTimeInterval = 5.f;
    _myBannersView.delegate = self;
    _myBannersView.dotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    _myBannersView.placeholderImage = [UIImage imageNamed:@"placeholder"];
    return _bannerBgView;
    
}
#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
//    if (_BannerImageArr.count < 1) {
//        return;
//    }
//    NewsDetailViewController *webVC = [[NewsDetailViewController alloc] init];
//    webVC.curModel = _listDic[@"slider"][index];
//    [self.navigationController pushViewController:webVC animated:YES];
    
    NSLog(@"---点击了第%ld张图片", (long)index);
}
#pragma mark Search
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [self searchItemClicked];
    [_mySearchBar insertBGColor:RGBColor(0, 102, 179)];

    return YES;
}
- (void)searchItemClicked{
    
    if (!_mySearchDisplayController) {
        _mySearchDisplayController = ({
            UISearchDisplayController *searchVC = [[UISearchDisplayController alloc] initWithSearchBar:_mySearchBar contentsController:self];
            searchVC.searchResultsTableView.contentInset = UIEdgeInsetsMake(CGRectGetHeight(self.mySearchBar.frame), 0, 44, 0);
            searchVC.searchResultsTableView.tableFooterView = [[UIView alloc] init];
            [searchVC.searchResultsTableView registerClass:[ActiveTableViewCell class] forCellReuseIdentifier:kCellIdentifier_ActiveTableViewCell];
            searchVC.searchResultsDataSource = self;
            searchVC.searchResultsDelegate = self;
           
            searchVC;
        });
    }
    
    
}

#pragma mark - UITableView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float offset = self.mytableView.contentOffset.y;
    if (offset < -20) {
        _mytableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    if (offset > 100) {
        if (_mytableView.contentInset.top == -44) {
            return;
        }
        _mytableView.contentInset = UIEdgeInsetsMake(-44, 0, 0, 0);

    }
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [_mySearchBar insertBGColor:BGCOLOR];

}
-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    
    [searchBar resignFirstResponder];
   
    [_mySearchBar insertBGColor:_isSearchButton ? RGBColor(0, 102, 179) :BGCOLOR];
    _isSearchButton = NO;
    return YES;
}
#pragma mark -
#pragma mark UISearchBarDelegate Support
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    [_mytableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    _isSearchButton = YES;
}


@end
