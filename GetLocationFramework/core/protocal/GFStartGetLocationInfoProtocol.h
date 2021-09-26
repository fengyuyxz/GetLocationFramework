//
//  GFStartGetLocationInfoProtocol.h
//  GetLocationFramework
//
//  Created by yanxuezhou on 2021/7/27.
//

#import <Foundation/Foundation.h>
#import "GFLocationInfoModel.h"

typedef void(^CompletionLocation)(BOOL suc,GFLocationInfoModel *model);
@protocol GFStartGetLocationInfoProtocol <NSObject>

/// 是否需要后台定位，NO则试用期间定位;  NSLocationAlwaysUsageDescription或者NSLocationAlwaysAndWhenInUseUsageDescription时;开发者如果只配置了NSLocationWhenInUseUsageDescription，且只有使用期间的定位
@property(nonatomic,assign)BOOL isAwaysLocation;
-(void)initAppKey:(NSString *)appKey;
-(void)beginLocation:(CompletionLocation)block;
@end



