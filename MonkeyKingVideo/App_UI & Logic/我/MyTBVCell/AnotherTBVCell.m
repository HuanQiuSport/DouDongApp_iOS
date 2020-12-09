//
//  AnotherTBVCell.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/24.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "AnotherTBVCell.h"

@interface AnotherTBVCell ()

@property(nonatomic,strong)UILabel *titleLab;

@end

@implementation AnotherTBVCell

+(instancetype)cellWith:(UITableView *)tableView{
    AnotherTBVCell *cell = (AnotherTBVCell *)[tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if (!cell) {
        cell = [[AnotherTBVCell alloc]initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:ReuseIdentifier
                                              marginX:3
                                              marginY:10];
        cell.contentView.backgroundColor = HEXCOLOR(0x242A37);
        [cell shadowCell];
    }return cell;
}

-(void)drawRect:(CGRect)rect{
    self.titleLab.alpha = 1;
    self.btn_1.alpha = 1;
    self.btn_3.alpha = 1;
    self.btn_2.alpha = 1;
}

+(CGFloat)cellHeightWithModel:(id _Nullable)model{
    return isiPhoneX_series() ? (MAINSCREEN_HEIGHT / 7) : (MAINSCREEN_HEIGHT / 5.7);
}

- (void)richElementsInCellWithModel:(id _Nullable)model{
    
}

-(void)action:(MKDataBlock)actionBlock{
    self.actionBlock = actionBlock;
}

-(void)btn_1ClickEvent:(UIButton *)sender{
//    NSLog(@"填写邀请码");
    [NSObject feedbackGenerator];
    @weakify(self)
    [UIView addViewAnimation:self.btn_1
             completionBlock:^(id data) {
        @strongify(self)
        if (self.actionBlock) {
            self.actionBlock(sender);
        }
    }];
}

-(void)btn_2ClickEvent:(UIButton *)sender{
//    NSLog(@"邀请好友");
    [NSObject feedbackGenerator];
    @weakify(self)
    [UIView addViewAnimation:self.btn_2
             completionBlock:^(id data) {
        @strongify(self)
        if (self.actionBlock) {
            self.actionBlock(sender);
        }
    }];
}

-(void)btn_3ClickEvent:(UIButton *)sender{
//    NSLog(@"帮助中心");
    [NSObject feedbackGenerator];
    @weakify(self)
    [UIView addViewAnimation:self.btn_3
             completionBlock:^(id data) {
        @strongify(self)
        if (self.actionBlock) {
            self.actionBlock(sender);
        }
    }];
}

#pragma mark —— lazyLoad
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.text = @"其他";
        _titleLab.textColor =  [UIColor whiteColor];
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self.contentView).offset(15);
        }];
    }return _titleLab;
}

-(FSCustomButton *)btn_1{
    if (!_btn_1) {
        _btn_1 = FSCustomButton.new;
        [_btn_1 setTitleColor:[UIColor whiteColor]
                     forState:UIControlStateNormal];
        _btn_1.buttonImagePosition = FSCustomButtonImagePositionTop;
        [_btn_1 setTitle:@"填写邀请码"
                   forState:UIControlStateNormal];
        [_btn_1 setImage:KIMG(@"邀请码填充")
                      forState:UIControlStateNormal];
        [_btn_1 addTarget:self
                         action:@selector(btn_1ClickEvent:)
               forControlEvents:UIControlEventTouchUpInside];
        _btn_1.titleEdgeInsets = UIEdgeInsetsMake(10,
                                                  0,
                                                  0,
                                                  0);
        [self.contentView addSubview:_btn_1];
        [_btn_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLab.mas_bottom).offset(15);
            make.left.equalTo(self.contentView).offset(30);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
    }return _btn_1;
}

-(FSCustomButton *)btn_3{
    if (!_btn_3) {
        _btn_3 = FSCustomButton.new;
        [_btn_3 setTitleColor:[UIColor whiteColor]
                     forState:UIControlStateNormal];
        _btn_3.buttonImagePosition = FSCustomButtonImagePositionTop;
        [_btn_3 setTitle:@"邀请好友"
                   forState:UIControlStateNormal];
        [_btn_3 setImage:KIMG(@"邀请好友")
                      forState:UIControlStateNormal];
        [_btn_3 addTarget:self
                         action:@selector(btn_3ClickEvent:)
               forControlEvents:UIControlEventTouchUpInside];
        _btn_3.titleEdgeInsets = UIEdgeInsetsMake(10,
                                                  0,
                                                  0,
                                                  0);
        [self.contentView addSubview:_btn_3];
        [_btn_3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLab.mas_bottom).offset(15);
            make.centerX.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
    }return _btn_3;
}

-(FSCustomButton *)btn_2{
    if (!_btn_2) {
        _btn_2 = FSCustomButton.new;
        [_btn_2 setTitleColor:[UIColor whiteColor]
                     forState:UIControlStateNormal];
        _btn_2.buttonImagePosition = FSCustomButtonImagePositionTop;
        [_btn_2 setTitle:@"帮助中心"
                   forState:UIControlStateNormal];
        [_btn_2 setImage:KIMG(@"帮助中心")
                      forState:UIControlStateNormal];
        [_btn_2 addTarget:self
                         action:@selector(btn_2ClickEvent:)
               forControlEvents:UIControlEventTouchUpInside];
        _btn_2.titleEdgeInsets = UIEdgeInsetsMake(10,
                                                  0,
                                                  0,
                                                  0);
        [self.contentView addSubview:_btn_2];
        [_btn_2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLab.mas_bottom).offset(15);
            make.right.equalTo(self.contentView).offset(-30);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
    }return _btn_2;
}




@end
