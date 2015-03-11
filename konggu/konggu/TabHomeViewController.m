//
//  TabHomeViewController.m
//  konggu
//
//  Created by zhaoliang on 15/3/8.
//  Copyright (c) 2015年 zhaoliang. All rights reserved.
//

#import "TabHomeViewController.h"
#import "PureLayout.h"
#import "KGRequestTool.h"
#import "Account.h"
#import "Status.h"
#import "TabHomeCell.h"
#import "NSDictionary+Json.h"

#define LIST_TIMELINE_URL   @"https://api.weibo.com/2/statuses/friends_timeline.json"

@interface TabHomeViewController()

@property(nonatomic, strong) NSMutableArray *cellArray;
@property(nonatomic, strong) NSMutableArray *dataArray;
@property(nonatomic, strong) UITableView *tableView;
@end

@implementation TabHomeViewController

- (void)loadView
{
    self.tableView = [UITableView new];
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self initDta];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self.tableView registerClass:[TabHomeCell class] forCellReuseIdentifier:@"name"];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
}

- (void) initDta
{
    //请求数据
    Account *account = [[Account alloc] initWithArchiever];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"access_token"] = account.accessToken;
    [KGRequestTool GET:LIST_TIMELINE_URL parameters:param response:@"json" success:^(id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dict = (NSDictionary *)responseObject;
            for (NSDictionary *status in [dict arrayValueForKey:@"statuses"]) {
                Status *weibo = [[Status alloc] initWithJsonDictionary:status];
                NSLog(@"weibo:%@", status);
                [self.dataArray addObject:weibo];
                TabHomeCell *cell = [[TabHomeCell alloc] init];
                [self.cellArray addObject:cell];
            }
        }
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TabHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"name"];
    if (!cell) {
        cell = [[TabHomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"name"];
    }
    cell.weibo = [self.dataArray objectAtIndex:indexPath.row];
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TabHomeCell *cell = [self.cellArray objectAtIndex:indexPath.row];
    cell.weibo = [self.dataArray objectAtIndex:indexPath.row];
    return cell.height;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _dataArray;
}

- (NSMutableArray *)cellArray
{
    if (!_cellArray) {
        _cellArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _cellArray;
}
@end
