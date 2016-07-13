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
    
    NSArray *arr = [NSArray arrayWithObjects:@"Top", @"Gain", @"Lose", @"My Stocks", nil];
    NSMutableArray *vcTabs = [NSMutableArray array];
    
    for (NSString *arrItem in arr) {
        SAStocksViewController *vc = [[SAStocksViewController alloc] initWithNibName:@"SAStocksViewController" bundle:[NSBundle mainBundle]];
        vc.title = arrItem;
//        vc.tabBarItem.image =
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        
        [vcTabs addObject:nav];
    }
    
    self.viewControllers = vcTabs;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
