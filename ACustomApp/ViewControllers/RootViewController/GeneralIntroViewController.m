//
//  GeneralIntroViewController.m
//  ACustomApp
//
//  Created by Apple on 16/3/30.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "GeneralIntroViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
@interface GeneralIntroViewController ()<UIWebViewDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, copy) NSString *content;

@end

@implementation GeneralIntroViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"大会简介";

     [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"leftNav"] style:UIBarButtonItemStylePlain target:self action:@selector(showLeftSliderVC)] animated:YES];
    
//    MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(showLeftSliderVC)];
//    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
    UIBarButtonItem *buttonItem = [UIBarButtonItem itemWithBtnTitle:@"English" target:self action:@selector(translateEnglish)];
    [self.navigationItem setRightBarButtonItem:buttonItem animated:YES];
    
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.scrollView.showsVerticalScrollIndicator = YES;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    self.webView.scalesPageToFit = NO;
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.scrollView.backgroundColor = [UIColor whiteColor];
    self.webView.paginationBreakingMode = UIWebPaginationBreakingModePage;
    self.webView.multipleTouchEnabled = NO;
    self.webView.scrollView.scrollsToTop = YES;
    [self.view addSubview:self.webView];
    
    [self.view beginLoading];
    
    NSString *title = @"青岛男子20多分钟钓上16斤重鲤鱼 众人合影后放生";
    NSString *zuozhe = @"2016年3月27日";
   _content = @"  3月27日下午，一名垂钓爱好者在山东青岛即墨麦泊村水库，钓上一条16斤重的大鲤鱼。垂钓者刘先生和几名钓友和大鱼斗了20多分钟，才将鲤鱼拖上岸。众多钓友争相拍照后，又将大鲤鱼重新放回水库生长。　“这是一条野生大鲤鱼，在小水库很难遇到这样大的鱼。”水库钓鱼场负责人张先生说，这个小水库是30多年前自然形成的，后来村民为了蓄水，特意修建起了一个拦水坝。原来水库里就有不少野生鱼，去年又放进去了一些鱼，但从来没有见过这么大的鲤鱼。渔业专家表示，这么大个头的鲤鱼一般都生活在深水区，像这样水不太深的小水库，有这样的大鱼出现，与自然形成的小水库有很大关系。水库钓鱼场负责人张先生说，这个小水库是30多年前自然形成的，后来村民为了蓄水，特意修建起了一个拦水坝。原来水库里就有不少野生鱼，去年又放进去了一些鱼，但从来没有见过这么大的鲤鱼。渔业专家表示，这么大个头的鲤鱼一般都生活在深水区，像这样水不太深的小水库，有这样的大鱼出现，与自然形成的小水库有很大关系。这个小水库是30多年前自然形成的，后来村民为了蓄水，特意修建起了一个拦水坝。（记者康晓欢）";
    
    NSString *webViewBGColor =  @"#ffffff";
    NSString *webViewContentTextColor =  @"#333333";
    NSString *webViewTitleTextColor = @"#5A5A5A";
    NSString *webViewAuthorTitleTextColor = @"#888888";
    
    NSMutableString *HTMLContent = [[NSMutableString alloc] init];
    [HTMLContent appendString:[NSString stringWithFormat:@"<body style=\"margin: 0px; background-color: %@;\"><div style=\"margin-bottom: 10px; background-color: %@;\">", webViewBGColor, webViewBGColor]];
    [HTMLContent appendString:[NSString stringWithFormat:@"<!-- 文章标题 --><p style=\"color: %@; font-size: 21px; font-weight: bold; margin-top: 20px; margin-left: 15px;\">%@</p>", webViewTitleTextColor, title]];
    [HTMLContent appendString:[NSString stringWithFormat:@"<!-- 文章作者 --><p style=\"color: %@; font-size: 14px; font-weight: bold; margin-left: 17px; margin-top: -15px;\">%@</p><p></p>", webViewAuthorTitleTextColor, zuozhe]];
    [HTMLContent appendString:[NSString stringWithFormat:@"<!-- 文章内容 --><div style=\"line-height: 26px; margin-top: 15px; margin-left: 15px; margin-right: 15px; color: %@; font-size: 16px;\">%@</div>", webViewContentTextColor, _content]];

    
    [self.webView loadHTMLString:HTMLContent baseURL:nil];
    
    
    self.webView.delegate = self;
    self.webView.scrollView.delegate = self;
//    [self.webView.scrollView scrollsToTop];
    
    
    
    }
-(void)translateEnglish
{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {

    [self.view endLoading];
    CGSize readingContentSize = webView.scrollView.contentSize;
    
    if (readingContentSize.height > SCREEN_HEIGHT) {
        readingContentSize.height += 100;
    }
    
    webView.scrollView.contentSize = readingContentSize;

}


-(void)showLeftSliderVC
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}


@end
