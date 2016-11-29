//
//  RedView.m
//  归档解档
//
//  Created by macbook on 16/11/29.
//  Copyright © 2016年 macbook. All rights reserved.
//

#import "RedView.h"

@implementation RedView

// 系统调用控件的这个方法帮你解析xib.storyboard
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    // 什么时候调用 [super initWithCoder:aDecoder]
    // 只要父类遵守了 NSCoding协议,就调用
    // 而在Person类中，父类 NSObject 没有遵守 NSCoding协议
    // 而RedView类的父类 UIView 遵守了，所以可以调用
    if (self = [super initWithCoder:aDecoder]) {
        NSLog(@"%s",__func__);
    }
    return self;
}

@end
