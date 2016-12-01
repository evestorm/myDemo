//
//  RenderTextView.m
//  Quartz2D
//
//  Created by macbook on 16/11/30.
//  Copyright © 2016年 macbook. All rights reserved.
//

#import "RenderTextView.h"

@implementation RenderTextView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
//    UIImage *image = [UIImage imageNamed:@"黄人"];

    UIImage *image = [UIImage imageNamed:@"001"];
    
    // 绘制出来的图片,是保持原始大小
    [image drawAtPoint:CGPointZero];
    // 把图片填充到这个rect中
//    [image drawInRect:rect];
    // 添加裁剪区域，吧超出裁剪区域以外的裁剪掉
//    UIRectClip(CGRectMake(0, 0, 50, 50));
    // 平铺图片
    [image drawAsPatternInRect:rect];
    
    UIRectFill(CGRectMake(0, 0, 100, 100));
}

- (void)drawText {
    NSString *str = @"EvestormEvestormEvestormEvestorm";
    
    // AtPoint:文字所画的位置
    // withAttributes:描述文字的属性
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:30];
    dict[NSForegroundColorAttributeName] = [UIColor yellowColor];
    dict[NSStrokeWidthAttributeName] = @2;
    //    dict[NSStrokeColorAttributeName] = [UIColor grayColor];
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeMake(10, 10);
    shadow.shadowColor = [UIColor greenColor];
    shadow.shadowBlurRadius = 2; // 阴影模糊
    dict[NSShadowAttributeName] = shadow;
    
    // 不会自动换行
    //    [str drawAtPoint:CGPointZero withAttributes:dict];
    // 会自动换行
    [str drawInRect:self.bounds withAttributes:dict];
}


@end
