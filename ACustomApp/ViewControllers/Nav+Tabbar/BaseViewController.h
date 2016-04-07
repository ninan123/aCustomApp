//
//  BaseViewController.h
//  hothot
//
//  Created by 张国平 on 15/11/17.
//  Copyright © 2015年 zgp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+toast.h"

@interface BaseViewController : UIViewController

- (void)showTosat:(NSString *)str;

- (void)showLoadingProgress;

- (void)hideLoadingProgress;

- (void)showWaittingProgress;
@end
