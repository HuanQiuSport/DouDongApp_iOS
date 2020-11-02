//
//  VedioCell.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/30.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "VideoCell.h"
#import "MKVideoDemandModel.h"
@interface VideoCell (){
    
}

/// 用户头像
@property(nonatomic,strong)UIImageView *mkVideoUserImageView;

///  喜欢红心按钮
@property(nonatomic,strong)UIButton *showDataBtn;
@property(nonatomic,strong)UILabel *titleLab;

/// 时间标签
@property(nonatomic,strong)UILabel *mkTimeLabel;
@property(nonatomic,strong)UIView *mkBotomBackView;

/// 视频封面图片
@property(nonatomic,strong)UIImageView *mkBackImageView;

/// 暂停图片
@property(nonatomic,strong)UIImageView *mkStopImageView;

/// 状态文本
@property(nonatomic,strong)UILabel *mkStatusLabel;

/// 数据模型
@property (strong,nonatomic) MKVideoDemandModel *mkVideoModel;
@end

@implementation VideoCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

    }return self;
}

-(void)drawRect:(CGRect)rect{
    self.backgroundColor = [UIColor whiteColor];
}

+(CGFloat)cellHeightWithModel:(id _Nullable)model{
    return SCREEN_HEIGHT / 10;
}

-(void)richElementsInCellWithModel:(id _Nullable)model{
  
    self.mkVideoModel = (MKVideoDemandModel *)model;
    switch (self.mkVideoType) {
        case MKVideoType_Attention:{
            
            [self.mkBackImageView sd_setImageWithURL:[NSURL URLWithString:self.mkVideoModel.videoImg] placeholderImage:KIMG(@"videoFont")];
            self.mkBackImageView.contentMode = UIViewContentModeScaleToFill;
//            self.mkBackImageView.contentMode = UIViewContentModeRedraw;
            self.mkBackImageView.clipsToBounds = YES;
            [self.mkVideoUserImageView sd_setImageWithURL:[NSURL URLWithString:self.mkVideoModel.headImage] placeholderImage:KIMG(@"videoFont")];
            
            
            self.titleLab.text = [NSString ensureNonnullString:[NSString stringWithFormat:@"@%@",self.mkVideoModel.author] ReplaceStr:@"@抖动"];
            
            self.titleLab.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
            
            self.mkTimeLabel.text = [MKTools backgroundTimeIsEqualCurrentDateWith:self.mkVideoModel.publishTime];
            self.mkTimeLabel.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
//            self.mkTimeLabel.font = [UIFont systemFontOfSize:8.0 weight:UIFontWeightRegular];
            
            self.mkBotomBackView.alpha = 1;
            
            self.titleLab.alpha = 1;
            
            self.mkTimeLabel.alpha = 1;
            
            
            
        }break;
        case MKVideoType_Like:{
            
            [self.mkBackImageView sd_setImageWithURL:[NSURL URLWithString:self.mkVideoModel.videoImg]];
            
            self.mkBotomBackView.alpha = 1;
            self.mkStopImageView.alpha = 1;
            self.mkBackImageView.contentMode = UIViewContentModeScaleToFill;
            self.mkBackImageView.clipsToBounds = YES;
//            self.mkBackImageView.contentScaleFactor = 0.5;
            [self.showDataBtn setTitle:self.mkVideoModel.praiseNum forState:UIControlStateNormal];
            
            if ([self.mkVideoModel.isPraise isEqualToString:@"1"]) {
                [self.showDataBtn setImage:KIMG(@"心型") forState:UIControlStateNormal];
            }else{
                [self.showDataBtn setImage:KIMG(@"心型") forState:UIControlStateNormal];
            }
            
            [self.showDataBtn titleLabel].font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
            [self.showDataBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView.mas_left).offset(5*KDeviceScale);
                make.centerY.equalTo(self.mkBotomBackView.mas_centerY);
            }];
            
           
        }break;
        case MKVideoType_MadeInMe:{
#pragma mark - 调整发布状态
            if (self.mkVideoModel.videoStatus.integerValue == 0) {
                //待审核
                self.mkVideoOfReviewType = MKVideoOfReviewType_review;
            } else if (self.mkVideoModel.videoStatus.integerValue == 1) {
                //审核通过
                self.mkVideoOfReviewType = MKVideoOfReviewType_success;
            } else if (self.mkVideoModel.videoStatus.integerValue == 2) {
                //审核不通过
                self.mkVideoOfReviewType = MKVideoOfReviewType_fail;
            }
            [self.mkBackImageView sd_setImageWithURL:[NSURL URLWithString:self.mkVideoModel.videoImg]];
            self.mkBackImageView.contentMode = UIViewContentModeScaleToFill;
            self.mkBackImageView.clipsToBounds = YES;
//            self.mkBackImageView.contentScaleFactor = 0.5;
            switch (self.mkVideoOfReviewType) {
                    
                case MKVideoOfReviewType_success: // 发布成功
                {
                    self.titleLab.alpha = 0;
                    self.mkBotomBackView.alpha = 1;
                    self.mkStopImageView.alpha = 1;
                    self.mkStatusLabel.alpha = 0; // 感叹号
                    self.showDataBtn.alpha = 1; // 点赞按钮
                    [self.showDataBtn setTitle:self.mkVideoModel.praiseNum forState:UIControlStateNormal];
                    
                    if ([self.mkVideoModel.isPraise isEqualToString:@"1"]) {
                        [self.showDataBtn setImage:KIMG(@"心型") forState:UIControlStateNormal];
                    }else{
                        [self.showDataBtn setImage:KIMG(@"心型") forState:UIControlStateNormal];
                    }
                    
                    [self.showDataBtn titleLabel].font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular];
                    [self.showDataBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.contentView.mas_left).offset(5*KDeviceScale);
                        make.centerY.equalTo(self.mkBotomBackView.mas_centerY);
                    }];
                    
                    
                } break;
                case MKVideoOfReviewType_fail: // 发布失败
                {
                    self.mkStatusLabel.alpha = 1; // 感叹号
                    self.mkBotomBackView.alpha = 0; // 底部状态
                    self.mkStopImageView.alpha = 0; // 播放按钮
                    self.titleLab.alpha = 0; // 底部状态审核中
                    self.showDataBtn.alpha = 0; // 点赞按钮
                    
                } break;
                case MKVideoOfReviewType_review: // 审核中
                {
                     self.mkStatusLabel.alpha = 0; // 感叹号
                    self.mkBotomBackView.alpha = 1; // 显示底部状态
                    self.mkStopImageView.alpha = 0; // 隐藏播放按钮
                    self.titleLab.alpha = 1; // 显示底部状态审核中
                    self.showDataBtn.alpha = 0; // 隐藏点赞按钮
                    
                    self.titleLab.text = @"审核中";
                    
                    self.titleLab.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
                    self.titleLab.textAlignment = NSTextAlignmentCenter;
                    [self.titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.left.right.equalTo(self.mkBotomBackView);
                        make.bottom.equalTo(self.mkBotomBackView).offset(-8);
                    }];
                    
                    
                } break;
                    
                default:{
                }break;
            }
