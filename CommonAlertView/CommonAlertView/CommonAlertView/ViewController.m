//
//  ViewController.m
//  CommonAlertView
//
//  Created by evestorm on 16/11/28.
//  Copyright © 2016年 evestorm. All rights reserved.
//

#import "ViewController.h"
#import "CommonAlertView.h"

@interface ViewController ()<CommonAlertViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *launchDialog = [UIButton buttonWithType:UIButtonTypeCustom];
    [launchDialog setFrame:CGRectMake(10, 30, self.view.bounds.size.width-20, 50)];
    [launchDialog addTarget:self action:@selector(launchDialog:) forControlEvents:UIControlEventTouchDown];
    [launchDialog setTitle:@"Launch Dialog" forState:UIControlStateNormal];
    [launchDialog setBackgroundColor:[UIColor whiteColor]];
    [launchDialog setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [launchDialog.layer setBorderWidth:0];
    [launchDialog.layer setCornerRadius:5];
    [self.view addSubview:launchDialog];
}

- (void)launchDialog:(id)sender {
    CommonAlertView *alertView = [[CommonAlertView alloc] initWithOffsetY:100];
    
    alertView.containerView = [self createDemoView];
    alertView.buttonTitles = @[@"残忍拒绝", @"任性投票"];
    alertView.buttonTextColors = @[[UIColor whiteColor],[UIColor blackColor]];
    alertView.buttonTextFont = [UIFont boldSystemFontOfSize:11.0f];
    alertView.buttonBgColors = @[[UIColor lightGrayColor],[UIColor greenColor]];
    alertView.delegate = self;
    alertView.topCorner = YES;
    alertView.layerCorner = 5.0f;
//    alertView.clickedBgCloseAlertView = YES;
    //    alertView.time = 1.0f;
    alertView.lineViewColor = [UIColor blackColor];
    alertView.verticalLineColor = [UIColor blueColor];
    [alertView show];
}

- (void)clickedDialogButtonTouchUpInside:(CommonAlertView *)alertView buttonAtIndex:(NSInteger)buttonIndex {
    [alertView close];
}

- (UIView *)createDemoView {
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 200)];
    demoView.backgroundColor = [UIColor yellowColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 270, 180)];
    imageView.backgroundColor = [UIColor lightGrayColor];
    [demoView addSubview:imageView];
    
    return demoView;
}

@end
