//
//  ViewController.m
//  归档解档
//
//  Created by macbook on 16/11/29.
//  Copyright © 2016年 macbook. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIButton *readBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)save:(id)sender {
    // 存储自定义对象使用归档
    
    // 创建自定义对象
    Person *person = [[Person alloc] init];
    person.age = 20;
    person.name = @"sw";
    
    // 获取caches文件夹
    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    // 拼接文件名
    NSString *filePath = [cachesPath stringByAppendingPathComponent:@"person.data"];
    
    // object: 需要归档的对象
    // file: 文件全路径
    // 任何对象都可以进行归档
    [NSKeyedArchiver archiveRootObject:person toFile:filePath];
    // 调用自定义对象的 encodeWithCoder:
    // 如果一个自定义对象需要归档，必须遵守NSCoding协议，并且实现协议的方法
}

- (IBAction)read:(id)sender {
    // 获取caches文件夹
    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    // 拼接文件名
    NSString *filePath = [cachesPath stringByAppendingPathComponent:@"person.data"];
    
    // 存进去是什么，读出来也是什么对象
    Person *p = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    NSLog(@"%@,%d",p.name,p.age);
}

@end