//            if (self.mkVideoModel.videoStatus.integerValue == 0) {
//                //待审核
//                self.mkVideoOfMineType = MKVideoOfMineTypeC;
//            } else if (self.mkVideoModel.videoStatus.integerValue == 1) {
//                //审核通过
//                self.mkVideoOfMineType = MKVideoOfMineTypeE;
//            } else if (self.mkVideoModel.videoStatus.integerValue == 2) {
//                //审核不通过
//                self.mkVideoOfMineType = MKVideoOfMineTypeD;
//            }
//            [self.mkBackImageView sd_setImageWithURL:[NSURL URLWithString:self.mkVideoModel.videoImg]];
//            self.mkBackImageView.contentMode = UIViewContentModeScaleToFill;
//            self.mkBackImageView.clipsToBounds = YES;
////            self.mkBackImageView.contentScaleFactor = 0.5;
//            switch (self.mkVideoOfMineType) {
//
//                case MKVideoOfMineTypeA: // 发布成功
//                {
//                    self.mkBotomBackView.alpha = 1;
//                    self.mkStopImageView.alpha = 1;
//
//                    [self.showDataBtn setTitle:self.mkVideoModel.praiseNum forState:UIControlStateNormal];
//
//                    if ([self.mkVideoModel.isPraise isEqualToString:@"1"]) {
//                        [self.showDataBtn setImage:KIMG(@"心型") forState:UIControlStateNormal];
//                    }else{
//                        [self.showDataBtn setImage:KIMG(@"心型") forState:UIControlStateNormal];
//                    }
//
//                    [self.showDataBtn titleLabel].font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular];
//                    [self.showDataBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//                        make.left.equalTo(self.contentView.mas_left).offset(5*KDeviceScale);
//                        make.centerY.equalTo(self.mkBotomBackView.mas_centerY);
//                    }];
//
//
//                } break;
//                case MKVideoOfMineTypeB: // 发布失败 暂时没有
//                {
//                    self.titleLab.alpha = 1;
//
//                    self.titleLab.text = self.mkVideoModel.videoTitle;
//
//                    self.titleLab.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
//
//                    [self.titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
//                        make.left.right.bottom.equalTo(self.mkBotomBackView);
//                    }];
//
//
//                } break;
//
//                case MKVideoOfMineTypeC: // 审核通过
//                {
//                    self.mkBotomBackView.alpha = 1;
//                    self.mkStopImageView.alpha = 1;
//
//                    [self.showDataBtn setTitle:self.mkVideoModel.praiseNum forState:UIControlStateNormal];
//
//                    if ([self.mkVideoModel.isPraise isEqualToString:@"1"]) {
//                        [self.showDataBtn setImage:KIMG(@"心型") forState:UIControlStateNormal];
//                    }else{
//                        [self.showDataBtn setImage:KIMG(@"心型") forState:UIControlStateNormal];
//                    }
//
//                    [self.showDataBtn titleLabel].font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
//                    [self.showDataBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//                        make.left.equalTo(self.contentView.mas_left).offset(5*KDeviceScale);
//                        make.centerY.equalTo(self.mkBotomBackView.mas_centerY);
//                    }];
//                } break;
//                case MKVideoOfMineTypeD: // 审核未通过
//                {
//                    self.mkStopImageView.alpha = 1;
//                    self.mkStatusLabel.alpha = 1;
//
//                } break;
//                case MKVideoOfMineTypeE: // 审核中
//                {
//
//                    self.mkBotomBackView.alpha = 1;
//                    self.mkStopImageView.alpha = 1;
//                    self.titleLab.alpha = 1;
//
//                    self.titleLab.text = @"审核中";
//
//                    self.titleLab.font = [UIFont systemFontOfSize:20 weight:UIFontWeightRegular];
//                    self.titleLab.textAlignment = NSTextAlignmentCenter;
//                    [self.titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
//                        make.left.right.bottom.equalTo(self.mkBotomBackView);
//                    }];
//
//
//                } break;
//                case MKVideoOfMineTypeF:
//                {
//
//
//                } break;
//
//                default:{
//                }break;
//            }
            
        }break;
        case MKVideoType_MyMadeByMe:{
            self.mkBackImageView.contentMode = UIViewContentModeScaleToFill;
            self.mkBackImageView.clipsToBounds = YES;
//            self.mkBackImageView.contentScaleFactor = 0.5;
           [self.mkBackImageView sd_setImageWithURL:[NSURL URLWithString:self.mkVideoModel.videoImg]];
            
            self.mkBackImageView.contentMode = UIViewContentModeScaleAspectFill ;
            
            self.mkBotomBackView.alpha = 1;
            //
            self.titleLab.alpha = 1;
            
            self.mkVideoUserImageView.hidden = YES;
            [self.mkBackImageView  mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.mkBotomBackView).offset(-35*KDeviceScale);
            }];
            
            self.titleLab.text = self.mkVideoModel.videoTitle;
            
            self.titleLab.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
            
            [self.titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.left.right.bottom.equalTo(self.mkBotomBackView);
                
            }];
           
                                                                        
        }break;
            
        case MKVideoType_MyLike:{
            self.mkBackImageView.contentMode = UIViewContentModeScaleToFill;
            self.mkBackImageView.clipsToBounds = YES;
//            self.mkBackImageView.contentScaleFactor = 0.5;
            [self.mkBackImageView sd_setImageWithURL:[NSURL URLWithString:self.mkVideoModel.videoImg]];
            
            self.mkBackImageView.contentMode = UIViewContentModeScaleToFill;
            
            self.mkBotomBackView.alpha = 1;
            
            self.mkVideoUserImageView.hidden = YES;
            
            [self.mkBackImageView  mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.bottom.equalTo(self.mkBotomBackView).offset(-35*KDeviceScale);
            }];

            self.titleLab.alpha = 1;
            
            self.titleLab.text = self.mkVideoModel.videoTitle;
            
            self.titleLab.font = [UIFont systemFontOfSize:8 weight:UIFontWeightRegular];
            
            [self.titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.equalTo(self.mkBotomBackView);
            }];
        }break;
        case MKVideoType_LikeMy:{
            self.mkBackImageView.contentMode = UIViewContentModeScaleToFill;
            self.mkBackImageView.clipsToBounds = YES;
//            self.mkBackImageView.contentScaleFactor = 0.5;
            
            [self.mkBackImageView sd_setImageWithURL:[NSURL URLWithString:self.mkVideoModel.videoImg] placeholderImage:KIMG(@"videoFont")];
            
            [self.mkVideoUserImageView sd_setImageWithURL:[NSURL URLWithString:self.mkVideoModel.headImage] placeholderImage:KIMG(@"videoFont")];
            
            self.titleLab.text = [NSString ensureNonnullString:[NSString stringWithFormat:@"@%@",self.mkVideoModel.author] ReplaceStr:@"@抖动"];
            
            self.titleLab.font = [UIFont systemFontOfSize:10.0 weight:UIFontWeightRegular];
            
            self.mkTimeLabel.text = [MKTools backgroundTimeIsEqualCurrentDateWith:self.mkVideoModel.publishTime];
            
            self.mkTimeLabel.font = [UIFont systemFontOfSize:10.0 weight:UIFontWeightRegular];
      
            self.mkBotomBackView.alpha = 1;
            
            self.titleLab.alpha = 1;
            
            self.mkTimeLabel.alpha = 1;
            
            
        }break;
    }
    

    
    
}

