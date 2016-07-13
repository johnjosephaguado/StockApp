//
//  SAStocksViewController.m
//  StocksApp
//
//  Created by Kape Man on 13/07/2016.
//  Copyright © 2016 Kape Man. All rights reserved.
//

#import "SAStocksViewController.h"
#import "SAWebServiceHelper.h"

@interface SAStocksViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tblStocks;
@property (nonatomic, strong) NSMutableArray *contents;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation SAStocksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.contents = [NSMutableArray arrayWithArray:[[SAWebServiceHelper sharedHelper] getStocksForCategory:self.title]];
    
    [self.tblStocks registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.tblStocks.delegate = self;
    self.tblStocks.dataSource = self;
    
    self.tblStocks.rowHeight = UITableViewAutomaticDimension;
    self.tblStocks.estimatedRowHeight = 80;
    
    self.tblStocks.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.tblStocks reloadData];
    
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshTriggered:)
                  forControlEvents:UIControlEventValueChanged];
    [self.tblStocks addSubview:self.refreshControl];
}

-(void) refreshTriggered:(id) sender{
    [self.tblStocks reloadData];
    [self.refreshControl endRefreshing];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];

    
    cell.textLabel.text = self.contents[indexPath.row];
    
    if(!cell.detailTextLabel.text) {
        [[SAWebServiceHelper sharedHelper] getPath:@"Lookup" withParam:@{@"input" : self.contents[indexPath.row]} withHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            if(!error){
                NSArray *tempResult = responseObject;
                
                NSString *stockName = @"";
                if(tempResult.count > 0) {
                    NSDictionary *dictResult = tempResult[0];
                    stockName = dictResult[@"Name"];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    UITableViewCell *cell = [self.tblStocks cellForRowAtIndexPath:indexPath];
                    cell.detailTextLabel.text = stockName;
                    [cell.contentView layoutIfNeeded];
                });
            }
        }];
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contents.count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
