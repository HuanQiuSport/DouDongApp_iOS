//
//  MKNoticeAlertView.m
//  MonkeyKingVideo
//
//  Created by xxx on 2020/12/4.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "MKNoticeAlertView.h"
#import "WPAlertControl.h"

@interface MKNoticeAlertView()
@property(nonatomic,strong) UIButton *nextButton;
@property(nonatomic,strong) UIImageView *bgImageView;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UITextView *contentView;

@property(nonatomic,strong) NSArray<MKHNoticeModel *> *dataSource;
@property(nonatomic,assign) int index;
@end

@implementation MKNoticeAlertView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.contentView];
        [self addSubview:self.nextButton];
        
        [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(0);
            make.top.equalTo(self.mas_top).offset(0);
            make.height.equalTo(@(516 * KDeviceScale));
            make.width.equalTo(@(324 * KDeviceScale));
        }];

        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(130);
            make.left.equalTo(self.mas_left).offset(28);
            make.right.equalTo(self.mas_right).offset(-28);
        }];
        
        [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self).offset(-21);
            make.height.offset(35*KDeviceScale);
            make.width.offset(168*KDeviceScale);
        }];
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(12);
            make.left.equalTo(self).offset(28);
            make.right.equalTo(self).offset(-28);
            make.height.equalTo(@(200));
        }];
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 10;
        
    }
    return self;
}


-(void)show:(NSArray<MKHNoticeModel *> *)dataSource {
    self.dataSource = dataSource;
    _index = 0;
    if(self.dataSource ==  0) {
        return;
    }
    [WPAlertControl alertForView:self
                           begin:WPAlertBeginCenter
                             end:WPAlertEndCenter
                     animateType:WPAlertAnimateBounce
                        constant:0
            animageBeginInterval:0.3
              animageEndInterval:0.1
                       maskColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.0]
                             pan:YES
                     rootControl:self.rootVc
                       maskClick:^BOOL(NSInteger index, NSUInteger alertLevel, WPAlertControl *alertControl) {
        return NO;
    }
                   animateStatus:nil];
    [self nextClick];
    
    
}

-(void)nextClick {
    if(self.dataSource.count > self.index) {
        MKHNoticeModel *model = self.dataSource[self.index];
        [self showItem:model];
        self.index = self.index + 1;
    } else {
        [WPAlertControl alertHiddenForRootControl:self.rootVc completion:^(WPAlertShowStatus status, WPAlertControl *alertControl) {
        }];
    }
    
}

-(void)showItem:(MKHNoticeModel *)model {
    CGFloat contentheight = [self contentH:model];
    self.frame = CGRectMake(0, 0, 324*KDeviceScale, 130 + 20 + 12 + contentheight + 35*KDeviceScale + 21 + 28 );
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(contentheight));
    }];
    self.contentView.attributedText =  [[NSAttributedString alloc] initWithString:model.content attributes:[self contentAttributes]];
    self.titleLabel.text = model.title;
    self.centerX = [UIScreen mainScreen].bounds.size.width / 2;
    self.centerY = [UIScreen mainScreen].bounds.size.height / 2;
}

-(CGFloat)contentH:(MKHNoticeModel *)model {
    CGFloat contentH = [model.content boundingRectWithSize:CGSizeMake(324*KDeviceScale - 56, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[self contentAttributes] context:nil].size.height + 20;
    contentH = MIN(contentH, 240);
    return contentH;
}

-(NSDictionary *)contentAttributes {
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];

    paragraphStyle.lineSpacing = 13;// 字体的行间距

    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:14],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    return  attributes;
}


-(UIButton *)nextButton {
    if(_nextButton == nil) {
        _nextButton = UIButton.new;
        [_nextButton setBackgroundImage:KIMG(@"gradualColor") forState:UIControlStateNormal];
        [_nextButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _nextButton.titleLabel.font = [UIFont systemFontOfSize:16]; // [UIFont fontWithName:@"PingFangSC-Medium" size:16];
        _nextButton.layer.cornerRadius = 35/2;
        _nextButton.layer.masksToBounds = 1;
        [_nextButton setTitle:@"我知道了" forState:UIControlStateNormal];
        [_nextButton addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}
-(UIImageView *)bgImageView {
    if(_bgImageView == nil) {
        _bgImageView =  [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 324*KDeviceScale, 516*KDeviceScale)];
        _bgImageView.image =  KIMG(@"imge_announcementHUB_nor");
    }
    return  _bgImageView;
}

-(UILabel *)titleLabel {
    if(_titleLabel == nil) {
        _titleLabel = UILabel.new;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = kBlackColor;
        _titleLabel.font = [UIFont systemFontOfSize:18];
    }
    return _titleLabel;
}

-(UITextView *)contentView {
    if(_contentView == nil) {
        _contentView = UITextView.new;
        _contentView.backgroundColor = UIColor.whiteColor;
        _contentView.editable = NO;
    }
    return _contentView;
}


@end
