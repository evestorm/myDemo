//
//  Person.h
//  归档解档
//
//  Created by macbook on 16/11/29.
//  Copyright © 2016年 macbook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject<NSCoding>
@property (nonatomic, assign) int age;
@property (nonatomic, strong) NSString *name;
@end
