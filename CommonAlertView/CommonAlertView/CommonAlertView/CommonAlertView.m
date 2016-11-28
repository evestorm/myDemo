//
//  CommonAlertView.m
//  CommonAlertView
//
//  Created by macbook on 16/11/28.
//  Copyright © 2016年 macbook. All rights reserved.
//

#import "CommonAlertView.h"
#import <QuartzCore/QuartzCore.h>

#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)

const static CGFloat DefaultButtonHeight = 50;
const static CGFloat CornerRadius = 5.0f;
const static CGFloat margin = 8;

@implementation CommonAlertView

CGFloat buttonHeight = 0;
CGFloat buttonSpacerHeight = 0;
CGFloat viewOffsetY = 0;

- (instancetype)init {
    return [self initWithParentView:NULL];
}

/** 默认弹出框屏幕正中间，offsetY为向上的偏移量*/
- (instancetype)initWithOffsetY:(CGFloat)offsetY {
    viewOffsetY = offsetY;
    return [self initWithParentView:NULL];
}

- (instancetype)initWithParentView:(UIView *)parentView {
    self = [super init];
    if (self) {
        if (_parentView) {
            self.frame = _parentView.frame;
            parentView = _parentView;
        }else {
            self.frame = [UIApplication sharedApplication].keyWindow.frame;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureClick)];
            self.clickedBgCloseAlertView = NO;
            self.isUseDelegate = NO;
            [self addGestureRecognizer:tapGesture];
        }
    }
    return self;
}

- (void)tapGestureClick {
    if (self.clickedBgCloseAlertView == YES) {
        [self close];
        if (self.isUseDelegate == YES) {
            if (self.delegate != nil) {
                [self.delegate alertViewWhenClose];
            }
        }
    }
}

/**
 *  显示弹窗
 */
- (void)show {
    self.dialogView = [self createContainerView];
    self.dialogView.layer.shouldRasterize = YES;
    self.dialogView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
    
    self.dialogView.layer.opacity = 0.5f;
    self.dialogView.layer.transform = CATransform3DMakeScale(1.3f, 1.3f, 1.0);
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    [self addSubview:self.dialogView];
    
    
    if (self.parentView != NULL) {
        [self.parentView addSubview:self];
    } else {
        UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
        switch (interfaceOrientation) {
            case UIInterfaceOrientationLandscapeLeft:
                self.transform = CGAffineTransformMakeRotation(M_PI * 270.0 / 180.0);
                break;
                
            case UIInterfaceOrientationLandscapeRight:
                self.transform = CGAffineTransformMakeRotation(M_PI * 90.0 / 180.0);
                break;
                
            case UIInterfaceOrientationPortraitUpsideDown:
                self.transform = CGAffineTransformMakeRotation(M_PI * 180.0 / 180.0);
                break;
                
            default:
                break;
        }
        
        [self setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [[[[UIApplication sharedApplication] windows] firstObject] addSubview:self];
    }
    
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        //弹框后面的背景
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.15f];
        self.dialogView.layer.opacity = 1.0f;
        self.dialogView.layer.transform = CATransform3DMakeScale(1, 1, 1);
    } completion:^(BOOL finished) {
        
    }];
    
    if (self.time) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self close];
        });
    }
}

- (UIView *)createContainerView {
    if (self.containerView == NULL) {
        self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 150)];
    }
    
    CGSize screenSize = [self countScreenSize];
    CGSize dialogSize = [self countDialogSize];
    
    //给弹窗视图中添加UI和底部按钮
    (viewOffsetY == 0) ? viewOffsetY = (screenSize.height - dialogSize.height) * 0.5 : viewOffsetY;
    UIView *dialogContainer = [[UIView alloc] initWithFrame:CGRectMake((screenSize.width - dialogSize.width) * 0.5,  viewOffsetY , dialogSize.width, dialogSize.height)];
    
    if (self.topCorner) {
        UIRectCorner corner = UIRectCornerTopLeft | UIRectCornerTopRight;
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:dialogContainer.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(CornerRadius, CornerRadius)];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path.CGPath;
        dialogContainer.layer.mask = layer;
    }
    
    
    //弹窗视图中间分割线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, dialogContainer.bounds.size.height - buttonHeight - buttonSpacerHeight, dialogContainer.bounds.size.width, buttonSpacerHeight)];
    
    //内容和底部按钮分割线
    lineView.backgroundColor = self.lineViewColor ? self.lineViewColor : [UIColor colorWithRed:198.0/255.0 green:198.0/255.0 blue:198.0/255.0 alpha:1.0f];
    [dialogContainer addSubview:lineView];
    
    //添加内容视图
    [dialogContainer addSubview:self.containerView];
    
    // 添加各种按钮
    [self addButtonsToView:dialogContainer];
    
    return dialogContainer;
    
    
}

/**
 *  点击按钮后调用代理
 *
 */
- (void)dialogButtonTouchUpInside:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickedDialogButtonTouchUpInside:buttonAtIndex:)]) {
        [self.delegate clickedDialogButtonTouchUpInside:self buttonAtIndex:sender.tag];
    }
}

/**
 *  默认按钮行为
 *
 */
