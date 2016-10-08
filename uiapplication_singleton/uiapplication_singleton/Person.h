//
//  Person.h
//  uiapplication_singleton
//
//  Created by evestorm on 16/10/8.
//  Copyright © 2016年 evestorm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

// 外界获取单例
+ (instancetype)sharedPerson;

@end
