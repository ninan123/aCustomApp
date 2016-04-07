//
//  Root_LeftViewController.m
//  ACustomApp
//
//  Created by Apple on 16/3/30.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "Root_LeftViewController.h"
#import "LeftSliderCell.h"
#import "LeftSliderMainCell.h"
#import "YLNavigationViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import "RootViewController.h"
#import "GeneralIntroViewController.h"
#import "ConferenceActViewController.h"
#import "ExhibitionHallViewController.h"
#import "ExhibitionEnterViewController.h"
#import "ExhibittionProjectViewController.h"
#import "InternitionalProjectViewController.h"
#import "GeneralAssViewController.h"
#import "BusinessServicesViewController.h"
#import "SettingViewController.h"

@interface Root_LeftViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *mytableView;

@end

@implementation Root_LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    if (!_mytableView) {
        
        _mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _mytableView.delegate = self;
        _mytableView.dataSource = self;
        _mytableView.backgroundColor = RGBColor(0, 102, 179);
        [_mytableView registerNib:[UINib nibWithNibName:@"LeftSliderCell" bundle:nil] forCellReuseIdentifier:kCellIdentifier_LeftSliderCell];
        [_mytableView registerNib:[UINib nibWithNibName:@"LeftSliderMainCell" bundle:nil] forCellReuseIdentifier:kCellIdentifier_LeftSliderMainCell];

        [self.view addSubview:_mytableView];
        _mytableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    }


}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        LeftSliderMainCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_LeftSliderMainCell forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else{
    
    LeftSliderCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_LeftSliderCell forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        if (indexPath.row == 1) {
            
            [cell setImage:[UIImage imageNamed:@"left2"] andTitle:@"大会简介" EnTitle:@"General introduction"];
        }else if (indexPath.row == 2) {
            
            [cell setImage:[UIImage imageNamed:@"left3"] andTitle:@"大会活动" EnTitle:@"Conference activities"];
        }else if (indexPath.row == 3) {
            
            [cell setImage:[UIImage imageNamed:@"left4"] andTitle:@"展馆展会" EnTitle:@"Exhibition hall"];
        }else if (indexPath.row == 4) {
            
            [cell setImage:[UIImage imageNamed:@"left5"] andTitle:@"参展企业" EnTitle:@"Exhibition enterprises"];
        }else if (indexPath.row == 5) {
            
            [cell setImage:[UIImage imageNamed:@"left6"] andTitle:@"参会项目" EnTitle:@"Exhibition project"];
        }
//        else if (indexPath.row == 6) {
//            
//            [cell setImage:[UIImage imageNamed:@"left7"] andTitle:@"国际项目" EnTitle:@"International Project"];
//        }
        else if (indexPath.row == 6) {
            
            [cell setImage:[UIImage imageNamed:@"left7"] andTitle:@"大会动态" EnTitle:@"General assembly dynamic"];
        }else if (indexPath.row == 7) {
            
            [cell setImage:[UIImage imageNamed:@"left8"] andTitle:@"会员服务" EnTitle:@"Business services"];
        }else if (indexPath.row == 8) {
            
            [cell setImage:[UIImage imageNamed:@"left9"] andTitle:@"系统设置" EnTitle:@"System Setup"];
        }
    
    return cell;
        
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

      if (indexPath.row == 1) {
          //大会简介
          GeneralIntroViewController * vc = [[GeneralIntroViewController alloc] init];
          YLNavigationViewController * navC = [[YLNavigationViewController alloc] initWithRootViewController:vc];
          [self.mm_drawerController setCenterViewController:navC withCloseAnimation:YES completion:nil];
          
      }else if (indexPath.row == 2) {
           //大会活动
          ConferenceActViewController * vc = [[ConferenceActViewController alloc] init];
          YLNavigationViewController * navC = [[YLNavigationViewController alloc] initWithRootViewController:vc];
          [self.mm_drawerController setCenterViewController:navC withCloseAnimation:YES completion:nil];
          
      }else if (indexPath.row == 3) {
           //展览展会
          ExhibitionHallViewController * vc = [[ExhibitionHallViewController alloc] init];
          YLNavigationViewController * navC = [[YLNavigationViewController alloc] initWithRootViewController:vc];
          [self.mm_drawerController setCenterViewController:navC withCloseAnimation:YES completion:nil];
          
      }else if (indexPath.row == 4) {
           //参会企业
          ExhibitionEnterViewController * vc = [[ExhibitionEnterViewController alloc] init];
          YLNavigationViewController * navC = [[YLNavigationViewController alloc] initWithRootViewController:vc];
          [self.mm_drawerController setCenterViewController:navC withCloseAnimation:YES completion:nil];
          
      }else if (indexPath.row == 5) {
           //参会项目
          ExhibittionProjectViewController * vc = [[ExhibittionProjectViewController alloc] init];
          YLNavigationViewController * navC = [[YLNavigationViewController alloc] initWithRootViewController:vc];
          [self.mm_drawerController setCenterViewController:navC withCloseAnimation:YES completion:nil];
          
      }
//      else if (indexPath.row == 6) {
//           //国际项目
//          InternitionalProjectViewController * vc = [[InternitionalProjectViewController alloc] init];
//          YLNavigationViewController * navC = [[YLNavigationViewController alloc] initWithRootViewController:vc];
//          [self.mm_drawerController setCenterViewController:navC withCloseAnimation:YES completion:nil];
//          
//      }
      else if (indexPath.row == 6) {
           //大会动态
          GeneralAssViewController * vc = [[GeneralAssViewController alloc] init];
          YLNavigationViewController * navC = [[YLNavigationViewController alloc] initWithRootViewController:vc];
          [self.mm_drawerController setCenterViewController:navC withCloseAnimation:YES completion:nil];
          
      }else if (indexPath.row == 7) {
           //会员服务
          BusinessServicesViewController * vc = [[BusinessServicesViewController alloc] init];
          YLNavigationViewController * navC = [[YLNavigationViewController alloc] initWithRootViewController:vc];
          [self.mm_drawerController setCenterViewController:navC withCloseAnimation:YES completion:nil];
          
      }else if (indexPath.row == 8) {
           //设置
          SettingViewController * vc = [[SettingViewController alloc] init];
          YLNavigationViewController * navC = [[YLNavigationViewController alloc] initWithRootViewController:vc];
          [self.mm_drawerController setCenterViewController:navC withCloseAnimation:YES completion:nil];
          
      }else if (indexPath.row == 0) {
          //首页
          RootViewController *vc = [[RootViewController alloc] init];
          YLNavigationViewController * navC = [[YLNavigationViewController alloc] initWithRootViewController:vc];
          [self.mm_drawerController setCenterViewController:navC withCloseAnimation:YES completion:nil];
      }
    
}

@end