#pragma mark —— lazyLoad
-(UIButton *)showDataBtn{
    if (!_showDataBtn) {
        
        _showDataBtn = UIButton.new;
        
        [_showDataBtn setTitle:@"1231"forState:UIControlStateNormal];
        
        [_showDataBtn setImage:KIMG(@"发布影视") forState:UIControlStateNormal];
        
        [_showDataBtn setImage:KIMG(@"喜欢-点击") forState:UIControlStateNormal];
        
        [self.contentView addSubview:_showDataBtn];
        
        [_showDataBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -8, 0, 0)];
        
        [_showDataBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -8)];
        
        
        [_showDataBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.contentView.mas_top).offset(5 * KDeviceScale);
            
            make.right.equalTo(self.contentView).offset(-10);
            
        }];
    }return _showDataBtn;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        
        _titleLab.numberOfLines = 0;
        
        _titleLab.lineBreakMode = NSLineBreakByTruncatingTail;
        
        _titleLab.text = @"@色情网";
        
        _titleLab.textColor = HEXCOLOR(0xFFFFFF);
        
        _mkTimeLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
        
        [self.mkBotomBackView addSubview:_titleLab];
        
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(6);
            
            make.width.equalTo(@(100 * KDeviceScale));
            make.bottom.equalTo(self.mkBotomBackView).offset(0);
            
