//
//  BTAreaPickViewController.h
//  BTAreaPickViewController
//
//  Created by leishen on 2019/11/23.
//  Copyright © 2019 leishen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTAreaPickViewModel.h"

NS_ASSUME_NONNULL_BEGIN
@class BTAreaPickViewController;
@protocol BTAreaPickViewControllerDelegate <NSObject>
@optional;

/// 选中后调用的方法
/// @param areaPickerView 地区视图控制器
/// @param model 模型数据
- (void)areaPickerView:(BTAreaPickViewController *)areaPickerView didSelectAreaModel:(BTAreaPickViewModel*)model;

/// 点击完成后
/// @param areaPickerView 地区视图控制器
/// @param model 模型数据
- (void)areaPickerView:(BTAreaPickViewController *)areaPickerView doneAreaModel:(BTAreaPickViewModel*)model;
@end

@interface BTAreaPickViewController : UIViewController

/// 初始化方法
/// @param enabel 是否带有拖拽关闭
- (instancetype)initWithDragDismissEnabal:(BOOL)enabel;

/// Toolbar
@property (nonatomic, strong) UIToolbar *toolBar;

/// 选择器
@property (nonatomic, strong) UIPickerView *pickerView;

/// 代理方法
@property (nonatomic, weak) id<BTAreaPickViewControllerDelegate> delegate;

/// 是否隐藏toolbar
@property (nonatomic, assign) BOOL hiddenToolbar;

/// 数据模型
@property (nonatomic, strong) BTAreaPickViewModel *model;
@end

NS_ASSUME_NONNULL_END
