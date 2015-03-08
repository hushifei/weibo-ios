//
//  TabHomeCell.m
//  konggu
//
//  Created by zhaoliang on 15/3/8.
//  Copyright (c) 2015年 zhaoliang. All rights reserved.
//

#import "TabHomeCell.h"
#import "PureLayout.h"
#import "GMGridView.h"

@interface TabHomeCell()

//头像
@property(nonatomic, strong) PAImageView *avatarImageView;
//姓名
@property(nonatomic, strong) UILabel *userNameLabel;
//是否认证
@property(nonatomic, strong) PAImageView *vertifyImageView;
//发送日期
@property(nonatomic, strong) UILabel *titleLabel;
//微博
@property(nonatomic, strong) UITextView *weiboTextView;
//原微博
@property(nonatomic, strong) UITextView *oriWeiboTextView;
//微博配图
@property(nonatomic, strong) GMGridView *thumbnailsGridView;
//操作栏
@property(nonatomic, strong) UIScrollView *operationScrollView;

@property(nonatomic, assign) BOOL didSetupConstarints;

@end

@implementation TabHomeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //[self.contentView addSubview:self.avatarImageView];
        self.titleLabel = [UILabel newAutoLayoutView];
        /*[self.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.titleLabel setNumberOfLines:1];
        [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [self.titleLabel setTextColor:[UIColor blackColor]];
        self.titleLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.1]; // light blue
        */
        [self.contentView addSubview:self.titleLabel];
        //[self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstarints) {
        /*[self.avatarImageView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView withOffset:10];
        [self.avatarImageView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.contentView withOffset:10];
        [self.avatarImageView autoSetDimensionsToSize:CGSizeMake(60, 60)];
        [self.weiboTextView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.contentView withOffset:10];
        [self.weiboTextView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView withOffset:10];
        [self.weiboTextView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.avatarImageView withOffset:10];*/
        
        /*[UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
            [self.titleLabel autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
        }];*/
        [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
        //[self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
        //[self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
        

        self.didSetupConstarints = YES;
    }
    [super updateConstraints];
}

- (void)setWeibo:(Status *)weibo
{
    //[self.avatarImageView setProperty:self.avatarImageView.frame backgroundProgresscolor:[UIColor whiteColor] progressColor:[UIColor grayColor] placeholderImage:[UIImage imageNamed:@"tabbar_profile"]];
    //[self.avatarImageView setImageURL:@"tabbar_profile"];
    
    self.titleLabel.text = @"hhhhh";
    
    //self.height = CGRectGetMaxY(self.weiboTextView.frame);
    self.height = 100;
}

- (PAImageView *)avatarImageView
{
    if (!_avatarImageView) {
        _avatarImageView = [PAImageView newAutoLayoutView];
    }
    return _avatarImageView;
}

/*- (UITextView *)weiboTextView
{
    if (!_weiboTextView) {
        _weiboTextView = [UITextView newAutoLayoutView];
    }
    return _weiboTextView;
}*/
@end
