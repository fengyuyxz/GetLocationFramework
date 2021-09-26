//
//  GFLocationAndSearchManager.h
//  GetLocationFramework
//
//  Created by yanxuezhou on 2021/8/4.
//

#import <Foundation/Foundation.h>
#import "GFStartGetLocationInfoProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface GFLocationAndSearchManager : NSObject<GFStartGetLocationInfoProtocol>
@property(nonatomic,assign)BOOL isAwaysLocation;
+(instancetype)shareInstance;
@end

NS_ASSUME_NONNULL_END
