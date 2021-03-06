//
//  HomeVC.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/23.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "HomeVC.h"
#import "HomeVC+VM.h"

#import "AttentionVC.h"
#import "RecommendVC.h"
#import "MonitorNetwoking.h"
#import "NewRVC.h"

#import "WPAlertControl.h"
#import "WPView.h"
@interface HomeVC ()<JXCategoryTitleViewDataSource,JXCategoryListContainerViewDelegate,JXCategoryViewDelegate>
@property(nonatomic,assign) int idx;

@property(nonatomic,strong)JXCategoryIndicatorLineView *lineView;
@property(nonatomic,strong)NSMutableArray <NSString *>*titleMutArr;
@property(nonatomic,strong)NSMutableArray *childVCMutArr;
@property(nonatomic,strong)NSTimer *mytimer;

@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;

@property(nonatomic,strong)MonitorNetwoking *monitorNetwoking;

@end

@implementation HomeVC

- (void)dealloc {
//    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    [self.mytimer invalidate];
    //别忘了把定时器置为nil,否则定时器依然没有释放掉的
    self.mytimer  = nil;
}

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated{
    HomeVC *vc = HomeVC.new;
    vc.successBlock = block;
    vc.requestParams = requestParams;
    switch (comingStyle) {
        case ComingStyle_PUSH:{
            if (rootVC.navigationController) {
                vc.isPush = YES;
                vc.isPresent = NO;
                [rootVC.navigationController pushViewController:vc
                                                       animated:animated];
            }else{
                vc.isPush = NO;
                vc.isPresent = YES;
                [rootVC presentViewController:vc
                                     animated:animated
                                   completion:^{}];
            }
        }break;
        case ComingStyle_PRESENT:{
            vc.isPush = NO;
            vc.isPresent = YES;
            //iOS_13中modalPresentationStyle的默认改为UIModalPresentationAutomatic,而在之前默认是UIModalPresentationFullScreen
            vc.modalPresentationStyle = presentationStyle;
            [rootVC presentViewController:vc
                                 animated:animated
                               completion:^{}];
        }break;
        default:
//            NSLog(@"错误的推进方式");
            break;
    }return vc;
}


#pragma mark - Lifecycle
-(instancetype)init{
    if (self = [super init]) {
    }return self;
}

-(void)viewDidLoad{
    self.view.backgroundColor = [UIColor clearColor];
    self.listContainerView.backgroundColor = [UIColor clearColor];
    #ifdef DEBUG
//    [self.mytimer fire];
    #endif
//    [[MKTools shared] announcementHUBWithView:self.view];
    self.idx = 0;
    
    [self MKVersionInfo_GET];
    
}
- (void)anno{
//    NSString *content;
    if(self.idx >= self.m_annoContents.count) {
        return;
    }
    @weakify(self)
    WPView *view1 = [WPView viewWithTapClick:^(id other) {
        @strongify(self)
    }];

    view1.tap = ^(id other) {
//        [WPAlertControl alertHiddenForRootControl:self completion:^(WPAlertShowStatus status, WPAlertControl *alertControl) {
//
//        }];
        
    };
    view1.frame = CGRectMake(0, 0, 324*KDeviceScale, 516*KDeviceScale);
    view1.backgroundColor = [UIColor clearColor];
    UIImageView *image = [[UIImageView alloc]initWithFrame:view1.frame];
    image.image = KIMG(@"imge_announcementHUB_nor");
    [view1 addSubview:image];

    UILabel *lab = UILabel.new;
    [view1 addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view1).offset(130);
        make.left.equalTo(view1).offset(28);
        make.right.equalTo(view1).offset(-28);

    }];
    lab.text = self.m_annoTitles[self.idx];

    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = kBlackColor;
    lab.font = [UIFont systemFontOfSize:18];
    
    UITextView *contentView = UITextView.new;
    contentView.backgroundColor = UIColor.whiteColor;
    [view1 addSubview:contentView];
    
