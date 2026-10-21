#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BDASignalBootstrap : NSObject

+ (void)startWithLaunchOptions:(nullable NSDictionary *)launchOptions
                connectOptions:(nullable UISceneConnectionOptions *)connectOptions;

@end

NS_ASSUME_NONNULL_END
