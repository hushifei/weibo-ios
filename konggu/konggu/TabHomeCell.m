//
//  TabHomeCell.m
//  konggu
//
//  Created by zhaoliang on 15/3/8.
//  Copyright (c) 2015年 zhaoliang. All rights reserved.
//

#import "TabHomeCell.h"
#import "PureLayout.h"
#import "UIImageView+WebCache.h"
#import "KIImagePager.h"

@interface TabHomeCell()

//头像
@property(nonatomic, strong) UIImageView *avatarImageView;
//姓名
@property(nonatomic, strong) UILabel *userNameLabel;
//是否认证
@property(nonatomic, strong) UIImageView *vertifyImageView;
//发送日期
@property(nonatomic, strong) UITextView *titleLabel;
//微博
@property(nonatomic, strong) UITextView *weiboTextView;
//原微博
@property(nonatomic, strong) UITextView *oriWeiboTextView;
//微博配图
@property(nonatomic, strong) KIImagePager *picturesPager;

@property(nonatomic, assign) BOOL didSetupConstarints;

@end

@implementation TabHomeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.avatarImageView];
        //self.titleLabel = [UITextView newAutoLayoutView];
        //[self.titleLabel setBackgroundColor:[UIColor blueColor]];
        /*[self.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.titleLabel setNumberOfLines:1];
        [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [self.titleLabel setTextColor:[UIColor blackColor]];
        self.titleLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.1]; // light blue
        */
        [self.contentView addSubview:self.weiboTextView];
        //[self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstarints) {
        [self.avatarImageView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView withOffset:10];
        [self.avatarImageView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.contentView withOffset:10];
        [self.avatarImageView autoSetDimensionsToSize:CGSizeMake(60, 60)];
        /*[self.weiboTextView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.contentView withOffset:10];
        [self.weiboTextView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView withOffset:10];*/
        [self.weiboTextView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.avatarImageView withOffset:10];
        [self.weiboTextView autoSetDimension:ALDimensionWidth toSize:self.contentView.frame.size.width - 60];
        [self.weiboTextView autoSetDimension:ALDimensionHeight toSize:80];
        
        /*[UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
            [self.titleLabel autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
        }];*/
        //[self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
        //[self.titleLabel autoSetDimensionsToSize:CGSizeMake(60, 60)];
        //[self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
        //[self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
        

        self.didSetupConstarints = YES;
    }
    [super updateConstraints];
}

- (void)setWeibo:(Status *)weibo
{
    //[self.avatarImageView setProperty:self.avatarImageView.frame backgroundProgresscolor:[UIColor whiteColor] progressColor:[UIColor grayColor] placeholderImage:[UIImage imageNamed:@"tabbar_profile"]];
    //[self.avatarImageView setImageURL:weibo.user.profileImageUrl];
    
    
    //[self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:weibo.user.profileImageUrl] placeholderImage:[UIImage imageNamed:@"tabbar_profile"]];
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:weibo.user.profileLargeImageUrl] placeholderImage:[UIImage imageNamed:@"tabbar_profile"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.width/2;
        self.avatarImageView.clipsToBounds = YES;
        self.avatarImageView.layer.borderWidth = 2.0f;
        self.avatarImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    }];
    
    self.weiboTextView.text = weibo.text;
    //self.titleLabel.text = @"hhhhh";
    
    //self.height = CGRectGetMaxY(self.weiboTextView.frame);
    self.height = 100;
}

- (UIImageView *)avatarImageView
{
    if (!_avatarImageView) {
        _avatarImageView = [UIImageView newAutoLayoutView];
    }
    return _avatarImageView;
}

- (UITextView *)weiboTextView
{
    if (!_weiboTextView) {
        _weiboTextView = [UITextView newAutoLayoutView];
    }
    return _weiboTextView;
}
@end
