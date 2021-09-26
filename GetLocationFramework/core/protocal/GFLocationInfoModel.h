//
//  GFLocationInfoModel.h
//  GetLocationFramework
//
//  Created by yanxuezhou on 2021/7/27.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface GFLocationInfoModel : NSObject


@property(nonatomic,copy)CLLocation *location;
///国家名字属性
@property(nonatomic,copy) NSString *country;
///国家编码属性
@property(nonatomic,copy) NSString *countryCode;
///省份名字属性
@property(nonatomic,copy) NSString *province;
///城市名字属性
@property(nonatomic,copy) NSString *city;

///区名字属性
@property(nonatomic,copy) NSString *district;

///乡镇名字属性
@property(nonatomic,copy) NSString *town;

///街道名字属性
@property(nonatomic,copy) NSString *street;

///街道号码属性
@property(nonatomic,copy) NSString *streetNumber;

///城市编码属性
@property(nonatomic,copy) NSString *cityCode;

///行政区划编码属性
@property(nonatomic,copy) NSString *adCode;

///位置语义化结果的定位点在什么地方周围的描述信息
@property(nonatomic,copy) NSString *locationDescribe;

@end


