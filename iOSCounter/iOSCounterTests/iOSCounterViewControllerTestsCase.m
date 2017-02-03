//
//  iOSCounterViewControllerTestsCase.m
//  iOSCounter
//
//  Created by zhaozhiyu on 2017/2/3.
//  Copyright © 2017年 zhaozhiyu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMockito/OCMockito.h>
#import <OCHamcrest/OCHamcrest.h>
#import "ViewController.h"
#import "Counter.h"

@interface iOSCounterViewControllerTestsCase : XCTestCase

@end

@implementation iOSCounterViewControllerTestsCase {
    ViewController *sut;
    Counter *mockCounter;
}

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;

    mockCounter = mock([Counter class]);
    sut = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"counterVC"];
    [sut view];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    sut = nil;
}

// 验证storyboard，View的连接
- (void)testPlusButtonShouldBeConnected {
    UIButton *button = [sut increaseButton];
    assertThat(button, is(notNilValue()));
}

// 验证Action绑定正确
- (void)testPlusButtonAction {
    UIButton *button = [sut increaseButton];
    assertThat([button actionsForTarget:sut forControlEvent:UIControlEventTouchUpInside], contains(@"clickIncreaseButton:",nil));
}

// 验证Controller发送消息正确
- (void)testPlusButtonClick {
    sut.counter = mockCounter;
    [sut clickIncreaseButton:nil];
    [verify(mockCounter) increment]; // 验证 model 增加方法被调用
}

// 验证更新视图
- (void)testModelChangedNotificationShouldUpdateCountLabel {
    sut.counter = mockCounter;
    [given([mockCounter count]) willReturn:@2];
    // FIXME zzy 这儿发出通知但没有被方法响应！！
    [[NSNotificationCenter defaultCenter] postNotificationName:CounterModelChanged object:mockCounter];
    assertThat([[sut counterLabel] text], is(@"2"));
}
@end
