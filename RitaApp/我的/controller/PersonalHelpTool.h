//
//  PersonalHelpTool.h
//  RitaApp
//
//  Created by BBC on 16/7/20.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalHelpTool : UIView

@property(nonatomic,copy) void(^personToolAction)(NSInteger index);
 

@end
