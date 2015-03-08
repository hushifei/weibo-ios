//
//  AccountViewController.m
//  kongku
//
//  Created by zhaoliang on 15/3/7.
//  Copyright (c) 2015年 zhaoliang. All rights reserved.
//

#import "AccountViewController.h"
#import "PureLayout.h"
#import "AFNetworking.h"
#import "Account.h"

#define OAUTH_URL           @"https://api.weibo.com/oauth2/authorize"
#define APP_KEY             @"3609198081"
#define APP_SECRET          @"**"
#define REDIRECT_URL        @"http://konggu.zhaoliang.info"
#define ACCESS_TOKEN_URL    @"https://api.weibo.com/oauth2/access_token"

@interface AccountViewController()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation AccountViewController

- (void)loadView
{
    self.view = [UIView new];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    //设置约束
    [self.view addSubview:self.webView];
    [self.view setNeedsUpdateConstraints];
    //请求页面
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"%@?client_id=%@&redirect_uri=%@", OAUTH_URL, APP_KEY, REDIRECT_URL]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)updateViewConstraints
{
    if(!self.didSetupConstraints)
    {
        [self.webView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:20];
        [self.webView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [self.webView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.webView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        self.didSetupConstraints = YES;
    }
    [super updateViewConstraints];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
        navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *requestUrl = request.URL.absoluteString;
    NSRange range = [requestUrl rangeOfString:REDIRECT_URL];
    if (range.location == 0) {
        NSRange codeRange = [requestUrl rangeOfString:[REDIRECT_URL stringByAppendingString:@"/?code="]];
        unsigned long codeIndex = codeRange.length;
        NSString *code = [requestUrl substringFromIndex:codeIndex];
        [self authWithCode:code];
        return NO;
    }
    return YES;
}

- (void)authWithCode: (NSString *)code
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"client_id"] = APP_KEY;
    param[@"client_secret"] = APP_SECRET;
    param[@"grant_type"] = @"authorization_code";
    param[@"code"] = code;
    param[@"redirect_uri"] = REDIRECT_URL;

    [manager POST:ACCESS_TOKEN_URL parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        Account *account = [[Account alloc] initWithString:result];
        [account saveAccount];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (UIWebView *) webView
{
    if (!_webView) {
        _webView = [UIWebView newAutoLayoutView];
    }
    return _webView;
}

@end
