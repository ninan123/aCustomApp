//
//  YLNavigationViewController.m
//  SXTV
//
//  Created by Apple on 15/12/24.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "YLNavigationViewController.h"

@interface YLNavigationViewController ()

@end

@implementation YLNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
/**
 *  系统在第一次使用这个类的时候调用(1个类只会调用一次)
 */
+ (void)initialize
{
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    [navigationBarAppearance setBackgroundImage:[UIImage imageWithColor:RGBColor(0, 102, 179)] forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTintColor:[UIColor whiteColor]];//返回按钮的箭头颜色
    NSDictionary *textAttributes = @{
                                     NSFontAttributeName: [UIFont boldSystemFontOfSize:19],
                                     NSForegroundColorAttributeName: [UIColor whiteColor],
                                     };
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
    
    [[UITextField appearance] setTintColor:[UIColor colorWithHexString:@"0x3bbc79"]];//设置UITextField的光标颜色
    [[UITextView appearance] setTintColor:[UIColor colorWithHexString:@"0x3bbc79"]];//设置UITextView的光标颜色
    [[UISearchBar appearance] setBackgroundImage:[UIImage imageWithColor:kColorTableSectionBg] forBarPosition:0 barMetrics:UIBarMetricsDefault];
    
    
}

/**
 *  重写这个方法,能拦截所有的push操作
 *
 */
//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    viewController.hidesBottomBarWhenPushed = YES;
//    [super pushViewController:viewController animated:animated];
//}

@end
