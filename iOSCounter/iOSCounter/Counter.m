//
//  Counter.m
//  iOSCounter
//
//  Created by zhaozhiyu on 2017/2/2.
//  Copyright © 2017年 zhaozhiyu. All rights reserved.
//

#import "Counter.h"
@interface Counter ()
@property (nonatomic, strong) NSUserDefaults* defaults;
@end

static NSString *countInDefaultID = @"countInDefaultID";

@implementation Counter
- (id)initWithUserDefault:(NSUserDefaults *)defaults
{
    self = [super init];
    if (self) {
        _defaults = defaults;
        _count = [self getCountInDefaults];
    }
    return self;
}

- (void)increment {
    _count = [self getCountInDefaults] + 1;
    [_defaults setObject:[NSNumber numberWithInteger:_count] forKey:countInDefaultID];
    [[NSNotificationCenter defaultCenter] postNotificationName:CounterModelChanged object:self];
}

- (void)decrement {
    _count = [self getCountInDefaults] - 1;
    [_defaults setObject:[NSNumber numberWithInteger:_count] forKey:countInDefaultID];
    [[NSNotificationCenter defaultCenter] postNotificationName:CounterModelChanged object:self];
}

- (NSUInteger)getCountInDefaults {
    NSNumber *reminderId = [_defaults objectForKey:countInDefaultID];
    if (reminderId) {
        reminderId =reminderId;
    } else {
        reminderId = @0;
    }
    
    return [reminderId integerValue];
}
@end
