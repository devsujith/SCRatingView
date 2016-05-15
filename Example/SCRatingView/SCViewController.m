//
//  SCViewController.m
//  SCRatingView
//
//  Created by devsujith on 05/15/2016.
//  Copyright (c) 2016 devsujith. All rights reserved.
//

#import "SCViewController.h"

@interface SCViewController ()<SCRatingViewDelegate>

@end

@implementation SCViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    NSMutableArray *smileyEmptyImages = [[NSMutableArray alloc ]initWithObjects:[UIImage imageNamed:@"empty-1"],[UIImage imageNamed:@"empty-2"],[UIImage imageNamed:@"empty-3"],[UIImage imageNamed:@"empty-4"],[UIImage imageNamed:@"empty-5"], nil  ];
    
    NSMutableArray *smileyFullImages =[[NSMutableArray alloc ]initWithObjects:[UIImage imageNamed:@"fill-1"],[UIImage imageNamed:@"fill-2"],[UIImage imageNamed:@"fill-3"],[UIImage imageNamed:@"fill-4"],[UIImage imageNamed:@"fill-5"], nil  ];
    
    
    
    NSMutableArray *heartEmptyImages = [[NSMutableArray alloc ]initWithObjects:[UIImage imageNamed:@"heartEmpty-1"],[UIImage imageNamed:@"heartEmpty-2"],[UIImage imageNamed:@"heartEmpty-3"],[UIImage imageNamed:@"heartEmpty-4"],[UIImage imageNamed:@"heartEmpty-5"], nil  ];
    
    NSMutableArray *heartFullImages =[[NSMutableArray alloc ]initWithObjects:[UIImage imageNamed:@"heartFull-1"],[UIImage imageNamed:@"heartFull-2"],[UIImage imageNamed:@"heartFull-3"],[UIImage imageNamed:@"heartFull-4"],[UIImage imageNamed:@"heartFull-5"], nil  ];
    
    
    
    // whole rating view
    self.wholeRatingView.emptySelectedImages = smileyEmptyImages;
    self.wholeRatingView.fullSelectedImages = smileyFullImages;
    self.wholeRatingView.mode = SCRatingViewModeWhole;
    self.wholeRatingView.maximumRating = 5;
    self.wholeRatingView.minimumRating = 1;
    self.wholeRatingView.rating = 4;
    self.wholeRatingView.isEditable = YES;
    self.wholeRatingView.delegate = self;
    
    
    
    // half rating view
    self.halfRatingView.emptySelectedImages = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"emptyStar"], nil];
    self.halfRatingView.fullSelectedImages = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"fullStar"], nil];;
    self.halfRatingView.mode = SCRatingViewModeHalf;
    self.halfRatingView.maximumRating = 5;
    self.halfRatingView.minimumRating = 1;
    self.halfRatingView.rating = 2.55;
    self.halfRatingView.isEditable = YES;
    self.halfRatingView.delegate = self;
    
    
    self.halfRatingLabel.text = [NSString stringWithFormat:@"%0.1f",self.halfRatingView.rating];
    
    
    // float rating view
    
    self.floatRatingView.emptySelectedImages = heartEmptyImages;
    self.floatRatingView.fullSelectedImages = heartFullImages;
    self.floatRatingView.mode = SCRatingViewModeFloat;
    self.floatRatingView.maximumRating = 5;
    self.floatRatingView.minimumRating = 0;
    self.floatRatingView.rating = 1.25;
    self.floatRatingView.isEditable = YES;
    self.floatRatingView.delegate = self;
    
    
    self.floatRatingLabel.text = [NSString stringWithFormat:@"%0.1f",self.floatRatingView.rating];
    
    
    
    
    
}

//SCRatingView Delegates
-(void)SCRatingView:(SCRatingView *)ratingView continuousRating:(CGFloat)rating{
    
    if(ratingView ==self.wholeRatingView)
    {
        
        self.wholeRatingLabel.text = [NSString stringWithFormat:@"%0.1f",rating];
        
    }
    else if(ratingView == self.halfRatingView)
    {
        self.halfRatingLabel.text = [NSString stringWithFormat:@"%0.1f",rating];
        
    }
    else
    {
        self.floatRatingLabel.text = [NSString stringWithFormat:@"%0.1f",rating];
        
    }
    
    
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
