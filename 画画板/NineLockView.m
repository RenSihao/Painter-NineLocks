//
//  NineLockView.m
//  画画板
//
//  Created by RenSihao on 15/10/10.
//  Copyright © 2015年 RenSihao. All rights reserved.
//

#import "NineLockView.h"
#define COUNT 9 //一共9个按钮
#define ROW_COUNT 3 //3行
#define COL_COUNT 3 //3列
#define BTN_BORDER 50 //按钮宽高都是50

@interface NineLockView ()

@property (nonatomic, strong) NSMutableArray *selectedPointsArray;
@property (nonatomic, assign) CGPoint unSelectPoint;
@end

@implementation NineLockView

#pragma mark - 接口部分

+ (instancetype)nineLockViewInitWithFrame:(CGRect)frame
{
    NineLockView *nineLockView = [[NineLockView alloc] initWithFrame:frame];
    
//    UIPanGestureRecognizer *panGest = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestDid)];
//    panGest.minimumNumberOfTouches = 1;
//    panGest.maximumNumberOfTouches = 1;
//    [nineLockView addGestureRecognizer:panGest];
    
    nineLockView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Home_refresh_bg.png"]];
    return nineLockView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        for(NSUInteger i=0; i<COUNT; i++)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            NSUInteger row = i/COL_COUNT;
            NSUInteger col = i%COL_COUNT;
            CGFloat marginW = (self.frame.size.width - BTN_BORDER*COL_COUNT) / (COL_COUNT+1);
            CGFloat marginH = (self.frame.size.height - BTN_BORDER*ROW_COUNT) / (ROW_COUNT+1);
            CGFloat btnX = marginW + col*(marginW+BTN_BORDER);
            CGFloat btnY = marginH + row*(marginH+BTN_BORDER);
            btn.frame = CGRectMake(btnX, btnY, BTN_BORDER, BTN_BORDER);
            btn.userInteractionEnabled = NO;
            btn.tag = i;
            
            [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_normal@2x.png"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted@2x.png"] forState:UIControlStateSelected];
            
            [self addSubview:btn];
        }
    }
    return self;
}

#pragma mark - lazyload

- (NSMutableArray *)selectedPointsArray
{
    if(!_selectedPointsArray)
    {
        _selectedPointsArray = [NSMutableArray array];
    }
    return _selectedPointsArray;
}

#pragma mark - 触摸事件

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:touch.view];
    
    for(UIButton *btn in self.subviews)
    {
        if(CGRectContainsPoint(btn.frame, currentPoint))
        {
            if(btn.selected == NO)
               [self.selectedPointsArray addObject:btn];
            NSLog(@"%ld", self.selectedPointsArray.count);
            btn.selected = YES;
        }
        else
        {
            self.unSelectPoint = currentPoint;
        }
        
    }
    [self setNeedsDisplay];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSMutableString *password = [NSMutableString string];
    for(UIButton *btn in self.selectedPointsArray)
    {
        btn.selected = NO;
       [password appendFormat:@"%ld", btn.tag];
    }
    [self.selectedPointsArray removeAllObjects];
    [self setNeedsDisplay];
    
    if([password isEqualToString:@"1234"])
    {
        NSLog(@"nice");
    }
    else
    {
        NSLog(@"code error");
    }
}

#pragma mark - 重绘

- (void)drawRect:(CGRect)rect {
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    [[UIColor greenColor] set];
    bezierPath.lineCapStyle = kCGLineCapRound;
    bezierPath.lineJoinStyle = kCGLineJoinRound;
    bezierPath.lineWidth = 10.0f;
    
    NSUInteger count = self.selectedPointsArray.count;
    if(count == 0)
    {
        return;
    }
    for(NSUInteger i=0; i<count; i++)
    {
        CGPoint point = [self.selectedPointsArray[i] center];
        if(i == 0)
        {
            [bezierPath moveToPoint:point];
        }
        else
        {
            [bezierPath addLineToPoint:point];
        }
    }
    [bezierPath addLineToPoint:self.unSelectPoint];
    [bezierPath stroke];
}


@end








