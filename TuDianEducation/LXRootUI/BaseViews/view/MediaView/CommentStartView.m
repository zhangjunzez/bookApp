
#import "CommentStartView.h"
#define kTag(a) 10000 + a
#define kNum 5
@interface CommentStartView()
@property (nonatomic, strong) NSMutableArray *starUiArray;
@property (nonatomic, assign) NSInteger star;
@end

@implementation CommentStartView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.star = kNum;
        self.commentStar = kNum;
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(valueChanged:)];
        [self addGestureRecognizer:tap];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panValueChaged:)];
        [self addGestureRecognizer:pan];
    }
    return self;
}
-(NSMutableArray *)starUiArray{
    if (!_starUiArray) {
        _starUiArray = [NSMutableArray array];
    }
    return _starUiArray;
}

-(void)setStar:(NSInteger)star
{
    _star = star;
    for (UIView *v in self.starUiArray) {
        [v removeFromSuperview];
    }
    [self.starUiArray removeAllObjects];
    
    CGFloat w = self.width/8.f;
    CGFloat slide = w *(3.f/4.f);
    CGFloat h = self.height;
    NSInteger num = _star;
    for (int i = 0; i <num; i ++)
    {
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(i *(w + slide), 0, w, h)];
        img.image = [UIImage imageNamed:@"星星拷贝"];
        [self addSubview:img];
        img.tag = kTag(i);
        [self.starUiArray addObject:img];
    }
}


-(void)setCommentStar:(NSInteger)commentStar{
    _commentStar = commentStar;
    NSInteger unsect = kNum - _commentStar;
    
    UIImage *selectImg = [UIImage imageNamed:@"星星"];
    UIImage *unSelectImg = [UIImage imageNamed:@"星星拷贝"];
    for (NSInteger i = commentStar; i < kNum; i ++) {
        UIImageView *img = [self viewWithTag:kTag(i)];
        img.image = unSelectImg;
    }
    for (NSInteger i = 0; i < commentStar; i ++) {
           UIImageView *img = [self viewWithTag:kTag(i)];
           img.image = selectImg;
    }
}

-(void)valueChanged:(UITapGestureRecognizer *)tap
{
    [self valueChangedWith:tap];
}
-(void)panValueChaged:(UIPanGestureRecognizer *)pan
{
    [self valueChangedWith:pan];
}

-(void)valueChangedWith:(UIGestureRecognizer *)ges
{
    CGPoint p = [ges locationInView:self];
    CGFloat x = p.x;
    CGFloat w = self.width/kNum;
    CGFloat num =  x/w;
    NSInteger index = x/w;
    if (num -index >0.5) {
        index = index +1;
    }
    self.commentStar = index;
}
@end
