//
//  ShareView.m
//  Share
//
//  Created by evestorm on 2017/2/6.
//  Copyright © 2017年 eve. All rights reserved.
//

#import "ShareView.h"
#import <UMSocialCore/UMSocialCore.h>
#import "APOpenAPI.h"
#import "UMSocialQQHandler.h"

#define kScreen_Bounds [UIScreen mainScreen].bounds
#define kScreen_Width [UIScreen mainScreen].bounds.size.width
#define kScreen_Height [UIScreen mainScreen].bounds.size.height

@interface ShareView ()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *shareContentView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *topLineView;
@property (nonatomic, strong) UIView *bottomLineView;
@property (nonatomic, strong) UIButton *dismissButton;

@property (nonatomic, strong) ShareModel *shareModel;

@property (nonatomic, strong) NSArray *shareShowImagesArray;/**< 图片数组*/
@property (nonatomic, strong) NSArray *shareShowTitlesArray;/**< 标题数组*/
@end

@implementation ShareView {
    UIViewController *_controller;
}

//+ (void)shareWithType:(NSInteger)type Title:(NSString *)title  andContent:(NSString *)content andImage:(NSString *)image andURL:(NSString *)url {
//
//        UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:
//                                            image];
//        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:content image:image location:nil urlResource:urlResource presentedController:nil completion:^(UMSocialResponseEntity *shareResponse){
//            
//            //            success(shareResponse.responseCode);
//            
//        }];
//    
//}

- (instancetype)initWithObj:(ShareModel *)obj controller:(id)controller {
    self = [super init];
    if (self) {
        self.shareModel = obj;
        _controller = (UIViewController *)controller;
        self.backgroundColor = [UIColor clearColor];
        self.frame = [UIScreen mainScreen].bounds;
        
        [self addViews];
        [self settingAutoLayout];
    }
    return self;
}

- (void)addViews {
    
    [self addSubview:self.bgView];
    [self addSubview:self.contentView];
    
    self.contentView.frame = CGRectMake(0, kScreen_Height, kScreen_Width, 300);
//    [self.contentView setSize:CGSizeMake(kScreen_Width, 300)];
//    [self.contentView setX:0];
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.topLineView];
    [self.contentView addSubview:self.bottomLineView];
    [self.contentView addSubview:self.dismissButton];
    [self.contentView addSubview:self.shareContentView];
}

- (void)settingAutoLayout {
//    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.mas_centerX);
//        make.top.mas_equalTo(self.mas_top).with.offset(10);
//        make.height.mas_equalTo(50);
//    }];
//    
//    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.button.mas_bottom).with.offset(10);
//        make.left.right.mas_equalTo(self.button);
//    }];
}

@end
