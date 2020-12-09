//
//  LZBTabBar.m
//  LZBTabBarVC
//
//  Created by zibin on 16/11/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBTabBar.h"
#import "Lottie.h"

#define default_TopLine_Height 0.5

#pragma mark - LZBTabBar

@interface LZBTabBar()

@property(nonatomic,assign) CGFloat itemWidth;
@property(nonatomic,assign) BOOL isAnimation;

@property(nonatomic,assign) CGFloat radius;
@property(nonatomic,strong) UIBezierPath *path;

@end

@implementation LZBTabBar

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (instancetype)init{
    if (self = [super init]) {
        _radius = 30;
        self.backgroundColor = UIColor.clearColor;
    }return self;
}

// 点击的覆盖方法，点击时判断点是否在path内，YES则响应，NO则不响应
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL res = [super pointInside:point withEvent:event];
    if(self.path == nil) {
        return res;
    }
    if (res)
    {
        if ([self.path containsPoint:point])
        {
            return YES;
        }
        return NO;
    }
    return NO;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if(_tabBarStyleType == LZBTabBarStyleType_middleItemUp) {
        [self drawCenter:rect];
    }
}

-(void)drawCenter:(CGRect)rect {
    CGFloat height = rect.size.height;
    CGFloat width = rect.size.width;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, UIColor.whiteColor.CGColor);
    UIBezierPath *path = [UIBezierPath bezierPath];
    self.path = path;
    [path moveToPoint:CGPointMake(0, height)];
    [path addLineToPoint:CGPointMake(0, _radius)];
    [path addLineToPoint:CGPointMake(width / 2 - _radius,_radius)];
    CGFloat arcAdjust = 4;
    CGFloat startAngle = asin(sin(arcAdjust/_radius));
    [path addArcWithCenter:CGPointMake(width / 2, _radius + arcAdjust) radius:_radius startAngle:M_PI + startAngle endAngle:-startAngle clockwise:YES];
    [path addLineToPoint:CGPointMake(width, _radius)];
    [path addLineToPoint:CGPointMake(width, height)];
    [path closePath];
    [path fill];
    UIGraphicsPopContext();
}


- (void)setupCenter {
    NSInteger index = 0;
    self.itemWidth = self.bounds.size.width / self.lzbTabBarItemsArr.count;
    for (LZBTabBarItem *item in self.lzbTabBarItemsArr) {
        [item removeFromSuperview];
        [item mas_remakeConstraints:^(MASConstraintMaker *make) {
        }];
    }
    for (LZBTabBarItem *item in self.lzbTabBarItemsArr) {
        CGFloat itemW = self.itemWidth;
        CGFloat itemH = 49;
        item.unselectTitleAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:13],
                                         NSForegroundColorAttributeName: UIColor.grayColor};
        [self addSubview:item];
        if (index == 2) {
            item.titleOffest = UIOffsetMake(0, 5);
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(itemW, itemH + 20));
                LZBTabBarItem *item_ = (LZBTabBarItem *)self.lzbTabBarItemsArr[index - 1];
                make.left.equalTo(item_.mas_right);
                make.top.equalTo(self).offset(8);
            }];
        }else{
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(itemW, itemH));
                if (index == 0) {
                    make.left.equalTo(self);
                }else{
                    LZBTabBarItem *item = (LZBTabBarItem *)self.lzbTabBarItemsArr[index - 1];
                    make.left.equalTo(item.mas_right);
                }
                make.top.equalTo(self).offset(_radius + 3);
            }];
        }
        [item setNeedsDisplay];
        index++;
    }
    // 阴影颜色
    self.layer.shadowColor = UIColor.grayColor.CGColor;
       // 阴影偏移，默认(0, -3)
    self.layer.shadowOffset = CGSizeMake(0,0);
       // 阴影透明度，默认0
    self.layer.shadowOpacity = 0.5;
       // 阴影半径，默认3
    self.layer.shadowRadius = 5;
}

