//
//  SearchView.h
//  Feidegou
//
//  Created by Kite on 2019/11/21.
//  Copyright © 2019 朝花夕拾. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchView : UIView

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)NSMutableArray <FSCustomButton *>*btnMutArr;
@property(nonatomic,strong)NSArray <NSString *>*btnTitleArr;

-(void)actionBlock:(MKDataBlock)block;
-(instancetype)initWithBtnTitleMutArr:(NSArray *)btnTitleMutArr;

@end

NS_ASSUME_NONNULL_END
