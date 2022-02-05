//
//  NSMutableString+PathComponents.h
//  RSSReader
//
//  Created by Nadezhda Zenkova on 02.02.2022.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableString (PathComponents)

- (void) appendPathComponent:(NSString *)path;
- (void) deleteLastPathComponent;

@end

NS_ASSUME_NONNULL_END
