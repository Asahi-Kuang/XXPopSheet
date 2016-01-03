//
//  ArrayDataSource.h
//  XXPopSheet
//
//  Created by Kxx.xxQ 一生相伴 on 16/1/3.
//  Copyright © 2016年 asahi_kuang. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Defines.h"

typedef void (^cellConfigureBlock)(id, id, id);
@interface ArrayDataSource : NSObject<UITableViewDataSource>

@property (nonatomic, copy)NSString *reuseIdentifier;

@property (nonatomic, copy)NSArray *titleArray;

@property (nonatomic, copy)NSArray *imagesArray;

@property (nonatomic, copy)cellConfigureBlock block;

@property (nonatomic, assign)BOOL isSystemCell;


- (instancetype)initWithItems:(NSArray *)items
                   withImages:(NSArray *)images
          withReuseIdentifier:(NSString *)identifier
                withCellBlock:(cellConfigureBlock)block
             withIsSystemCell:(BOOL)isSystem;



@end
