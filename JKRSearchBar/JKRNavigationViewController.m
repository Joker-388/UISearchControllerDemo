//
//  JKRNavigationViewController.m
//  JKRSearchBar
//
//  Created by tronsis_ios on 17/3/31.
//  Copyright © 2017年 tronsis_ios. All rights reserved.
//

#import "JKRNavigationViewController.h"

@interface JKRNavigationViewController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) id popDelegate;

@end

@implementation JKRNavigationViewController

+ (void)load {
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    [bar setTintColor:[UIColor darkGrayColor]];
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    [item setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.interactivePopGestureRecognizer.delegate = viewController == self.viewControllers[0] ? self.popDelegate : nil;
}

@end
