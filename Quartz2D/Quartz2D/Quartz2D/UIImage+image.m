//
//  UIImage+image.m
//  Quartz2D
//
//  Created by macbook on 16/12/3.
//  Copyright © 2016年 macbook. All rights reserved.
//

#import "UIImage+image.h"

@implementation UIImage (image)

+ (UIImage *)imageWithBorderWidth:(CGFloat)borderW borderColor:(UIColor *)color image:(UIImage *)image{
    
    //3.开启图片上下文.
    CGSize size = CGSizeMake(image.size.width + 2 * borderW, image.size.height + 2 * borderW);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    //4.先描述一个大圆,设为填充
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
    //设置边框的颜色
    [color set];
    [path fill];
    //5.再添加一个小圆,把小圆设裁剪区域
    
    path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderW, borderW, image.size.width, image.size.height)];
    [path addClip];
    
    //6.把图片给绘制上下文.
    [image drawInRect:CGRectMake(borderW, borderW, image.size.width, image.size.height)];
    //7.生成一张新的图片
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //8.关闭上下文.
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

@end
