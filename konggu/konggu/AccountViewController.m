//
//  AccountViewController.m
//  kongku
//
//  Created by zhaoliang on 15/3/7.
//  Copyright (c) 2015年 zhaoliang. All rights reserved.
//

#import "AccountViewController.h"
#import "KGRequestTool.h"
#import "Account.h"
#import "KGMainViewController.h"

#define kOauthUrl           @"https://api.weibo.com/oauth2/authorize"
#define kAppKey             @"3609198081"
#define kAppSecret          @"d53262e6f2bfc0a225af66b0e1a7deab"
#define kRedirectUrl        @"http://konggu.zhaoliang.info"
#define kAccessTokenUrl     @"https://api.weibo.com/oauth2/access_token"

@interface AccountViewController()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation AccountViewController

- (void)loadView
{
    self.view = [UIView new];
    
    [self setupViews];
    [self setupConstraints];
    
    //请求页面
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"%@?client_id=%@&redirect_uri=%@", kOauthUrl, kAppKey, kRedirectUrl]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)setupViews
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.webView = [UIWebView new];
    self.webView.translatesAutoresizingMaskIntoConstraints = NO;
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
}

- (void)setupConstraints
{
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:20.0f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f]];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
        navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *requestUrl = request.URL.absoluteString;
    NSRange range = [requestUrl rangeOfString:kRedirectUrl];
    if (range.location == 0) {
        NSRange codeRange = [requestUrl rangeOfString:[kRedirectUrl stringByAppendingString:@"/?code="]];
        unsigned long codeIndex = codeRange.length;
        NSString *code = [requestUrl substringFromIndex:codeIndex];
        [self authWithCode:code];
        return NO;
    }
    return YES;
}

- (void)authWithCode: (NSString *)code
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"client_id"] = kAppKey;
    param[@"client_secret"] = kAppSecret;
    param[@"grant_type"] = @"authorization_code";
    param[@"code"] = code;
    param[@"redirect_uri"] = kRedirectUrl;
    [KGRequestTool POST:kAccessTokenUrl parameters:param response:@"plain" success:^(id responseObject) {
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        Account *account = [[Account alloc] initWithString:result];
        [account saveAccount];
        KGMainViewController *mainViewController = [[KGMainViewController alloc] initWithStyle];
        [self presentViewController:mainViewController animated:true completion:^{
            
        }];

    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
