//
//  SCRatingView.m
//  SCRatingView
//
//  Created by Sujith Chandran on 14/05/16.
//  Copyright © 2016 Sujith. All rights reserved.
//

#import "SCRatingView.h"

@interface SCRatingView()

@property (strong, nonatomic) NSMutableArray *emptyImageViews;
@property (strong, nonatomic) NSMutableArray *fullImageViews;

@end

@implementation SCRatingView

- (void)baseInit
{
  
    _contentMode = UIViewContentModeCenter;
    _minimumRating = 0;
    _maximumRating = 5;
    _minimumImageSize = CGSizeMake(5, 5);
    _rating = 0;
    _isEditable = NO;
    _mode = SCRatingViewModeWhole;
    _delegate = nil;
    
    _emptySelectedImages = [[NSMutableArray alloc]init];
    _fullSelectedImages = [[NSMutableArray alloc] init];
    _emptyImageViews = [[NSMutableArray alloc] init];
    _fullImageViews = [[NSMutableArray alloc] init];
    
    [self initImageViews];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        [self baseInit];
    }
    return self;
}

- (void)refresh
{

    
    for (int i = 0; i < self.fullImageViews.count; ++i) {
        UIImageView *imageView = [self.fullImageViews objectAtIndex:i];
        
        // Change rating display by updating Full selected image layer mask
        if (self.rating >= i+1) {
            imageView.layer.mask = nil;
            imageView.hidden = NO;
        }
        else if (self.rating>i && self.rating<i+1){
            // Set mask layer to hide full images
            CALayer *maskLayer = [CALayer layer];
            maskLayer.frame = CGRectMake(0, 0, (self.rating-i)*imageView.frame.size.width, imageView.frame.size.height);
            maskLayer.backgroundColor = [UIColor blackColor].CGColor;
            imageView.layer.mask = maskLayer;
            imageView.hidden = NO;
        }
        else {
            imageView.layer.mask = nil;
            imageView.hidden = YES;
        }
    }
}

- (CGSize)sizeForImage:(UIImage*)image inSize:(CGSize)size
{
    CGFloat imageRatio = image.size.width / image.size.height;
    CGFloat viewRatio = size.width / size.height;
    CGSize returnSize;
    
    // Find correct size for image to fit
    if(imageRatio < viewRatio) {
        CGFloat scale = size.height / image.size.height;
        CGFloat width = scale * image.size.width;
        
        returnSize = CGSizeMake(width, size.height);
    }
    else {
        CGFloat scale = size.width / image.size.width;
        CGFloat height = scale * image.size.height;
        
        returnSize = CGSizeMake(size.width, height);
    }
    
    return returnSize;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if(self.emptySelectedImages.count == 0)
        return;
    

    
    UIImage *emptySelectedImage = [self.emptySelectedImages objectAtIndex:0];
    
    CGFloat desiredImageWidth = self.frame.size.width / self.emptyImageViews.count;
    CGFloat maxImageWidth = MAX(self.minimumImageSize.width, desiredImageWidth);
    CGFloat maxImageHeight = MAX(self.minimumImageSize.height, self.frame.size.height);
    CGSize imageViewSize = [self sizeForImage:emptySelectedImage inSize:CGSizeMake(maxImageWidth, maxImageHeight)];
    CGFloat imageXOffset = (self.frame.size.width-(imageViewSize.width*self.emptyImageViews.count))/(self.emptyImageViews.count-1);
    
    for (int i = 0; i < self.emptyImageViews.count; ++i) {
        CGRect imageFrame = CGRectMake(i==0? 0:i*(imageXOffset+imageViewSize.width), 0, imageViewSize.width, imageViewSize.height);
        
        UIImageView *imageView = [self.emptyImageViews objectAtIndex:i];
        imageView.frame = imageFrame;
        
        imageView = [self.fullImageViews objectAtIndex:i];
        imageView.frame = imageFrame;
    }
    [self refresh];
}

- (void)removeImageViews
{
    // Remove old image views
    for (int i = 0; i < self.emptyImageViews.count; ++i) {
        UIImageView *imageView = (UIImageView *)[self.emptyImageViews objectAtIndex:i];
        [imageView removeFromSuperview];
        imageView = (UIImageView *)[self.fullImageViews objectAtIndex:i];
        [imageView removeFromSuperview];
    }
    [self.emptyImageViews removeAllObjects];
    [self.fullImageViews removeAllObjects];
}

