//
//  ShareView.m
//  Share
//
//  Created by evestorm on 2017/2/6.
//  Copyright © 2017年 eve. All rights reserved.
//

#import "ShareView.h"
#import <Masonry.h>
#import <UShareUI/UShareUI.h>

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

#define kKeyWindow [UIApplication sharedApplication].keyWindow
#define kScreen_Bounds [UIScreen mainScreen].bounds
#define kScreen_Width [UIScreen mainScreen].bounds.size.width
#define kScreen_Height [UIScreen mainScreen].bounds.size.height

#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)

@implementation ShareView {
    UIViewController *_controller;
}

- (instancetype)initWithObj:(ShareModel *)obj controller:(id)controller {
    self = [super init];
    if (self) {
        self.shareModel = obj;
        _controller = (UIViewController *)controller;
        self.backgroundColor = [UIColor clearColor];
        self.frame = kScreen_Bounds;
        
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

- (void)showShareViewWithObj:(ShareModel *)obj controller:(id)controller{
    _controller = (UIViewController *)controller;
    self.shareModel = obj;
    [self shareShow];
}

/**
 *  分享弹窗显示
 */
- (void)shareShow {
    
    [self checkShareSnsValues];
    
    [kKeyWindow addSubview:self];
    
    CGPoint endCenter = self.contentView.center;
    endCenter.y -= CGRectGetHeight(self.contentView.frame);
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.bgView.alpha = 0.6;
        self.contentView.center = endCenter;
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)shareDismiss {
    
    CGPoint endCenter = self.contentView.center;
    endCenter.y += CGRectGetHeight(self.contentView.frame);
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.bgView.alpha = 0;
        self.contentView.center = endCenter;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)shareDismissWithCompletionBlock:(void (^)(void))completionBlock {
    CGPoint endCenter = self.contentView.center;
    endCenter.y += CGRectGetHeight(self.contentView.frame);
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.bgView.alpha = 0;
        self.contentView.center = endCenter;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (completionBlock) {
            completionBlock();
        }
    }];
}

- (void)checkShareSnsValues {
    self.shareShowImagesArray = @[@"circle_share",@"friends_share",@"weibo_icon",@"QQ_icon",@"kongjian_icon"];
    self.shareShowTitlesArray = @[@"朋友圈",@"微信好友",@"新浪微博",@"QQ好友",@"QQ空间"];
    //一行最多三个
    NSInteger maxCountForline = 3;
    if (self.shareShowTitlesArray.count<maxCountForline) {
        maxCountForline = self.shareShowTitlesArray.count;
    }
    CGFloat padding = (kScreen_Width - maxCountForline * [ShareView_Item itemWidth]) * 0.5;
    
    for (int index = 0; index < self.shareShowTitlesArray.count; index ++) {
        CGFloat itemX = padding + index %maxCountForline* [ShareView_Item itemWidth];
        ShareView_Item *item = [ShareView_Item itemWithsnsName:self.shareShowTitlesArray[index] imageName:self.shareShowImagesArray[index]];
        item.frame = CGRectMake(itemX, index/maxCountForline * 92, item.frame.size.width, item.frame.size.height);
//        item.y = index/maxCountForline * 92;
        [self.shareContentView addSubview:item];
        item.clickedBlock = ^(NSString *snsName) {
            [self shareItemClickedWithSnsName:snsName];
        };
    }
    
    
}

- (void)doShareSnsName:(NSString *)snsName {
    
    
//    DBLog(@"title===%@",self.shareModel.share_title);
    
    
    if ([snsName isEqualToString:@"朋友圈"]) {
        [self shareTextToPlatformType:(UMSocialPlatformType_WechatTimeLine)];
    }else if ([snsName isEqualToString:@"微信好友"]) {
        [self shareTextToPlatformType:(UMSocialPlatformType_WechatSession)];
    }else if ([snsName isEqualToString:@"新浪微博"]) {
        [self shareTextToPlatformType:(UMSocialPlatformType_Sina)];
    }else if ([snsName isEqualToString:@"QQ好友"]) {
        [self shareTextToPlatformType:(UMSocialPlatformType_QQ)];
    }else if ([snsName isEqualToString:@"QQ空间"]) {
        [self shareTextToPlatformType:(UMSocialPlatformType_Qzone)];
    }else if ([snsName isEqualToString:@"支付宝"]) {
//        snsPlatformStr = @"alipaysession";
        //        [self snsShareWithSnsPlatformStr:snsPlatformStr];
        [self shareToAliypay];
    }
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

-(void)shareToAliypay
{
//    //  创建消息载体 APMediaMessage 对象
//    APMediaMessage *message = [[APMediaMessage alloc] init];
//    
//    message.title =self.shareModel.share_title;
//    message.desc = self.shareModel.share_content.length > 600 ? [self.shareModel.share_content substringToIndex:600] : self.shareModel.share_content;
//    message.thumbUrl = self.shareModel.share_ImageUrl;
//    
//    //  创建网页类型的消息对象
//    APShareWebObject *webObj = [[APShareWebObject alloc] init];
//    webObj.wepageUrl =self.shareModel.share_url;
//    //  回填 APMediaMessage 的消息对象
//    message.mediaObject = webObj;
//    
//    //  创建发送请求对象
//    APSendMessageToAPReq *request = [[APSendMessageToAPReq alloc] init];
//    //  填充消息载体对象
//    request.message = message;
//    //  分享场景，0为分享到好友，1为分享到生活圈，9.9.5之后的支付宝不需要传此参数，用户会在跳转进支付宝后选择分享场景（好友、动态等）
//    request.scene = 0;
//    //  发送请求
//    BOOL result = [APOpenAPI sendReq:request];
//    if (!result) {
//        //失败处理
//        NSLog(@"发送失败");
//    }
    
}

- (void)shareItemClickedWithSnsName:(NSString *)snsName {
    void(^complete)() = ^() {
        [self doShareSnsName:snsName];
    };
    [self shareDismissWithCompletionBlock:complete];
}

#pragma mark - getter and setter
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareDismiss)];
        [_bgView addGestureRecognizer:gesture];
    }
    return _bgView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    }
    return _contentView;
}

