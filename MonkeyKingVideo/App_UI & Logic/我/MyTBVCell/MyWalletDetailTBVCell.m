//
//  MyWalletDetailTBVCell.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/1.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MyWalletDetailTBVCell.h"

@interface MyWalletDetailTBVCell ()

@property(nonatomic,strong)UILabel *changeNumLab;

@end

@implementation MyWalletDetailTBVCell

+(instancetype)cellWith:(UITableView *)tableView{
    MyWalletDetailTBVCell *cell = (MyWalletDetailTBVCell *)[tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if (!cell) {
        cell = [[MyWalletDetailTBVCell alloc]initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:ReuseIdentifier
                                              marginX:3
                                              marginY:10];
        [UIView cornerCutToCircleWithView:cell.contentView
                          AndCornerRadius:5.f];
        [UIView colourToLayerOfView:cell.contentView
                         WithColour:kWhiteColor
                     AndBorderWidth:.1f];
    }return cell;
}

-(void)drawRect:(CGRect)rect{
    
}

+(CGFloat)cellHeightWithModel:(id _Nullable)model{
    return MAINSCREEN_HEIGHT / 15;
}

- (void)richElementsInCellWithModel:(id _Nullable)model{
    if ([model isKindOfClass:NSDictionary.class]) {
        NSDictionary *dic = (NSDictionary *)model;
        if ([dic[@"MKWalletMyFlowsListModel"] isKindOfClass:MKWalletMyFlowsListModel.class]) {
            MKWalletMyFlowsListModel *walletMyFlowsListModel = (MKWalletMyFlowsListModel *)dic[@"MKWalletMyFlowsListModel"];
            self.detailTextLabel.text = walletMyFlowsListModel.updateTime;
            if ([dic[@"MyWalletStyle"] intValue] == MyWalletStyle_CURRENTCOIN) {
                switch (walletMyFlowsListModel.goldType.intValue) {
                    case BalanceType_Style1:{
                        self.textLabel.text = @"视频收入";
                    }break;
                    case BalanceType_Style2:{
                        self.textLabel.text = @"完善身份信息收入";
                    }break;
                    case BalanceType_Style3:{
                        self.textLabel.text = @"填写邀请码收入";
                    }break;
                    case BalanceType_Style4:{
                        self.textLabel.text = @"完善实名信息收入";
                    }break;
                    case BalanceType_Style5:{
                        self.textLabel.text = @"签到收入";
                    }break;
                    default:
                        break;
                }
            }else if ([dic[@"MyWalletStyle"] intValue] == MyWalletStyle_CURRENTBALANCE){
                switch (walletMyFlowsListModel.balanceType.intValue) {
                    case BalanceDetail_Style1:{
                        self.textLabel.text = @"新人礼包";
                    }break;
                    case BalanceDetail_Style2:{
                        self.textLabel.text = @"金币转换零钱";
                    }break;
                    case BalanceDetail_Style3:{
                        self.textLabel.text = @"余额兑换会员";
                    }break;
                    case BalanceDetail_Style4:{
                        self.textLabel.text = @"活跃用户收入";
                    }break;
                    default:
                        break;
                }
            }
            switch (walletMyFlowsListModel.inOutType.intValue) {
                case InOutType_in:{
                    self.changeNumLab.textColor = KGreenColor;
                    self.changeNumLab.text = [NSString stringWithFormat:@"+ %@",walletMyFlowsListModel.amount];
                    self.contentView.backgroundColor = KSystemPinkColor;
                }break;
                case InOutType_out:{
                    self.changeNumLab.textColor = kRedColor;
                    self.changeNumLab.text = [NSString stringWithFormat:@"- %@",walletMyFlowsListModel.amount];
                    self.contentView.backgroundColor = kCyanColor;
                }break;
                default:
                    break;
                }
            }
    }
}
#pragma mark —— lazyLoad
-(UILabel *)changeNumLab{
    if (!_changeNumLab) {
        _changeNumLab = UILabel.new;
        [self.contentView addSubview:_changeNumLab];
        [_changeNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-15);
        }];
    }return _changeNumLab;
}


@end
