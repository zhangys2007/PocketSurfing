

#import "TomorrowModalController.h"
#import "Header.h"
#import "UIImageView+WebCache.h"
#import "TomorrowCellData.h"
#import "TomorrowCollectionViewController.h"
#import "BDKNotifyHUD.h"
#define K_PICWIDTH SCREEN_AUTO_SIZE 270
#define K_TOPVIEW_HEIGHT SCREEN_AUTO_SIZE 340
#define K_LABLE_DISTANCE_TO_RIGHT_EDGE SCREEN_AUTO_SIZE 150
#define K_LABLE_DISTANCE_TO_PIC_BOTTOM SCREEN_AUTO_SIZE 15
#define K_LABLE_HEIGHT SCREEN_AUTO_SIZE 35
@interface TomorrowModalController ()
@property(nonatomic,retain)UIButton * remindButton;
@end

@implementation TomorrowModalController
- (void)dealloc
{
    self.dataModel = nil;
    self.controller = nil;
    [super dealloc];
}
-(id)initWIthDataModel:(TomorrowCellData *)model
{
    self = [super init];
    if (self) {
        self.dataModel = model;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, SCREEN_AUTO_SIZE 320, SCREEN_AUTO_SIZE 400);
    self.view.backgroundColor = [UIColor clearColor];
    //上面的视图
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_SIZE_WIDTH,K_TOPVIEW_HEIGHT )];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    [topView release];
    
    //下面的透明视图
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, topView.bottom, SCREEN_SIZE_WIDTH, SCREEN_SIZE_HEIGHT - topView.height)];
    bottomView.backgroundColor = [UIColor blackColor];
    bottomView.alpha = 0.5;
    [self.view addSubview:bottomView];
    [bottomView release];
    
    //下方透明BUtton
    UIButton * translucentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    translucentButton.frame = bottomView.bounds;
    [translucentButton addTarget:self action:@selector(backToLastView:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:translucentButton];

    //大图
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake((topView.width-K_PICWIDTH)/2, topView.top, K_PICWIDTH, K_PICWIDTH)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.dataModel.pic_url]] placeholderImage:[UIImage imageNamed:@"upload11.png"]];
    [self.view addSubview:imageView];
    [imageView release];
    
    //标题
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.left, imageView.bottom+5, imageView.width, (topView.height-imageView.height)/2)];
    titleLabel.text = self.title;
    titleLabel.text = _dataModel.title;
    titleLabel.numberOfLines = 0;
    titleLabel.font = FONT(SCREEN_AUTO_SIZE 14);
    [self.view addSubview:titleLabel];
    [titleLabel release];
    
    
    //尚未开秒
    UIImageView * priceView = [[UIImageView alloc]initWithFrame:CGRectMake(topView.right-K_LABLE_DISTANCE_TO_RIGHT_EDGE, imageView.bottom-K_LABLE_DISTANCE_TO_PIC_BOTTOM-K_LABLE_HEIGHT, K_LABLE_DISTANCE_TO_RIGHT_EDGE, K_LABLE_HEIGHT)];
    priceView.image = [UIImage imageNamed:@"tommorrowlink_bg.png"];
    [self.view addSubview:priceView];
    [priceView release];
    
    //价格标签
    UILabel * priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(priceView.left+SCREEN_AUTO_SIZE 15, SCREEN_AUTO_SIZE 1, SCREEN_AUTO_SIZE 45, (priceView.height-SCREEN_AUTO_SIZE 15)/2)];
    priceLabel.centerY = priceView.centerY;
    priceLabel.text =[NSString stringWithFormat:@"¥%@",_dataModel.now_price];
    priceLabel.textAlignment = NSTextAlignmentCenter;
    priceLabel.font = [UIFont boldSystemFontOfSize:SCREEN_AUTO_SIZE 15];
    //自适应文字大小
    priceLabel.adjustsFontSizeToFitWidth = YES;
    priceLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    priceLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:priceLabel];
    [priceLabel release];
    
    //剩余时间
//    UIImageView * leftTimeView = [[UIImageView alloc]initWithFrame:cg
    
    //提醒button
    self.remindButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _remindButton.frame = CGRectMake(priceLabel.right, titleLabel.top + titleLabel.height/3*2, SCREEN_AUTO_SIZE 35, SCREEN_AUTO_SIZE 35);
    
    [_remindButton setBackgroundImage:[UIImage imageNamed:@"remind_btn.png"] forState:UIControlStateNormal];
    [_remindButton setBackgroundImage:[UIImage imageNamed:@"remind_btn_click.png"] forState:UIControlStateSelected];
    if (_dataModel.isRemind) {
        [_remindButton setSelected:YES];
    }else{
        [_remindButton setSelected:NO];
    }
    [_remindButton addTarget:self action:@selector(likeClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_remindButton];
    
    
    
    
    //返回键
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake((topView.width-SCREEN_AUTO_SIZE 65)/2, topView.bottom, SCREEN_AUTO_SIZE 65, SCREEN_AUTO_SIZE 20  );
    [backButton setImage:[UIImage imageNamed:@"semicircle_btn.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"semicircle_click_btn.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:backButton];
    [backButton addTarget:self action:@selector(backToLastView:) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view.
}
-(void)likeClick:(UIButton *)button
{
    if (!button.selected) {
        [UIView beginAnimations:nil context:NULL];
        button.selected = !button.selected;
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:button cache:YES];
        [UIView commitAnimations ];
        [_controller remindBtnClick:_dataModel];
    }else{
        BDKNotifyHUD *hud = [BDKNotifyHUD notifyHUDWithView:nil
                                                       text:@"\n\n已设置提醒\n\n"];
        hud.center = CGPointMake(self.view.center.x, SCREEN_AUTO_SIZE 200);
        [self.view addSubview:hud];
        [hud presentWithDuration:1.0f speed:0.5f inView:self.view completion:^{
            [hud removeFromSuperview];
        }];
    }
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)backToLastView:(UIButton *)btn
{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame = CGRectMake(0, -1 * SCREEN_SIZE_HEIGHT, SCREEN_SIZE_WIDTH,SCREEN_SIZE_HEIGHT);
        [self.view removeFromSuperview];
    }];

    [self dealloc];
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
