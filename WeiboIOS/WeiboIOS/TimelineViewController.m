//
//  TimelineViewController.m
//  WeiboIOS
//
//  Created by zhaoliang on 15/3/2.
//  Copyright (c) 2015年 zhaoliang. All rights reserved.
//

#import "TimelineViewController.h"
#import "WeiboItemCell.h"

@interface TimelineViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UINib *nib = [UINib nibWithNibName:@"WeiboItem" bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"WeiboItem"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeiboItemCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"WeiboItem" forIndexPath:indexPath];
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
