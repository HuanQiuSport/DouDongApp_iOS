//
//  MyWalletTBVCell.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/24.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MyWalletTBVCell.h"

@interface Coin ()

@property(nonatomic,strong)UILabel *titleLab;

@end

@implementation Coin

-(instancetype)initWithTitleStr:(NSString *)titleStr{
    if (self = [super init]) {
        self.backgroundColor = HEXCOLOR(0x242A37);
        self.coinIMGV.alpha = 1;
        self.showNumLab.alpha = 1;
        self.titleLab.text = titleStr;
    }return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    @weakify(self)
    [UIView addViewAnimation:self.coinIMGV
             completionBlock:^(id data) {
        @strongify(self)
        if (self.actionBlock) {
            self.actionBlock(@1);
        }
    }];
}

-(void)action:(MKDataBlock)actionBlock{
    self.actionBlock = actionBlock;
}

#pragma mark —— lazyLoad
-(UIImageView *)coinIMGV{
    if (!_coinIMGV) {
        _coinIMGV = UIImageView.new;
        [self addSubview:_coinIMGV];
        [_coinIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCALING_RATIO(35), SCALING_RATIO(35)));
            make.left.equalTo(self);
            make.centerY.equalTo(self);
        }];
    }return _coinIMGV;
}

-(UILabel *)showNumLab{
    if (!_showNumLab) {
        _showNumLab = UILabel.new;
        _showNumLab.textColor = kWhiteColor;
        _showNumLab.text = @"0";
        _showNumLab.font = [UIFont fontWithName:@"SFUDINMitAlt"
                                           size:19];
        _showNumLab.textAlignment = NSTextAlignmentCenter;
        _showNumLab.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_showNumLab];
        [_showNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.coinIMGV);
            make.bottom.equalTo(self.mas_centerY);
            make.left.equalTo(self.coinIMGV.mas_right).offset(SCALING_RATIO(5));
            make.right.equalTo(self);
        }];
    }return _showNumLab;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.adjustsFontSizeToFitWidth = YES;
        _titleLab.font = [UIFont fontWithName:@"PingFangSC-Regular"
                                         size:14];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.textColor = [UIColor whiteColor];
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.coinIMGV.mas_right).offset(SCALING_RATIO(5));
            make.right.equalTo(self);
            make.top.equalTo(self.mas_centerY);
            make.bottom.equalTo(self);
        }];
    }return _titleLab;
}

@end

@interface MyWalletTBVCell ()

@property(nonatomic,strong)UIView *backV;

@end

@implementation MyWalletTBVCell

+(instancetype)cellWith:(UITableView *)tableView{
    MyWalletTBVCell *cell = (MyWalletTBVCell *)[tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if (!cell) {
        cell = [[MyWalletTBVCell alloc]initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:ReuseIdentifier
                                              marginX:3
                                              marginY:10];
        
        cell.contentView.backgroundColor = HEXCOLOR(0x242A37);
        [cell shadowCell];
    }return cell;
}

-(void)drawRect:(CGRect)rect{
    self.backV.alpha = 1;
    self.coin_1_V.alpha = 1;
    self.coin_2_V.alpha = 1;
}

+(CGFloat)cellHeightWithModel:(id _Nullable)model{
    return isiPhoneX_series() ? (SCREEN_HEIGHT / 9) : (SCREEN_HEIGHT / 8.5);
}

- (void)richElementsInCellWithModel:(id _Nullable)model{
    if ([model isKindOfClass:NSDictionary.class]) {
        NSDictionary *dic = (NSDictionary *)model;
        self.coin_1_V.showNumLab.text = [NSString ensureNonnullString:dic[@"goldNumber"] ReplaceStr:@"0"];
        self.coin_2_V.showNumLab.text = [NSString ensureNonnullString:dic[@"balance"] ReplaceStr:@"0"];
    }
}

-(void)action:(MKDataBlock)actionBlock{
    self.actionBlock = actionBlock;
}

#pragma mark —— lazyLoad
-(UIView *)backV{
    if (!_backV) {
        _backV = UIView.new;
        _backV.backgroundColor = HEXCOLOR(0x242A37);
        [UIView cornerCutToCircleWithView:_backV
                          AndCornerRadius:10];
        [self.contentView addSubview:_backV];
        [_backV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(SCALING_RATIO(15));
            make.left.equalTo(self.contentView).offset(SCALING_RATIO(15));
            make.right.equalTo(self.contentView).offset(SCALING_RATIO(-15));
            make.bottom.equalTo(self.contentView).offset(SCALING_RATIO(-15));
        }];
    }return _backV;
}

-(Coin *)coin_1_V{
    if (!_coin_1_V) {
        _coin_1_V = [[Coin alloc] initWithTitleStr:@"当前金币（个）"];
        _coin_1_V.tagStr = @"当前金币";
//        _coin_1_V.coinIMGV.image = [UIImage animatedGIFNamed:@"金币"];
        _coin_1_V.coinIMGV.image = KIMG(@"金币");
        @weakify(self);
        [_coin_1_V action:^(id data) {
             @strongify(self)
            self.actionBlock(self->_coin_1_V);
        }];
        [self.backV addSubview:_coin_1_V];
        [_coin_1_V mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backV).offset(SCALING_RATIO(15));
            make.centerY.equalTo(self.backV);
            make.size.mas_equalTo(CGSizeMake(SCALING_RATIO(150), SCALING_RATIO(50)));
        }];
    }return _coin_1_V;
}

-(Coin *)coin_2_V{
    if (!_coin_2_V) {
        _coin_2_V = [[Coin alloc] initWithTitleStr:@"当前余额（元）"];
        _coin_2_V.tagStr = @"当前余额";
//        _coin_2_V.coinIMGV.image = [UIImage animatedGIFNamed:@"钱袋"];
        _coin_2_V.coinIMGV.image = KIMG(@"余额");
        @weakify(self)
        [_coin_2_V action:^(id data) {
            @strongify(self)
            self.actionBlock(self->_coin_2_V);
        }];
        [self.backV addSubview:_coin_2_V];
        [_coin_2_V mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.backV);
            make.size.mas_equalTo(CGSizeMake(SCALING_RATIO(150), SCALING_RATIO(50)));
            make.right.equalTo(self.backV).offset(SCALING_RATIO(-15));
        }];
    }return _coin_2_V;
}

@end
