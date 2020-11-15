//
//  MKBorderView.m
//  MonkeyKingVideo
//
//  Created by hansong on 8/17/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKBorderView.h"
#import "MKMenueCell.h"
@interface MKBorderView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong,nonatomic) UICollectionView *mkCollectionView;
@end

@implementation MKBorderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = MKBakcColor;
         self.mkDataTitleArray = @[@"我的余额",@"我的抖币",@"邀请好友",@"填写邀请码"];
         self.mkDataImageArray = @[@"withe_profile_blance",@"white_profile_金币",@"white_profile_邀请好友",@"white_profile_invite"];
        self.mkCollectionView.alpha = 1;
    }
    return self;
}

-(void)refreshSkin {
    if ([SkinManager manager].skin == MKSkinWhite) {
        self.backgroundColor = UIColor.whiteColor;
        self.mkCollectionView.backgroundColor = UIColor.whiteColor;
        self.mkCollectionView.tintColor =  UIColor.whiteColor;
        self.mkDataTitleArray = @[@"我的余额",@"我的抖币",@"邀请好友",@"填写邀请码"];
        self.mkDataImageArray = @[@"withe_profile_blance",@"white_profile_金币",@"white_profile_邀请好友",@"white_profile_invite"];
    } else {
        self.backgroundColor = MKBakcColor;
        self.mkCollectionView.backgroundColor = MKBakcColor;
        self.mkCollectionView.tintColor =  MKBakcColor;
        self.mkDataTitleArray = @[@"我的余额",@"我的抖币",@"邀请好友",@"填写邀请码"];
        self.mkDataImageArray = @[@"withe_profile_blance",@"white_profile_金币",@"white_profile_邀请好友",@"white_profile_invite"];
    }
    [self.mkCollectionView reloadData];
}

- (UICollectionView *)mkCollectionView{
    
    if (!_mkCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 20;
        layout.minimumInteritemSpacing = 30;
        layout.sectionInset = UIEdgeInsetsMake(5.0, 25, 5.0, 25);
        _mkCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-20*KDeviceScale) collectionViewLayout:layout];
        _mkCollectionView.backgroundColor = MKBakcColor;
        _mkCollectionView.tintColor =  MKBakcColor;
//        [_myCollectionView registerNib:[UINib nibWithNibName:@"CT_MyCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CT_MyCollectionReusableView"];
        //    [_myCollectionView registerClass:[CT_MyCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CT_MyCollectionReusableView"];
//        [_myCollectionView registerNib:[UINib nibWithNibName:@"CT_MyCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"myCollectionViewCell"];
        _mkCollectionView.dataSource = self;
        _mkCollectionView.delegate = self;
        [_mkCollectionView registerClass:[MKMenueCell class]
               forCellWithReuseIdentifier:@"MKMenueCell"];
//        _mkCollectionView.mj_header = self.tableViewHeader;
//        _mkCollectionView.mj_footer = self.tableViewFooter;
        _mkCollectionView.mj_footer.hidden = NO;
        [self addSubview:_mkCollectionView];
        [_mkCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return _mkCollectionView;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.mkDataTitleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MKMenueCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MKMenueCell" forIndexPath:indexPath];
    cell.mKIMGaeView.mkTitleLable.text = self.mkDataTitleArray[indexPath.item];
    cell.mKIMGaeView.mkButton.hidden = YES;
    if([SkinManager manager].skin == MKSkinWhite) {
        cell.mKIMGaeView.mkTitleLable.textColor = [UIColor blackColor];
    } else {
        cell.mKIMGaeView.mkTitleLable.textColor = [UIColor whiteColor];
    }
    cell.mKIMGaeView.mkImageView.image = KIMG(self.mkDataImageArray[indexPath.item]);
    return cell;
}
#pragma mark - 调整cell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    CGFloat width = (([UIScreen mainScreen].bounds.size.width-40)/4);
    CGSize size = CGSizeMake(47, 57*KDeviceScale);
    return size;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
    if(![MKTools mkLoginIsYESWith:[self getCurrentVC]]) {
        return;
    }
    if(self.mkDelegate && [self.mkDelegate respondsToSelector:@selector(didClickMineView:WithIndex:)]){
        [self.mkDelegate didClickMineView:self WithIndex:indexPath.item];
    }

}
-(UIViewController *)getCurrentVC{

    UIViewController *result = nil;

    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }

    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];

    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;

    return result;
}
@end
