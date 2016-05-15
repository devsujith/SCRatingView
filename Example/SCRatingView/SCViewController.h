//
//  SCViewController.h
//  SCRatingView
//
//  Created by devsujith on 05/15/2016.
//  Copyright (c) 2016 devsujith. All rights reserved.
//

@import UIKit;
#import "SCRatingView.h"

@interface SCViewController : UIViewController

@property (weak, nonatomic) IBOutlet SCRatingView *wholeRatingView;
@property (weak, nonatomic) IBOutlet UILabel *wholeRatingLabel;

@property (weak, nonatomic) IBOutlet SCRatingView *halfRatingView;
@property (weak, nonatomic) IBOutlet UILabel *halfRatingLabel;

@property (weak, nonatomic) IBOutlet SCRatingView *floatRatingView;
@property (weak, nonatomic) IBOutlet UILabel *floatRatingLabel;

@end
