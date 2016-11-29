//
//  ViewController.m
//  手势识别
//
//  Created by macbook on 16/11/29.
//  Copyright © 2016年 macbook. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate>
// uiimageview
@property (nonatomic,weak) IBOutlet UIImageView *imgView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 默认一个手势只能支持一个方向
    // 如果想要多个方向，就再添加一个手势
    // 即一个控件支持添加多个手势
    // 但是一定不要造成手势冲突
    
    [self setUpPan];
}

#pragma mark - UIGestureRecognizerDelegate
// 是否允许接收手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    // 让控件左边点击，右边不点击
    CGPoint curP = [touch locationInView:_imgView];
    if (curP.x < _imgView.bounds.size.width * 0.5) {
        return YES;
    }
    return NO;
}

#pragma mark - 添加点按手势
/** 点按手势*/
- (void)setUpTap {
    // 点按
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    tap.delegate = self;
    
    [_imgView addGestureRecognizer:tap];
}

#pragma mark - 添加长按手势
/** 长按手势*/
- (void)setUpLongPress {
    // 长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    
    [_imgView addGestureRecognizer:longPress];
}

#pragma mark - 添加轻扫手势
/** 轻扫手势*/
- (void)setUpSwipe {
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe)];
    // 轻扫有方向，默认往右边
    swipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [_imgView addGestureRecognizer:swipe];
}

#pragma mark - 添加旋转手势
/** 旋转手势*/
- (void)setUpRotation {
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
    
    [_imgView addGestureRecognizer:rotation];
}

#pragma mark - 添加捏合手势
/** 捏合手势*/
- (void)setUpPinch {
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    
    [_imgView addGestureRecognizer:pinch];
}

#pragma mark - 添加拖拽手势
/** 拖拽手势*/
- (void)setUpPan {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    
    [_imgView addGestureRecognizer:pan];
}

#pragma mark - transform
- (void)tap {
    NSLog(@"%s",__func__);
}

- (void)longPress:(UILongPressGestureRecognizer *)longPress {
    // 在一开始长按得时候做事情
    if (longPress.state == UIGestureRecognizerStateBegan) {
        NSLog(@"长按了");
    }
//    NSLog(@"%s",__func__);
}

- (void)swipe {
    NSLog(@"%s",__func__);
}

- (void)rotation:(UIRotationGestureRecognizer *)rotation {
    
    self.imgView.transform = CGAffineTransformRotate(self.imgView.transform,rotation.rotation);
    
    // 复位
    rotation.rotation = 0;
    
    // 获取手势旋转的角度
//    NSLog(@"%f",rotation.rotation);
}

- (void)pinch:(UIPinchGestureRecognizer *)pinch {
    self.imgView.transform = CGAffineTransformScale(self.imgView.transform, pinch.scale, pinch.scale);
    pinch.scale = 1;
    // 获取手势缩放比例
//    NSLog(@"%f",pinch.scale);
}

- (void)pan:(UIPanGestureRecognizer *)pan {
    // 获取手势的触摸点
    CGPoint curP = [pan locationInView:self.imgView];
    
    
    // 移动视图
    // 获取手势的移动，也是相对最开始的位置
    CGPoint tranP = [pan translationInView:self.imgView];
    
    self.imgView.transform = CGAffineTransformTranslate(self.imgView.transform, tranP.x, tranP.y);
    
    [pan setTranslation:CGPointZero inView:self.imgView];
    
    NSLog(@"%@",NSStringFromCGPoint(curP));
}




@end
