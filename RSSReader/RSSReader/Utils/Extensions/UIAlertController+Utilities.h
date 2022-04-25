//
//  UIAlertController+Utilities.h
//  RSSReader
//
//  Created by Nadezhda Zenkova on 20.04.2022.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertController (Utilities)

+ (UIAlertController *) presentAlertWithErrorMessage:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
