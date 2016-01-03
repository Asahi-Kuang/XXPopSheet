//
//  Defines.h
//  XXPopSheet
//
//  Created by Kxx.xxQ 一生相伴 on 16/1/3.
//  Copyright © 2016年 asahi_kuang. All rights reserved.
//

#ifndef Defines_h
#define Defines_h


// 尺寸相关
#define SCREEN                [UIScreen mainScreen].bounds
#define SCREEN_WIDTH          [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT         [UIScreen mainScreen].bounds.size.height
#define RECT_MAKE(x, y, w, h) CGRectMake(x, y, w, h)
#define GET_WIDTH(des)        CGRectGetWidth(des)
#define GET_HEIGHT(des)       CGRectGetHeight(des)
#define GET_MINX(des)         CGRectGetMinX(des)
#define GET_MINY(des)         CGRectGetMinY(des)
#define GET_MIDX(des)         CGRectGetMidX(des)
#define GET_MIDY(des)         CGRectGetMidY(des)
#define GET_MAXX(des)         CGRectGetMaxX(des)
#define GET_MAXY(des)         CGRectGetMaxY(des)

// 颜色
#define RGB(r, g, b)          [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1.f]
#define RGBA(r, g, b, a)      [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a]

//
#define POINT_MAKE(x, y)      CGPointMake(x, y)
#define SIZE_MAKE(w, h)       CGSizeMake(w, h)


#endif /* Defines_h */
