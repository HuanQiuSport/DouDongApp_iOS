//
//  MKCustomView.m
//  MonkeyKingVideo
//
//  Created by admin on 2020/10/16.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "MKCustomView.h"

@implementation MKCustomView
#pragma mark - 懒加载
//- (UILabel *)titleLabel {
//- (UIImageView *)titleLabel {
//    if (!_titleLabel) {
//        _titleLabel = [[UIImageView alloc]init];
//        [self addSubview:_titleLabel];
////        _titleLabel.textAlignment = NSTextAlignmentCenter;
////        _titleLabel.font = [UIFont systemFontOfSize:13];
////        _titleLabel.textColor = [UIColor redColor];
////        _titleLabel.layer.masksToBounds = YES;
////        _titleLabel.layer.cornerRadius = 3;
////        _titleLabel.layer.borderWidth = 1;
////        _titleLabel.layer.borderColor = [UIColor redColor].CGColor;
//    }
//    return _titleLabel;
//}
- (UIButton *)infoBtn
{
    if (!_infoBtn) {
        _infoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_infoBtn setBackgroundImage:KIMG(@"gradualColor") forState:UIControlStateNormal];
        [_infoBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _infoBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _infoBtn.layer.cornerRadius = 24/2;
        _infoBtn.layer.masksToBounds = 1;
        [_infoBtn setTitle:@"跟投" forState:UIControlStateNormal];
        [_infoBtn addAction:^(UIButton *btn) {
            NSURL * url = [NSURL URLWithString:@"tingyun.75://"];
            BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:url];
            if (canOpen){//打开微信
                [[UIApplication sharedApplication] openURL:url];
            }else {
            
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mkSkipHQAppString]  options:@{}  completionHandler:nil];
               
            }
        }];
        [self addSubview:_infoBtn];
    }
    return _infoBtn;
}
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        [self addSubview:_contentLabel];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textColor = kWhiteColor;
    }
    return _contentLabel;
}

-(void)refreshSkin {
    if ([SkinManager manager].skin == MKSkinWhite) {
        _contentLabel.textColor = UIColor.blackColor;
        _contentLabel.font = [UIFont systemFontOfSize:12];
    } else {
        _contentLabel.textColor = kWhiteColor;
        _contentLabel.font = [UIFont systemFontOfSize:13];
    }
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        [self refreshSkin];
    }
    return self;
}
- (void)setupView {
    
//    self.titleLabel.frame   = CGRectMake(10, 10, 40, 20);

    
//    self.titleLabel = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 18, 13)];
//    _titleLabel.image = [UIImage imageNamed:@"icon_proclamation"];
//    [self addSubview:self.titleLabel];
   
    self.infoBtn.frame = CGRectMake(SCREEN_W - 110, 8, 60, 40-16);
    self.contentLabel.frame = CGRectMake(0, 8, SCREEN_W - 110, 20);
}
@end
