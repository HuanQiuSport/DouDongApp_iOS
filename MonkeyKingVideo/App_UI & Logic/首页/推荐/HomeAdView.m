//
//  HomeAdView.m
//  MonkeyKingVideo
//
//  Created by xxx on 2020/11/9.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "HomeAdView.h"

@interface HomeAdView()

@property(nonatomic,strong) UIButton *button;

@end

@implementation HomeAdView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *image = [[UIImageView alloc]initWithFrame:frame];
        image.image = [UIImage imageNamed:@"广告图"];
        [self addSubview:image];
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(MAINSCREEN_WIDTH-80*1,rectOfStatusbar(),60*1,22*1)];
        self.button = button;
        [button titleLabel].font = [UIFont systemFontOfSize:10 weight:UIFontWeightThin];
        [button addTapGesture:self sel:@selector(tapClick)];
        button.backgroundColor = [UIColor redColor];
        [self addSubview:button];
        button.layer.cornerRadius = 11*1;
        button.layer.masksToBounds = YES;
        button.backgroundColor = HEXCOLOR(0x101010);
        button.titleColor = [UIColor whiteColor];
        [button setTitle:@"4" forState:UIControlStateNormal];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        [self addGestureRecognizer:tapgesture];
    }
    return self;
}

-(void)showTo:(UIView *)view {
    [view addSubview:self];
    self.userInteractionEnabled = YES;
    self.button.userInteractionEnabled = NO;
    self.button.hidden = NO;
    __block NSInteger second = 3;
    //(1)
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //(2)
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
    //(3)
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    //(4)
    dispatch_source_set_event_handler(timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (second == 0) {
                self.button.userInteractionEnabled = YES;
                [self.button setTitle:[NSString stringWithFormat:@""] forState:UIControlStateNormal];
                self.button.hidden = YES;
                self.timerEndBlock();
                second = 3;
                dispatch_cancel(timer);
            } else {
                self.button.userInteractionEnabled = NO;
                [self.button setTitle:[NSString stringWithFormat:@"%ld｜跳转",second] forState:UIControlStateNormal];
                second--;
            }
        });
    });
    //(5)
    dispatch_resume(timer);
}

-(void)remove {
    [self removeFromSuperview];
}

-(void)tapClick {
    self.tapClickBlock();
}


@end
