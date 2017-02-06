//
//  ViewController.m
//  Share
//
//  Created by evestorm on 2017/2/6.
//  Copyright © 2017年 eve. All rights reserved.
//

#import "ViewController.h"
#import <UShareUI/UShareUI.h>
#import "ShareView.h"
#import "ShareModel.h"

@interface ViewController ()

@end

@implementation ViewController {
    UIButton *_addBtn;
    UIButton *_customBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _addBtn = [UIButton buttonWithType:(UIButtonTypeContactAdd)];
    _addBtn.center = self.view.center;
    [_addBtn addTarget:self action:@selector(presentShareUI) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_addBtn];
    
    _customBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.center.x + 60, self.view.center.y, 100, 35)];
    [_customBtn setTitle:@"自定义" forState:(UIControlStateNormal)];
    [_customBtn addTarget:self action:@selector(customShareUI) forControlEvents:(UIControlEventTouchUpInside)];
    [_customBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self.view addSubview:_customBtn];
    
}

- (void)presentShareUI {
    //显示分享面板
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession)]];
    //显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        if (platformType == UMSocialPlatformType_Sina) {
            [self shareTextToPlatformType:UMSocialPlatformType_Sina];
        } else if (platformType == UMSocialPlatformType_QQ) {
            [self shareTextToPlatformType:UMSocialPlatformType_QQ];
        }
    }];
}

//- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType
//{
//    //创建分享消息对象
//    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//    //设置文本
//    messageObject.text = @"社会化组件UShare将各大社交平台接入您的应用，快速武装App。";
//    
//    //调用分享接口
//    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
//        if (error) {
//            NSLog(@"************Share fail with error %@*********",error);
//        }else{
//            NSLog(@"response data is %@",data);
//        }
//    }];
//}

- (void)customShareUI {
    ShareModel *shareModel = [[ShareModel alloc] init];
    ShareView *shareView = [[ShareView alloc] initWithObj:shareModel controller:self];
    [shareView shareShow];
}

- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = @"社会化组件UShare将各大社交平台接入您的应用，快速武装App。";
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}


@end
