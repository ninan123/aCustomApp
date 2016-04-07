//
//  BaseViewController.m
//  hothot
//
//  Created by 张国平 on 15/11/17.
//  Copyright © 2015年 zgp. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] == 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone ;
    }
    
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    
    UIBarButtonItem *backItem=[[UIBarButtonItem alloc]init];
    backItem.title=@"返回";
    backItem.tintColor=[UIColor colorWithRed:129/255.0 green:129/255.0  blue:129/255.0 alpha:1.0];
    self.navigationItem.backBarButtonItem = backItem;
    
}

- (void)showTosat:(NSString *)str
{
    [self.view makeToast:[NSString stringWithFormat:@"%@",str]];
}

- (void)showLoadingProgress
{
    [self performSelectorOnMainThread:@selector(showLPV) withObject:nil waitUntilDone:YES];
}

- (void)hideLoadingProgress
{
    [self performSelectorOnMainThread:@selector(hideLPV) withObject:nil waitUntilDone:YES];

}
- (void)showLPV
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *progressHUD = [[MBProgressHUD alloc] initWithWindow:window];
    progressHUD.labelText = @"加载中...";
    [progressHUD show:YES];
    progressHUD.yOffset = -20.00;
    progressHUD.userInteractionEnabled = NO;//设置可点击属性
    [window addSubview:progressHUD];
    
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(antuHideLPV) userInfo:nil repeats:NO];
//    [timer fire];
}
- (void)showWaittingProgress
{
    [self performSelectorOnMainThread:@selector(showWaittingLPV) withObject:nil waitUntilDone:YES];

}

- (void)showWaittingLPV
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *progressHUD = [[MBProgressHUD alloc] initWithWindow:window];
    progressHUD.labelText = @"等稍后...";
    [progressHUD show:YES];
    progressHUD.yOffset = -20.00;
    progressHUD.userInteractionEnabled = NO;//设置可点击属性
    [window addSubview:progressHUD];
    
    //    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(antuHideLPV) userInfo:nil repeats:NO];
    //    [timer fire];
}
- (void)hideLPV
{
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
}
- (void) antuHideLPV
{
    [self hideLoadingProgress];
}


- (void)leftEvent:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
