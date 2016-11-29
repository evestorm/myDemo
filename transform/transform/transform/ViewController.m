//
//  ViewController.m
//  transform
//
//  Created by macbook on 16/11/29.
//  Copyright © 2016年 macbook. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *redView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [UIView animateWithDuration:1 animations:^{
        self.redView.transform = CGAffineTransformMakeTranslation(200, 0);
    }];
    // MakeTranslation:基于最开始的位置形变，每一次使用，把之前的形变清空,重新从最原始的位置形变
//    _redView.transform = CGAffineTransformMakeTranslation(200, 0);
    // Translate:相对于哪一次的形变
//    _redView.transform = CGAffineTransformTranslate(self.redView.transform, 0, 200);
    
    // 旋转
//    _redView.transform = CGAffineTransformMakeRotation(M_PI_2);
    // 缩放
//    _redView.transform = CGAffineTransformMakeScale(2.0, 0.5);
}

- (IBAction)transform:(id)sender {
    [UIView animateWithDuration:1 animations:^{
        self.redView.transform = CGAffineTransformTranslate(self.redView.transform, 0, 200);
    }];
}


@end
