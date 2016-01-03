//
//  XXPopSheetView.m
//  TEXTFIELD
//
//  Created by Kxx.xxQ 一生相伴 on 16/1/3.
//  Copyright © 2016年 asahi_kuang. All rights reserved.
//

#import "XXPopSheetView.h"
#import "AppDelegate.h"
#import "ArrayDataSource.h"

typedef enum {
    XXPopSheetStyleRightUp = 0,
    XXPopSheetStyleLeftUp,
    XXPopSheetStyleRightDown,
    XXPopSheetStyleLeftDown
}XXPopStyle;

static NSInteger const navHeight = 64;
static NSInteger const rowHeight = 44;
static NSInteger const distance = 40;
static NSString *const upImage = @"up";
static NSString *const downImage = @"down";
static NSString *const identifier = @"reuseIdentifier";
@interface XXPopSheetView ()<UITableViewDelegate>

// 产生点x
@property (nonatomic, assign)CGFloat birthX;

// 产生点y
@property (nonatomic, assign)CGFloat birthY;

@property (nonatomic, assign)CGFloat popWidth;

@property (nonatomic, assign)CGFloat popHeight;

// keyWindow
@property (nonatomic, strong)UIWindow *kWindow;

// 背景视图
@property (nonatomic, strong)UIView *backgroundView;

// 弹出视图
@property (nonatomic, strong)UIView *popView;

// 样式
@property (nonatomic, assign)XXPopStyle popStyle;

@property (nonatomic, strong)UITableView *popBlank;

@property (nonatomic, strong)ArrayDataSource *dataSource;

//@property (nonatomic, assign)NSInteger indexPath;

@end

@implementation XXPopSheetView

#pragma mark - 构造
- (instancetype)initWithFrame:(CGRect)frame {
    self  = [super initWithFrame:frame];
    if (self) {
        //
        [self originalPropertiesSetting:frame];
    }
    return self;
}

- (instancetype)init {
    return nil;
}
#pragma mark --

#pragma mark - methods
- (void)originalPropertiesSetting:(CGRect)frame {
    // 初始化设置一些简单必要的
    _kWindow = [UIApplication sharedApplication].keyWindow;
    _backgroundView = [[UIView alloc] initWithFrame:SCREEN];
    [_backgroundView setBackgroundColor:RGBA(0, 0, 0, 0.2)];
    [_kWindow addSubview:_backgroundView];
    
    CGFloat x = GET_MIDX(frame);
    CGFloat y = GET_MIDY(frame);
    _birthX = x; _birthY = y;
    [self addTapGesture];
    
    
}

- (CGPoint)minPoints {
    return CGPointMake(_popView.frame.origin.x, CGRectGetMinY(_popView.frame));
}

- (CGPoint)maxPoints {
    return CGPointMake(CGRectGetMaxX(_popView.frame), CGRectGetMaxY(_popView.frame));
}

// 手势取消
- (void)addTapGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissThePop:)];
    [_backgroundView addGestureRecognizer:tap];
}

- (void)dismissThePop:(UITapGestureRecognizer *)tap {
    // 过滤掉父视图点击事件响应
    CGFloat minX = [self minPoints].x;
    CGFloat maxX = [self maxPoints].x;
    
    CGFloat minY = [self minPoints].y;
    CGFloat maxY = [self maxPoints].y;
    
    NSLog(@"%f, %f->%f, %f", minX, maxX, minY, maxY);
    
    CGFloat tapX = [tap locationInView:_backgroundView].x;
    CGFloat tapY = [tap locationInView:_backgroundView].y;
    
    NSLog(@"%f -----> %f", tapX, tapY);
    
    if ((tapX >= minX && tapX <= maxX) && (tapY >= minY && tapY <= maxY)) {
        //
        NSArray *arr = _popBlank.indexPathsForVisibleRows;
        
        // 根据点击tableView的地点获取是哪一行被点击
        NSInteger indexNum = 0;
        if (tapY > [self minPoints].y && tapY < [self minPoints].y + rowHeight) {
            
            indexNum = 0;
        }
        else if (tapY > [self minPoints].y + rowHeight && tapY < [self minPoints].y + rowHeight * 2) {
            
            indexNum = 1;
        }
        else if (tapY > [self minPoints].y + rowHeight * 2 && tapY < [self minPoints].y + rowHeight * 3) {
            
            indexNum = 2;
        }
        else {
            return;
        }
        [self tableView:_popBlank didSelectRowAtIndexPath:arr[indexNum]];
        
    }
    else {
        [self dismiss];
    }
}

- (void)setPopViewWidth:(CGFloat)width andHeight:(CGFloat)height {
    _popWidth = width;
    _popHeight = height;
    
    [self buildUpPopView];
}

