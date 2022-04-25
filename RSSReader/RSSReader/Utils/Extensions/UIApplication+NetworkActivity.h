//
//  UIApplication+NetworkActivity.h
//  RSSReader
//
//  Created by Nadezhda Zenkova on 20.04.2022.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (NetworkActivity)

+ (void) startNetworkActivityIndicator;
+ (void) stopNetworkActivityIndicator;

@end

NS_ASSUME_NONNULL_END
