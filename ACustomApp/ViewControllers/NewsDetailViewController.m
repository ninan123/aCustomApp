//
//  NewsDetailViewController.m
//  ACustomApp
//
//  Created by Apple on 16/4/1.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "NewsDetailView.h"
#import "UIViewController+MMDrawerController.h"

@interface NewsDetailViewController ()
@property(nonatomic,strong)NewsDetailView *detailView;
@end

@implementation NewsDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModePanningNavigationBar];

    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareButtonClick)] animated:YES];
    
    _detailView = [[NewsDetailView alloc] initWithFrame:self.view.bounds];
    _detailView.curModel = _curModel;
    [self.view addSubview:_detailView];

}

- (void)shareButtonClick {
   

}



@end
