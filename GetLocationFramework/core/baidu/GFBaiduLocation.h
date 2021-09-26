//
//  GFBaiduLocation.h
//  GetLocationFramework
//
//  Created by yanxuezhou on 2021/7/27.
//

#import <Foundation/Foundation.h>
#import "GFStartGetLocationInfoProtocol.h"
#import "GFLocationInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GFBaiduLocation : NSObject <GFStartGetLocationInfoProtocol>
@property(nonatomic,assign)BOOL isAwaysLocation;
@end

NS_ASSUME_NONNULL_END
