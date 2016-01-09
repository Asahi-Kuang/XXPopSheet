//
//  ViewController.m
//  TEXTFIELD
//
//  Created by Kxx.xxQ 一生相伴 on 16/1/3.
//  Copyright © 2016年 asahi_kuang. All rights reserved.
//

#import "ViewController.h"
#import "XXPopSheetView.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface ViewController ()<XXPopSheetDelegate>
@property (nonatomic, strong)XXPopSheetView *pop;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setUpButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建按钮
- (void)setUpButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, 30, 30)];
    [btn setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:btn]];
}

#pragma mark - responder
- (void)buttonPressed:(UIButton *)button {
    _pop = [[XXPopSheetView alloc] initWithFrame:button.frame];
    [_pop setDelegate:self];
    NSArray *titles = @[@"title 1", @"title 2", @"title 3"];
    NSArray *images = @[@"image1", @"image2", @"image3"];
    [_pop setTitles:titles];
    [_pop setImages:images];
    [_pop setPopViewWidth:180 andHeight:132];
}

- (void)view:(XXPopSheetView *)popView didSelectAtIndexPath:(NSInteger)index {
    [_pop dismiss];
    FirstViewController *fVC = [[FirstViewController alloc] init];
    SecondViewController *sVC = [[SecondViewController alloc] init];
    ThirdViewController *tVC = [[ThirdViewController alloc] init];
    UIViewController *vc;
    switch (index) {
        case 0:
            vc = fVC;
            break;
            case 1:
            vc = sVC;
            break;
            case 2:
            vc = tVC;
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
}
@end
