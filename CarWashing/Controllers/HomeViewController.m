//
//  HomeViewController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/19.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "HomeViewController.h"
#import "DSMessagesController.h"
#import "SXScrPageView.h"
#import "DSAdDetailController.h"
#import "DSCardGroupController.h"
#import "PurchaseViewController.h"
#import "MenuTabBarController.h"
#import "DSExchangeController.h"

#import "JFLocation.h"
#import "JFAreaDataManager.h"
#import "JFCityViewController.h"

#define KCURRENTCITYINFODEFAULTS [NSUserDefaults standardUserDefaults]

@interface HomeViewController ()<JFLocationDelegate,UITableViewDelegate,UITableViewDataSource>

/** 选择的结果*/
@property (strong, nonatomic) UILabel *resultLabel;
@property (nonatomic, strong) UIButton  *locationButton;
/** 城市定位管理器*/
@property (nonatomic, strong) JFLocation *locationManager;
/** 城市数据管理器*/
@property (nonatomic, strong) JFAreaDataManager *manager;

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation HomeViewController


- (void) drawContent {
    
    self.statusView.hidden      = YES;
    
    self.navigationView.hidden  = YES;
    self.contentView.top        = 0;
    self.contentView.height     = self.view.height;
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"首页";
    self.navigationController.navigationBar.hidden = YES;
    
    [self createSubView];
    
    self.locationManager = [[JFLocation alloc] init];
    _locationManager.delegate = self;
    
}
- (JFAreaDataManager *)manager {
    if (!_manager) {
        _manager = [JFAreaDataManager shareManager];
        [_manager areaSqliteDBData];
    }
    return _manager;
}

- (void) createSubView {
    
    
    
    self.tableView                  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width,Main_Screen_Height) style:UITableViewStylePlain];
    self.tableView.top              = 0;
    self.tableView.delegate         = self;
    self.tableView.dataSource       = self;
    //    self.tableView.separatorStyle   = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor  = [UIColor whiteColor];
    //    self.tableView.scrollEnabled    = NO;
//    self.tableView.tableFooterView  = [UIView new];
    
    [self.contentView addSubview:self.tableView];
    
    
    
    
    UIView *upView                  = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*58/667) color:[UIColor whiteColor]];
    upView.top                      = 0;
    
    NSString *titleName              = @"首页";
    UIFont *titleNameFont            = [UIFont boldSystemFontOfSize:18];
    UILabel *titleNameLabel          = [UIUtil drawLabelInView:upView frame:[UIUtil textRect:titleName font:titleNameFont] font:titleNameFont text:titleName isCenter:NO];
    titleNameLabel.textColor         = [UIColor blackColor];
    titleNameLabel.centerX           = upView.centerX;
    titleNameLabel.centerY           = upView.centerY +Main_Screen_Height*10/667;
    
