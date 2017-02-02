//
//  Person.m
//  uiapplication_singleton
//
//  Created by evestorm on 16/10/8.
//  Copyright © 2016年 evestorm. All rights reserved.
//

#import "Person.h"

@implementation Person
// 程序启动的时候就要创建对象

// 静态变量
static Person *_instance = nil;

// 作用：加载类
// 什么时候调用：每次程序一启动，就会把所有的类加载进内存
+ (void)load {
    NSLog(@"%s",__func__);
    

    _instance = [[self alloc] init];
}

+ (instancetype)sharedPerson {
    return _instance;
}

+ (instancetype)alloc {
    
    if (_instance) {
        // 表示已经分配了内存，就不允许外界再分配内存
        
        // 抛异常，告诉外界不运用分配
        // 'NSInternalInconsistencyException', reason: 'There can only be one UIApplication instance.'
        // 创建异常类
        NSException *excp = [NSException exceptionWithName:@"NSInternalInconsistencyException" reason:@"There can only be one Person instance." userInfo:nil];
        
        // 抛异常
        [excp raise];
    }
    // super -> NSObject 才知道怎么分配内存
    // 调用系统默认的做法，当从重写一个方法的时候，如果不想覆盖原来的实现，就调用super
    return [super alloc];
}
@end