- (void)setupUI {
    NSInteger index = 0;
    self.itemWidth = self.bounds.size.width / self.lzbTabBarItemsArr.count;
    for (LZBTabBarItem *item in self.lzbTabBarItemsArr) {
        [item removeFromSuperview];
        [item mas_remakeConstraints:^(MASConstraintMaker *make) {
        }];
    }
    for (LZBTabBarItem *item in self.lzbTabBarItemsArr) {
        CGFloat itemW = self.itemWidth;
        CGFloat itemH = 50;
        [self addSubview:item];
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(itemW, itemH));
            if (index == 0) {
                make.left.equalTo(self);
            }else{
                LZBTabBarItem *item = (LZBTabBarItem *)self.lzbTabBarItemsArr[index - 1];
                make.left.equalTo(item.mas_right);
            }
            make.top.equalTo(self).offset(3);
        }];
        [item setNeedsDisplay];
        index++;
    }
    self.path = nil;
    // 阴影颜色
    self.layer.shadowColor = UIColor.grayColor.CGColor;
       // 阴影偏移，默认(0, -3)
    self.layer.shadowOffset = CGSizeMake(0,0);
       // 阴影透明度，默认0
    self.layer.shadowOpacity = 0.3;
       // 阴影半径，默认3
    self.layer.shadowRadius = 3;
}
#pragma mark —— API
///点击事件
- (void)tabbarItemDidSelected:(LZBTabBarItem *)item{
    if (self.currentSelectItem != item) {
        if(![self.lzbTabBarItemsArr containsObject:item]) return;
        NSInteger index = [self.lzbTabBarItemsArr indexOfObject:item];
        //关于动画部分
        if (item.animationView) {
            //先全部停止
            for (id v in self.subviews) {//LZBTabBarItem
                if ([v isKindOfClass:LZBTabBarItem.class]) {
                    LZBTabBarItem *item = (LZBTabBarItem *)v;
                    [item.animationView stop];
                }
            }
            //再独开一个
            if (item.animationView.animationProgress == 0) {
                [item.animationView playToProgress:0.5
                                    withCompletion:^(BOOL animationFinished) {
                    NSLog(@"pressButtonAction isSelected animation");
                    
                }];
            }
        }
        
        if([self.delegate respondsToSelector:@selector(lzb_tabBar:shouldSelectItemAtIndex:)]){
            if(![self.delegate lzb_tabBar:self
                  shouldSelectItemAtIndex:index])
                return;
        }
        if([self.delegate respondsToSelector:@selector(lzb_tabBar:didSelectItemAtIndex:)]){
            [self.delegate lzb_tabBar:self
                 didSelectItemAtIndex:index];
        }
        self.currentSelectItem = item;
    }
}

-(void)setTabBarStyleType:(LZBTabBarStyleType)tabBarStyleType{
    if (tabBarStyleType == LZBTabBarStyleType_middleItemUp) {
        if (self.lzbTabBarItemsArr.count % 2) {
            _tabBarStyleType = tabBarStyleType;
        }else{
            _tabBarStyleType = LZBTabBarStyleType_sysNormal;
        }
    }else{
        _tabBarStyleType = tabBarStyleType;
    }
    CGFloat screenHeight = UIScreen.mainScreen.bounds.size.height;
    CGFloat screenWidth = UIScreen.mainScreen.bounds.size.width;
    CGFloat tabbarHeight =  isiPhoneX_series() ? (50 + 34) : 50;
    if(_tabBarStyleType == LZBTabBarStyleType_middleItemUp) {
        tabbarHeight = tabbarHeight + 30;
        self.backgroundColor = UIColor.clearColor;
        [self setupCenter];
    } else {
        self.backgroundColor = UIColor.whiteColor;
        [self setupUI];
    }
    self.frame = CGRectMake(0,screenHeight - tabbarHeight, screenWidth, tabbarHeight);
    [self setNeedsDisplay];
}

