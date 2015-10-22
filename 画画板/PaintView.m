//
//  PaintView.m
//  画画板
//
//  Created by RenSihao on 15/10/10.
//  Copyright © 2015年 RenSihao. All rights reserved.
//

#import "PaintView.h"

@interface PaintView ()

@property (nonatomic, strong) NSMutableArray *bezierPathArray;
@end

@implementation PaintView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    NSUInteger count = self.bezierPathArray.count;
    for(NSUInteger i=0; i<count; i++)
    {
        UIBezierPath *path = [self.bezierPathArray objectAtIndex:i];
        
        NSLog(@"draw %lf", path.lineWidth);
        [path stroke];
    }
    
}

#pragma mark - 触摸事件

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint orignPoint = [touch locationInView:touch.view];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:orignPoint];
    
    [self.bezierPathArray addObject:path];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:touch.view];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    path = [self.bezierPathArray lastObject];
    //NSLog(@"newpath:%@", path);
    NSLog(@"moved %lf", path.lineWidth);
    [path addLineToPoint:currentPoint];
    
    
    [self setNeedsDisplay];
}

#pragma mark - lazyload
- (NSMutableArray *)bezierPathArray
{
    if(!_bezierPathArray)
    {
        _bezierPathArray = [NSMutableArray array];
    }
    return _bezierPathArray;
}

#pragma mark - 外部开放的对象方法

- (void)undo
{
    [self.bezierPathArray removeLastObject];
    [self setNeedsDisplay];
}
- (void)trash
{
    [self.bezierPathArray removeAllObjects];
    [self setNeedsDisplay];
}
- (void)save
{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    UIGraphicsBeginImageContext(self.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //写入保存路径
    NSData *imageData = UIImagePNGRepresentation(newImage);
    [imageData writeToFile:docPath atomically:YES];
    [imageData writeToFile:@"Users/rensihao/Desktop/画画板截屏.png" atomically:YES];
}
- (void)circle
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 20;
    //[[UIColor redColor] set];
    [self.bezierPathArray addObject:path];
    [self setNeedsDisplay];
}
- (void)oval
{
    
}
- (void)rectangle
{
    
}
- (void)square
{
    
}
- (void)min
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 10);
    CGContextStrokePath(context);
}
- (void)mid
{
    
}
- (void)max
{
    
}
- (void)red
{
    
    
    [self setNeedsDisplay];
}
- (void)orange
{
    [[UIColor orangeColor] set];
    [self setNeedsDisplay];
}
- (void)yellow
{
    
}
- (void)greeen
{
    
}
- (void)blue
{
    
}
- (void)indigo
{
    
}
- (void)purple
{
    
}

@end

















