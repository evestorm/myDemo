//
//  ViewController.m
//  uiapplication_singleton
//
//  Created by evestorm on 16/10/8.
//  Copyright © 2016年 evestorm. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 什么是单例:整个应用程序只有一份内存，并不会分配很多内存
    
    // 获取单例
    UIApplication *app = [UIApplication sharedApplication];
    NSLog(@"%@",app);
    
    // 苹果单例的实现
    // 1.不能外界调用alloc，调用就会崩溃，其实就是抛异常
    // 第一次调用alloc就不崩溃，其他都崩溃
    // 2.提供一个方法给外界获取单例
    // 3.内部创建一个单例，什么时候创建，程序启动的时候创建单例
    
    // 测试我们写的 Person 会不会抛出异常
//    [[Person alloc] init];
    
    Person *p = [Person sharedPerson];
    NSLog(@"%@",p);
    
}



@end
