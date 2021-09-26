//
//  ViewController.m
//  GetLocationFramework
//
//  Created by yanxuezhou on 2021/7/27.
//

#import "ViewController.h"
#import "GFLocationAndSearchManager.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property(nonatomic,strong) NSOperationQueue * ioQueue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _ioQueue = [[NSOperationQueue alloc]init];
    _ioQueue.maxConcurrentOperationCount = 6;
    NSString *baiduKey = @"8c8ljIkHKVAqcXEwicPeMYk6tBjiFrtG";
    [GFLocationAndSearchManager shareInstance].isAwaysLocation = YES;
    [[GFLocationAndSearchManager shareInstance]initAppKey:baiduKey];
    
    //
}

- (IBAction)butClick:(id)sender {
    [self.ioQueue addOperationWithBlock:^{
        for (int i=0; i<10; i++) {
//            if (i%2==0) {
//                [self performSelector:@selector(begin:) withObject:[NSString stringWithFormat:@"%d",i] afterDelay:0.1];
//            }else{
                [self performSelector:@selector(begin:) withObject:[NSString stringWithFormat:@"%d",i]];
//            }
            
        }
    }];
    [self.ioQueue addOperationWithBlock:^{
        for (int i=10; i<20; i++) {
//            if (i%3==0) {
//                [self performSelector:@selector(begin:) withObject:[NSString stringWithFormat:@"%d",i] afterDelay:0.1];
//            }else{
                [self performSelector:@selector(begin:) withObject:[NSString stringWithFormat:@"%d",i]];
//            }
            
        }
    }];
    
    [self.ioQueue addOperationWithBlock:^{
        for (int i=20; i<30; i++) {
//            if (i%2==0) {
//                [self performSelector:@selector(begin:) withObject:[NSString stringWithFormat:@"%d",i] afterDelay:0.1];
//            }else{
                [self performSelector:@selector(begin:) withObject:[NSString stringWithFormat:@"%d",i]];
//            }
            
        }
    }];
    
    [self.ioQueue addOperationWithBlock:^{
        for (int i=30; i<40; i++) {
//            if (i%3==0) {
//                [self performSelector:@selector(begin:) withObject:[NSString stringWithFormat:@"%d",i] afterDelay:0.1];
//            }else{
                [self performSelector:@selector(begin:) withObject:[NSString stringWithFormat:@"%d",i]];
//            }
            
        }
    }];
    
}

-(void)begin:(NSString *)i{
    
        [[GFLocationAndSearchManager shareInstance] beginLocation:^(BOOL suc, GFLocationInfoModel * model) {

            if (suc&&model) {
                self.textView.text = model.locationDescribe;
                NSLog(@"结束定位%@  =   %@",i,model.locationDescribe);
                
            }
        }];
    
}
@end
