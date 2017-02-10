//
//  ViewController.m
//  循环引用
//
//  Created by evestorm on 2017/2/7.
//  Copyright © 2017年 eve. All rights reserved.
//

#import "ViewController.h"
typedef void (^MyBlock)();
@interface ViewController ()
/** block*/
@property (nonatomic, copy) MyBlock myblock;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

- (void)dealloc {
    NSLog(@"%s",__FUNCTION__);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //    __weak typeof(self)weakSelf = self;
    self.myblock = ^{
        NSLog(@"%@",self.view);
    };
}


@end
