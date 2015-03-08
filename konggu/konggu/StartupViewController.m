//
//  StartupViewController.m
//  konggu
//
//  Created by zhaoliang on 15/3/7.
//  Copyright (c) 2015年 zhaoliang. All rights reserved.
//

#import "StartupViewController.h"
#import "PureLayout.h"
#import "KGRequestTool.h"
#import "PAImageView.h"
#import "User.h"
#import "KGMainViewController.h"

#define GET_USER_URL        @"https://api.weibo.com/2/users/show.json"

@interface StartupViewController()

@property(nonatomic, strong) PAImageView *userAvatar;
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
        
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"access_token"] = accessToken;
        param[@"uid"] = uid;
        
        [KGRequestTool GET:GET_USER_URL parameters:param response:@"json" success:^(id responseObject) {
            User *currentUser = [[User alloc] initWithDictionary:responseObject];
            [self.userName setText:currentUser.screenName];
            
            //UIImage *image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:currentUser.profileImageUrl]]];
            //[self.userAvatar setImage:image];
            [self.userAvatar setProperty:self.userAvatar.frame backgroundProgresscolor:[UIColor whiteColor] progressColor:[UIColor grayColor] placeholderImage:[UIImage imageNamed:@"tabbar_profile"]];
            [self.userAvatar setImageURL:currentUser.profileImageUrl];
            
            KGMainViewController *mainVC = [[KGMainViewController alloc] initWithStyle];
            [self presentViewController:mainVC.tabbar animated:true completion:^{
                
            }];
        } failure:^(NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
    return self;
}

- (void)updateViewConstraints
{
    if (!self.didSetupConstraints) {
        [self.userAvatar autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.userAvatar autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.view withOffset:-30];
        [self.userAvatar autoSetDimensionsToSize:CGSizeMake(60, 60)];
        [self.userName autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.userName autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.userAvatar withOffset:10];
        self.didSetupConstraints = YES;
    }
    [super updateViewConstraints];
}

- (PAImageView *)userAvatar
{
    if (!_userAvatar) {
        _userAvatar = [PAImageView newAutoLayoutView];
    }
    return _userAvatar;
}

- (UILabel *)userName
{
    if (!_userName) {
        _userName = [UILabel newAutoLayoutView];
    }
    return _userName;
}

@end
