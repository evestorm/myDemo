//
//  Person.m
//  归档解档
//
//  Created by macbook on 16/11/29.
//  Copyright © 2016年 macbook. All rights reserved.
//

#import "Person.h"

@implementation Person

// 作用：告诉系统模型哪些属性需要归档
// 调用时刻：把一个自定义对象，归档的时候调用
- (void)encodeWithCoder:(NSCoder *)aCoder {
    // aCoder用来归档
    [aCoder encodeInteger:_age forKey:@"age"];
    [aCoder encodeObject:_name forKey:@"name"];
}

// 作用：告诉系统模型中的哪些属性需要解档
// 调用时刻：解析一个文件的时候调用
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    // [super initWithCoder];
    // 为什么此处敲不出 initWithCoder ？在RedView中查看
    if (self = [super init]) {
        // 注意：一定要记得给成员属性赋值
        _name = [aDecoder decodeObjectForKey:@"name"];
        _age = [aDecoder decodeIntForKey:@"age"];
    }
    return self;
}
@end
