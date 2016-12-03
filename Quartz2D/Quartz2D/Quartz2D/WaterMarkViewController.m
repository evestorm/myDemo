//
//  WaterMarkViewController.m
//  Quartz2D
//
//  Created by macbook on 16/12/1.
//  Copyright © 2016年 macbook. All rights reserved.
//

#import "WaterMarkViewController.h"
#import "UIImage+image.h"

@interface WaterMarkViewController ()
// uiimageView
@property (nonatomic,strong) IBOutlet UIImageView *imgView;
@end

@implementation WaterMarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.imgView.image = [self clipImageAndWaterMarkWith:@"阿狸头像"];
    self.imgView.image = [UIImage imageWithBorderWidth:10.0 borderColor:[UIColor yellowColor] image:[UIImage imageNamed:@"阿狸头像"]];
}

/** 带水印图像裁剪*/
- (UIImage *)clipImageAndWaterMarkWith:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    // 生成图片
    // size：开启一个多大的上下文
    // opaque：不透明
    // scale：0
    // 开启跟图片大小相同的上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0);
    
    // 裁剪
    // 在上下文添加一个圆形裁剪区域
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    // 把路径设置成裁剪区域
    [path addClip];
    
    // 把图片给绘制图片上下文
    [image drawAtPoint:CGPointZero];
    // 绘制文字
    NSString *str = @"Evestorm";
    [str drawAtPoint:CGPointMake(image.size.width * 0.5, image.size.height * 0.5) withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20],NSForegroundColorAttributeName : [UIColor yellowColor]}];
    
    
    // 生成图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 手动关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
