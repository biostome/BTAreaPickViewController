//
//  BTAreaPickViewModel.h
//  BTAreaPickViewController
//
//  Created by leishen on 2019/11/23.
//  Copyright © 2019 leishen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface BTAreas : NSObject
/// 编码
@property (nonatomic, assign) NSInteger code;
/// 区名
@property (nonatomic, strong) NSString *name;
@end

@interface BTCities : NSObject
/// 编码
@property (nonatomic, assign) NSInteger code;
/// 市名
@property (nonatomic, strong) NSString *name;
/// 子区
@property (nonatomic, strong) NSArray<BTAreas*> *children;
@end

@interface BTProvinces : NSObject
/// 编码
@property (nonatomic, assign) NSInteger code;
/// 省名
@property (nonatomic, strong) NSString *name;
/// 子市
@property (nonatomic, strong) NSArray<BTCities*> *children;
@end

@interface BTAreaPickViewModel : NSObject
/// 子省
@property (nonatomic, strong) NSArray<BTProvinces*> *provinces;
/// 选中的省
@property (nonatomic, strong) BTProvinces *selectedProvince;
/// 选中的市
@property (nonatomic, strong) BTCities *selectedCitie;
/// 选中的区
@property (nonatomic, strong) BTAreas *selectedArea;
@end

NS_ASSUME_NONNULL_END
