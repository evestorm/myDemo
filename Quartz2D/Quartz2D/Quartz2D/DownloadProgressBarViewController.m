//
//  DownloadProgressBarViewController.m
//  Quartz2D
//
//  Created by macbook on 16/11/30.
//  Copyright © 2016年 macbook. All rights reserved.
//

#import "DownloadProgressBarViewController.h"
#import "DownGrayView.h"

@interface DownloadProgressBarViewController ()
// 文本
@property (nonatomic,weak)IBOutlet UILabel *textLab;
// 进度View
@property (nonatomic,weak) IBOutlet DownGrayView *progressView;
@end

@implementation DownloadProgressBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _textLab.text = @"0.00%";
    
}

- (IBAction)valueChange:(UISlider *)sender {
//    NSLog(@"%f",sender.value);
    _textLab.text = [NSString stringWithFormat:@"%0.2f%%",sender.value * 100];
    self.progressView.progress = sender.value;
}


@end
