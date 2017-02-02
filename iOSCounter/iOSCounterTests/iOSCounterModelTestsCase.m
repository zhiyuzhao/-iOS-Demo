//
//  iOSCounterModelTestsCase.m
//  iOSCounter
//
//  Created by zhaozhiyu on 2017/2/2.
//  Copyright © 2017年 zhaozhiyu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMockito/OCMockito.h>
#import <OCHamcrest/OCHamcrest.h>
#import "Counter.h"

@interface iOSCounterModelTestsCase : XCTestCase

@end

@implementation iOSCounterModelTestsCase {
    Counter *sut;
    NSUserDefaults *mockDefaults;
    int modelChangedCount;
    NSInteger modelChangedValuel;
}

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    mockDefaults = mock([NSUserDefaults class]);
    sut = [[Counter alloc] initWithUserDefault:mockDefaults];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(counterModelChanged:) name:CounterModelChanged object:sut];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    sut = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)testInitShouldNotReturnNil {
    Counter *counter = [[Counter alloc] initWithUserDefault:[NSUserDefaults standardUserDefaults]];
    assertThat(counter, instanceOf([Counter class]));
}

- (void)testGetCountInDefaultsWithNilShouldReturnZero {
    [given([mockDefaults objectForKey:@"countInDefaultID"]) willReturn:nil];
    assertThatInteger([sut getCountInDefaults], equalToInteger(0));
}

- (void)testGetCountInDefaultsWithNumber3ShouldReturn3 {
    [given([mockDefaults objectForKey:@"countInDefaultID"]) willReturn:@3];
    assertThatInteger([sut getCountInDefaults], equalToInteger(3));
}

- (void)counterModelChanged:(NSNotification *)notification {
    ++modelChangedCount;
    Counter *counter = (Counter *)notification.object;
    modelChangedValuel = [counter count];
}

- (void)testIncrementShouldInvokeSetObject {
    [given([mockDefaults objectForKey:@"countInDefaultID"]) willReturn:@3];
    [sut increment];
    [verify(mockDefaults) setObject:@4 forKey:@"countInDefaultID"];
}

@end
