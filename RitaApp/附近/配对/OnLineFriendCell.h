//
//  OnLineFriendCell.h
//  RitaApp
//
//  Created by BBC on 16/7/28.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MakeFriendModel.h"
@interface OnLineFriendCell : UITableViewCell

@property(nonatomic,copy) void(^OnLineFriendCellAcction)(NSInteger index);

-(void)updateZYFriendMainCell:(MakeFriendModel *)model withIndex:(NSInteger)index;

@end
   