//
//  TabHomeCell.h
//  konggu
//
//  Created by zhaoliang on 15/3/8.
//  Copyright (c) 2015年 zhaoliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PAImageView.h"
#import "Status.h"

@interface TabHomeCell : UITableViewCell

//微博内容
@property(nonatomic, strong) Status *weibo;
//单元格高度
@property(nonatomic, assign) CGFloat height;

@end
