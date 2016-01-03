//
//  XXPopSheetView.h
//  TEXTFIELD
//
//  Created by Kxx.xxQ 一生相伴 on 16/1/3.
//  Copyright © 2016年 asahi_kuang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface XXPopSheetView : UIView
// 标题
@property (nonatomic, copy)NSArray *titles;
// cell.imageView图片
@property (nonatomic, copy)NSArray *images;
// 跳转控制器
@property (nonatomic, strong)NSArray *viewControllers;


// 设置宽高
- (void)setPopViewWidth:(CGFloat)width andHeight:(CGFloat)height;
// 取消
- (void)dismiss;


@end