- (UIView *)shareContentView {
    if (!_shareContentView) {
        _shareContentView = [[UIView alloc] init];
        _shareContentView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    }
    return _shareContentView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:15.0];
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.text = @"分享到";
    }
    return _titleLabel;
}

- (UIView *)topLineView {
    if (!_topLineView) {
        _topLineView = [[UIView alloc] init];
        _topLineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _topLineView;
}

- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _bottomLineView;
}

- (UIButton *)dismissButton {
    if (!_dismissButton) {
        _dismissButton = [[UIButton alloc] init];
        _dismissButton.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
        [_dismissButton setTitle:@"取消" forState:UIControlStateNormal];
        [_dismissButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _dismissButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [_dismissButton addTarget:self action:@selector(shareDismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dismissButton;
}


- (NSArray *)shareShowImagesArray {
    if (!_shareShowImagesArray) {
        _shareShowImagesArray = [[NSArray alloc] init];
    }
    return _shareShowImagesArray;
}

- (NSArray *)shareShowTitlesArray {
    if (!_shareShowTitlesArray) {
        _shareShowTitlesArray = [[NSArray alloc] init];
    }
    return _shareShowTitlesArray;
}

- (void)settingAutoLayout {
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.contentView);
        make.height.mas_equalTo(50-SINGLE_LINE_WIDTH);
    }];
    
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.titleLabel.mas_bottom);
        make.height.mas_equalTo(SINGLE_LINE_WIDTH);
    }];
    
    [self.dismissButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(50 - SINGLE_LINE_WIDTH);
    }];
    
    
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.dismissButton.mas_top);
        make.height.mas_equalTo(SINGLE_LINE_WIDTH);
    }];
    
    
    [self.shareContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.topLineView.mas_bottom);
        make.bottom.mas_equalTo(self.bottomLineView.mas_top);
    }];
    
}

@end

@interface ShareView_Item ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *title;

@end

@implementation ShareView_Item

- (instancetype)init {
    self = [super initWithFrame:CGRectMake(0, 0, [ShareView_Item itemWidth], [ShareView_Item itemHeight])];
    if (self) {
        [self addSubview:self.button];
        [self addSubview:self.title];
        [self settingAutoLayout];
        
    }
    return self;
}

#pragma mark - 实例化方法
+ (instancetype)itemWithsnsName:(NSString *)snsName imageName:(NSString *)imageName{
    ShareView_Item *item = [[ShareView_Item alloc] init];
    item.snsName = snsName;
    item.imageName = imageName;
    return item;
}

+ (CGFloat)itemWidth {
    return 92;//图片的宽度 + 图片间距
}

+ (CGFloat)itemHeight {
    return 100;
}


- (void)setSnsName:(NSString *)snsName {
    _snsName = snsName;
    self.title.text = snsName;
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    [self.button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self.button setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
}

- (void)itemButtonClicked {
    if (self.clickedBlock) {
        self.clickedBlock(_snsName);
    }
}

#pragma mark - getter and setter
- (UIButton *)button {
    if (!_button) {
        _button = [[UIButton alloc] init];
        [_button addTarget:self action:@selector(itemButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.font = [UIFont systemFontOfSize:12.0];
        _title.textColor = [UIColor grayColor];
    }
    return _title;
}

- (void)settingAutoLayout {
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_top).with.offset(10);
        make.height.mas_equalTo(50);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.button.mas_bottom).with.offset(10);
        make.left.right.mas_equalTo(self.button);
    }];
    
}


@end
