//
//  ViewController.m
//  CJAnimationTool
//
//  Created by JWCao on 2019/2/16.
//  Copyright © 2019年 曹纪伟. All rights reserved.
//

#import "ViewController.h"
#import "LCAnimationTips.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)down:(UIButton *)sender {
    [LCAnimationTips AddSignAnimationViewWithImageUrl:nil localImageName:@"chatbox_emoji_collected" startPoint:sender.center endPoint:CGPointZero size:CGSizeMake(50, 50) animationDissmis:YES animationTime:2 type:LCAnimationDirection_down handler:nil];
}
- (IBAction)up:(UIButton *)sender {
    [LCAnimationTips AddSignAnimationViewWithImageUrl:nil localImageName:@"chatbox_emoji_collected" startPoint:sender.center endPoint:CGPointZero size:CGSizeMake(50, 50) animationDissmis:YES animationTime:2 type:LCAnimationDirection_up handler:nil];
}
- (IBAction)right:(UIButton *)sender {
    [LCAnimationTips AddSignAnimationViewWithImageUrl:nil localImageName:@"chatbox_emoji_collected" startPoint:sender.center endPoint:CGPointZero size:CGSizeMake(50, 50) animationDissmis:YES animationTime:2 type:LCAnimationDirection_right handler:nil];
}
- (IBAction)left:(UIButton *)sender {
    [LCAnimationTips AddSignAnimationViewWithImageUrl:nil localImageName:@"chatbox_emoji_collected" startPoint:sender.center endPoint:CGPointZero size:CGSizeMake(50, 50) animationDissmis:YES animationTime:2 type:LCAnimationDirection_left handler:nil];
}
- (IBAction)jsonAnimation:(UIButton *)sender {
    [LCAnimationTips ShowAnimationWithAimationNamed:@"data_record.json" toView:nil centerPoint:sender.center size:CGSizeZero];
}
- (IBAction)mutiAnimation:(UIButton *)sender {
    [LCAnimationTips AddMultiAnimations:5 startPoint:sender.center imageUrl:nil localImageName:@"chatbox_emoji_collected"];
}

@end
