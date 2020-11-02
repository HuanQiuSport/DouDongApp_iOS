//
//  NewRVC.m
//  MonkeyKingVideo
//
//  Created by hansong on 10/2/20.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "NewRVC.h"

@interface NewRVC ()<JXCategoryListContentViewDelegate>

@end

@implementation NewRVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(UIView *)listView{
    return self.view;
}
@end
