//
//  BrowseImagesViewController.h
//  2015-02-04-WeChatImagePickerDemo
//
//  Created by TangJR on 15/2/5.
//  Copyright (c) 2015年 tangjr. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define PROPORTION SCREEN_WIDTH / 320

@interface BrowseImagesViewController : UIViewController

@property (copy, nonatomic) void(^deleteBlock)(NSInteger index);

- (instancetype)initWithIndex:(NSInteger)index selectImages:(NSMutableArray *)selectImages;

@end  