- (void)buildUpPopView {
    _popView = [[UIView alloc] init]; // 只是用来确定大小  位置用_birthX _birthY来控制
    [_popView setBackgroundColor:[UIColor whiteColor]];
    [_popView setFrame:RECT_MAKE(0, 0, _popWidth, _popHeight)];
    
    [_popView setTransform:CGAffineTransformMakeScale(0.0, 0.0)];
    [_popView setCenter:POINT_MAKE(_birthX, _birthY)];
    // 设置样式
    XXPopStyle style = [self judgingPopViewStyle];
    if (style == XXPopSheetStyleLeftDown) {
        //
        [UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:1.0 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveLinear animations:^{
            //
            [_popView setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
            [_popView setCenter:POINT_MAKE(_birthX - 0.5 * _popWidth + 10, _birthY + 0.5 * _popHeight + distance)];
            // 添加三角形
            [self indicatorImageViewWithFrame:RECT_MAKE(GET_WIDTH(_popView.frame) - 25, -11, 23, 11)];
        } completion:nil];
        
    }
    else if (style == XXPopSheetStyleLeftUp) {
        [UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:0.9 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveLinear animations:^{
            //
            [_popView setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
            [_popView setCenter:POINT_MAKE(_birthX - 0.5 * _popWidth + 10, _birthY - 0.5 * _popHeight - 35 - 11)];
            // 添加三角形
            [self indicatorImageViewWithFrame:RECT_MAKE(GET_WIDTH(_popView.frame) - 25, GET_HEIGHT(_popView.frame), 23, 11)];
        } completion:nil];
        
    }
    else if (style == XXPopSheetStyleRightDown) {
        NSLog(@"%f   %f", _birthX, _birthY);
        NSLog(@"%f", POINT_MAKE(_birthX + 0.5 * _popWidth - 10, _birthY + 0.5 * _popHeight + (navHeight - _birthY) + 11).x);
        [UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:0.9 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveLinear animations:^{
            //
            [_popView setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
            [_popView setCenter:POINT_MAKE(_birthX + 0.5 * _popWidth - 10, _birthY + 0.5 * _popHeight + distance)];
            [self indicatorImageViewWithFrame:RECT_MAKE(GET_MINX(_popView.frame) - _birthX + 10, -11, 23, 11)];
        } completion:nil];
        
    }
    else {
        [UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:0.9 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveLinear animations:^{
            //
            [_popView setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
            [_popView setCenter:POINT_MAKE(_birthX + 0.5 * _popWidth - 10, _birthY - 0.5 * _popHeight - 35 - 11)];
            [self indicatorImageViewWithFrame:RECT_MAKE(GET_MINX(_popView.frame) - 65, GET_HEIGHT(_popView.frame), 23, 11)];
        } completion:nil];
        
    }
    [self setUpTableView];
    [_popView setBackgroundColor:[UIColor clearColor]];
    [_backgroundView addSubview:_popView];
    
}

- (void)setUpTableView {
    _popBlank = [[UITableView alloc] initWithFrame:RECT_MAKE(0, 0, _popView.frame.size.width, _popView.frame.size.height) style:UITableViewStylePlain];
    [_popBlank setScrollEnabled:NO];
    [_popBlank setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_popBlank.layer setCornerRadius:3.0];
    [_popBlank setDelegate:self];
    [_popBlank setTableFooterView:[UIView new]];
    
    cellConfigureBlock cBlock = ^(UITableViewCell *cell, NSString *title, NSString *imageName) {
        [cell.imageView setImage:[UIImage imageNamed:imageName]];
        [cell.textLabel setText:title];
    };
    
    _dataSource = [[ArrayDataSource alloc] initWithItems:self.titles withImages:self.images withReuseIdentifier:identifier withCellBlock:cBlock withIsSystemCell:YES];
    [_popBlank setDataSource:_dataSource];
    
    [_popView addSubview:_popBlank];
}

- (void)addAnimationForView:(UIView *)view {
    [UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:0.9 initialSpringVelocity:0.9 options:UIViewAnimationOptionCurveLinear animations:^{
        //
        [view setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
    } completion:nil];
}

// 构建小三角图像
- (void)indicatorImageViewWithFrame:(CGRect)indicatorFrame {
    UIImageView *indicator = [[UIImageView alloc] initWithFrame:indicatorFrame];
    
    if (_popStyle == XXPopSheetStyleLeftDown || _popStyle == XXPopSheetStyleRightDown) {
        [indicator setImage:[UIImage imageNamed:upImage]];
    }
    else {
        [indicator setImage:[UIImage imageNamed:downImage]];
    }
    [_popView addSubview:indicator];
}

// 判断弹出框的中心点位置
- (XXPopStyle)judgingPopViewStyle {
    
    CGFloat screenMidX = SCREEN_WIDTH / 2.0;
    CGFloat screenMidY = SCREEN_HEIGHT / 2.0;
    
    // 根据弹出框中心点来判断是哪种形式。
    if (_birthX <= screenMidX && _birthY <= screenMidY) {
        _popStyle = XXPopSheetStyleRightDown;
    }
    else if (_birthX <= screenMidX && _birthY > screenMidY) {
        _popStyle = XXPopSheetStyleRightUp;
    }
    else if (_birthX >= screenMidX && _birthY <= screenMidY) {
        _popStyle = XXPopSheetStyleLeftDown;
    }
    else {
        _popStyle = XXPopSheetStyleLeftUp;
    }
    
    return _popStyle;
}

- (void)dismiss {
    [UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:0.9 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveLinear animations:^{
        //
        [_popView setTransform:CGAffineTransformMakeScale(0.0, 0.0)];
        [_popView setCenter:POINT_MAKE(_birthX, _birthY)];
        [_backgroundView setAlpha:0.0];
    } completion:^(BOOL finished) {
        [_backgroundView removeFromSuperview];
    }];
}

- (void)dismissDirectly {
    [_backgroundView removeFromSuperview];
}
#pragma mark --


#pragma mark --

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.viewControllers.count < self.titles.count) {
        return;
    }
    [self dismissDirectly];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.nav pushViewController:self.viewControllers[indexPath.row] animated:YES];
}
#pragma mark --
@end