//    NSMutableArray * images = [NSMutableArray array];
//    
//    for (NSInteger i = 0; i<4; i++)
//    {
//        [images addObject:[NSString stringWithFormat:@"%02ld.jpg",i+1]];
//    }
//    
//    SXScrPageView * sxView =   [SXScrPageView direcWithtFrame:CGRectMake(0, 80, Main_Screen_Width, 200) ImageArr:images AndImageClickBlock:^(NSInteger index) {
//        
//        DSAdDetailController *viewVC = [[DSAdDetailController alloc]init];
//        [self.navigationController pushViewController:viewVC animated:YES];
//        
//        
//    }];
//    [self.view addSubview:sxView];
    
    
    UIImage *messagesImage           = [UIImage imageNamed:@"icon_messagebox"];
    UIButton  *messagesButton        = [UIUtil drawButtonInView:upView frame:CGRectMake(0, 0, messagesImage.size.width, messagesImage.size.height) iconName:@"icon_messagebox" target:self action:@selector(messagesButtonClick:)];
    messagesButton.right             = Main_Screen_Width -Main_Screen_Width*10/375;
    messagesButton.centerY           = titleNameLabel.centerY;
    
    
    self.locationButton        = [UIButton buttonWithType:UIButtonTypeCustom];
    self.locationButton.frame             = CGRectMake(0, 0, 100, 30);
    self.locationButton.backgroundColor   = [UIColor whiteColor];
    [self.locationButton setTitle:@"上海市" forState:UIControlStateNormal];
    [self.locationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.locationButton.titleLabel.font   = [UIFont systemFontOfSize:16];
    self.locationButton.left              = 10;
    self.locationButton.centerY           = titleNameLabel.centerY;
    [self.locationButton addTarget:self action:@selector(locationButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.locationButton setImage:[UIImage imageNamed:@"icon_arrow_down"] forState:UIControlStateNormal];
    self.locationButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -80);
    [self.locationButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -60, 0, 0)];
    
    [upView addSubview:self.locationButton];
    

}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return 5;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 340;
    }
    return 180;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellStatic = @"cellStatic";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStatic];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    }
    cell.backgroundColor    = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView  *recordimageView       = [UIUtil drawCustomImgViewInView:cell.contentView frame:CGRectMake(0, 0, 50, 50) imageName:@"xiaofei"];
    recordimageView.left                = Main_Screen_Width*10/375;
    recordimageView.top                 = Main_Screen_Height*10/667;
    
    NSString *titleString              = @"消费记录";
    UIFont *titleStringFont            = [UIFont systemFontOfSize:14];
    UILabel *titleStringLabel          = [UIUtil drawLabelInView:cell.contentView frame:[UIUtil textRect:titleString font:titleStringFont] font:titleStringFont text:titleString isCenter:NO];
    titleStringLabel.textColor         = [UIColor blackColor];
    titleStringLabel.left              = recordimageView.right +Main_Screen_Width*10/375;
    titleStringLabel.top               = Main_Screen_Height*15/667;
    
    NSString *timeString              = @"2017-7-27 15:30";
    UIFont *timeStringFont            = [UIFont systemFontOfSize:14];
    UILabel *timeStringLabel          = [UIUtil drawLabelInView:cell.contentView frame:[UIUtil textRect:timeString font:timeStringFont] font:timeStringFont text:timeString isCenter:NO];
    timeStringLabel.textColor         = [UIColor blackColor];
    timeStringLabel.left              = recordimageView.right +Main_Screen_Width*10/375;
    timeStringLabel.top               = titleStringLabel.bottom +Main_Screen_Height*5/667;
    
    NSString *contentString              = @"洗车月卡";
    UIFont *contentStringFont            = [UIFont systemFontOfSize:18];
    UILabel *contentStringLabel          = [UIUtil drawLabelInView:cell.contentView frame:[UIUtil textRect:contentString font:contentStringFont] font:contentStringFont text:contentString isCenter:NO];
    contentStringLabel.textColor         = [UIColor blackColor];
    contentStringLabel.left              = timeStringLabel.left;
    contentStringLabel.top               = recordimageView.bottom +Main_Screen_Height*10/667;
    
    NSString *contentShowString              = @"自动扫码支付";
    UIFont *contentShowStringFont            = [UIFont systemFontOfSize:18];
    UILabel *contentShowStringLabel          = [UIUtil drawLabelInView:cell.contentView frame:[UIUtil textRect:contentShowString font:contentShowStringFont] font:contentShowStringFont text:contentShowString isCenter:NO];
    contentShowStringLabel.textColor         = [UIColor blackColor];
    contentShowStringLabel.left              = contentStringLabel.left;
    contentShowStringLabel.top               = contentStringLabel.bottom +Main_Screen_Height*10/667;
    
    NSString *remindShowString              = @"还剩余8次自动扫码洗车";
    UIFont *remindShowStringFont            = [UIFont systemFontOfSize:18];
    UILabel *remindShowStringLabel          = [UIUtil drawLabelInView:cell.contentView frame:[UIUtil textRect:remindShowString font:remindShowStringFont] font:remindShowStringFont text:remindShowString isCenter:NO];
    remindShowStringLabel.textColor         = [UIColor blackColor];
    remindShowStringLabel.left              = contentShowStringLabel.left;
    remindShowStringLabel.top               = contentShowStringLabel.bottom +Main_Screen_Height*10/667;
    
    if (indexPath.row == 0) {
        recordimageView.image           = nil;
        titleStringLabel.text           = nil;
        timeStringLabel.text            = nil;
        contentStringLabel.text         = nil;
        contentShowStringLabel.text     = nil;
        remindShowStringLabel.text      = nil;
        
        UIView *payView                   = [UIUtil drawLineInView:cell.contentView frame:CGRectMake(0, 0, Main_Screen_Width*60/375, Main_Screen_Height*80/667) color:[UIColor clearColor]];
        payView.left                      = Main_Screen_Width*20/375;
        payView.top                       = Main_Screen_Height*40/375;
        
        UITapGestureRecognizer  *tapPayGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPayButtonClick:)];
        [payView addGestureRecognizer:tapPayGesture];
        
        UIImageView *payImageView      = [UIUtil drawCustomImgViewInView:payView frame:CGRectMake(0, 0, 50,40) imageName:@"duihuan"];
        payImageView.left              = Main_Screen_Width*30/375;
        payImageView.top               = Main_Screen_Height*10/667;
        
        NSString *payName              = @"兑换";
        UIFont *payNameFont            = [UIFont systemFontOfSize:16];
        UILabel *payNameLabel          = [UIUtil drawLabelInView:payView frame:[UIUtil textRect:payName font:payNameFont] font:payNameFont text:payName isCenter:NO];
        payNameLabel.textColor         = [UIColor blackColor];
        payNameLabel.centerX           = payImageView.centerX;
        payNameLabel.top               = payImageView.bottom +Main_Screen_Height*10/667;
        
        
        UIView *scanView                   = [UIUtil drawLineInView:cell.contentView frame:CGRectMake(0, 0, Main_Screen_Width*60/375, Main_Screen_Height*80/667) color:[UIColor clearColor]];
        scanView.left                      = payView.right +Main_Screen_Width*50/375;
        scanView.top                       = Main_Screen_Height*40/375;
        
        UITapGestureRecognizer  *tapScanGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapScanButtonClick:)];
        [scanView addGestureRecognizer:tapScanGesture];
        
        UIImageView *scanImageView      = [UIUtil drawCustomImgViewInView:scanView frame:CGRectMake(0, 0, 50,40) imageName:@"xiche"];
        scanImageView.left              = Main_Screen_Width*30/375;
        scanImageView.top               = Main_Screen_Height*10/667;
        
        NSString *scanName              = @"扫码洗车";
        UIFont *scanNameFont            = [UIFont systemFontOfSize:16];
        UILabel *scanNameLabel          = [UIUtil drawLabelInView:scanView frame:[UIUtil textRect:scanName font:scanNameFont] font:scanNameFont text:scanName isCenter:NO];
        scanNameLabel.textColor         = [UIColor blackColor];
        scanNameLabel.centerX           = scanImageView.centerX;
        scanNameLabel.top               = scanImageView.bottom +Main_Screen_Height*10/667;
        
        UIView *cardBagView                   = [UIUtil drawLineInView:cell.contentView frame:CGRectMake(0, 0, Main_Screen_Width*60/375, Main_Screen_Height*80/667) color:[UIColor clearColor]];
        cardBagView.left                      = scanView.right +Main_Screen_Width*50/375;
        cardBagView.top                       = Main_Screen_Height*40/375;
        
        UITapGestureRecognizer  *tapCardBagGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCardBagButtonClick:)];
        [cardBagView addGestureRecognizer:tapCardBagGesture];
        
        UIImageView *cardBagImageView      = [UIUtil drawCustomImgViewInView:cardBagView frame:CGRectMake(0, 0, 50,40) imageName:@"kabao"];
        cardBagImageView.left              = Main_Screen_Width*30/375;
        cardBagImageView.top               = Main_Screen_Height*10/667;
        
        NSString *cardBagName              = @"卡包";
        UIFont *cardBagNameFont            = [UIFont systemFontOfSize:16];
        UILabel *cardBagNameLabel          = [UIUtil drawLabelInView:cardBagView frame:[UIUtil textRect:cardBagName font:cardBagNameFont] font:cardBagNameFont text:cardBagName isCenter:NO];
        cardBagNameLabel.textColor         = [UIColor blackColor];
        cardBagNameLabel.centerX           = cardBagImageView.centerX;
        cardBagNameLabel.top               = cardBagImageView.bottom +Main_Screen_Height*10/667;
        
        NSString *restName              = @"剩余8次";
        UIFont *restNameFont            = [UIFont systemFontOfSize:16];
        UILabel *restNameLabel          = [UIUtil drawLabelInView:scanView frame:[UIUtil textRect:restName font:restNameFont] font:restNameFont text:restName isCenter:NO];
        restNameLabel.textColor         = [UIColor grayColor];
        restNameLabel.centerX           = scanNameLabel.centerX;
        restNameLabel.top               = scanNameLabel.bottom +Main_Screen_Height*5/667;
        
        UIView *lineView                   = [UIUtil drawLineInView:cell.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*1/667) color:[UIColor grayColor]];
        lineView.top                       = cardBagView.bottom +Main_Screen_Height*40/667;
    
        UIView *newBagView                  = [UIUtil drawLineInView:cell.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*120/667) color:[UIColor clearColor]];
        newBagView.top                      = lineView.bottom +Main_Screen_Height*20/667;
        
        UIImageView *newImageView           = [UIUtil drawCustomImgViewInView:newBagView frame:CGRectMake(0, 0, Main_Screen_Width,120) imageName:@"banka"];
        newImageView.top                    = 0;
        
        UITapGestureRecognizer  *tapNewGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapNewButtonClick:)];
        [newBagView addGestureRecognizer:tapNewGesture];
        
    }if (indexPath.row == 1) {
        recordimageView.image   = [UIImage imageNamed:@"quanyi"];
        titleStringLabel.text   = @"用户权益";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}


