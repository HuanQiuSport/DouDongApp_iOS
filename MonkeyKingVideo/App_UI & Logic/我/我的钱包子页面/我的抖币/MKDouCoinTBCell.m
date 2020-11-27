//
//  MKDouCoinTBCell.m
//  MonkeyKingVideo
//
//  Created by admin on 2020/9/5.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKDouCoinTBCell.h"
@interface MKDouCoinTBCell ()

@property(nonatomic,strong)UILabel *changeNumLab;

@end

@implementation MKDouCoinTBCell

+(instancetype)cellWith:(UITableView *)tableView{
    MKDouCoinTBCell *cell = (MKDouCoinTBCell *)[tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if (!cell) {
        cell = [[MKDouCoinTBCell alloc]initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:ReuseIdentifier
                                              marginX:0
                                              marginY:0];
//        [UIView cornerCutToCircleWithView:cell.contentView
//                          AndCornerRadius:5.f];
//        [UIView colourToLayerOfView:cell.contentView
//                         WithColour:kWhiteColor
//                     AndBorderWidth:.1f];
    }return cell;
}

-(void)drawRect:(CGRect)rect{
    
}

+(CGFloat)cellHeightWithModel:(id _Nullable)model{
    return SCREEN_HEIGHT / 15;
}

- (void)richElementsInCellWithModel:(id _Nullable)model{
    if ([model isKindOfClass:NSDictionary.class]) {
        NSDictionary *dic = (NSDictionary *)model;
        if ([dic[@"MKWalletMyFlowsListModel"] isKindOfClass:MKWalletMyFlowsListModel.class]) {
            MKWalletMyFlowsListModel *walletMyFlowsListModel = (MKWalletMyFlowsListModel *)dic[@"MKWalletMyFlowsListModel"];
            self.detailTextLabel.text = [NSString timeStampConversionNSString:walletMyFlowsListModel.createTime ByFormat:@"yyyy年MM月dd日 HH:mm"];
            self.detailTextLabel.alpha = .6f;
            self.detailTextLabel.font = [UIFont systemFontOfSize:8];
            self.textLabel.font = [UIFont systemFontOfSize:12];
            self.textLabel.text = walletMyFlowsListModel.moneyType;
            switch (walletMyFlowsListModel.inOutType.intValue) {
                case InOutType_in:{
                    self.changeNumLab.textColor = HEXCOLOR(0x79BB24);
                    self.changeNumLab.text = [NSString stringWithFormat:@"+%@",walletMyFlowsListModel.amount];
//                    self.contentView.backgroundColor = KSystemPinkColor;
                }break;
                case InOutType_out:{
                    self.changeNumLab.textColor = kRedColor;
                    self.changeNumLab.text = [NSString stringWithFormat:@"%@",walletMyFlowsListModel.amount];
                    
                }break;
                default:
                    break;
                }
            }
        self.contentView.backgroundColor = UIColor.whiteColor; /// 统一是黑色背景
        self.textLabel.textColor = UIColor.blackColor; /// 统一是白色字体
        self.detailTextLabel.textColor = COLOR_HEX(0x8E8E92, 1);
    }
}
#pragma mark —— lazyLoad
-(UILabel *)changeNumLab{
    if (!_changeNumLab) {
        _changeNumLab = UILabel.new;
        [self.contentView addSubview:_changeNumLab];
        [_changeNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(SCALING_RATIO(-15));
        }];
    }return _changeNumLab;
}

@end
