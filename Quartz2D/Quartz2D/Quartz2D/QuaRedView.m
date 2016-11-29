//
//  QuaRedView.m
//  Quartz2D
//
//  Created by macbook on 16/11/29.
//  Copyright © 2016年 macbook. All rights reserved.
//

#import "QuaRedView.h"

@implementation QuaRedView

// 作用：专门用来绘图
// 什么时候调用：
// rect：
- (void)drawRect:(CGRect)rect {
    // Drawing code
    NSLog(@"%s",__func__);
    NSLog(@"%@",NSStringFromCGRect(rect));
    
    // 1. 取得一个跟View相关联的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext(); // C语言的方法
    // 2. 描述路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 2.1 设置起点
    [path moveToPoint:CGPointMake(10, 100)];
    // 2.2 添加一根线到某点
    [path addLineToPoint:CGPointMake(200, 200)];
    
    // 一个路径上面可以画多条线
//    [path moveToPoint:CGPointMake(300, 150)];
//    [path addLineToPoint:CGPointMake(50, 250)];
    [path addLineToPoint:CGPointMake(50, 250)];
    
    // 3. 把路径添加到上下文
    CGContextAddPath(ctx, path.CGPath);
    // 4. 把上下文的内容渲染到View
    CGContextStrokePath(ctx);
    
}


@end
