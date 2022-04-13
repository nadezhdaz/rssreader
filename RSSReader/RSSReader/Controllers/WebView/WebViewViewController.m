//
//  WebViewViewController.m
//  RSSReader
//
//  Created by Nadezhda Zenkova on 11.04.2022.
//

#import "WebViewViewController.h"

@interface WebViewViewController ()

@property (nonatomic, retain) WebViewViewModel *viewModel;
@property(nonatomic, retain) WKWebView *webView;

@property (nonatomic, retain) UIBarButtonItem *flexibleSpace;
@property (nonatomic, retain) UIBarButtonItem *backButton;
@property (nonatomic, retain) UIBarButtonItem *forwardButton;
@property (nonatomic, retain) UIBarButtonItem *refreshButton;
@property (nonatomic, retain) UIBarButtonItem *stopButton;
@property (nonatomic, retain) UIBarButtonItem *launchInSafariButton;

@end

@implementation WebViewViewController

- (instancetype)initWithViewModel:(WebViewViewModel *)viewModel {
    self = [super init];
    if (self) {
        _viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupWebView];
    
    [self setupToolBar];
    
    self.webView.navigationDelegate = self;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[self.viewModel url]]];
}

- (void)setupWebView {
    WKWebViewConfiguration *configuration = [WKWebViewConfiguration new];
    self.webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
    NSURLRequest *request = [NSURLRequest requestWithURL:[self.viewModel url]];
    [self.webView loadRequest:request];
    
    [self.view addSubview:self.webView];
    [self.webView setFrame:self.view.bounds];
}

- (void)setupToolBarButtons {
    self.flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                   target:nil
                                                                                   action:nil];
    
    self.backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"chevron.backward"]
                                                       style:UIBarButtonItemStylePlain
                                                      target:self
                                                      action:@selector(goBackAction)];
    
    
    self.forwardButton = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"chevron.forward"]
                                                          style:UIBarButtonItemStylePlain
                                                         target:self
                                                         action:@selector(goForwardAction)];
    
    self.refreshButton = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"arrow.clockwise"]
                                                       style:UIBarButtonItemStylePlain
                                                      target:self
                                                      action:@selector(refreshAction)];
    
    self.stopButton = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"xmark"]
                                                       style:UIBarButtonItemStylePlain
                                                      target:self
                                                      action:@selector(stopLoadingAction)];
    
    self.launchInSafariButton = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"safari"]
                                                          style:UIBarButtonItemStylePlain
                                                         target:self
                                                         action:@selector(launchSafariAction)];
    
    [self.stopButton setEnabled:false];
}

- (void)setupToolBar {
    [self setupToolBarButtons];
    //UIRefreshControl
    
    CGFloat screenWidth = self.view.bounds.size.width;
    CGFloat toolBarHeight = self.view.bounds.size.height * 0.2;
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, screenWidth, toolBarHeight)];
    [toolBar setTranslucent:false];
    toolBar.translatesAutoresizingMaskIntoConstraints = false;
    
    [toolBar setItems:@[self.flexibleSpace, self.backButton, self.forwardButton, self.flexibleSpace, self.flexibleSpace, self.refreshButton, self.flexibleSpace, self.stopButton, self.flexibleSpace, self.launchInSafariButton, self.flexibleSpace]];
    [self.webView addSubview:toolBar];
    
    [NSLayoutConstraint activateConstraints:@[
        [toolBar.leadingAnchor constraintEqualToAnchor: self.webView.leadingAnchor constant:0.0],
        [toolBar.trailingAnchor constraintEqualToAnchor: self.webView.trailingAnchor constant:0.0],
        [toolBar.bottomAnchor constraintEqualToAnchor: self.webView.bottomAnchor constant:-16.0],
    ]];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    self.stopButton.enabled = false;
    self.refreshButton.enabled = true;
}

- (void)goBackAction {
    [self.webView goBack];
}

- (void)goForwardAction {
    [self.webView goForward];
}

- (void)refreshAction {
    [self.webView reloadFromOrigin];
}

- (void)stopLoadingAction {
    [self.webView stopLoading];
}

- (void)updateButtonsState {
    if ([self.webView isLoading]) {
        [self.stopButton setEnabled:true];
        [self.refreshButton setEnabled:true];
    } else {
        [self.stopButton setEnabled:false];
        [self.refreshButton setEnabled:true];
    }
    
}

- (void)launchSafariAction {
    [[UIApplication sharedApplication] openURL:[self.viewModel url]
                                       options:@{}
                             completionHandler:nil];
}

@end
