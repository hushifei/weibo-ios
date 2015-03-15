//
//  KGImageGallary.h
//  konggu
//
//  Created by zhaoliang on 15/3/15.
//  Copyright (c) 2015年 zhaoliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KGImageGallary : UIView

@property(nonatomic, copy)NSArray *imageUrls;
@property(nonatomic, assign)double height;

- (void)clearAll;
@end