//            make.centerY.equalTo(self.mkBotomBackView);
            
        }];
    }return _titleLab;
}
- (UILabel *)mkTimeLabel{
    
    if (!_mkTimeLabel) {
        
        _mkTimeLabel = [[UILabel alloc]init];
        
        _mkTimeLabel.numberOfLines = 0;
        
        _mkTimeLabel.textAlignment = NSTextAlignmentRight;
        
        _mkTimeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        
        _mkTimeLabel.text = @"16小时";
        
        _mkTimeLabel.textColor = HEXCOLOR(0xFFFFFF);
        
        _mkTimeLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
        
        [self.mkBotomBackView addSubview:_mkTimeLabel];
        
        [_mkTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.mkBotomBackView.mas_right).offset(-9);
            
            make.width.equalTo(@(50 * KDeviceScale));
            
//            make.centerY.equalTo(self.mkBotomBackView);
            make.bottom.equalTo(self.mkBotomBackView).offset(0);
            
        }];
    }
    return _mkTimeLabel;
}
- (UIImageView *)mkVideoUserImageView{
    
    if (!_mkVideoUserImageView) {
        
        _mkVideoUserImageView = [[UIImageView alloc]init];
        
        _mkVideoUserImageView.layer.cornerRadius = KDeviceScale * 25 /2;
        
        _mkVideoUserImageView.layer.borderColor = [UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:CGSizeMake(SCALING_RATIO(40), 30)]].CGColor;
        
        _mkVideoUserImageView.layer.borderWidth = 0.3f;
        
        _mkVideoUserImageView.layer.masksToBounds = YES;
        
        [self.mkBotomBackView addSubview:_mkVideoUserImageView];

        [_mkVideoUserImageView mas_makeConstraints:^(MASConstraintMaker *make) {

            make.left.equalTo(self.mkBotomBackView).offset(8 * KDeviceScale);
            make.bottom.equalTo(self.titleLab).offset(-19);

            make.width.height.equalTo(@(KDeviceScale *25));

        }];
    }
    return _mkVideoUserImageView;
}
- (UIView *)mkBotomBackView{
    
    if (!_mkBotomBackView) {
        
        _mkBotomBackView = [[UIView alloc]init];
        UIImageView *imgeV = UIImageView.new;
        [_mkBotomBackView addSubview:imgeV];
        imgeV.image = KIMG(@"bg_shadow");
        [imgeV mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.bottom.top.equalTo(self.mkBotomBackView);
        }];
//        _mkBotomBackView.backgroundColor = COLOR_HEX(0x665E50,.3f);
//        NSString *path = [[NSBundle mainBundle]pathForResource:@"bg_shadow"ofType:@"png"];

//        UIImage *image = [UIImage imageWithContentsOfFile:path];
//
//        _mkBotomBackView.layer.contents = (id)image.CGImage;
        [self.contentView addSubview:_mkBotomBackView];
        
        [_mkBotomBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.bottom.equalTo(self.contentView);
            
            make.height.mas_equalTo(KDeviceScale *30);
        }];
    }
    return _mkBotomBackView;
}
- (UIImageView *)mkBackImageView{
    
    if (!_mkBackImageView) {
        
        _mkBackImageView = [[UIImageView alloc]init];
        
        _mkBackImageView.image = KIMG(@"videoFont");
        
        [self.contentView addSubview:_mkBackImageView];
        
        [_mkBackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.bottom.top.equalTo(self.contentView);
            
        }];
    }
    return _mkBackImageView;
}
- (MKVideoDemandModel *)mkVideoModel{
    
    if (!_mkVideoModel) {
        
        _mkVideoModel = [[MKVideoDemandModel alloc] init];
        
    }
    
    return _mkVideoModel;
}

