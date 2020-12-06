//
//  ChoeseTagView.m
//  MonkeyKingVideo
//
//  Created by xxx on 2020/12/6.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "ChoeseTagView.h"
@interface ChoeseTagView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong) UILabel *titleLable;
@property(nonatomic,strong) UILabel *tipLable;
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) UIImageView *arrowImageView;

@end

@implementation ChoeseTagView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLable];
        [self addSubview:self.tipLable];
        [self addSubview:self.arrowImageView];
        [self addSubview:self.collectionView];
        
        [self.tipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(14.5);
            make.centerX.equalTo(self.mas_centerX).offset(0);
        }];
        [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX).offset(0);
            make.right.equalTo(self.mas_right).offset(14);
        }];
        [self.tipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX).offset(0);
            make.right.equalTo(self.arrowImageView.mas_left).offset(20);
        }];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_left);
            make.bottom.equalTo(self.mas_bottom);
            make.right.equalTo(self.tipLable.mas_left).offset(10);
        }];
        
        
    }
    return self;
}

-(UILabel *)titleLable {
    if(_titleLable == nil) {
        _titleLable = UILabel.new;
        _titleLable.text = @"标签";
        _titleLable.font = [UIFont systemFontOfSize:14];
        _titleLable.textColor = UIColor.blackColor;
    }
    return _tipLable;
}

-(UILabel *)tipLable {
    if(_tipLable == nil) {
        _tipLable = UILabel.new;
        _tipLable.text = @"选择标签";
        _tipLable.font = [UIFont systemFontOfSize:12];
        _tipLable.textColor = COLOR_HEX(0x000000, 0.4);
    }
    return _tipLable;
}

-(UICollectionView *)collectionView {
    if(_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
    }
    return _collectionView;
}



- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return  nil;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  3;
}


@end
