//
//  YPPhotoGroupController.h
//  YPPhotoDemo
//
//  Created by YueWen on 16/7/13.
//  Copyright © 2017年 YueWen. All rights reserved.
//  Github:https://github.com/RITL/RITLImagePickerDemo
//

#import <UIKit/UIKit.h>
#import "RITLTableViewModel.h"
#import "RITLPhotoViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class RITLPhotoGroupViewModel;

/// 显示组的控制器
NS_AVAILABLE_IOS(8_0) @interface RITLPhotoGroupViewController : UITableViewController <RITLPhotoViewController>

/// viewModel
@property (nonatomic, strong) id <RITLTableViewModel> viewModel;


@end

NS_ASSUME_NONNULL_END