- (UIImageView *)mkStopImageView{
    
    if (!_mkStopImageView) {
        
        _mkStopImageView = [[UIImageView alloc]init];
        
        _mkStopImageView.image = [self imageByApplyingAlpha:0.58 WithImgae:KIMG(@"暂停播放")];
        
        _mkStopImageView.alpha = 0.25;
        
        [self.contentView addSubview:_mkStopImageView];
        
        [_mkStopImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.equalTo(@(25 *KDeviceScale));
            make.height.equalTo(@(35 *KDeviceScale));
            
            make.centerX.equalTo(self.contentView.mas_centerX);
            
            make.centerY.equalTo(self.contentView.mas_centerY);
            
        }];
        
    }
    return _mkStopImageView;
}
- (UIImage*)imageByApplyingAlpha:(CGFloat) alpha  WithImgae:(UIImage *)immage{

    UIGraphicsBeginImageContextWithOptions(immage.size,NO,0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
     
    CGRect area = CGRectMake(0,0,immage.size.width,immage.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    
    CGContextTranslateCTM(ctx,0,-area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);

    CGContextSetAlpha(ctx, alpha);

    CGContextDrawImage(ctx, area,immage.CGImage);

    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
    
    return newImage;

}

#pragma mark - 审核未通过状态标签
- (UILabel *)mkStatusLabel{
    
    if (!_mkStatusLabel) {
        
        _mkStatusLabel = [[UILabel alloc]init];
        
        _mkStatusLabel.backgroundColor = [UIColor colorWithPatternImage:KIMG(@"画板")];
        
        _mkStatusLabel.text = @"!";
        
        _mkStatusLabel.textAlignment = NSTextAlignmentCenter;
        
        _mkStatusLabel.textColor = [UIColor whiteColor];
        
        _mkStatusLabel.layer.cornerRadius = 9*KDeviceScale ;
        
        _mkStatusLabel.layer.masksToBounds = YES;
        [self.contentView addSubview:_mkStatusLabel];
        [_mkStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.equalTo(@(18 *KDeviceScale));
            
            make.right.equalTo(self.contentView.mas_right).offset(-2*KDeviceScale);
            
            make.top.equalTo(self.contentView.mas_top).offset(2*KDeviceScale);
            
        }];
        
    }
    return _mkStatusLabel;
}
@end
