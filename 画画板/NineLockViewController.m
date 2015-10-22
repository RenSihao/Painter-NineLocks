//
//  NineLockViewController.m
//  画画板
//
//  Created by RenSihao on 15/10/10.
//  Copyright © 2015年 RenSihao. All rights reserved.
//

#import "NineLockViewController.h"
#import "NineLockView.h"
#import "Commond.h"


@interface NineLockViewController ()

@property (nonatomic, strong) NineLockView *nineLockView;
@end

@implementation NineLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"九宫格解锁";
    
    //加载所有子控件
    [self loadViewInit];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 初始化子控件
- (void)loadViewInit
{
    [self.view addSubview:self.nineLockView];
}

#pragma mark - lazyload
- (NineLockView *)nineLockView
{
    if(!_nineLockView)
    {
        _nineLockView = [NineLockView nineLockViewInitWithFrame:CGRectMake(0, HeaderBar_Height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-HeaderBar_Height-FooterTab_Height)];
        UIPanGestureRecognizer *panGest = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        panGest.minimumNumberOfTouches = 1;
        panGest.maximumNumberOfTouches = 1;
        //[_nineLockView addGestureRecognizer:panGest];
    }
    return _nineLockView;
}

#pragma mark - 手势监听
- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    NSLog(@"fdsfa");
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
