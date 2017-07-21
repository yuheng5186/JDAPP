//
//  BusinessDetailCell.h
//  CarWashing
//
//  Created by 时建鹏 on 2017/7/20.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;

@property (weak, nonatomic) IBOutlet UILabel *carLabel;

@property (weak, nonatomic) IBOutlet UILabel *clearLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;



+ (instancetype)businessDetailCell;

@end
