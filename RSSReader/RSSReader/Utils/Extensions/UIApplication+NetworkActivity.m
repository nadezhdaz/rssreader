//
//  UIApplication+NetworkActivity.m
//  RSSReader
//
//  Created by Nadezhda Zenkova on 20.04.2022.
//

#import "UIApplication+NetworkActivity.h"

@implementation UIApplication (NetworkActivity)

static NSInteger activityIndicatorsCount = 0;

+ (void) startNetworkActivityIndicator {
    @synchronized ([UIApplication sharedApplication]) {
        if (activityIndicatorsCount == 0) {
            UIApplication* app = [UIApplication sharedApplication];
            app.networkActivityIndicatorVisible = true;
        }
        activityIndicatorsCount++;
    }
}

+ (void) stopNetworkActivityIndicator {
    @synchronized ([UIApplication sharedApplication]) {
        activityIndicatorsCount--;
        if (activityIndicatorsCount <= 0) {
            UIApplication* app = [UIApplication sharedApplication];
            app.networkActivityIndicatorVisible = false;
            activityIndicatorsCount = 0;
        }
    }
}

@end
