//
//  StartupViewController.m
//  konggu
//
//  Created by zhaoliang on 15/3/7.
//  Copyright (c) 2015年 zhaoliang. All rights reserved.
//

#import "StartupViewController.h"
#import "PureLayout.h"
#import "AFNetworking.h"
#import "User.h"

#define GET_USER_URL    @"https://api.weibo.com/2/users/show.json"

@interface StartupViewController()

@property(nonatomic, strong) UIImageView *userAvatar;
@property(nonatomic, strong) UILabel *userName;
@property(nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation StartupViewController

- (void)loadView
{
    self.view = [UIView new];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.userAvatar];
    [self.view addSubview:self.userName];
    [self.view setNeedsUpdateConstraints];
}

- (instancetype)initWithUid:(NSString *)uid accessToken:(NSString *)accessToken
{
    self = [super init];
    if (self) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"access_token"] = accessToken;
        param[@"uid"] = uid;
        [manager GET:GET_USER_URL parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
            User *currentUser = [[User alloc] initWithDictionary:responseObject];
            [self.userName setText:currentUser.screenName];
            NSLog(@"name%@", currentUser.screenName);
            
            //UIImage *image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:currentUser.profileImageUrl]]];
            //[self.userAvatar setImage:image];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
    return self;
}

- (void)updateViewConstraints
{
    if (!self.didSetupConstraints) {
        [self.userAvatar autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.userAvatar autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        //[self.userAvatar autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.view withOffset:40];
        [self.userAvatar autoSetDimensionsToSize:CGSizeMake(80, 80)];
        [self.userName autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.userName autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.userAvatar withOffset:10];
        [self.userName autoSetDimensionsToSize:CGSizeMake(100, 100)];
        self.didSetupConstraints = YES;
    }
    [super updateViewConstraints];
}

- (UIImageView *)userAvatar
{
    if (_userAvatar) {
        _userAvatar = [UIImageView newAutoLayoutView];
    }
    return _userAvatar;
}

- (UILabel *)userName
{
    if (_userName) {
        _userName = [UILabel newAutoLayoutView];
        [_userName setBackgroundColor:[UIColor blueColor]];
    }
    return _userName;
}

@end
