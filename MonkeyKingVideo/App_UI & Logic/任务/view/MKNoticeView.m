//
//  MKNoticeView.m
//  MonkeyKingVideo
//
//  Created by xxx on 2020/11/2.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "MKNoticeView.h"
#import "MKTaskVerticalView.h"

@interface MKNoticeView()
@property(nonatomic, strong) MKTaskVerticalView *contentView;


@end

@implementation MKNoticeView

-(void)refreshSkin {
    if ([SkinManager manager].skin == MKSkinWhite) {
        self.backgroundColor = UIColor.whiteColor;
        self.layer.shadowColor = [UIColor clearColor].CGColor;
    } else {
        self.backgroundColor = HEXCOLOR(0x242a37);
        self.layer.shadowColor = [UIColor blackColor].CGColor;
    }
    [self.contentView refreshSkin];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        self.backgroundColor = HEXCOLOR(0x242a37);
        self.layer.cornerRadius = 19.5;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0,0);
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowRadius = 20;
        
        UIImageView *imgeV = UIImageView.new;
        [self addSubview:imgeV];
        [imgeV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self).offset(48);
            make.width.offset(16);
            make.height.offset(16);
        }];
        imgeV.image = KIMG(@"icon_proclamation");
        _contentView = [[MKTaskVerticalView alloc] initWithFrame:CGRectMake(67,0,SCREEN_W - 32 - 67,40)];
//        _paomaView = [[MKPaoMaView alloc] initWithFrame:CGRectMake(67,0,SCREEN_W - 32 - 66 - 67,40) font:[UIFont systemFontOfSize:17] textColor:[UIColor redColor]];
//        _paomaView.textColor = [UIColor whiteColor];
//        _paomaView.font = [UIFont systemFontOfSize:13];// 字体大小
//        _paomaView.backgroundColor = kClearColor;
        [self addSubview:_contentView];
    }
    return self;
}

- (void)setDataSource:(NSArray<NSString *> *)dataSource {
    _dataSource = dataSource;
    self.contentView.dataSource = dataSource;
}






@end
