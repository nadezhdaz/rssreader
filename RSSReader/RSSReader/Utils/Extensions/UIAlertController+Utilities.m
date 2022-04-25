//
//  UIAlertController+Utilities.m
//  RSSReader
//
//  Created by Nadezhda Zenkova on 20.04.2022.
//

#import "UIAlertController+Utilities.h"

@implementation UIAlertController (Utilities)

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+ (UIAlertController *) presentAlertWithErrorMessage:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error"
                                                                             message:[NSString stringWithFormat:@"%@", message]
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil]];
    return alertController;
}

@end
