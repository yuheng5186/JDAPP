//
//  DSServiceController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/20.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSServiceController.h"
#import "HQSliderView.h"
#import <Masonry.h>
#import "ProblemTitleModel.h"
#import "AnswerModel.h"
#import "HeadView.h"
#import "AnswerCell.h"

@interface DSServiceController ()<UITableViewDelegate, UITableViewDataSource, HQSliderViewDelegate, HeadViewDelegate>

@property (nonatomic, weak) UITableView *serviceListView;

/** 记录点击的是第几个Button */
@property (nonatomic, assign) NSInteger serviceTag;

@property (nonatomic, strong) NSMutableArray *answersArray;
@property (nonatomic, assign) CGSize textSize;

@end

@implementation DSServiceController

- (NSMutableArray *)answersArray{
    if (_answersArray == nil) {
        self.answersArray = [NSMutableArray array];
    }
    return _answersArray;
}

- (void)drawNavigation {
    
    [self drawTitle:@"客服"];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self loadData];
}


#pragma mark 加载数据
- (void)loadData
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"problemCenter.plist" withExtension:nil];
    NSArray *tempArray = [NSArray arrayWithContentsOfURL:url];
    
    self.answersArray = [NSMutableArray array];
    for (NSDictionary *dict in tempArray) {
        ProblemTitleModel *titleGroup = [ProblemTitleModel friendGroupWithDict:dict];
        [self.answersArray addObject:titleGroup];
    }
    
}


- (void)setupUI {
    
    [self setupTopServiceSliderView];
    
    UITableView *serviceListView = [[UITableView alloc] initWithFrame:CGRectMake(0, 108, Main_Screen_Width, Main_Screen_Height - 300)];
    serviceListView.delegate = self;
    serviceListView.dataSource = self;
    [self.view addSubview:serviceListView];
    self.serviceListView = serviceListView;
    self.serviceListView.sectionHeaderHeight = 50;
    
    
    //底部电话客服
    UIView *bottomPhoneView = [[UIView alloc] init];
    bottomPhoneView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomPhoneView];

    
    UIButton *phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    phoneBtn.backgroundColor = [UIColor whiteColor];
    [phoneBtn setTitle:@"电话客服" forState:UIControlStateNormal];
    //[phoneBtn setTintColor:[UIColor blackColor]];
    [phoneBtn setTitleColor:[UIColor colorFromHex:@"#4a4a4a"] forState:UIControlStateNormal];
   
    phoneBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [phoneBtn setImage:[UIImage imageNamed:@"kefuzixun"] forState:UIControlStateNormal];
    [bottomPhoneView addSubview:phoneBtn];
    
    [bottomPhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(60);
    }];
    
    [phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(bottomPhoneView);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(60);
    }];
    
    phoneBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [phoneBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    
    [phoneBtn addTarget:self action:@selector(showAlertWithMessage:) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)showAlertWithMessage:(NSString *)message{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"呼叫" message:@"13661682431" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancelAction];
    
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:OKAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - 创建上部的SliderView
- (void)setupTopServiceSliderView {
    
    HQSliderView *serviceSliderView = [[HQSliderView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 44)];
    serviceSliderView.titleArr = @[@"常见问题",@"车型疑问",@"APP使用"];
    serviceSliderView.delegate = self;
    [self.view addSubview:serviceSliderView];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.answersArray.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //    if (self.serviceTag == 0) {
    //        return 8;
    //    }else if (self.serviceTag == 1){
    //        return 3;
    //    }else{
    //        return 7;
    //    }
    ProblemTitleModel *titleGroup = self.answersArray[section];
    NSInteger count = titleGroup.isOpened ? titleGroup.infor.count : 0;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *id_serviceCell = @"id_serviceCell";
    
    AnswerCell * serviceCell = [tableView dequeueReusableCellWithIdentifier:id_serviceCell];
    if (!serviceCell) {
        serviceCell = [[[NSBundle mainBundle] loadNibNamed:@"AnswerCell" owner:self options:nil] lastObject];
    }
    serviceCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ProblemTitleModel *titleGroup = self.answersArray[indexPath.section];
    AnswerModel *answerModel = titleGroup.infor[indexPath.row];
    
    serviceCell.textViewLabel.text = answerModel.answer;
    
    self.textSize = [self getLabelSizeFortextFont:[UIFont systemFontOfSize:15] textLabel:answerModel.answer];
    
    
    //    if (serviceCell == nil) {
    //        serviceCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id_serviceCell];
    //    }
    //
    //    if (self.serviceTag == 0) {
    //        serviceCell.textLabel.text = [NSString stringWithFormat:@"全部 --- 第%ld行", indexPath.row];
    //    } else if (self.serviceTag == 1) {
    //        serviceCell.textLabel.text = [NSString stringWithFormat:@"待付款 --- 第%ld行", indexPath.row];
    //    }  else{
    //        serviceCell.textLabel.text = [NSString stringWithFormat:@"待评价 --- 第%ld行", indexPath.row];
    //    }
    
    return serviceCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.textSize.height+20;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HeadView *headView = [HeadView headViewWithTableView:tableView];
    
    headView.delegate = self;
    headView.titleGroup = self.answersArray[section];
    
    return headView;
}

- (void)clickHeadView
{
    [self.serviceListView reloadData];
}


- (CGSize)getLabelSizeFortextFont:(UIFont *)font textLabel:(NSString *)text{
    NSDictionary * totalMoneydic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
    CGSize totalMoneySize =[text boundingRectWithSize:CGSizeMake(Main_Screen_Width-16,1000) options:NSStringDrawingUsesLineFragmentOrigin  attributes:totalMoneydic context:nil].size;
    return totalMoneySize;
}


#pragma mark - 实现HQSliderView的代理
- (void)sliderView:(HQSliderView *)sliderView didClickMenuButton:(UIButton *)button{
    
    self.serviceTag = button.tag;
    [self.serviceListView reloadData];
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
