//
//  User.m
//  konggu
//
//  Created by zhaoliang on 15/3/7.
//  Copyright (c) 2015年 zhaoliang. All rights reserved.
//

#import "User.h"

@implementation User

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:[NSNumber numberWithLongLong:self.userId] forKey:@"userId"];
    [encoder encodeObject:self.screenName forKey:@"screenName"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.province forKey:@"province"];
    [encoder encodeObject:self.city forKey:@"city"];
    [encoder encodeObject:self.location forKey:@"location"];
    [encoder encodeObject:self.description forKey:@"description"];
    [encoder encodeObject:self.url forKey:@"url"];
    [encoder encodeObject:self.profileImageUrl forKey:@"profileImageUrl"];
    [encoder encodeObject:self.profileLargeImageUrl forKey:@"profileLargeImageUrl"];
    [encoder encodeObject:self.domain forKey:@"domain"];
    [encoder encodeObject:self.weihao forKey:@"weihao"];
    [encoder encodeObject:self.profileUrl forKey:@"profileUrl"];
    [encoder encodeObject:self.verifiedReason forKey:@"verifiedReason"];
    [encoder encodeInt:self.gender forKey:@"gender"];
    [encoder encodeInt:self.followersCount forKey:@"followersCount"];
    [encoder encodeInt:self.friendsCount forKey:@"friendsCount"];
    [encoder encodeInt:self.statusesCount forKey:@"statusesCount"];
    [encoder encodeInt:self.favoritesCount forKey:@"favoritesCount"];
    [encoder encodeInt:self.biFollowersCount forKey:@"biFollowersCount"];
    [encoder encodeInt:self.createdAt forKey:@"createdAt"];
    [encoder encodeBool:self.following forKey:@"following"];
    [encoder encodeBool:self.followedBy forKey:@"followedBy"];
    [encoder encodeBool:self.verified forKey:@"verified"];
    [encoder encodeBool:self.allowAllActMsg forKey:@"allowAllActMsg"];
    [encoder encodeBool:self.geoEnabled forKey:@"geoEnabled"];
    [encoder encodeBool:self.allowComment forKey:@"allowComment"];
    [encoder encodeInt:self.onlineStatus forKey:@"onlineStatus"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        [self setUserId:[[decoder decodeObjectForKey:@"userId"] longLongValue]];
        self.screenName = [decoder decodeObjectForKey:@"screenName"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.province = [decoder decodeObjectForKey:@"province"];
        self.city = [decoder decodeObjectForKey:@"city"];
        self.location = [decoder decodeObjectForKey:@"location"];
        self.description = [decoder decodeObjectForKey:@"description"];
        self.url = [decoder decodeObjectForKey:@"url"];
        self.profileImageUrl = [decoder decodeObjectForKey:@"profileImageUrl"];
        self.profileLargeImageUrl = [decoder decodeObjectForKey:@"profileLargeImageUrl"];
        self.domain = [decoder decodeObjectForKey:@"domain"];
        self.weihao = [decoder decodeObjectForKey:@"weihao"];
        self.profileUrl = [decoder decodeObjectForKey:@"profileUrl"];
        self.verifiedReason = [decoder decodeObjectForKey:@"verifiedReason"];
        self.gender = [decoder decodeIntForKey:@"gender"];
        self.followersCount = [decoder decodeIntForKey:@"followersCount"];
        self.friendsCount = [decoder decodeIntForKey:@"friendsCount"];
        self.statusesCount = [decoder decodeIntForKey:@"statusesCount"];
        self.favoritesCount = [decoder decodeIntForKey:@"favoritesCount"];
        self.biFollowersCount = [decoder decodeIntForKey:@"biFollowersCount"];
        self.createdAt = [decoder decodeIntForKey:@"createdAt"];
        self.following = [decoder decodeBoolForKey:@"following"];
        self.followedBy = [decoder decodeBoolForKey:@"followedBy"];
        self.verified = [decoder decodeBoolForKey:@"verified"];
        self.allowAllActMsg = [decoder decodeBoolForKey:@"allowAllActMsg"];
        self.geoEnabled = [decoder decodeBoolForKey:@"geoEnabled"];
        self.allowComment = [decoder decodeBoolForKey:@"allowComment"];
        self.onlineStatus = [decoder decodeIntForKey:@"onlineStatus"];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.userId = [[dict objectForKey:@"id"] longLongValue];
        self.screenName = [dict objectForKey:@"screen_name"];
        self.name = [dict objectForKey:@"name"];
        self.profileImageUrl = [dict objectForKey:@"profile_image_url"];
    }
    return self;
}

@end