//    contentView.text = content;
    contentView.editable = NO;
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];

    paragraphStyle.lineSpacing = 13;// 字体的行间距

    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:14],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    contentView.typingAttributes = attributes;
    contentView.attributedText =  [[NSAttributedString alloc] initWithString:self.m_annoContents[self.idx] attributes:attributes];
    
    
    UIButton *btn = UIButton.new;
    [view1 addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view1);
        make.bottom.equalTo(view1).offset(-21);
        make.height.offset(35*KDeviceScale);
        make.width.offset(168*KDeviceScale);
    }];
    [btn setBackgroundImage:KIMG(@"gradualColor") forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16]; // [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    btn.layer.cornerRadius = 35/2;
    btn.layer.masksToBounds = 1;
    [btn setTitle:@"我知道了" forState:UIControlStateNormal];
    WeakSelf
    [btn addAction:^(UIButton *btn) {
        weakSelf.idx++;
        if (weakSelf.idx >= weakSelf.m_annoContents.count) {
            [WPAlertControl alertHiddenForRootControl:self completion:^(WPAlertShowStatus status, WPAlertControl *alertControl) {
    
            }];
        } else {
            lab.text = weakSelf.m_annoTitles[weakSelf.idx];
            contentView.attributedText =  [[NSAttributedString alloc] initWithString:weakSelf.m_annoContents[weakSelf.idx] attributes:attributes];
            
        }
    }];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lab.mas_bottom).offset(12);
        make.left.equalTo(view1).offset(28);
        make.right.equalTo(view1).offset(-28);
        make.bottom.equalTo(btn.mas_top).offset(-28);
    }];
    
    if ([[[SceneDelegate sharedInstance].customSYSUITabBarController.navigationController.viewControllers lastObject] isKindOfClass:[DoorVC class]]) {
//        NSLog(@"你他妹的手那么快干啥子呦");
        return;
    }
    [WPAlertControl alertForView:view1
                           begin:WPAlertBeginCenter
                             end:WPAlertEndCenter
                     animateType:WPAlertAnimateBounce
                        constant:0
            animageBeginInterval:0.3
              animageEndInterval:0.1
                       maskColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.0]
                             pan:YES
                     rootControl:self
                       maskClick:^BOOL(NSInteger index, NSUInteger alertLevel, WPAlertControl *alertControl) {
        @strongify(self)
        return NO;
    }
                   animateStatus:nil];
}
#pragma mark - 网络监控
-(void)makeMonitorNetwoking{
    [self.monitorNetwoking getInternetface];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.gk_navigationBar.hidden = YES;
    self.gk_statusBarHidden = YES;
    self.navigationController.navigationBar.hidden = YES;
    self.categoryView.alpha = 1;
    
#warning UserDefault存页面暂时解决上传页面返回问题
    SetUserDefaultKeyWithValue(@"selectedIndex", @"0");
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //0x102e33150
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
#pragma mark JXCategoryTitleViewDataSource
//// 如果将JXCategoryTitleView嵌套进UITableView的cell，每次重用的时候，JXCategoryTitleView进行reloadData时，会重新计算所有的title宽度。所以该应用场景，需要UITableView的cellModel缓存titles的文字宽度，再通过该代理方法返回给JXCategoryTitleView。
//// 如果实现了该方法就以该方法返回的宽度为准，不触发内部默认的文字宽度计算。
//- (CGFloat)categoryTitleView:(JXCategoryTitleView *)titleView
//               widthForTitle:(NSString *)title{
//
//    return 10;
//}
#pragma mark JXCategoryListContainerViewDelegate
/**
 返回list的数量

 @param listContainerView 列表的容器视图
 @return list的数量
 */
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView{
    return self.titleMutArr.count;
}
/**
 根据index初始化一个对应列表实例，需要是遵从`JXCategoryListContentViewDelegate`协议的对象。
 如果列表是用自定义UIView封装的，就让自定义UIView遵从`JXCategoryListContentViewDelegate`协议，该方法返回自定义UIView即可。
 如果列表是用自定义UIViewController封装的，就让自定义UIViewController遵从`JXCategoryListContentViewDelegate`协议，该方法返回自定义UIViewController即可。

 @param listContainerView 列表的容器视图
 @param index 目标下标
 @return 遵从JXCategoryListContentViewDelegate协议的list实例
 */
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView
                                          initListForIndex:(NSInteger)index{
    return self.childVCMutArr[index];
}
#pragma mark JXCategoryViewDelegate
//传递didClickSelectedItemAt事件给listContainerView，必须调用！！！
- (void)categoryView:(JXCategoryBaseView *)categoryView
didClickSelectedItemAtIndex:(NSInteger)index {
//    NSLog(@"%ld",(long)index);
    [[NSUserDefaults standardUserDefaults] setValue:@[@(index)] forKey:@"HomeCurrentView"];
    [[NSUserDefaults standardUserDefaults] synchronize];
//    if (index == 0) {
//        WeakSelf
//        if ([MKTools mkLoginIsYESWith:weakSelf]) {
//            NSLog(@"");
//            [self.listContainerView didClickSelectedItemAtIndex:index];
//        }else{
//            [self.listContainerView didClickSelectedItemAtIndex:1];
//        }
//    }else{
//        [self.listContainerView didClickSelectedItemAtIndex:index];
//    }

     [self.listContainerView didClickSelectedItemAtIndex:index];
}

//传递scrolling事件给listContainerView，必须调用！！！
- (void)categoryView:(JXCategoryBaseView *)categoryView
scrollingFromLeftIndex:(NSInteger)leftIndex
        toRightIndex:(NSInteger)rightIndex
               ratio:(CGFloat)ratio {
//    NSLog(@"左右滑动了啊！！！！！！！！！！！！！");
//    [self.listContainerView scrollingFromLeftIndex:leftIndex
//                                      toRightIndex:rightIndex
//                                             ratio:ratio
//                                     selectedIndex:categoryView.selectedIndex];
}
- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index
{
//    NSLog(@"%ld",(long)index);
//    NSLog(@"左右滑动了啊！！！！！！！！！！！！！%ld",(long)index); // 0关注 1推荐
//    if (index == 0) {
//        RecommendVC *vc = [[RecommendVC alloc] init];
//        vc.isCanPlay = NO;
//    } else {
//        RecommendVC *vc = [[RecommendVC alloc] init];
//        vc.isCanPlay = YES;
//    }
}
#pragma mark —— lazyLoad
-(NSMutableArray<NSString *> *)titleMutArr{
    if (!_titleMutArr) {
        _titleMutArr = NSMutableArray.array;
        [_titleMutArr addObject:@"关注"];//关注
        [_titleMutArr addObject:@"抖币"];//推荐
    }return _titleMutArr;
}

-(NSMutableArray *)childVCMutArr{
    if (!_childVCMutArr) {
        _childVCMutArr = NSMutableArray.array;
        [self.childVCMutArr addObject:AttentionVC.new];
        RecommendVC *vc = RecommendVC.new;
        vc.isHome = true;
        vc.homeVC = self;
//        NewRVC *vc = NewRVC.new;
        [self.childVCMutArr addObject:vc];
    }return _childVCMutArr;
}

-(JXCategoryListContainerView *)listContainerView{
    if (!_listContainerView) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_CollectionView delegate:self];        
        _listContainerView.defaultSelectedIndex = 1;//默认从第二个开始显示
        [[NSUserDefaults standardUserDefaults] setValue:@[@(1)] forKey:@"HomeCurrentView"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        _listContainerView.listCellBackgroundColor = [UIColor clearColor];
        [self.view addSubview:_listContainerView];
        [_listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        
        [self.view layoutIfNeeded];
    }return _listContainerView;
}

-(JXCategoryIndicatorLineView *)lineView{
    if (!_lineView) {
        _lineView = JXCategoryIndicatorLineView.new;
        _lineView.indicatorColor = [UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:CGSizeMake(SCALING_RATIO(26), 5)]];
        _lineView.indicatorHeight = 4*KDeviceScale;
        _lineView.indicatorWidth = SCALING_RATIO(26);
        _lineView.verticalMargin = 4;
    }return _lineView;
}

