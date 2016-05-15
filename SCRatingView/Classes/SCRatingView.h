//
//  SCRatingView.h
//  SCRatingView
//
//  Created by Sujith Chandran on 14/05/16.
//  Copyright © 2016 Sujith. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

/**
 A simple rating view inspired by TPFloatRatingView  that can set whole, half or floating point ratings with multiple rating imgaes.
 
https://github.com/glenyi/TPFloatRatingView
 
*/

#import <UIKit/UIKit.h>
@class SCRatingView;


@protocol SCRatingViewDelegate <NSObject>
@optional

/**
//Returns the rating value when touch events end.
*/
- (void)SCRatingView:(SCRatingView *)ratingView ratingDidChange:(CGFloat)rating;

/**
// Returns the current rating value as the user pans.
*/
- (void)SCRatingView:(SCRatingView *)ratingView continuousRating:(CGFloat)rating;

@end


typedef NS_ENUM(NSUInteger, SCRatingViewMode) {
    SCRatingViewModeWhole, // Ratings change by 1 .(Default).
    SCRatingViewModeHalf, // Ratings change by 0.5. Overrides floatRatings property.
    SCRatingViewModeFloat, // Ratings change by floating point values.
};


@interface SCRatingView : UIView


@property (weak, nonatomic) id <SCRatingViewDelegate> delegate;

/**
//Mode to choose rating type.(Whole numbers / Float Numbers / Half )
*/
@property (nonatomic) SCRatingViewMode mode;
/**
//Sets the images from array. Provide maxRating(else images will be re used) UIImage objects.
//Keep images of same size.
*/
@property (strong,nonatomic) NSMutableArray *fullSelectedImages;

@property (strong,nonatomic) NSMutableArray *emptySelectedImages;

/**
//Sets the empty and full image view content mode. Defaults to UIViewContentModeCenter.
*/
@property (nonatomic) UIViewContentMode contentMode;

/**
//Minimum rating. Default is 0.
*/
@property (nonatomic) NSInteger minimumRating;
/**
//Max rating value. Default is 5.
*/
@property (nonatomic) NSInteger maximumRating;

/**
//Minimum image size. Default is CGSize(5,5).
*/
@property (nonatomic) CGSize minimumImageSize;

/**
// Set the current rating. Default is 0.
*/
@property (nonatomic) CGFloat rating;
/**
//Sets whether or not the rating view is editable. Default is NO.
*/
@property (nonatomic) BOOL isEditable;



@end

