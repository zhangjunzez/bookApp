

#import "MineEdtingViewController.h"

@interface MineEdtingViewController ()

@end

@implementation MineEdtingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.view.backgroundColor = kWhiteColor;
    [self addLeftNavItemWithTitle:@"取消" color:kMainTxtColor font:systemFont(ScaleW(15))];
    [self addRightNavItemWithTitle:@"完成" color:kBlueColor font:systemFont(ScaleW(15))];
    [self inputTextFied];
}
-(void)rigthBtnAction:(id)sender
{
    !self.sucessEdtingBlock?:self.sucessEdtingBlock(_inputTextFied.text?:@"");
    [self dismiss];
}
-(void)leftBtnAction:(id)sender
{
    [self dismiss];
}
-(UITextField *)inputTextFied
{
    if (!_inputTextFied) {
        _inputTextFied = [[UITextField alloc]init];
        [self.view addSubview:_inputTextFied];
        _inputTextFied.backgroundColor = kMainLineColor;
        [_inputTextFied mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@50);
            make.width.equalTo(@(ScreenWidth));
            make.left.right.top.equalTo(@0);
        }];
        UIView *leftView = [[UIView alloc]init];
        _inputTextFied.leftViewMode = UITextFieldViewModeAlways;
        _inputTextFied.leftView = leftView;
        leftView.frame = CGRectMake(0, 0, ScaleW(10), ScaleW(50));
        [_inputTextFied textField:_inputTextFied textFont:ScaleW(14) placeHolderFont:ScaleW(14) text:nil placeText:[NSString stringWithFormat:@"请输入%@",self.title] textColor:kMainTxtColor placeHolderTextColor:kGrayTxtColor];
    }
    return _inputTextFied;;
}
-(void)dismiss
{
    [self.navigationController popViewControllerAnimated:YES];
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
