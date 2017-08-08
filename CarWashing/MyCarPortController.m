//
//  MyCarPortController.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/7/31.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "MyCarPortController.h"
#import <Masonry.h>
#import "MyCarViewCell.h"
#import "IcreaseCarController.h"

@interface MyCarPortController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UIView *increaseView;

@property (nonatomic, weak) UITableView *carListView;

@end

static NSString *id_carListCell = @"id_carListCell";

@implementation MyCarPortController

- (UITableView *)carListView {
    
    if (_carListView == nil) {
        
        UITableView *carListView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height)];
        _carListView = carListView;
        [self.view addSubview:_carListView];
    }
    
    return _carListView;
}

//- (UIView *)increaseView {
//    
//    if (_increaseView == nil) {
//        
//        UIView *increaseView = [[UIView alloc] initWithFrame:CGRectMake(0, Main_Screen_Height - 60, Main_Screen_Width, 60)];
//        _increaseView = increaseView;
//        [self.view addSubview:_increaseView];
//    }
//    return _increaseView;
//}


- (void)drawNavigation {
    
    [self drawTitle:@"我的车库"];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}


- (void)setupUI {
    
    self.carListView.delegate = self;
    self.carListView.dataSource = self;
    self.carListView.rowHeight = 140;
    [self.carListView registerNib:[UINib nibWithNibName:@"MyCarViewCell" bundle:nil] forCellReuseIdentifier:id_carListCell];
    
    
    UIButton *increaseBtn = [UIUtil drawDefaultButton:self.view title:@"新增车辆" target:self action:@selector(didClickIncreaseButton)];
    
    [increaseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(351);
        make.height.mas_equalTo(48);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).mas_offset(-25);
    }];
}

#pragma mark - 数据源代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyCarViewCell *carCell = [tableView dequeueReusableCellWithIdentifier:id_carListCell];
    
    return carCell;
}


#pragma mark - 新增车辆
- (void)didClickIncreaseButton {
    
    IcreaseCarController *increaseVC = [[IcreaseCarController alloc] init];
    increaseVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:increaseVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
