//
//  BTAreaPickViewModel.m
//  BTAreaPickViewController
//
//  Created by leishen on 2019/11/23.
//  Copyright © 2019 leishen. All rights reserved.
//

#import "BTAreaPickViewModel.h"


@implementation BTAreas


- (instancetype)initWithDictionary:(NSDictionary*)otherDictionary{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:otherDictionary];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"undefine %@",key);
}

@end


@implementation BTCities

- (instancetype)initWithDictionary:(NSDictionary*)otherDictionary{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:otherDictionary];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"undefine %@",key);
}

- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"children"]) {
        NSMutableArray<BTAreas*> * childrenArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in value) {
            BTAreas * children = [[BTAreas alloc]initWithDictionary:dic];
            [childrenArray addObject:children];
        }
        self.children = childrenArray;
    }
}


@end



@implementation BTProvinces

- (instancetype)initWithDictionary:(NSDictionary*)otherDictionary{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:otherDictionary];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"undefine %@",key);
}

- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"children"]) {
        NSMutableArray<BTCities*> * childrenArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in value) {
            BTCities * children = [[BTCities alloc]initWithDictionary:dic];
            [childrenArray addObject:children];
        }
        self.children = childrenArray;
    }
}


@end


@implementation NSArray (JSON)
+ (NSArray *)loadJsonOfBundlePathForResource:(NSString*)name{
    NSString *provincesPath = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:provincesPath];
    NSArray *temArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    return temArray;
}
@end

@implementation BTAreaPickViewModel


- (instancetype)init{
    self = [super init];
    if (self) {
        NSArray * temArray = [NSArray loadJsonOfBundlePathForResource:@"pca-code"];
        NSMutableArray<BTProvinces*> * provinceArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in temArray) {
            BTProvinces * provinces = [[BTProvinces alloc]initWithDictionary:dic];
            [provinceArray addObject:provinces];
        }
        self.provinces = provinceArray;
        
        self.selectedProvince = self.provinces.firstObject;
        self.selectedCitie = self.selectedProvince.children.firstObject;
        self.selectedArea = self.selectedCitie.children.firstObject;
    }
    return self;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"%@ %@ %@", self.selectedProvince.name,self.selectedCitie.name,self.selectedArea.name];
}
@end
