//
//  TabHomeCell.m
//  konggu
//
//  Created by zhaoliang on 15/3/8.
//  Copyright (c) 2015年 zhaoliang. All rights reserved.
//

#import "TabHomeCell.h"
#import "UIImageView+WebCache.h"
#import "KGImageGallary.h"
#import "UIView+UpdateAutoLayoutConstraints.h"

#define kMarginTopToSuperview 10.0f
#define kMarginBottomToSuperview 0.0f
#define kMarginLeftToSuperview 10.0f
#define kMarginRightToSuperview 10.0f
#define kAvatarWidth 41.0f
#define kAvatarHeight 41.0f
#define kNameLeftToAvatar 5.0f
#define kTextTopToDividing 2.0f
#define kOriTextToWeibo 2.0f

@interface TabHomeCell()
{
    //头像
    UIImageView *_userAvatar;
    //姓名
    UILabel *_userName;
    //是否认证
    UIImageView *_vertifyFlag;
    //发送日期
    UILabel *_createTime;
    //微博
    UITextView *_weiboText;
    //原微博
    UITextView *_oriWeiboText;
    //微博配图
    KGImageGallary *_pictures;
    //分割线
    UIView *_headDividingLine;
    
    CGFloat _oriTextHeight;
}
@end

@implementation TabHomeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    _userAvatar = [UIImageView new];
    _userAvatar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_userAvatar];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_userAvatar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0f constant:kMarginTopToSuperview]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_userAvatar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0f constant:kMarginLeftToSuperview]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_userAvatar attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:kAvatarWidth]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_userAvatar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:kAvatarHeight]];
    
    _userName = [UILabel new];
    _userName.translatesAutoresizingMaskIntoConstraints = NO;
    _userName.font = [UIFont systemFontOfSize:12.0f];
    _userName.backgroundColor = [UIColor clearColor];
    [_userName setTextColor:[UIColor orangeColor]];
    [self.contentView addSubview:_userName];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_userName attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_userAvatar attribute:NSLayoutAttributeRight multiplier:1.0f constant:kNameLeftToAvatar]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_userName attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0f constant:kMarginTopToSuperview]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_userName attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.contentView attribute:NSLayoutAttributeWidth multiplier:0.5f constant:-kAvatarWidth]];
    
    _weiboText = [UITextView new];
    _weiboText.translatesAutoresizingMaskIntoConstraints = NO;
    [_weiboText setEditable:NO];
    [_weiboText setScrollEnabled:NO];
    _weiboText.font = [UIFont systemFontOfSize:12.0f];
    //[self.weiboText setBackgroundColor:[UIColor orangeColor]];
    _weiboText.contentInset = UIEdgeInsetsZero;
    _weiboText.textContainerInset = UIEdgeInsetsZero;
    _weiboText.textContainer.lineFragmentPadding = 0;
    [self.contentView addSubview:_weiboText];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_weiboText attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_userName attribute:NSLayoutAttributeBottom multiplier:1.0f constant:kTextTopToDividing]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_weiboText attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_userName attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0.0f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_weiboText attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0f constant:-1.0f *kMarginRightToSuperview]];
    
    _oriWeiboText = [UITextView new];
    [self.contentView addSubview:_oriWeiboText];
}


- (void)setStatus:(Status *)status
{
    double rightPartHeight;
    
    [_pictures removeFromSuperview];
    [_oriWeiboText removeFromSuperview];
    _oriTextHeight = 0;
    
    _userAvatar.backgroundColor = [UIColor clearColor];
    _userAvatar.layer.cornerRadius =  kAvatarWidth / 2;
    _userAvatar.layer.masksToBounds = YES;
    _userAvatar.layer.borderWidth = 1.0f;
    _userAvatar.layer.borderColor = [UIColor grayColor].CGColor;
    [_userAvatar sd_setImageWithURL:[NSURL URLWithString:status.user.avatarHD] placeholderImage:[UIImage imageNamed:@"tabbar_profile"]];
    
    _userName.text = status.user.screenName;
    CGSize nameTextSize = [_userName.text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12.0f]}];
    rightPartHeight += nameTextSize.height;
    
    _weiboText.text = status.text;
    CGFloat weiboTextWidth = self.contentView.frame.size.width - kMarginLeftToSuperview -kAvatarWidth - kNameLeftToAvatar - kMarginRightToSuperview;
    CGSize weiboTextSize = [_weiboText sizeThatFits:CGSizeMake(weiboTextWidth, MAXFLOAT)];
    rightPartHeight += weiboTextSize.height;
    
    if (status.retweetedStatus) {
        [self setRetweetedStatus:status.retweetedStatus];
        CGSize oriWeiboTextSize = [_oriWeiboText sizeThatFits:CGSizeMake(weiboTextWidth, MAXFLOAT)];
        _oriTextHeight = oriWeiboTextSize.height;
        rightPartHeight += kTextTopToDividing + _oriTextHeight;
        
        [_oriWeiboText setConstraintConstant:_oriTextHeight forAttribute:NSLayoutAttributeHeight];
    }
    
    NSMutableArray *thumbnailPics = [[NSMutableArray alloc] init];
    if ([status.thumbnailPics count] > 0) {
        thumbnailPics = [status.thumbnailPics copy];
    }
    else if ([status.retweetedStatus.thumbnailPics count] > 0) {
        thumbnailPics = [status.retweetedStatus.thumbnailPics copy];
    }
    if ([thumbnailPics count] > 0) {
        [self setPictures:thumbnailPics];
        [_pictures setImageUrls:thumbnailPics];
        rightPartHeight += _pictures.height;
        [_pictures setConstraintConstant:_oriTextHeight+kOriTextToWeibo forAttribute:NSLayoutAttributeTop];
        [_pictures setConstraintConstant:_pictures.height forAttribute:NSLayoutAttributeHeight];
    }
    
    self.height = kMarginTopToSuperview + MAX(rightPartHeight, kAvatarHeight) + kMarginBottomToSuperview;
}

- (void)setPictures:(NSArray *)thumbnailPics
{
    _pictures = [KGImageGallary new];
    _pictures.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_pictures];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_pictures attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_userName attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0.0f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_pictures attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0f constant:-1.0f *kMarginRightToSuperview]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_pictures attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_weiboText attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_pictures attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:0.0f]];
    
}

- (void) setRetweetedStatus:(Status *)retweetedStatus
{
    if (retweetedStatus) {
        _oriWeiboText = [UITextView new];
        _oriWeiboText.translatesAutoresizingMaskIntoConstraints = NO;
        [_oriWeiboText setEditable:NO];
        [_oriWeiboText setScrollEnabled:NO];
        _oriWeiboText.font = [UIFont systemFontOfSize:12.0f];
        [_oriWeiboText setTextColor:[UIColor grayColor]];
        _oriWeiboText.contentInset = UIEdgeInsetsZero;
        _oriWeiboText.textContainerInset = UIEdgeInsetsZero;
        _oriWeiboText.textContainer.lineFragmentPadding = 0;
        
        _oriWeiboText.text = [NSString stringWithFormat:@"@%@:%@", retweetedStatus.user.screenName, retweetedStatus.text];
        [self.contentView addSubview:_oriWeiboText];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_oriWeiboText attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_weiboText attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0.0f]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_oriWeiboText attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_weiboText attribute:NSLayoutAttributeBottom multiplier:1.0f constant:kOriTextToWeibo]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_oriWeiboText attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0f constant:-1.0f *kMarginRightToSuperview]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_oriWeiboText attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:0.0f]];
    }
}

@end
