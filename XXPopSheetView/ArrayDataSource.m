//
//  ArrayDataSource.m
//  XXPopSheet
//
//  Created by Kxx.xxQ 一生相伴 on 16/1/3.
//  Copyright © 2016年 asahi_kuang. All rights reserved.
//

#import "ArrayDataSource.h"

@implementation ArrayDataSource

- (instancetype)initWithItems:(NSArray *)items
                   withImages:(NSArray *)images
          withReuseIdentifier:(NSString *)identifier
                withCellBlock:(cellConfigureBlock)block
             withIsSystemCell:(BOOL)isSystem {
    
    self = [super init];
    if (self) {
        self.titleArray = items;
        self.imagesArray = images;
        self.reuseIdentifier = identifier;
        self.block = block;
        self.isSystemCell = isSystem;
    }
    return self;
}

- (id)titleAtIndexPath:(NSIndexPath *)indexPath {
    return [self.titleArray objectAtIndex:(NSUInteger)indexPath.row];
}

- (id)imagesAtIndexPath:(NSIndexPath *)indexPath {
    return [self.imagesArray objectAtIndex:(NSUInteger)indexPath.row];
}

#pragma mark - data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.titleArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id item = [self titleAtIndexPath:indexPath];
    id image = [self imagesAtIndexPath:indexPath];
    
    if (_isSystemCell) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.reuseIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.reuseIdentifier];
        }
        else {
            while ([cell.contentView.subviews lastObject]) {
                [[cell.contentView.subviews lastObject] removeFromSuperview];
            }
        }
        self.block(cell, item, image);
        return cell;
    }
    else {
        id cell = [tableView dequeueReusableCellWithIdentifier:self.reuseIdentifier forIndexPath:indexPath];
        self.block(cell, item, image);
        return cell;
    }
}

@end
