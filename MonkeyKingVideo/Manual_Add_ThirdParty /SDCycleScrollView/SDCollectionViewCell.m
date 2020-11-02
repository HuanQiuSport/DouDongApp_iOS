//
//  SDCollectionViewCell.m
//  SDCycleScrollView
//
//  Created by aier on 15-3-22.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

/**
 
 *******************************************************
 *                                                      *
 * 感谢您的支持， 如果下载的代码在使用过程中出现BUG或者其他问题    *
 * 您可以发邮件到gsdios@126.com 或者 到                       *
 * https://github.com/gsdios?tab=repositories 提交问题     *
 *                                                      *
 *******************************************************
 
 */

#import "SDCollectionViewCell.h"

#import "UIView+SDExtension.h"

@implementation SDCollectionViewCell{
    
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _imageView = [[UIImageView alloc] init];
        
        [self addSubview:_imageView];
        
        _titleLabel = [[UILabel alloc] init];
        
        _titleLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        
        _titleLabel.hidden = YES;
        
        _titleLabel.textColor = [UIColor whiteColor];
        
        _titleLabel.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:_titleLabel];
    }
    
    return self;
}

- (void)setTitle:(NSString *)title{
    
    _title = [title copy];
    
    _titleLabel.text = [NSString stringWithFormat:@"   %@", title];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    _imageView.frame = self.bounds;
    
    CGFloat titleLabelW = self.sd_width;
    
    CGFloat titleLabelH = 30;
    
    CGFloat titleLabelX = 0;
    
    CGFloat titleLabelY = self.sd_height - titleLabelH;
    
    _titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    
    _titleLabel.hidden = !_titleLabel.text;
}

@end
