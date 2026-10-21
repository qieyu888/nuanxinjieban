#import "BDASignalBootstrap.h"
#import <BDASignalSDK/BDASignalSDK.h>

@implementation BDASignalBootstrap

+ (void)startWithLaunchOptions:(NSDictionary *)launchOptions
                connectOptions:(UISceneConnectionOptions *)connectOptions {
  [BDASignalManager registerWithOptionalData:@{}];
  [BDASignalManager didFinishLaunchingWithOptions:launchOptions
                                   connectOptions:connectOptions];
}

@end
