//
//  SPMImageAsyncView.h
//  ImageDL
//
//  Created by Pierre Abi-aad on 21/03/2014.
//  Copyright (c) 2014 Pierre Abi-aad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PAImageView : UIView

@property (nonatomic, assign, getter = isCacheEnabled) BOOL cacheEnabled;

- (void)setProperty:(CGRect)frame backgroundProgresscolor:(UIColor *)backgroundProgresscolor progressColor:(UIColor *)progressColor placeholderImage:(UIImage *)placeholder;
- (void)setImageURL:(NSString *)URL;

@end