- (void)clickedDialogButtonTouchUpInside:(CommonAlertView *)alertView buttonAtIndex:(NSInteger)buttonIndex {
    [self close];
}


- (void)close {
    CATransform3D currentTransform = self.dialogView.layer.transform;
    
    CGFloat startRotation = [[self.dialogView valueForKeyPath:@"layer.transform.rotation.z"] floatValue];
    CATransform3D rotation = CATransform3DMakeRotation(-startRotation + M_PI * 270.0 / 180.0, 0.0f, 0.0f, 0.0f);
    
    self.dialogView.layer.transform = CATransform3DConcat(rotation, CATransform3DMakeScale(1, 1, 1));
    self.dialogView.layer.opacity = 1.0f;
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
        self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f];
        self.dialogView.layer.transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6f, 0.6f, 1.0));
        self.dialogView.layer.opacity = 0.0f;
    } completion:^(BOOL finished) {
        for (UIView *v in [self subviews]) {
            [v removeFromSuperview];
        }
        [self removeFromSuperview];
    }];
}


// 给容器添加按钮
- (void)addButtonsToView: (UIView *)container {
    if (self.buttonTitles.count > 0) {
        UIView *buttonBgView = [[UIView alloc] initWithFrame:CGRectMake(container.bounds.origin.x, container.bounds.size.height - buttonHeight, container.bounds.size.width, buttonHeight)];
        buttonBgView.backgroundColor = self.buttonBgViewColor ? self.buttonBgViewColor : [UIColor whiteColor];
        UIRectCorner corner = UIRectCornerBottomLeft | UIRectCornerBottomRight;
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:buttonBgView.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(CornerRadius, CornerRadius)];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path.CGPath;
        buttonBgView.layer.mask = layer;
        [container addSubview:buttonBgView];
    }
    
    NSInteger buttonBgColorCount = self.buttonBgColors.count;
    CGFloat buttonWidth = 0.0;
    if (buttonBgColorCount > 0) {
        buttonWidth = (container.bounds.size.width - (buttonBgColorCount + 1) * margin) / [self.buttonTitles count];
    }else {
        buttonWidth = container.bounds.size.width / [self.buttonTitles count];
    }
    
    for (int i=0; i<[self.buttonTitles count]; i++) {
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        if (buttonBgColorCount > 0) {
            closeButton.frame = CGRectMake(i * buttonWidth + margin * (i + 1), container.bounds.size.height + margin - buttonHeight, buttonWidth, buttonHeight - margin * 2);
            closeButton.backgroundColor = self.buttonBgColors[i];
        }else {
            closeButton.frame = CGRectMake(i * buttonWidth, container.bounds.size.height - buttonHeight, buttonWidth, buttonHeight);
        }
        
        [closeButton addTarget:self action:@selector(dialogButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        closeButton.tag = i;
        
        [closeButton setTitle:self.buttonTitles[i] forState:UIControlStateNormal];
        
        //按钮文字颜色
        UIColor *textColor;
        if (self.buttonTextColors.count == 1) {
            textColor = self.buttonTextColors[0];
        }
        
        if (!self.buttonTextColors.count) {
            textColor = [UIColor whiteColor];
        }
        
        if (self.buttonTextColors.count == self.buttonTitles.count) {
            textColor = self.buttonTextColors[i];
        }else {
            textColor = self.buttonTextColors[0];
        }
        
        [closeButton setTitleColor:textColor forState:UIControlStateNormal];
        [closeButton setTitleColor:textColor forState:UIControlStateHighlighted];
        
        if (self.layerCorner) {
            closeButton.layer.cornerRadius = self.layerCorner;
            closeButton.layer.masksToBounds = YES;
        }
        
        //按钮文字字体
        UIFont *textFont = self.buttonTextFont ? self.buttonTextFont : [UIFont boldSystemFontOfSize:14.0f];
        closeButton.titleLabel.font = textFont;
        [container addSubview:closeButton];
        
        if (i != self.buttonTitles.count - 1 && !buttonBgColorCount) {
            UIView *verticalLine = [[UIView alloc] init];
            verticalLine.backgroundColor = self.verticalLineColor ? self.verticalLineColor : [UIColor colorWithRed:198.0/255.0 green:198.0/255.0 blue:198.0/255.0 alpha:1.0f];
            verticalLine.frame = CGRectMake(CGRectGetMaxX(closeButton.frame), closeButton.frame.origin.y, SINGLE_LINE_WIDTH, closeButton.frame.size.height);
            [container addSubview:verticalLine];
        }
    }
}

// 返回弹窗视图的尺寸
- (CGSize)countDialogSize {
    CGFloat dialogWidth = self.containerView.frame.size.width;
    CGFloat dialogHeight = self.containerView.frame.size.height + buttonHeight + buttonSpacerHeight;
    return CGSizeMake(dialogWidth, dialogHeight);
}

// 返回屏幕的尺寸
- (CGSize)countScreenSize {
    if ([self.buttonTitles count] > 0) {
        buttonHeight = DefaultButtonHeight;
        buttonSpacerHeight = SINGLE_LINE_WIDTH;
    } else {
        buttonHeight = 0;
        buttonSpacerHeight = 0;
    }
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    return CGSizeMake(screenWidth, screenHeight);
}


@end
