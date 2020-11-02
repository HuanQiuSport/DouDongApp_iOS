//
//  MKWebViewVC.h
//  MonkeyKingVideo
//
//  Created by hansong on 7/7/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN
typedef void (^MKWebViewBLOCK)(NSDictionary *dic);
@interface MKWebViewVC : UIViewController
@property (nonatomic,copy) MKWebViewBLOCK webblock;
@property (nonatomic ,strong) NSString *url;
@end

NS_ASSUME_NONNULL_END