- (void)setLzbTabBarItemsArr:(NSArray<LZBTabBarItem *> *)lzbTabBarItemsArr{
    for (LZBTabBarItem *item in _lzbTabBarItemsArr){
        [item removeFromSuperview];
    }
    _lzbTabBarItemsArr = lzbTabBarItemsArr;
    if(_lzbTabBarItemsArr.count == 0) return;
    //移除所有子控件
    for (int i = 0; i < _lzbTabBarItemsArr.count; i++) {
        [self addSubview:_lzbTabBarItemsArr[i]];
        LZBTabBarItem *item = _lzbTabBarItemsArr[i];
        item.tagger = i;
        if (i == 0) {
            item.selected = YES;//默认第一个为点击选中状态
        }
        @weakify(self)
        //点击事件回调
        [item gestureRecognizerLZBTabBarItemBlock:^(id data,
                                                    id data2) {
            @strongify(self)
            if ([data isKindOfClass:LZBTabBarItem.class]) {
                LZBTabBarItem *item = (LZBTabBarItem *)data;
                if ([data2 isKindOfClass:UITapGestureRecognizer.class]) {//点按手势
                    //这里可以嵌入一些判断，允许是否走下一步，下一步是先走UI，viewDidLoad
                    if (item.tagger == 2) {
                        @weakify(self)
                        [NSObject checkAuthorityWithType:MKLoginAuthorityType_Upload :^(id data) {
                            @strongify(self)
                            if ([data isKindOfClass:NSNumber.class]) {
                                NSNumber *f = (NSNumber *)data;
                                if (f.boolValue) {
                                    [self tabbarItemDidSelected:self->_lzbTabBarItemsArr[item.tagger]];
                                }else{
                                    [NSObject showSYSAlertViewTitle:@"暂时没法使用此功能"
                                                            message:@"请联系管理员开启此权限"
                                                    isSeparateStyle:NO
                                                        btnTitleArr:@[@"我知道了"]
                                                     alertBtnAction:@[@""]
                                                           targetVC:[SceneDelegate sharedInstance].customSYSUITabBarController
                                                       alertVCBlock:^(id data) {
                                        
                                    }];
                                }
                            }
                        }];
                    }else{
                        [self tabbarItemDidSelected:self->_lzbTabBarItemsArr[item.tagger]];
                    }
                }else if ([data2 isKindOfClass:UILongPressGestureRecognizer.class]){//长按手势
                    NSLog(@"长按手势执行什么？");
                }else{}
            }
        }];
    }
    [self setNeedsDisplay];
}

- (void)setCurrentSelectItem:(LZBTabBarItem *)currentSelectItem{
    [self setCurrentSelectItem:currentSelectItem
                     animation:self.isAnimation];
}

- (void)setCurrentSelectItem:(LZBTabBarItem *)currentSelectItem
                   animation:(BOOL)animation{
    if(_currentSelectItem == currentSelectItem) return;
    _currentSelectItem.selected = NO;
    _currentSelectItem = currentSelectItem;
    _currentSelectItem.selected = YES;
    self.isAnimation = animation;
    if(self.isAnimation)
    [self addScaleAnimationWithSuperLayer:_currentSelectItem.layer];
}

- (void)addScaleAnimationWithSuperLayer:(CALayer *)layer{
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    keyAnimation.values = @[@0.8,
                            @1.1,
                            @1.0];
    keyAnimation.duration = 0.25;
    keyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [layer addAnimation:keyAnimation
                 forKey:@"keyAnimation"];
}

#pragma mark —— LazyLoad
-(UIView *)backgroundView{
  if(!_backgroundView){
      _backgroundView = UIView.new;
      [self addSubview:_backgroundView];
      [_backgroundView addSubview:self.topLine];
      _backgroundView.frame = self.bounds;
  }return _backgroundView;
}

-(UIView *)topLine{
  if(!_topLine){
      _topLine = UIView.new;
      _topLine.backgroundColor = kClearColor;//分割线的颜色
      _topLine.frame = CGRectMake(0,
                                  0,
                                  self.bounds.size.width,
                                  default_TopLine_Height);
  }return _topLine;
}

@end


