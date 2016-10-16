//
//  ViewController.m
//  AYBubbleView
//
//  Created by Andy on 16/4/2.
//  Copyright © 2016年 AYJk. All rights reserved.
//

#import "ViewController.h"
#import "AYBubbleView.h"
@interface ViewController ()
@property (nonatomic, strong) AYBubbleView *bubbleView;
@property (weak, nonatomic) IBOutlet UIStepper *messageSteper;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.bubbleView = [[AYBubbleView alloc] initWithCenterPoint:self.view.center bubleRadius:15 addToSuperView:self.view];
    self.bubbleView.decayCoefficent = .2;
    self.bubbleView.unReadLabel.text = @"69";
//    bubbleView.unReadLabel.font = [UIFont systemFontOfSize:11.0];
    self.bubbleView.bubbleColor = [UIColor redColor];
    __weak typeof(self) weakSelf = self;
    self.bubbleView.cleanMessageBlock = ^(BOOL isClean) {
        if (isClean) {
            weakSelf.messageSteper.value = 0;
            [weakSelf setupBoom];
        } else {
//            do other logical operation
        }
    };
}
// 爆炸效果
- (void)setupBoom {
    // 变成气泡消失
    UIImageView * gitImageView = [[UIImageView alloc] init];
    gitImageView.frame = self.bubbleView.frontView.frame;
    
    [self.bubbleView.superview addSubview:gitImageView];
    
    NSMutableArray * arr = [NSMutableArray array];
    for (int i = 1; i < 9; i++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"boom.bundle/%d.jpg", i]];
        if(image !=nil){
            [arr addObject:image];
        }
    }
    
    gitImageView.animationImages = arr;
    
    gitImageView.animationDuration = 1.2;
    gitImageView.animationRepeatCount = 1;
    [gitImageView startAnimating];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
                       [gitImageView removeFromSuperview];
                   });
}
- (IBAction)stepperAction:(UIStepper *)sender {
    if (sender.value >= 1) {
        [self.bubbleView showBubbleView];
    }
    self.bubbleView.unReadLabel.text = [NSString stringWithFormat:@"%d",(int)sender.value];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
