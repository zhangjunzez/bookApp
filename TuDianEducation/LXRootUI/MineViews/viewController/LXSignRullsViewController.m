//
//  LXSignRullsViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/28.

#import "LXSignRullsViewController.h"
#import <WebKit/WebKit.h>

@interface LXSignRullsViewController ()<UITextViewDelegate,WKUIDelegate,WKNavigationDelegate>
@property (nonatomic, strong) UIView *bacView;
@property (nonatomic, strong) UILabel *lessNameLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) WKWebView *commentTextView;
@property (nonatomic, strong) UIButton *commitBtn;



@end

@implementation LXSignRullsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.view.backgroundColor = kBacColor;
   
    [self.view addSubview:self.bacView];
    [self.bacView addSubview:self.titleLabel];
    [self.bacView addSubview:self.commentTextView];
    [self.bacView addSubview:self.commitBtn];
    
    [self.commentTextView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseRequstUrl,@"/display/agreement?id=8"]]]];
    
}
-(UIView *)bacView{
    if (!_bacView) {
        _bacView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(27), 0, ScaleW(320), ScaleW(253))];
        _bacView.centerY = ScreenHeight*2/5.f;
        [_bacView setCornerRadius:ScaleW(5)];
        _bacView.backgroundColor = kWhiteColor;
    }
    return _bacView;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //self.navigationController.navigationBarHidden = YES;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:@"签到规则" font:systemFont(ScaleW(16)) textColor:kMainTxtColor frame:CGRectMake(0, ScaleW(30), _bacView.width, ScaleW(16)) textAlignment:(NSTextAlignmentCenter)];
        
    }
    return _titleLabel;
}

-(WKWebView*)commentTextView{
    if (!_commentTextView) {
        _commentTextView = [[WKWebView alloc]initWithFrame:CGRectMake(ScaleW(40), ScaleW(29) + _titleLabel.bottom, _bacView.width - ScaleW(80), ScaleW(100))];
            _commentTextView.UIDelegate = self;
            _commentTextView.navigationDelegate = self;
            [_commentTextView setOpaque:FALSE];
            _commentTextView.backgroundColor=kWhiteColor;
            
            if (@available(iOS 11.0, *))
            {
                
                _commentTextView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
                
                _commentTextView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                
                _commentTextView.scrollView.scrollIndicatorInsets = _commentTextView.scrollView.contentInset;
                
            }
            else
            {
                self.automaticallyAdjustsScrollViewInsets=NO;
            }
            
    }
    return _commentTextView;
}

//RoundedRectangle

-(UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [WLTools allocButtonTitle:@"我知道了" font:systemBoldFont(14) textColor:kWhiteColor image:nil frame:CGRectMake(ScaleW(100), _bacView.height - ScaleW(33) - ScaleW(20), ScaleW(120), ScaleW(33)) sel:@selector(commitAction:) taget:self];
              _commitBtn.backgroundColor = kBlueColor;
              [_commitBtn setCornerRadius:_commitBtn.height/2.f];
    }
    return _commitBtn;
}

-(void)commitAction:(UIButton *)sender
{
   [self dismissAction];
}

-(void)dismissAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
