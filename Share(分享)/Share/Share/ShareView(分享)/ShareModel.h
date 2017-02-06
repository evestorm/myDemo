//
//  ShareModel.h
//  Share
//
//  Created by evestorm on 2017/2/6.
//  Copyright © 2017年 eve. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareModel : NSObject
@property (nonatomic, copy) NSString *share_title; /**< 分享标题*/
@property (nonatomic, copy) NSString *share_content; /**< 分享内容*/
@property (nonatomic, copy) NSString *share_url; /**< 分享URL*/
@end
