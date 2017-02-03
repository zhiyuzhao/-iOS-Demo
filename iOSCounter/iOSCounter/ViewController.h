//
//  ViewController.h
//  iOSCounter
//
//  Created by zhaozhiyu on 2017/2/2.
//  Copyright © 2017年 zhaozhiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Counter;

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *counterLabel;
@property (weak, nonatomic) IBOutlet UIButton *increaseButton;
@property (weak, nonatomic) IBOutlet UIButton *decreaseButton;

@property (nonatomic, strong) Counter *counter;

- (IBAction)clickIncreaseButton:(id)sender;
- (IBAction)clickDecreaseButton:(id)sender;

@end

