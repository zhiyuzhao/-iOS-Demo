//
//  ViewController.m
//  iOSCounter
//
//  Created by zhaozhiyu on 2017/2/2.
//  Copyright © 2017年 zhaozhiyu. All rights reserved.
//

#import "ViewController.h"
#import "Counter.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *counterLabel;
@property (weak, nonatomic) IBOutlet UIButton *increaseButton;
@property (weak, nonatomic) IBOutlet UIButton *decreaseButton;

@property (nonatomic, strong) Counter *counter;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _counter = [[Counter alloc] initWithUserDefault:[NSUserDefaults standardUserDefaults]];
    _counterLabel.text = [NSString stringWithFormat:@"%ld",_counter.count];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(valueChanged:) name:CounterModelChanged object:_counter];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)valueChanged:(id)sender {
    _counterLabel.text = [NSString stringWithFormat:@"%ld",_counter.count];
}
- (IBAction)clickIncreaseButton:(id)sender {
    [_counter increment];
}

- (IBAction)clickDecreaseButton:(id)sender {
    [_counter decrement];
}

@end
