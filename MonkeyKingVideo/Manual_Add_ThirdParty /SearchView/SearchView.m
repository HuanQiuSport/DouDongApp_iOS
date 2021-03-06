//
//  SearchView.m
//  Feidegou
//
//  Created by Kite on 2019/11/21.
//  Copyright © 2019 朝花夕拾. All rights reserved.
//

#import "SearchView.h"

#define BtnDefaultWidth SCALING_RATIO(100)

@interface SearchView ()
<
UIScrollViewDelegate
>

@property(nonatomic,copy)MKDataBlock block;
@property(nonatomic,assign)CGFloat BtnWidth;
@property(nonatomic,strong)FSCustomButton *tempBtn;

@end

@implementation SearchView

-(instancetype)initWithBtnTitleMutArr:(NSArray *)btnTitleMutArr{
    if (self = [super init]) {
        self.btnTitleArr = btnTitleMutArr;
        self.scrollView.alpha = 1;
        self.backgroundColor = kClearColor;
        
        if (btnTitleMutArr.count < 5) {
            self.BtnWidth = (SCREEN_WIDTH - SCALING_RATIO(5) * 2 - SCALING_RATIO(10) * (btnTitleMutArr.count - 1))/ btnTitleMutArr.count;
        }else{
            self.BtnWidth = BtnDefaultWidth;
        }
        
        for (int i = 0; i < btnTitleMutArr.count; i++) {
            FSCustomButton *btn = FSCustomButton.new;
//            btn.backgroundColor = RandomColor;
            [UIView cornerCutToCircleWithView:btn
                              AndCornerRadius:7.f];
            [UIView colourToLayerOfView:btn
                             WithColour:KLightGrayColor
                         AndBorderWidth:.5f];
            
            if ([btnTitleMutArr[i] isKindOfClass:[UIImage class]]) {
                [btn setBackgroundImage:btnTitleMutArr[i]
                               forState:UIControlStateNormal];
            }else if ([btnTitleMutArr[i] isKindOfClass:[NSString class]]){
                [btn setTitle:btnTitleMutArr[i]
                     forState:UIControlStateNormal];
                [btn setImage:KIMG(@"TwoWayArrow_1")
                     forState:UIControlStateNormal];
                [btn setImage:KIMG(@"TwoWayArrow_2")
                     forState:UIControlStateSelected];
                [btn setTitleColor:kBlackColor
                          forState:UIControlStateNormal];
                [btn setTitleColor:kRedColor
                          forState:UIControlStateSelected];
            }else{}
            
            btn.buttonImagePosition = FSCustomButtonImagePositionRight;
            btn.titleEdgeInsets = UIEdgeInsetsMake(0,
                                                   0,
                                                   0,
                                                   SCALING_RATIO(10));
            [btn.titleLabel sizeToFit];
            btn.titleLabel.adjustsFontSizeToFitWidth = YES;
            [btn addTarget:self
                    action:@selector(MMButtonClickEvent:)
          forControlEvents:UIControlEventTouchUpInside];
            [btn setTitleColor:kBlackColor
                      forState:UIControlStateNormal];
            [self.scrollView addSubview:btn];
            btn.frame = CGRectMake((self.BtnWidth + SCALING_RATIO(10)) * (i) + SCALING_RATIO(0),
                                   SCALING_RATIO(3),
                                   self.BtnWidth,
                                   SCALING_RATIO(30));
            [self.btnMutArr addObject:btn];
        }
    }return self;
}

-(void)actionBlock:(MKDataBlock)block{
    self.block = block;
}

-(void)MMButtonClickEvent:(FSCustomButton *)sender{
    NSLog(@"MMM = %d",sender.selected);
    if ([self.tempBtn isEqual:sender]) {//同一个btn
        sender.selected = !sender.selected;
    }else{//不同一个btn
        //点击不同的btn
        for (FSCustomButton *btn in self.btnMutArr) {
            btn.selected = NO;
        }
        sender.selected = YES;
    }
    self.tempBtn = sender;//上一个被点击的btn
    if (self.block) {
        self.block(sender);
    }
}
#pragma mark —— UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

}
#pragma mark —— lazyLoad
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = UIScrollView.new;
//        _scrollView.alwaysBounceHorizontal = YES;//禁止左右滚动
//        _scrollView.alwaysBounceVertical = NO;//禁止上下滚动
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake((SCALING_RATIO(100) + SCALING_RATIO(10)) * (self.btnTitleArr.count) + SCALING_RATIO(5),
                                             55);
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = YES;
        [self addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }return _scrollView;
}

-(NSMutableArray<FSCustomButton *> *)btnMutArr{
    if (!_btnMutArr) {
        _btnMutArr = NSMutableArray.array;
    }return _btnMutArr;
}

@end
