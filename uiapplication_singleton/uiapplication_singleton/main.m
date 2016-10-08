//
//  main.m
//  uiapplication_singleton
//
//  Created by evestorm on 16/10/8.
//  Copyright © 2016年 evestorm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSLog(@"%s",__func__);
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
