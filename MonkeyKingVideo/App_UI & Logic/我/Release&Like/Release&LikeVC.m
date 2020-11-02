//
//  Release&LikeVC.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/30.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "Release&LikeVC.h"
#import "Release_LikeVC+VM.h"

#import "ReleaseVC.h"


@interface Release_LikeVC ()
<
JXCategoryTitleViewDataSource
,JXCategoryListContainerViewDelegate
,JXCategoryViewDelegate
>
//demo
@property(nonatomic,strong)JXCategoryTitleView *categoryView;
@property(nonatomic,strong)JXCategoryIndicatorLineView *lineView;//滚动条可以修改样式
@property(nonatomic,strong)JXCategoryIndicatorBackgroundView *backgroundView;//滚动条可以修改样式
@property(nonatomic,strong)JXCategoryListContainerView *listContainerView;
@property(nonatomic,strong)NSMutableArray <NSString *>*titleMutArr;
@property(nonatomic,strong)NSMutableArray *childVCMutArr;

@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;
///


@end

@implementation Release_LikeVC

- (void)dealloc {
    
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated{
    Release_LikeVC *vc = Release_LikeVC.new;
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
            NSLog(@"错误的推进方式");
            break;
    }return vc;
}

#pragma mark - Lifecycle
-(instancetype)init{
    if (self = [super init]) {
        
    }return self;
}

-(void)viewDidLoad{
    self.gk_navigationBar.hidden = YES;
    self.view.backgroundColor = HEXCOLOR(0x242A37);
    self.navigationController.navigationBar.hidden = YES;
//    [self setupSubviews];
//    [self layoutNavigation];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = YES;

    self.categoryView.alpha = 1;
    
    self.navigationController.navigationBar.hidden = NO;
    NSLog(@"");
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
}

- (void)setupSubviews {
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBarHidden = YES;
}

- (void)layoutNavigation {
    //设置导航栏
    self.view.userInteractionEnabled = YES;
    self.navigationController.navigationBarHidden = YES;
//    // 适配iOS 11
//    if (@available(iOS 11.0, *)) {
//    } else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
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
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    [self.listContainerView didClickSelectedItemAtIndex:index];
}

//传递scrolling事件给listContainerView，必须调用！！！
- (void)categoryView:(JXCategoryBaseView *)categoryView
scrollingFromLeftIndex:(NSInteger)leftIndex
        toRightIndex:(NSInteger)rightIndex
               ratio:(CGFloat)ratio {
//    [self.listContainerView scrollingFromLeftIndex:leftIndex
//                                      toRightIndex:rightIndex
//                                             ratio:ratio
//                                     selectedIndex:categoryView.selectedIndex];
}

#pragma mark —— lazyLoad
-(NSMutableArray<NSString *> *)titleMutArr{
    if (!_titleMutArr) {
        _titleMutArr = NSMutableArray.array;
//        [_titleMutArr addObject:@"发布"];//发布
        [_titleMutArr addObject:@"喜欢"];//喜欢
    }return _titleMutArr;
}

-(NSMutableArray *)childVCMutArr{
    if (!_childVCMutArr) {
        _childVCMutArr = NSMutableArray.array;
//        [self.childVCMutArr addObject:ReleaseVC.new];
        [self.childVCMutArr addObject:self.mkLiked];
    }return _childVCMutArr;
}

-(JXCategoryListContainerView *)listContainerView{
    if (!_listContainerView) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_CollectionView
                                                                      delegate:self];
        
        if (self.titleMutArr.count == 1) {
            _listContainerView.defaultSelectedIndex = 0;
        }else{
            _listContainerView.defaultSelectedIndex = 1;
        }
        [self.view addSubview:_listContainerView];
        [self.view layoutIfNeeded];
        [_listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        [self.view layoutIfNeeded];
    }return _listContainerView;
}

-(JXCategoryIndicatorLineView *)lineView{
    if (!_lineView) {
        _lineView = JXCategoryIndicatorLineView.new;
        _lineView.indicatorColor = HEXCOLOR(0xF54D64);
    }return _lineView;
}

-(JXCategoryIndicatorBackgroundView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView = JXCategoryIndicatorBackgroundView.new;
        _backgroundView.indicatorHeight = 15;
        _backgroundView.indicatorCornerRadius = JXCategoryViewAutomaticDimension;
        _backgroundView.layer.shadowColor = kRedColor.CGColor;
        _backgroundView.layer.shadowRadius = 3;
        _backgroundView.layer.shadowOffset = CGSizeMake(3, 4);
        _backgroundView.layer.shadowOpacity = 0.6;
    }return _backgroundView;
}

-(JXCategoryTitleView *)categoryView{
    if (!_categoryView) {
        _categoryView = JXCategoryTitleView.new;
        _categoryView.backgroundColor = kClearColor;
        _categoryView.titleSelectedColor = HEXCOLOR(0xF54D64);
        _categoryView.titleColor = kWhiteColor;
        _categoryView.titleFont = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        _categoryView.titleSelectedFont = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        _categoryView.delegate = self;
        _categoryView.titles = self.titleMutArr;
        _categoryView.titleColorGradientEnabled = YES;
        
        if (self.titleMutArr.count == 1) {
             _categoryView.defaultSelectedIndex = 0;//默认从第一个开始显示
        }else{
            _categoryView.defaultSelectedIndex = 1;//默认从第二个开始显示
        }
        
        //滚动条可以修改样式
        _categoryView.indicators = @[self.backgroundView];
//        _categoryView.indicators = @[self.lineView];
        
        //关联cotentScrollView，关联之后才可以互相联动！！！
        _categoryView.contentScrollView = self.listContainerView.scrollView;
        [self.view addSubview:_categoryView];
        [_categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
            //临时改动
            if (self.titleMutArr.count == 1) {
                make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCALING_RATIO(0)));
            }else{
                make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCALING_RATIO(30)));
            }
            make.bottom.equalTo(self.view.mas_bottom).offset(0);
        }];
    }return _categoryView;
}

- (LikeVC *)mkLiked{
    
    if (!_mkLiked){
        
        _mkLiked = [[LikeVC alloc]init];
    }
    return _mkLiked;
}


@end
