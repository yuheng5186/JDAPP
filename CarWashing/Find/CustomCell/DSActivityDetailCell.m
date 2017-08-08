//
//  DSActivityDetailCell.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/8/1.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSActivityDetailCell.h"
#import "UIView+SDAutoLayout.h"
#import "UITableView+SDAutoTableViewCellHeight.h"


@implementation DSActivityDetailCell

{
    UIImageView *_iconImageView;
    UILabel     *_nameLabel;
    UILabel     *_contentLabel;
    UILabel     *_sayTimeLabel;
    
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createSubView];
    }
    return self;
}


- (void) createSubView {
    
    UIImageView     *view0 = [UIImageView new];
    view0.backgroundColor   = [UIColor redColor];
    _iconImageView          = view0;
    
    UILabel *lab1           = [UILabel new];
    lab1.textColor          = [UIColor lightGrayColor];
    lab1.font               = [UIFont systemFontOfSize:16];
    _nameLabel              = lab1;
    
    
    UILabel *lab2           = [UILabel new];
    lab2.textColor          = [UIColor lightGrayColor];
    lab2.font               = [UIFont systemFontOfSize:16];
    lab2.numberOfLines      = 0;
    _contentLabel           = lab2;
    
    UILabel *lab3           = [UILabel new];
    lab3.textColor          = [UIColor lightGrayColor];
    lab3.font               = [UIFont systemFontOfSize:16];
    _sayTimeLabel           = lab3;
    
    
    [self.contentView sd_addSubviews:@[view0,lab1,lab2,lab3]];
    
    
    _iconImageView.sd_layout
    .widthIs(40)
    .heightIs(40)
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 10);
    
    _nameLabel.sd_layout
    .topEqualToView(_iconImageView)
    .leftSpaceToView(_iconImageView, 10)
    .heightRatioToView(_iconImageView, 0.4);
    
    
    _contentLabel.sd_layout
    .topSpaceToView(_nameLabel, 10)
    .leftEqualToView(_nameLabel)
    .autoHeightRatio(0);
    
    _sayTimeLabel.sd_layout
    .rightSpaceToView(self.contentView, 10)
    .centerYEqualToView(_nameLabel)
    .heightIs(20);
    
    _iconImageView.sd_cornerRadiusFromWidthRatio = @(0.5);
    
    [_contentLabel setSingleLineAutoResizeWithMaxWidth:200];
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    [_sayTimeLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    
}


- (void) setModel:(DSUserModel *)model {
    
    _model  = model;
    _iconImageView.image    = [UIImage imageNamed:model.iconName];
    _nameLabel.text         = model.name;
    _contentLabel.text      = model.content;
    _sayTimeLabel.text      = model.sayTime;
    
    CGFloat bottomMargin = 0;
    
    
    [self setupAutoHeightWithBottomView:_contentLabel bottomMargin:bottomMargin];
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end