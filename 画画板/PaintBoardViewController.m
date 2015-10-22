//
//  PaintBoardViewController.m
//  画画板
//
//  Created by RenSihao on 15/10/10.
//  Copyright © 2015年 RenSihao. All rights reserved.
//

#import "PaintBoardViewController.h"
#import "Commond.h"
#import "PaintView.h"

#define EditBar_Heihgt 44
#define ToolsView_Height 100
#define COUNT 14 //一共14个工具按钮
#define ROW_COUNT 2 //2行
#define COL_COUNT 7 //7列
#define BTN_BORDER 30 //工具按钮是方形（宽高都是30）

typedef NS_ENUM(NSUInteger, EditType)
{
    Undo,
    Trash,
    Save
};

typedef NS_ENUM(NSUInteger, ToolsType)
{
    Circle = 0,
    Oval,
    Rectangle,
    Square,
    Min,
    Mid,
    Max,
    
    Red,
    Orange,
    Yellow,
    Green,
    Blue,
    Indigo,
    Purple
};

@interface PaintBoardViewController ()

@property (nonatomic, strong) UIToolbar *editBar;
@property (nonatomic, strong) PaintView *paintView;
@property (nonatomic, strong) UIView    *toolsView;

@property (nonatomic, strong) NSArray   *toolsArray;
@end

@implementation PaintBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"画画板";
    self.view.backgroundColor = [UIColor whiteColor];
    //NSLog(@"%lf", self.view.frame.size.height);
    self.toolsArray = [NSArray arrayWithObjects:@"圆", @"椭", @"矩", @"方", @"细", @"中", @"粗", @"红", @"橙", @"黄", @"绿", @"蓝", @"靛", @"紫", nil];
    
    //加载子控件
    [self loadViewInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 初始化画画板上的所有子控件

- (void)loadViewInit
{
    [self.view addSubview: self.paintView];
    [self.view addSubview:self.editBar];
    [self.view addSubview:self.toolsView];
}

#pragma mark - lazyload

- (UIToolbar *)editBar
{
    if(!_editBar)
    {
        _editBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), self.view.frame.size.width, EditBar_Heihgt)];
        _editBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Home_refresh_bg.png"]];
        _editBar.tintColor = [UIColor colorWithRed:0.2 green:0.6 blue:0.8 alpha:1.0];
        
        UIBarButtonItem *undoItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemUndo target:self action:@selector(editDidSelect:)];
        undoItem.tag = Undo;
        UIBarButtonItem *fixItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *clearItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(editDidSelect:)];
        clearItem.tag = Trash;
        UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(editDidSelect:)];
        saveItem.tag = Save;
        _editBar.items = @[undoItem, fixItem, clearItem, fixItem, saveItem];
        
    }
    return _editBar;
}
- (PaintView *)paintView
{
    if(!_paintView)
    {
        _paintView = [[PaintView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.editBar.frame), [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-HeaderBar_Height-EditBar_Heihgt-ToolsView_Height-FooterTab_Height)];
        _paintView.backgroundColor = [UIColor clearColor];
    }
    return _paintView;
}

- (UIView *)toolsView
{
    if(!_toolsView)
    {
        _toolsView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.paintView.frame), [UIScreen mainScreen].bounds.size.width, ToolsView_Height)];
        _toolsView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Home_refresh_bg.png"]];
        
        for(NSUInteger i=0; i<COUNT; i++)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            CGFloat mariginW = (_toolsView.frame.size.width - BTN_BORDER*COL_COUNT) / (COL_COUNT+1);
            CGFloat mariginH = 10;
            NSUInteger row = i/COL_COUNT;
            NSUInteger col = i%COL_COUNT;
            CGFloat btnX = 20 + col*(mariginW + BTN_BORDER);
            CGFloat btnY = 10 + row*(mariginH + BTN_BORDER);
            btn.frame = CGRectMake(btnX, btnY, BTN_BORDER, BTN_BORDER);
            btn.backgroundColor = [UIColor redColor];
            [btn setTitle:self.toolsArray[i] forState:UIControlStateNormal];
            btn.tag = i;
            [btn addTarget:self action:@selector(toolsDidSelect:) forControlEvents:UIControlEventTouchUpInside];
            [_toolsView addSubview:btn];
        }
    }
    return _toolsView;
}


#pragma mark - 监听响应方法
- (void)editDidSelect:(UIBarButtonItem *)sender
{
    switch(sender.tag)
    {
        case Undo:
        {
            [self.paintView undo];
        }
            break;
        case Trash:
        {
            [self.paintView trash];
        }
            break;
        case Save:
        {
            [self.paintView save];
        }
            break;
        default:
        {
            NSLog(@"edit select error");
        }
    }
}

- (void)toolsDidSelect:(UIButton *)sender
{
    NSLog(@"%ld", sender.tag);
    switch(sender.tag)
    {
        case Circle:
        {
            [self.paintView circle];
        }
            break;
        case Oval:
        {
            [self.paintView oval];
        }
            break;
        case Rectangle:
        {
            [self.paintView rectangle];
        }
            break;
        case Square:
        {
            [self.paintView square];
        }
            break;
        case Min:
        {
            [self.paintView min];
        }
            break;
        case Mid:
        {
            [self.paintView mid];
        }
            break;
        case Max:
        {
            [self.paintView max];
        }
            break;
        case Red:
        {
            [self.paintView red];
        }
            break;
        case Orange:
        {
            [self.paintView orange];
        }
            break;
        case Yellow:
        {
            [self.paintView yellow];
        }
            break;
        case Green:
        {
            [self.paintView greeen];
        }
            break;
        case Blue:
        {
            [self.paintView blue];
        }
            break;
        case Indigo:
        {
            [self.paintView indigo];
        }
            break;
        case Purple:
        {
            [self.paintView purple];
        }
            break;
        default:
        {
            NSLog(@"tools select error");
        }
        
    }
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
