//
//  MakeCoinRuleView.m
//  MonkeyKingVideo
//
//  Created by xxx on 2020/12/4.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "MakeCoinRuleView.h"
#import <Masonry/Masonry.h>
#import "WPAlertControl.h"
#import "WPView.h"
#import "RuleItemCell.h"

@interface MakeCoinRuleView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) UILabel *titleLabel;

@property(nonatomic,strong) UIButton *contineButton;
@property(nonatomic,strong) UIButton *seeCoinButton;

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,weak) UIViewController *rootVc;

@property(nonatomic,strong) UIImageView *topImageView;

@property(nonatomic,strong) NSArray<NSString *> *rules;

@property(nonatomic,strong) UIView *contentView;

@end

@implementation MakeCoinRuleView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.contentView];
        [self addSubview:self.topImageView];
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(0);
            make.centerX.equalTo(self.mas_centerX).offset(0);
            make.width.equalTo(@(280));
            make.top.equalTo(self.topImageView.mas_bottom).offset(-80);
        }];
       
        [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(0);
            make.centerX.equalTo(self.mas_centerX).offset(10);
//            make.width.equalTo(@(300));
//            make.height.equalTo(@(200));
        }];
        
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.contineButton];
        [self.contentView addSubview:self.seeCoinButton];
        [self.contentView addSubview:self.tableView];
       
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(60);
            make.centerX.equalTo(self.contentView.mas_centerX).offset(0);
        }];
        
        CGFloat offsetCenterX = 70;
        
        [self.contineButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX).offset(-offsetCenterX);
            make.width.equalTo(@(94));
            make.height.equalTo(@(27));
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-30);
        }];
        
        [self.seeCoinButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX).offset(offsetCenterX);
            make.width.equalTo(@(94));
            make.height.equalTo(@(27));
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-30);
        }];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
            make.left.equalTo(self.contentView.mas_left).offset(0);
            make.right.equalTo(self.contentView.mas_right).offset(0);
            make.bottom.equalTo(self.seeCoinButton.mas_top).offset(-20);
        }];
        
        self.contentView.backgroundColor = UIColor.whiteColor;
        self.contentView.layer.cornerRadius = 12;
        self.backgroundColor = UIColor.clearColor;
        
        
    }
    return self;
}
+(MakeCoinRuleView *)ruleView {
    MakeCoinRuleView *view = [[MakeCoinRuleView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 502)];
    return view;
}


-(UILabel *)titleLabel {
    if(_titleLabel == nil) {
        _titleLabel = UILabel.new;
        _titleLabel.textColor = [UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:CGSizeMake(94, 27)]];
        _titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightBold];
        _titleLabel.text = @"刷视频得抖币";
    }
    return _titleLabel;
}


-(UIButton *)contineButton {
    if(_contineButton == nil) {
        _contineButton = UIButton.new;
        _contineButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:CGSizeMake(94, 27)]];
        _contineButton.layer.cornerRadius = 13.5;
        _contineButton.layer.masksToBounds = true;
        _contineButton.titleLabel.font = [UIFont systemFontOfSize:10];
        [_contineButton addTarget:self action:@selector(contineClick) forControlEvents:UIControlEventTouchUpInside];
        [_contineButton setTitle:@"继续赚抖币" forState:UIControlStateNormal];
    }
    return _contineButton;
}

-(UIButton *)seeCoinButton {
    if(_seeCoinButton == nil) {
        _seeCoinButton = UIButton.new;
        _seeCoinButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:CGSizeMake(94, 27)]];
        _seeCoinButton.layer.cornerRadius = 13.5;
        _seeCoinButton.layer.masksToBounds = true;
        _seeCoinButton.titleLabel.font = [UIFont systemFontOfSize:10];
        [_seeCoinButton addTarget:self action:@selector(seeCoinClick) forControlEvents:UIControlEventTouchUpInside];
        [_seeCoinButton setTitle:@"看看我的抖币" forState:UIControlStateNormal];
    }
    return _seeCoinButton;
}

-(UIImageView *)topImageView {
    if(_topImageView == nil) {
        _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _topImageView.image = [UIImage imageNamed:@"rule_top_bg"];
    }
    return _topImageView;
}

-(UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 70;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.bounces = NO;
        _tableView.scrollEnabled = NO;
        [_tableView registerNib:[UINib nibWithNibName:@"RuleItemCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

-(UIView *)contentView {
    if(_contentView == nil) {
        _contentView = UIView.new;
        _contentView.backgroundColor = UIColor.clearColor;
        
    }
    return _contentView;
}


-(NSArray<NSString *> *)rules {
    if(_rules == nil) {
        _rules = @[@"抖动的小伙伴们，可以一边观看视频一边获得抖币哦！看得越多，送得越多，每天可以无限获得抖币。",
        @"抖币领取时长为每90秒可自动领取一次，每次领取的数量均不同。注意不要一直停留在当前视频哦，如果当前视频观看完后，仍然停留在当前视频重复播放，则抖币领取倒计时将暂停。",
                   @"小小抖币大有用途，所获取的抖币可以进行余额的兑换，每10000抖币可兑换1元人民币。兑换的余额可以根据相应的规则进行提现，让您有玩游戏的资格，赚更多的钱！享受成人盛宴的同时顺带把钱赚了，还不赶快行动！"];
    }
    return _rules;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.rules.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RuleItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSString *content = self.rules[indexPath.row];
    [cell setContent:content index:indexPath.row + 1];
    return  cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  UITableViewAutomaticDimension;
}


-(void)show:(UIViewController *)rootVc {
    self.rootVc = rootVc;
    [WPAlertControl alertForView:self
                           begin:WPAlertBeginCenter
                             end:WPAlertEndCenter
                     animateType:WPAlertAnimateBounce
                        constant:0
            animageBeginInterval:0.3
              animageEndInterval:0.1
                       maskColor:[UIColor clearColor]
                             pan:YES
                     rootControl:rootVc
                       maskClick:^BOOL(NSInteger index, NSUInteger alertLevel, WPAlertControl *alertControl) {
//        @strongify(self)
        return NO;
    }
                   animateStatus:nil];
    
}

-(void)dismiss:(UIViewController *)rootVc {
    [WPAlertControl alertHiddenForRootControl:rootVc completion:^(WPAlertShowStatus status, WPAlertControl *alertControl) {
    }];
}


-(void)contineClick {
    [self dismiss:self.rootVc];
}

-(void)seeCoinClick {
    [WPAlertControl alertHiddenForRootControl:self.rootVc completion:^(WPAlertShowStatus status, WPAlertControl *alertControl) {
        if(status == WPAnimateDidDisappear) {
            self.seeCoinBlock();
        }
    }];
}

@end
