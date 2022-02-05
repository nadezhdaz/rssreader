//
//  NSMutableString+PathComponents.m
//  RSSReader
//
//  Created by Nadezhda Zenkova on 02.02.2022.
//

#import "NSMutableString+PathComponents.h"

@implementation NSMutableString (PathComponents)

- (void) appendPathComponent:(NSString *)path {
    NSString *string = [self stringByAppendingPathComponent:path];
    [self setString:string];
}

- (void) deleteLastPathComponent {
    NSString *string = [self stringByDeletingLastPathComponent];
    [self setString:string];
}

@end
