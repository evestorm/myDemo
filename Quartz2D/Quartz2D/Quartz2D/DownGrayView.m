//
//  DownGrayView.m
//  Quartz2D
//
//  Created by macbook on 16/11/30.
//  Copyright © 2016年 macbook. All rights reserved.
//

#import "DownGrayView.h"

@implementation DownGrayView

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    
    // 如果我们手动调用drawRect，系统是不会给我们生成View相关联的上下文
    // 系统调用drawRect的时候，才会生成跟View相关联上下文
//    [self drawRect:self.bounds];
    
    // setNeedDisplay底层会调用drawRect. 系统自动调用
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGPoint center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    CGFloat radius = rect.size.width * 0.5 -10;
    CGFloat startA = -M_PI_2;
    CGFloat endA = -M_PI_2 + self.progress * M_PI * 2;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    
    [path stroke];
}


@end
