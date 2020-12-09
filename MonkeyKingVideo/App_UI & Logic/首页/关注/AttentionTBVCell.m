//
//  AttentionTBVCell.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/24.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "AttentionTBVCell.h"

@implementation AttentionTBVCell

+(instancetype)cellWith:(UITableView *)tableView{
    AttentionTBVCell *cell = (AttentionTBVCell *)[tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if (!cell) {
        cell = [[AttentionTBVCell alloc]initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:ReuseIdentifier
                                              marginX:3
                                              marginY:10];
//        [UIView cornerCutToCircleWithView:cell.contentView
//                          AndCornerRadius:5.f];
//        [UIView colourToLayerOfView:cell.contentView
//                         WithColour:kBlackColor
//                     AndBorderWidth:.1f];
    }return cell;
}

-(void)drawRect:(CGRect)rect{

}

+(CGFloat)cellHeightWithModel:(id _Nullable)model{
    return MAINSCREEN_HEIGHT / 4.5;
}

- (void)richElementsInCellWithModel:(id _Nullable)model{
    
}
#pragma mark —— lazyLoad

@end
