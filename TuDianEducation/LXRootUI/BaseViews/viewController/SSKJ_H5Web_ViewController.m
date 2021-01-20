//
//  SSKJ_H5Web_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/6/19.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "SSKJ_H5Web_ViewController.h"
#import <WebKit/WebKit.h>

@interface SSKJ_H5Web_ViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation SSKJ_H5Web_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kMainBgColor;
//   清理缓存
    [self cleanCacheAndCookie];
    
    [self setUI];
}
//增加返回H5上级界面
- (void)leftBtnAction:(id)sender
{
    //判断是否能返回到H5上级页面
    if (self.webView.canGoBack==YES) {
        //返回上级页面
        ///返回HTML内部上级页面
        [self.webView goBack];
        
        
    }else{
        //退出控制器
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.html.length) {
        [self.webView loadHTMLString:self.html baseURL:nil];
    }else{
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    }
}

- (void)cleanCacheAndCookie{
    
    //清除cookies
    
    NSHTTPCookie *cookie;
    
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (cookie in [storage cookies]){
        
        [storage deleteCookie:cookie];
        
    }
    
    //清除UIWebView的缓存
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    NSURLCache * cache = [NSURLCache sharedURLCache];
    
    [cache removeAllCachedResponses];
    
    [cache setDiskCapacity:0];
    
    [cache setMemoryCapacity:0];
    
}


#pragma mark - UI
-(void)setUI
{
    [self.view addSubview:self.webView];
}

-(WKWebView *)webView
{
    if (nil == _webView) {
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, ScaleW(10), ScreenWidth, ScreenHeight-ScaleW(10))];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        [_webView setOpaque:FALSE];
        _webView.backgroundColor=kWhiteColor;
        
        if (@available(iOS 11.0, *))
        {
            
            _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            
            _webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            
            _webView.scrollView.scrollIndicatorInsets = _webView.scrollView.contentInset;
            
        }
        else
        {
            self.automaticallyAdjustsScrollViewInsets=NO;
        }
        
    }
    return _webView;
}



#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
//    [ webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '200%'"completionHandler:nil];
//
////    修改字体颜色  #9098b8
//    [ webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#121212'"completionHandler:nil];
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    [MBProgressHUD showError:SSKJLocalized(@"加载失败",nil)];
}


// 根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {

    
    NSString * urlStr = navigationAction.request.URL.absoluteString;
//    NSLog(@"当前跳转地址：%@",urlStr);

    if (![urlStr hasPrefix:@"https://zf.flyotcpay"] && [urlStr containsString:@"http://47.244.56.146/web/index.html"]) {
        [self.navigationController popViewControllerAnimated:YES];
        decisionHandler(WKNavigationActionPolicyCancel);
    }else{
        decisionHandler(WKNavigationActionPolicyAllow);

    }
        
}

// 根据客户端受到的服务器响应头以及response相关信息来决定是否可以跳转

//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
//    NSString * urlStr = navigationResponse.response.URL.absoluteString;
//    NSLog(@"当前跳转地址：%@",urlStr);
//
//    if ([urlStr containsString:@"http://47.244.56.146/web/index.html"]) {
//        [self.navigationController popViewControllerAnimated:YES];
//        decisionHandler(WKNavigationResponsePolicyCancel);
//    }else{
//        decisionHandler(WKNavigationResponsePolicyAllow);
//    }
//}

//- (BOOL)webView:(WKWebView *)webView shouldStartLoadWithRequest:(nonnull NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    NSURL *URL = request.URL;
//    NSString *str = [URL absoluteString];

//
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
