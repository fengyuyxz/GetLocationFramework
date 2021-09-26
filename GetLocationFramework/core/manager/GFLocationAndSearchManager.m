//
//  GFLocationAndSearchManager.m
//  GetLocationFramework
//
//  Created by yanxuezhou on 2021/8/4.
//

#import "GFLocationAndSearchManager.h"
#define safeMainBlock(x) __weak typeof(self) weakSelf = self;\
dispatch_async(dispatch_get_main_queue(), ^{\
__strong typeof(weakSelf) strongSelf = weakSelf;\
    if (strongSelf==nil) {\
        return;\
    }\
{x}\
});
@interface GFLocationAndSearchManager()
@property(nonatomic,strong) NSObject<GFStartGetLocationInfoProtocol> * location;
@property(nonatomic,strong) NSMutableArray<CompletionLocation> * blockList;
@property(nonatomic,strong) NSOperationQueue * queue;
@property(nonatomic,assign)BOOL isLocationing;
@end
@implementation GFLocationAndSearchManager
{
    int i;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        _queue = [[NSOperationQueue alloc]init];
        _queue.maxConcurrentOperationCount = 1;
    }
    return self;
}
- (void)initAppKey:(NSString *)appKey {
    [self.location initAppKey:appKey];
    
}
- (void)beginLocation:(CompletionLocation)block {
    __weak typeof(self) weakSelf = self;
    [self.queue addOperationWithBlock:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf==nil) {
            return;
        }
        if (block) {
            [strongSelf.blockList addObject:block];
        }
    }];
    [self.queue addOperationWithBlock:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf==nil) {
            return;
        }
        if (!strongSelf.isLocationing) {
            NSLog(@"开始定位==== %d",++self->i);
            strongSelf.isLocationing = YES;
            [strongSelf.location beginLocation:^(BOOL suc, GFLocationInfoModel *model) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                if (strongSelf==nil) {
                    return;
                }

                strongSelf.isLocationing = NO;
                [strongSelf boadcastLocationResult:suc?model:nil];
            }];
        }
    }];
}
-(void)boadcastLocationResult:(GFLocationInfoModel *)model
{   __weak typeof(self) weakSelf = self;
    NSLog(@"boadcastLocationResult====");
    [self.queue addOperationWithBlock:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf==nil) {
            return;
        }
//        NSLog(@"通知总数==== %lu",(unsigned long)self.blockList.count);
        if (strongSelf.blockList==nil||strongSelf.blockList.count==0) {
            return;
        }
        if (model==nil) {
            [strongSelf.blockList enumerateObjectsUsingBlock:^(CompletionLocation  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                obj(NO,nil);
                if (obj) {
                    safeMainBlock(obj(NO,nil);)
                }
            }];
        }else{
            [strongSelf.blockList enumerateObjectsUsingBlock:^(CompletionLocation  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                obj(YES,model);
                if (obj) {
                    safeMainBlock(obj(YES,model);)
                }
                
            }];
        }
        [strongSelf.blockList removeAllObjects];
    }];
}

- (NSObject<GFStartGetLocationInfoProtocol> *)location{
    if (_location==nil) {
        Class baidClass = NSClassFromString(@"GFBaiduLocation");
        Class gaoDeClass = NSClassFromString(@"GFGaoDeLocation");
        if (baidClass!=nil) {
            NSObject *baidu = [[baidClass alloc]init];
            if ([baidu conformsToProtocol:@protocol(GFStartGetLocationInfoProtocol)]) {
                _location = (NSObject<GFStartGetLocationInfoProtocol> *)baidu;
                
            }
        }else if (gaoDeClass!=nil) {
            NSObject *gaode = [[gaoDeClass alloc]init];
            if ([gaode conformsToProtocol:@protocol(GFStartGetLocationInfoProtocol)]) {
                _location = (NSObject<GFStartGetLocationInfoProtocol> *)gaode;
            }
        }
        _location.isAwaysLocation = self.isAwaysLocation;
    }
    return _location;
}

-(NSMutableArray<CompletionLocation> *)blockList{
    if (_blockList==nil) {
        _blockList = [[NSMutableArray alloc]init];
    }
    return _blockList;
}
#pragma mark - ================= 单例实现代码 ===============
static GFLocationAndSearchManager *_instance;
static dispatch_once_t onceToken;
+(instancetype)shareInstance{
    return [[self alloc]init];
}
//alloc 底层调用还是 allocWithZone，所以重写allocWithZone方法
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
// copy 方法 也会创建新的对象。为了严谨也应该重写copy方法，因copy方法最终调用的也是copyWithZone因此 重写copyWithZone和mutableCopyWithZone。mutableCopyWithZone，mutableCopyWithZone需遵守NSCopying,NSMutableCopying协议才能敲出，在写出这两个方法后可删除NSCopying,NSMutableCopying协议
-(id)copyWithZone:(NSZone *)zone{
    
  
    return _instance;
}
-(id)mutableCopyWithZone:(NSZone *)zone{
    return _instance;
}

@end

