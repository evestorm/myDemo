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
    // 无论有没有看到上下文，只要在View上面绘图，就必须在drawRect方法实现
    
    //ArcCenter:圆心
    // radius:圆的半径
    // startAngle: 开始角度 -> 起始点圆的最右侧
    // endAngle:截取角度
    // clockwise:顺时针还是逆时针 YES:顺时针 NO:逆时针
    
    CGPoint center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    CGFloat radius = rect.size.width * 0.5 - 10;
    CGFloat startA = 0;
    CGFloat endA = M_PI;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    
    [path addLineToPoint:center];
    
    [path stroke];
}

#pragma mark - 画圆角，椭圆
/** 画圆角，椭圆*/
- (void)drawRoundandOval {
    // 圆角
    //    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(10, 10, 100, 100) cornerRadius:10];
    // 画椭圆
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(10, 10, 100, 60)];
    
    [path fill];

}

#pragma mark - 画矩形
/** 画矩形*/
- (void)drawRectangle {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(10, 10, 100, 100)];
    
    [[UIColor yellowColor] setStroke];
    
    CGContextAddPath(ctx, path.CGPath);
    
    CGContextStrokePath(ctx);
}

#pragma mark - 画曲线
/** 画曲线*/
- (void)drawCurve {
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 描述路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(20, 200)];
    [path addQuadCurveToPoint:CGPointMake(200, 200) controlPoint:CGPointMake(100, 10)];
    
    CGContextSetLineWidth(ctx, 10);
    // 把路径添加到上下文
    CGContextAddPath(ctx, path.CGPath);
    // 把上下文内容显示出来
    CGContextStrokePath(ctx);
}

#pragma mark - 画直线
/** 画直线*/
- (void)drawLine {
    // Drawing code
    NSLog(@"%s",__func__);
    NSLog(@"%@",NSStringFromCGRect(self.bounds));
    
    // 1. 取得一个跟View相关联的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext(); // C语言的方法
    // 2. 描述路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 2.1 设置起点
    [path moveToPoint:CGPointMake(10, 100)];
    // 2.2 添加一根线到某点
    [path addLineToPoint:CGPointMake(200, 20)];
    
    // 一个路径上面可以画多条线
    //    [path moveToPoint:CGPointMake(300, 150)];
    //    [path addLineToPoint:CGPointMake(50, 250)];
    [path addLineToPoint:CGPointMake(150, 200)];
    
    // 设置上下文的状态
    // 设置线的宽度
    CGContextSetLineWidth(ctx, 10);
    // 设置线的连接样式
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    // 设置顶角样式
    CGContextSetLineCap(ctx, kCGLineCapRound);
    // 设置线的颜色
    [[UIColor greenColor] setStroke];
    
    
    // 3. 把路径添加到上下文
    CGContextAddPath(ctx, path.CGPath);
    // 4. 把上下文的内容渲染到View
    CGContextStrokePath(ctx);

}


@end
