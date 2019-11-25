//
//  BTAreaPickViewController.m
//  BTAreaPickViewController
//
//  Created by leishen on 2019/11/23.
//  Copyright © 2019 leishen. All rights reserved.
//

#import "BTAreaPickViewController.h"
#import "BTAreaPickViewModel.h"
#import "BTCoverVerticalTransition.h"

@interface BTAreaPickViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic, assign) NSInteger provinceIndex,citieIndex,areaIndex;
@property (nonatomic, strong) BTCoverVerticalTransition *aniamtion;
@end

@implementation BTAreaPickViewController

- (instancetype)initWithDragDismissEnabal:(BOOL)enabel{
    self = [super init];
    if (self) {
        _aniamtion = [[BTCoverVerticalTransition alloc]initPresentViewController:self withDragDismissEnabal:enabel];
        self.transitioningDelegate = _aniamtion;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:UIColor.whiteColor];
    [self.view addSubview:self.pickerView];
    [self.view addSubview:self.toolBar];
    [self updatePreferredContentSizeWithTraitCollection:self.traitCollection];
    [self.toolBar setBackgroundColor:UIColor.whiteColor];
    [self.toolBar setBarTintColor:UIColor.whiteColor];
}

- (void)setHiddenToolbar:(BOOL)hiddenToolbar{
    _hiddenToolbar = hiddenToolbar;
    self.toolBar.hidden = YES;
    [self.view layoutIfNeeded];
}

- (void)updatePreferredContentSizeWithTraitCollection:(UITraitCollection *)traitCollection {
    // 适配屏幕，横竖屏
    if (CGSizeEqualToSize(CGSizeZero, self.preferredContentSize)) {
        self.preferredContentSize = CGSizeMake(self.view.bounds.size.width, traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact ? 220 : 400);
    }
}

/// 屏幕旋转时调用的方法
/// @param newCollection 新的方向
/// @param coordinator 动画协调器
- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
    [self updatePreferredContentSizeWithTraitCollection:newCollection];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.toolBar.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), self.hiddenToolbar?0:40);
    self.pickerView.frame = CGRectMake(0, CGRectGetMaxY(self.toolBar.frame), CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-CGRectGetHeight(self.toolBar.bounds));
}

- (void)setSelectedModelWithProvinceIndex:(NSInteger)provinceIndex
                           withCitieIndex:(NSInteger)citieIndex
                            withAreaIndex:(NSInteger)areaIndex {
    self.model.selectedProvince = self.model.provinces[provinceIndex];
    if (citieIndex>self.model.selectedProvince.children.count) {
        citieIndex = [self.pickerView selectedRowInComponent:1];
    }
    self.model.selectedCitie = self.model.selectedProvince.children[citieIndex];
    if (areaIndex>self.model.selectedCitie.children.count) {
        areaIndex = [self.pickerView selectedRowInComponent:2];
    }
    self.model.selectedArea = self.model.selectedCitie.children[areaIndex];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    switch (component) {
        case 0: {
            return self.model.provinces.count;
        };
        case 1: {
            return self.model.provinces[self.provinceIndex].children.count;
        }
        case 2: {
            return self.model.provinces[self.provinceIndex].children[self.citieIndex].children.count;
        };
        default: {
            return 0;
        }
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    switch (component) {
        case 0: {
            self.model.selectedProvince = self.model.provinces[row];
            return self.model.selectedProvince.name;
        }
        case 1: {
            self.model.selectedCitie = self.model.provinces[self.provinceIndex].children[row];
            return self.model.selectedCitie.name;
        }
        case 2: {
            self.model.selectedArea = self.model.provinces[self.provinceIndex].children[self.citieIndex].children[row];
            return self.model.selectedArea.name;
        }
        default: {
            return nil;
        }
    }
}

#pragma mark - UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (component) {
        case 0:{
            self.provinceIndex = row;
            self.citieIndex = 0;
            [pickerView reloadComponent:1];
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:1 animated:YES];
            [pickerView selectRow:0 inComponent:2 animated:YES];
            break;
        }
        case 1:{
            self.citieIndex = row;
            self.areaIndex = 0;
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:YES];
            break;
        }
        case 2:{
            self.areaIndex = row;
            break;
        }
        default:
            break;
    }
    if ([self.delegate respondsToSelector:@selector(areaPickerView:didSelectAreaModel:)]) {
        [self.delegate areaPickerView:self didSelectAreaModel:self.model];
    }
}

- (void)cancelAction:(UIBarButtonItem*)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)doneAction:(UIBarButtonItem*)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        if ([self.delegate respondsToSelector:@selector(areaPickerView:doneAreaModel:)]) {
            [self.delegate areaPickerView:self doneAreaModel:self.model];
        }
    }];
}

#pragma mark - lazy

- (UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]init];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
    }
    return _pickerView;
}

- (BTAreaPickViewModel *)model{
    if (!_model) {
        _model = [[BTAreaPickViewModel alloc]init];
    }
    return _model;
}

- (UIToolbar *)toolBar{
    if (!_toolBar) {
        _toolBar = [[UIToolbar alloc]init];
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemCancel) target:self action:@selector(cancelAction:)];
        UIBarButtonItem *doneItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemDone) target:self action:@selector(doneAction:)];;
        UIBarButtonItem *fixItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixItem.width = 20;

        UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        _toolBar.items = @[cancelItem,flexItem,doneItem];
    }
    return _toolBar;
}
@end