- (void) messagesButtonClick:(id)sender {
    
    DSMessagesController *messageController     = [[DSMessagesController alloc]init];
    messageController.hidesBottomBarWhenPushed  = YES;
    [self.navigationController pushViewController:messageController animated:YES];
}

- (void) locationButtonClick:(id)sender {
    
    JFCityViewController *cityViewController = [[JFCityViewController alloc] init];
    cityViewController.title = @"城市";
    __weak typeof(self) weakSelf = self;
    [cityViewController choseCityBlock:^(NSString *cityName) {
        
        [weakSelf.locationButton setTitle:cityName forState:UIControlStateNormal];
        
        weakSelf.resultLabel.text = cityName;
    }];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:cityViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
    
}
#pragma mark --- JFLocationDelegate

//定位中...
- (void)locating {
    NSLog(@"定位中...");
}

//定位成功
- (void)currentLocation:(NSDictionary *)locationDictionary {
    NSString *city = [locationDictionary valueForKey:@"City"];
    if (![_resultLabel.text isEqualToString:city]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"您定位到%@，确定切换城市吗？",city] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _resultLabel.text = city;
            [KCURRENTCITYINFODEFAULTS setObject:city forKey:@"locationCity"];
            [KCURRENTCITYINFODEFAULTS setObject:city forKey:@"currentCity"];
            [self.manager cityNumberWithCity:city cityNumber:^(NSString *cityNumber) {
                [KCURRENTCITYINFODEFAULTS setObject:cityNumber forKey:@"cityNumber"];
            }];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

/// 拒绝定位
- (void)refuseToUsePositioningSystem:(NSString *)message {
    NSLog(@"%@",message);
}

/// 定位失败
- (void)locateFailure:(NSString *)message {
    NSLog(@"%@",message);
}

- (void) tapPayButtonClick:(id)sender {
    DSExchangeController *exchangeVC        = [[DSExchangeController alloc]init];
    exchangeVC.hidesBottomBarWhenPushed     = YES;
    [self.navigationController pushViewController:exchangeVC animated:YES];
    
}
- (void) tapScanButtonClick:(id)sender {
    
    
}
- (void) tapCardBagButtonClick:(id)sender {
    
    DSCardGroupController *cardGroupController      = [[DSCardGroupController alloc]init];
    cardGroupController.hidesBottomBarWhenPushed    = YES;
    [self.navigationController pushViewController:cardGroupController animated:YES];
    
}
- (void) tapNewButtonClick:(id)sender {

    MenuTabBarController *menuTabBarController	= [[MenuTabBarController alloc] init];
    [menuTabBarController setSelectedIndex:3];
    menuTabBarController.tabBarItem.tag = 3;
    
    PurchaseViewController *purchaseController  = [[PurchaseViewController alloc]init];
    purchaseController.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:purchaseController animated:YES];

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
