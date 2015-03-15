//
//  TabHomeViewController.m
//  konggu
//
//  Created by zhaoliang on 15/3/8.
//  Copyright (c) 2015年 zhaoliang. All rights reserved.
//

#import "TabHomeViewController.h"
#import "KGRequestTool.h"
#import "Account.h"
#import "Status.h"
#import "TabHomeCell.h"
#import "NSDictionary+Json.h"

#define kListTimeLineUrl   @"https://api.weibo.com/2/statuses/friends_timeline.json"

@interface TabHomeViewController(){
    NSMutableArray *_cellArray;
    NSMutableArray *_dataArray;
}

@end

@implementation TabHomeViewController

- (void)loadView
{
    self.tableView = [UITableView new];
    [self setupViews];
    [self setupDatas];
}

/*- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 400;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}*/

- (void)setupViews
{
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setupDatas
{
    //请求数据
    Account *account = [[Account alloc] initWithArchiever];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"access_token"] = account.accessToken;
    [KGRequestTool GET:kListTimeLineUrl parameters:param response:@"json" success:^(id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dict = (NSDictionary *)responseObject;
            _dataArray = [[NSMutableArray alloc] init];
            _cellArray = [[NSMutableArray alloc] init];
            for (NSDictionary *status in [dict arrayValueForKey:@"statuses"]) {
                Status *weibo = [[Status alloc] initWithDictionary:status];
                [_dataArray addObject:weibo];
                TabHomeCell *cell = [[TabHomeCell alloc] init];
                [_cellArray addObject:cell];
            }
        }
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TabHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"name"];
    if (cell == nil) {
        cell = [[TabHomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"name"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.status = [_dataArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TabHomeCell *cell = [_cellArray objectAtIndex:indexPath.row];
    cell.status = [_dataArray objectAtIndex:indexPath.row];
    return cell.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
