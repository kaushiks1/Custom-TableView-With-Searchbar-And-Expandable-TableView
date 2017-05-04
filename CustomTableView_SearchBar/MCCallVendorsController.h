//
//  MCCallVendorsController.h
//  moveCHECK
//
//  Created by Roshan Sequeira on 26/05/16.
//  Copyright © 2016 Saltmines-Mac2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJSwitch.h"

@interface MCCallVendorsController : UIViewController

@property (strong, nonatomic) NSString *moveTo;
@property  (strong, nonatomic) NSString *moveFrom;
@property (strong, nonatomic) NSArray *arrayJson;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

//@property (weak, nonatomic) IBOutlet UISwitch *switchMoveFromTo;
@property (weak, nonatomic) IBOutlet UIView *viewForSwitch;







@end
