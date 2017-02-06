//
//  ShareView.h
//  Share
//
//  Created by evestorm on 2017/2/6.
//  Copyright © 2017年 eve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareModel.h"

@interface ShareView : UIView

- (instancetype)initWithObj:(ShareModel *)obj controller:(id)controller;

- (void)shareShow;

//+ (void)shareWithType:(NSInteger)type Title:(NSString *)title  andContent:(NSString *)content andImage:(NSString *)image andURL:(NSString *)url;

@end
