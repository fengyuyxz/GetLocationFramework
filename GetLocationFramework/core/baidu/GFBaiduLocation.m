//
//  GFBaiduLocation.m
//  GetLocationFramework
//
//  Created by yanxuezhou on 2021/7/27.
//

#import "GFBaiduLocation.h"
#import <BMKLocationkit/BMKLocationComponent.h>
@interface GFBaiduLocation()<BMKLocationAuthDelegate,BMKLocationManagerDelegate>
@property(nonatomic,strong) BMKLocationManager * locationManager;

@end
@implementation GFBaiduLocation
- (instancetype)init
{
    self = [super init];
    if (self) {
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (strongSelf==nil) {
                return;
            }
            strongSelf.locationManager = [[BMKLocationManager alloc]init];
            strongSelf.locationManager.delegate = self;
            //设置返回位置的坐标系类型
            strongSelf.locationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
            //设置距离过滤参数
            strongSelf.locationManager.distanceFilter = kCLDistanceFilterNone;
            //设置预期精度参数
            strongSelf.locationManager.desiredAccuracy =kCLLocationAccuracyHundredMeters;// kCLLocationAccuracyBest;
            //设置应用位置类型
            strongSelf.locationManager.activityType = CLActivityTypeAutomotiveNavigation;
            //设置是否自动停止位置更新
            strongSelf.locationManager.pausesLocationUpdatesAutomatically = NO;
            //设置是否允许后台定位
//            strongSelf.locationManager.allowsBackgroundLocationUpdates = YES;
            //设置位置获取超时时间
            strongSelf.locationManager.locationTimeout = 3;//10;
            //设置获取地址信息超时时间
            strongSelf.locationManager.reGeocodeTimeout = 3;//10;
        });
    }
    return self;
}
- (void)initAppKey:(NSString *)appKey {
    [[BMKLocationAuth sharedInstance] checkPermisionWithKey:appKey authDelegate:self];
}

- (void)beginLocation:(CompletionLocation)block {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf==nil) {
            return;
        }
        [strongSelf.locationManager requestLocationWithReGeocode:YES withNetworkState:NO completionBlock:^(BMKLocation * _Nullable location, BMKLocationNetworkState state, NSError * _Nullable error) {
            if (error) {
                if (block) {
                    block(NO,nil);
                }
            }else{
                GFLocationInfoModel *model = [strongSelf translationLocationInfo:location];
                if (block) {
                    block(YES,model);
                }
            }
        }];

    });
}
-(GFLocationInfoModel *)translationLocationInfo:(BMKLocation *)bmkLocation
{
    GFLocationInfoModel *model = [[GFLocationInfoModel alloc]init];
    model.location = bmkLocation.location;
    BMKLocationReGeocode *geoCode = bmkLocation.rgcData;
    ///国家名字属性
    model.country=geoCode.country;

    ///国家编码属性
    model.countryCode=geoCode.countryCode;

    ///省份名字属性
    model.province=geoCode.province;

    ///城市名字属性
    model.city=geoCode.city;

    ///区名字属性
    model.district=geoCode.district;

    ///乡镇名字属性
    model.town=geoCode.town;

    ///街道名字属性
    model.street=geoCode.street;

    ///街道号码属性
    model.streetNumber=geoCode.streetNumber;

    ///城市编码属性
    model.cityCode=geoCode.cityCode;

    ///行政区划编码属性
    model.adCode=geoCode.adCode;


    ///位置语义化结果的定位点在什么地方周围的描述信息
    model.locationDescribe=geoCode.locationDescribe;
    return model;
}


- (void)onCheckPermissionState:(BMKLocationAuthErrorCode)iError{
    NSLog(@"百度鉴权 %ld",(long)iError);
}

/**
 *  @brief 为了适配app store关于新的后台定位的审核机制（app store要求如果开发者只配置了使用期间定位，则代码中不能出现申请后台定位的逻辑），当开发者在plist配置NSLocationAlwaysUsageDescription或者NSLocationAlwaysAndWhenInUseUsageDescription时，需要在该delegate中调用后台定位api：[locationManager requestAlwaysAuthorization]。开发者如果只配置了NSLocationWhenInUseUsageDescription，且只有使用期间的定位需求，则无需在delegate中实现逻辑。
 *  @param manager 定位 BMKLocationManager 类。
 *  @param locationManager 系统 CLLocationManager 类 。
 *  @since 1.6.0
 */
- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager doRequestAlwaysAuthorization:(CLLocationManager * _Nonnull)locationManager{
    if (self.isAwaysLocation) {
        [locationManager requestAlwaysAuthorization];
    }
}














/*
-(BMKLocationManager *)locationManager{
    if (_locationManager==nil) {
        _locationManager = [[BMKLocationManager alloc]init];
        _locationManager.delegate = self;
        //设置返回位置的坐标系类型
        _locationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
        //设置距离过滤参数
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        //设置预期精度参数
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        //设置应用位置类型
        _locationManager.activityType = CLActivityTypeAutomotiveNavigation;
        //设置是否自动停止位置更新
        _locationManager.pausesLocationUpdatesAutomatically = NO;
        
        //设置位置获取超时时间
        _locationManager.locationTimeout = 10;
        //设置获取地址信息超时时间
        _locationManager.reGeocodeTimeout = 10;
    }
    return _locationManager;
}*/
@end
