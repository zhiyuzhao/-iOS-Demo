//
//  Counter.h
//  iOSCounter
//
//  Created by zhaozhiyu on 2017/2/2.
//  Copyright © 2017年 zhaozhiyu. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *CounterModelChanged = @"CounterModelChanged";

@interface Counter : NSObject
@property (nonatomic) NSUInteger count;

- (id)initWithUserDefault:(NSUserDefaults *)defaults;

- (void)increment;

- (void)decrement;

- (NSUInteger)getCountInDefaults;
@end
