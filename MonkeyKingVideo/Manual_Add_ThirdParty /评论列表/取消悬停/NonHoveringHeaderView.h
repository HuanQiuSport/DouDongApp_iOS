//
//  NonHoveringHeaderView.h
//  HeaderDemo
//
//  Created by zyd on 2018/6/22.
//  Copyright © 2018年 zyd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NonHoveringHeaderView : UITableViewHeaderFooterView
@property(nonatomic, strong)UIButton *supportBtn;
@property(nonatomic, strong)UIImageView *heartIcon;
@property(nonatomic, strong)UILabel *countLab;
@property(nonatomic, strong)UIImageView *vipImageView;
@property(nonatomic,strong)UIControl * _Nullable result;
@property(nonatomic,copy)void (^headerBlock)(NSDictionary *dic);
- (instancetype _Nullable )initWithReuseIdentifier:(nullable NSString *)reuseIdentifier
                                          withData:(id _Nullable )data;
-(void)actionBlock:(MKDataBlock _Nullable )actionBlock;


@end

/* 使用示例
 NonHoveringHeaderView *header = nil;
 
 {//第一种创建方式
     header = [[NonHoveringHeaderView alloc]initWithReuseIdentifier:NSStringFromClass(NonHoveringHeaderView.class)
                                                           withData:@(section)];


 
     [header.result addTarget:self
                       action:@selector(headerIsTapEvent:)
             forControlEvents:UIControlEventTouchUpInside];
 }
 
//    {//第二种创建方式
//        //viewForHeaderInSection 悬停与否
//        Class headerClass = NonHoveringHeaderView.class;
//    //    Class headerClass = HoveringHeaderView.class;
//
//        header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(headerClass)];
//    }
*/