- (void)initImageViews
{
    if(self.emptySelectedImages.count == 0 || self.fullSelectedImages.count == 0)
        return;
    
    if (self.emptyImageViews.count!=0)
        return;
    
    // Add new image views
    for (int i = 0; i < self.maximumRating; ++i) {
        UIImageView *emptyImageView = [[UIImageView alloc] init];
        emptyImageView.contentMode = self.contentMode;
        
        if(self.emptySelectedImages.count > i)
        {
            emptyImageView.image = [self.emptySelectedImages objectAtIndex:i];
        }
        else
        {
          emptyImageView.image = [self.emptySelectedImages objectAtIndex:0];
        }
        [self.emptyImageViews addObject:emptyImageView];
        [self addSubview:emptyImageView];
        
        UIImageView *fullImageView = [[UIImageView alloc] init];
        fullImageView.contentMode = self.contentMode;
        if(self.fullSelectedImages.count > i)
        {
            
            fullImageView.image = [self.fullSelectedImages objectAtIndex:i];
        }
        else
        {
            fullImageView.image = [self.fullSelectedImages objectAtIndex:0];
        }
        [self.fullImageViews addObject:fullImageView];
        [self addSubview:fullImageView];
    }
}



- (void)setMaximumRating:(NSInteger)maximumRating
{
    _maximumRating = maximumRating;
    
    [self removeImageViews];
    
    [self initImageViews];
    
    // Relayout and refresh
    [self setNeedsLayout];
    [self refresh];
}


-(void)setEmptySelectedImages:(NSMutableArray *)emptySelectedImages
{
    
    _emptySelectedImages = emptySelectedImages;
    
    int i = 0;
    for (UIImageView *imageView in self.emptyImageViews) {
        if(self.emptySelectedImages.count > i)
        {
        imageView.image =  [emptySelectedImages objectAtIndex:i] ;
        }
        else
        {
            imageView.image = [emptySelectedImages objectAtIndex:0];
        }
        i++;
    }
    [self refresh];
    
    
}

//- (void)setEmptySelectedImage:(UIImage *)emptySelectedImage
//{
//    _emptySelectedImage = emptySelectedImage;
//    
//    // Update empty image views
//    for (UIImageView *imageView in self.emptyImageViews) {
//        imageView.image = emptySelectedImage;
//    }
//    [self refresh];
//}

-(void)setFullSelectedImages:(NSMutableArray *)fullSelectedImages{
    _fullSelectedImages = fullSelectedImages;
    
    int i = 0;
    for (UIImageView *imageView in self.fullImageViews) {
      
        
        if(self.fullSelectedImages.count > i)
        {
            imageView.image =  [fullSelectedImages objectAtIndex:i] ;
        }
        else
        {
           imageView.image =  [fullSelectedImages objectAtIndex:0] ;
        }

        i++;
    }
    [self refresh];
    
    
}

//- (void)setFullSelectedImage:(UIImage *)fullSelectedImage
//{
//    _fullSelectedImage = fullSelectedImage;
//    
//    // Update full image views
//    for (UIImageView *imageView in self.fullImageViews) {
//        imageView.image = fullSelectedImage;
//    }
//    [self refresh];
//}

-(void)roundOffRating{
    
    if(_rating)
    {
        if(_mode == SCRatingViewModeWhole)
        {
           _rating = round(_rating);
        }
        else if (_mode == SCRatingViewModeHalf)
        {
            _rating = _rating < 0.5f ? 0.5f : floorf(_rating * 2) / 2;
        }
    }
    
}

- (void)setRating:(CGFloat)rating
{
    _rating = rating;
    [self roundOffRating];
    [self refresh];
}

- (void)setMode:(SCRatingViewMode)mode {
    _mode = mode;
     [self roundOffRating];
    [self refresh];
}

- (void)handleTouchAtLocation:(CGPoint)touchLocation
{
    if (!self.isEditable)
        return;
    
    CGFloat newRating = 0;
    for (NSInteger i = self.emptyImageViews.count - 1; i >= 0; i--) {
        UIImageView *imageView = [self.emptyImageViews objectAtIndex:i];
        if (touchLocation.x > imageView.frame.origin.x) {
            // Find touch point in image view
            CGPoint newLocation = [imageView convertPoint:touchLocation fromView:self];
            
            if ([imageView pointInside:newLocation withEvent:nil] && (_mode == SCRatingViewModeHalf || _mode == SCRatingViewModeFloat)) {
                CGFloat decimalNum = newLocation.x/imageView.frame.size.width;
                newRating = i + decimalNum;
                if (_mode == SCRatingViewModeHalf ) {
                    newRating = i + (decimalNum>0.75? 1:(decimalNum>0.25? 0.5:0));
                }
            }
            else {
                newRating = i+1;
            }
            break;
        }
    }
    
    self.rating = newRating<self.minimumRating? self.minimumRating:newRating;
    
    // Update delegate
    if ([self.delegate respondsToSelector:@selector(SCRatingView:continuousRating:)])
        [self.delegate SCRatingView:self continuousRating:self.rating];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    [self handleTouchAtLocation:touchLocation];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    [self handleTouchAtLocation:touchLocation];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.delegate respondsToSelector:@selector(SCRatingView:ratingDidChange:)])
        [self.delegate SCRatingView:self ratingDidChange:self.rating];
}

@end
