//
//  UIImage+image.h
//  Quartz2D
//
//  Created by macbook on 16/12/3.
//  Copyright © 2016年 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (image)
/** 给图片设置边框
  * borderW:边框宽度
  * borderColor:边框颜色
  * image:要设置边框的图片
  */
+ (UIImage *)imageWithBorderWidth:(CGFloat)borderW borderColor:(UIColor *)color image:(UIImage *)image;
@end
