//
//  MCCallVendorTaskCell.h
//  moveCHECK
//
//  Created by Roshan Sequeira on 27/05/16.
//  Copyright © 2016 Saltmines-Mac2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCCallVendorTaskModel.h"

@class MCCallVendorTaskCell;

@protocol MCCallVendorTaskCellProtocol <NSObject>

- (void)expandCell:(MCCallVendorTaskCell *)cell;

@end

@interface MCCallVendorTaskCell : UITableViewCell

@property (nonatomic, strong) MCCallVendorTaskModel *model;

@property (nonatomic, assign) id <MCCallVendorTaskCellProtocol> delegate;

@end
