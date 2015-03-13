//
//  TabHomeCell.m
//  konggu
//
//  Created by zhaoliang on 15/3/8.
//  Copyright (c) 2015年 zhaoliang. All rights reserved.
//

#import "TabHomeCell.h"
#import "UIImageView+WebCache.h"
#import "MWPhotoBrowser.h"

#define kMarginTopToSuperview 10.0f
#define kMarginBottomToSuperview 10.0f
#define kMarginLeftToSuperview 10.0f
#define kMarginRightToSuperview 10.0f
#define kAvatarWidth 41.0f
#define kAvatarHeight 41.0f
#define kNameLeftToAvatar 5.0f
#define kNameHeight 20.0f
#define kHeadDividingLineHeight 0.5f
#define kTextTopToDividing  2.0f

@interface TabHomeCell()

//头像
@property(nonatomic, strong)UIImageView *userAvatar;
//姓名
@property(nonatomic, strong)UILabel *userName;
//是否认证
@property(nonatomic, strong)UIImageView *vertifyFlag;
//发送日期
@property(nonatomic, strong)UILabel *createTime;
//微博
@property(nonatomic, strong)UITextView *weiboText;
//原微博
@property(nonatomic, strong)UITextView *oriWeiboText;
//微博配图
@property(nonatomic, strong)MWPhotoBrowser *pictures;
//分割线
@property(nonatomic, strong)UIView *headDividingLine;

@property(nonatomic, assign) BOOL didSetupConstarints;

@end

@implementation TabHomeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
        [self setupConstraints];
    }
    return self;
}

- (void)setupViews
{
    self.userAvatar = [UIImageView new];
    self.userAvatar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.userAvatar];
    
    self.userName = [UILabel new];
    self.userName.translatesAutoresizingMaskIntoConstraints = NO;
    self.userName.font = [UIFont systemFontOfSize:12.0f];
    [self.contentView addSubview:self.userName];
    
    self.weiboText = [UITextView new];
    self.weiboText.translatesAutoresizingMaskIntoConstraints = NO;
    [self.weiboText setEditable:NO];
    [self.weiboText setScrollEnabled:NO];
    self.weiboText.font = [UIFont systemFontOfSize:12.0f];
    self.weiboText.contentInset = UIEdgeInsetsMake(-8.0f, -4.0f, 0, 0);
    
    [self.contentView addSubview:self.weiboText];
}

- (void)setupConstraints
{
    //头像
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.userAvatar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0f constant:kMarginTopToSuperview]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.userAvatar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0f constant:kMarginLeftToSuperview]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.userAvatar attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:kAvatarWidth]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.userAvatar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:kAvatarHeight]];
    //姓名
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.userName attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.userAvatar attribute:NSLayoutAttributeRight multiplier:1.0f constant:kNameLeftToAvatar]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.userName attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0f constant:kMarginTopToSuperview]];
    //微博内容
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.weiboText attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.userName attribute:NSLayoutAttributeBottom multiplier:1.0f constant:kTextTopToDividing]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.weiboText attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.userName attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0.0f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.weiboText attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0f constant:-1.0f *kMarginRightToSuperview]];
}

- (void)setStatus:(Status *)status
{
    [self.userAvatar sd_setImageWithURL:[NSURL URLWithString:status.user.avatarHD] placeholderImage:[UIImage imageNamed:@"tabbar_profile"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.userAvatar.layer.cornerRadius = self.userAvatar.frame.size.width/2;
        self.userAvatar.clipsToBounds = YES;
        self.userAvatar.layer.borderWidth = 1.0f;
        self.userAvatar.layer.borderColor = [UIColor grayColor].CGColor;
    }];
    
    self.userName.text = status.user.screenName;
    
    self.weiboText.text = status.text;
    
    CGFloat weiboTextWidth = self.contentView.frame.size.width - kMarginLeftToSuperview -kAvatarWidth - kNameLeftToAvatar - kMarginRightToSuperview;
    CGSize textSize=[self.weiboText.text boundingRectWithSize:CGSizeMake(weiboTextWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12.0f]} context:nil].size;
    CGSize nameTextSize = [self.userName.text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12.0f]}];
    self.height = kMarginTopToSuperview + MAX(textSize.height + nameTextSize.height + kTextTopToDividing, kAvatarHeight) + kMarginBottomToSuperview;
}

@end
