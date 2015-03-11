//
//  Status.h
//  konggu
//
//  Created by zhaoliang on 15/3/11.
//  Copyright (c) 2015年 zhaoliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Status : NSObject

@property(nonatomic, assign)long long id;
@property(nonatomic, assign)long long mid;
@property(nonatomic, copy)NSString *idStr;
@property(nonatomic, copy)NSString *text;
@property(nonatomic, strong)NSArray *originalPic;
@property(nonatomic, strong)NSArray *bMiddlePic;
@property(nonatomic, strong)NSArray *thumbnailPic;
@property(nonatomic, assign)int commentsCount;
@property(nonatomic, assign)int attitudesCount;
@property(nonatomic, assign)int repostsCount;
@property(nonatomic, copy)NSString *createTime;
@property(nonatomic, assign)BOOL hasFavorited;
@property(nonatomic, copy)NSString *source;
@property(nonatomic, strong)User *user;
@property(nonatomic, strong)Status *retweetedStatus;

- (instancetype)initWithDictionary:(NSDictionary *)status;

@end
