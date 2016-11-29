//
//  TouchImageView.m
//  UITouch
//
//  Created by macbook on 16/11/29.
//  Copyright © 2016年 macbook. All rights reserved.
//

#import "TouchImageView.h"

@implementation TouchImageView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        // 默认UIImageView没有触摸事件，它里面的控件也不会有
        self.userInteractionEnabled = YES;
    }
    return self;
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 让当前控件随着手指移动而移动
    
    // 获取UITouch
    UITouch *touch = [touches anyObject];
    
    // 获取当前点
    CGPoint curP = [touch locationInView:self];
    
    // 获取上一个点
    CGPoint preP = [touch previousLocationInView:self];
    
    // 计算手指X轴偏移量
    CGFloat offsetX = curP.x - preP.x;
    
    // 计算手指Y轴偏移量
    CGFloat offsetY = curP.y - preP.y;
    
    // 修改控件的形变
    self.transform = CGAffineTransformTranslate(self.transform, offsetX, offsetY);
}

@end
