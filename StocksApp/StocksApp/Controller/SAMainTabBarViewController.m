//
//  SAMainTabBarViewController.m
//  StocksApp
//
//  Created by Kape Man on 13/07/2016.
//  Copyright © 2016 Kape Man. All rights reserved.
//

#import "SAMainTabBarViewController.h"
#import "SAStocksViewController.h"

@interface SAMainTabBarViewController ()

@end

@implementation SAMainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *arr = [NSArray arrayWithObjects:@"Top", @"Gain", @"Lose", @"Me", nil];
    NSMutableArray *vcTabs = [NSMutableArray array];
    
    for (NSString *arrItem in arr) {
        SAStocksViewController *vc = [[SAStocksViewController alloc] initWithNibName:@"SAStocksViewController" bundle:[NSBundle mainBundle]];
        vc.title = arrItem;
        [vcTabs addObject:vc];
    }
    
    self.viewControllers = vcTabs;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