-(JXCategoryTitleView *)categoryView{
    if (!_categoryView) {
        _categoryView = JXCategoryTitleView.new;
        _categoryView.backgroundColor = kClearColor;
        _categoryView.titleSelectedColor = _categoryView.titleSelectedColor = [[MKTools shared] getColorWithColor:RGBCOLOR(245,75,100) andCoe:0.5 andEndColor:RGBCOLOR(247,131,97)];//[UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:CGSizeMake(SCALING_RATIO(40), 30)]];
        _categoryView.titleColor = kWhiteColor;
        _categoryView.titleFont = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
        _categoryView.titleSelectedFont = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
        _categoryView.delegate = self;
        _categoryView.titles = self.titleMutArr;
        _categoryView.titleColorGradientEnabled = YES;
        _categoryView.indicators = @[self.lineView];//
        _categoryView.defaultSelectedIndex = 1;//默认从第二个开始显示
        _categoryView.contentEdgeInsetLeft = SCALING_RATIO(130);
        _categoryView.contentEdgeInsetRight = SCALING_RATIO(130);
        _categoryView.cellWidth = SCALING_RATIO(40);
        //关联cotentScrollView，关联之后才可以互相联动！！！
        _categoryView.contentScrollView = self.listContainerView.scrollView;//
        _categoryView.contentScrollView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_categoryView];
        [_categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(SCALING_RATIO(50));
            make.top.equalTo(self.listContainerView).offset(rectOfStatusbar());
        }];
        [self.view layoutIfNeeded];
    }return _categoryView;
}

-(MonitorNetwoking *)monitorNetwoking{
    if (!_monitorNetwoking) {
        _monitorNetwoking = [MonitorNetwoking sharedInstance];
        [self.view addSubview:_monitorNetwoking.rateLabel];
        _monitorNetwoking.rateLabel.backgroundColor = kRedColor;
        _monitorNetwoking.rateLabel.frame = CGRectMake(SCREEN_WIDTH - 71,
                                                       300,
                                                       150,
                                                       30);
    }return _monitorNetwoking;
}


-(NSTimer *)mytimer{
    if (!_mytimer) {
        _mytimer =[NSTimer scheduledTimerWithTimeInterval:1.0
                                                   target:self
                                                 selector:@selector(makeMonitorNetwoking)
                                                 userInfo:nil
                                                  repeats:YES];
    }return _mytimer;
}


@end
