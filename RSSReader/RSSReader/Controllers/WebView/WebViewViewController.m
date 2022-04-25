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
@property (nonatomic, retain) UIBarButtonItem *fixedSpace;
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

- (void) dealloc {
    [_viewModel release];
    [_webView release];
    [_flexibleSpace release];
    [_fixedSpace release];
    [_backButton release];
    [_forwardButton release];
    [_refreshButton release];
    [_stopButton release];
    [_launchInSafariButton release];
    
    [super dealloc];
}

- (void)setViewModel:(WebViewViewModel *)viewModel {
    _viewModel = viewModel;
}

-(void)loadView {
    WKWebView *webView = [[[WKWebView alloc] initWithFrame:CGRectZero] autorelease];
    webView.navigationDelegate = self;
    webView.UIDelegate = self;
    
    self.view = webView;
    self.webView = webView;
    
    //[self loadURL:[self.viewModel url]];
    
    [self setupToolBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadURL:[self.viewModel url]];
}

-(void)loadURL:(NSURL *)url {
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

/*- (void)setupWebView {
    self.webView = [[[WKWebView alloc] initWithFrame:CGRectZero] autorelease];
    NSURLRequest *request = [NSURLRequest requestWithURL:[self.viewModel url]];
    [self.webView loadRequest:request];
    
    [self.view addSubview:self.webView];
    [self.webView setFrame:self.view.bounds];
}*/

- (void)setupToolBarButtons {
    self.flexibleSpace = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                   target:nil
                                                                                   action:nil] autorelease];
    
    self.fixedSpace = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                        target:nil
                                                                        action:nil] autorelease];
    [self.fixedSpace setWidth:20.0];
    
    self.backButton = [[[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"chevron.backward"]
                                                       style:UIBarButtonItemStylePlain
                                                      target:self
                                                      action:@selector(goBackAction)] autorelease];
    
    
    self.forwardButton = [[[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"chevron.forward"]
                                                          style:UIBarButtonItemStylePlain
                                                         target:self
                                                         action:@selector(goForwardAction)] autorelease];
    
    self.refreshButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                      target:self
                                                      action:@selector(refreshAction)] autorelease];
    
    self.stopButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                                      target:self
                                                      action:@selector(stopLoadingAction)] autorelease];
    
    self.launchInSafariButton = [[[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"safari"]
                                                          style:UIBarButtonItemStylePlain
                                                         target:self
                                                         action:@selector(launchSafariAction)] autorelease];
    
    [self.stopButton setEnabled:false];
}

- (void)setupToolBar {
    [self setupToolBarButtons];
    //UIRefreshControl
    
    self.navigationController.toolbarHidden = false;
    
    [self setToolbarItems:@[self.fixedSpace,
                            self.backButton,
                            self.flexibleSpace,
                            self.forwardButton,
                            self.flexibleSpace,
                            self.refreshButton,
                            self.flexibleSpace,
                            self.stopButton,
                            self.flexibleSpace,
                            self.launchInSafariButton,
                            self.fixedSpace]];
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

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.toolbarHidden = true;
}

@end
