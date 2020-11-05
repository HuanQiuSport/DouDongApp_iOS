//
//  MKTaskVerticalView.m
//  MonkeyKingVideo
//
//  Created by xxx on 2020/11/2.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "MKTaskVerticalView.h"
#import <Masonry/Masonry.h>
#import <MJRefresh/MJRefresh.h>


@interface MKTaskVerticalViewCell1 : UIView

@property(nonatomic,strong) UILabel *lable;

@end


@implementation MKTaskVerticalViewCell1

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self addSubview:self.lable];
        self.backgroundColor = UIColor.clearColor;
        [self.lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
    }
    return  self;
}
-(UILabel *)lable{
    if(_lable == nil) {
        _lable = UILabel.new;
        _lable.font = [UIFont systemFontOfSize:13];
        _lable.textColor = [UIColor whiteColor];
    }
    return  _lable;
}
@end

@interface MKTaskVerticalViewCell : UITableViewCell

@property(nonatomic,strong) UILabel *lable;

@end


@implementation MKTaskVerticalViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.lable];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColor.clearColor;
        self.contentView.backgroundColor = UIColor.clearColor;
        [self.lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
        }];
    }
    return  self;
}
-(UILabel *)lable{
    if(_lable == nil) {
        _lable = UILabel.new;
        _lable.font = [UIFont systemFontOfSize:13];
        _lable.textColor = [UIColor whiteColor];
    }
    return  _lable;
}
@end



@interface MKTaskVerticalView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic, assign) NSInteger index;

@property(nonatomic, strong) NSArray *subViewArray;




@end

@implementation MKTaskVerticalView



- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        _dataSource = NSArray.new;
        self.index = 0;
        MKTaskVerticalViewCell1 *view1 = [[MKTaskVerticalViewCell1 alloc] initWithFrame:CGRectZero];
        MKTaskVerticalViewCell1 *view2 = [[MKTaskVerticalViewCell1 alloc] initWithFrame:CGRectZero];
        MKTaskVerticalViewCell1 *view3 = [[MKTaskVerticalViewCell1 alloc] initWithFrame:CGRectZero];
        self.subViewArray = @[view1,view2,view3];
        self.backgroundColor = UIColor.clearColor;
        self.layer.masksToBounds = true;
//        [self addSubview:self.tableView];
//        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self).offset(0);
//            make.right.mas_equalTo(self).offset(0);
//            make.top.mas_equalTo(self).offset(0);
//            make.bottom.mas_equalTo(self).offset(0);
//        }];
    }
    return self;
}

- (void)setDataSource:(NSArray<NSString *> *)dataSource {
    _dataSource = dataSource;
    [self initSubView];
}

-(void)initSubView {
    MKTaskVerticalViewCell1 *view1 = self.subViewArray[0];
    MKTaskVerticalViewCell1 *view2 = self.subViewArray[1];
    MKTaskVerticalViewCell1 *view3 = self.subViewArray[2];
    view1.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    view2.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height);
    view3.frame = CGRectMake(0,  2 * self.frame.size.height, self.frame.size.width, self.frame.size.height);
    [self addSubview:self.subViewArray[0]];
    [self addSubview:self.subViewArray[1]];
    [self addSubview:self.subViewArray[2]];
    if(_dataSource.count > 0) {
       view2.lable.text = _dataSource[0];
    }
    if(_dataSource.count > 1) {
       view3.lable.text = _dataSource[1];
    }
    [UIView animateWithDuration:1.5 animations:^{
        view1.mj_y = view1.mj_y - self.frame.size.height;
        view2.mj_y = view2.mj_y - self.frame.size.height;
        view3.mj_y = view3.mj_y - self.frame.size.height;
    } completion:^(BOOL finished) {
        [self startRolling];
    }];
}

- (void)timerAction {
    MKTaskVerticalViewCell1 *view1 = self.subViewArray[0];
    MKTaskVerticalViewCell1 *view2 = self.subViewArray[1];
    MKTaskVerticalViewCell1 *view3 = self.subViewArray[2];
    
    [UIView animateWithDuration:1.5 animations:^{
        view1.mj_y = view1.mj_y - self.frame.size.height;
        view2.mj_y = view2.mj_y - self.frame.size.height;
        view3.mj_y = view3.mj_y - self.frame.size.height;
    } completion:^(BOOL finished) {
        view1.mj_y = self.frame.size.height;
        self.subViewArray = @[view2,view3,view1];
        if(self.index >= self.dataSource.count - 1) {
            self.index = 0;
        } else {
            self.index = self.index + 1;
        }
        view1.lable.text = self.dataSource[self.index];
    }];
}

- (void)startRolling{
        if (_timer) {
            [_timer invalidate];
            _timer = nil;
        }
    if(self.dataSource.count > 1) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}


//-(void) timerAction {
//    if(self.index == self.dataSource.count - 1) {
//        self.index = 0;
//        [self.tableView setContentOffset:CGPointMake(0, 0)];
//    } else {
//        self.index = self.index + 1;
//        [UIView animateWithDuration:1.5 animations:^{
//            [self.tableView setContentOffset:CGPointMake(0, self.index * (self.frame.size.height)) animated:false];
//        }];
//    }
//}





-(UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = UIColor.clearColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.scrollEnabled = NO;
        [_tableView registerClass:[MKTaskVerticalViewCell class] forCellReuseIdentifier:@"MKTaskVerticalViewCell"];
        [_tableView registerClass:[MKTaskVerticalViewCell class] forCellReuseIdentifier:@"MKTaskVerticalViewCell1"];
    }
    return  _tableView;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if(indexPath.row % 2 == 0) {
        MKTaskVerticalViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKTaskVerticalViewCell"];
        cell.lable.text = self.dataSource[indexPath.row];
        return  cell;
    } else {
        MKTaskVerticalViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKTaskVerticalViewCell1"];
        cell.lable.text = self.dataSource[indexPath.row];
        return  cell;
    }
   
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  25;
}



@end


