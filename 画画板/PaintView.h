//
//  PaintView.h
//  画画板
//
//  Created by RenSihao on 15/10/10.
//  Copyright © 2015年 RenSihao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaintView : UIView

- (void)undo;
- (void)trash;
- (void)save;
- (void)circle;
- (void)oval;
- (void)rectangle;
- (void)square;
- (void)min;
- (void)mid;
- (void)max;
- (void)red;
- (void)orange;
- (void)yellow;
- (void)greeen;
- (void)blue;
- (void)indigo;
- (void)purple;
@end
