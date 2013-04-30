/*

 UIImage+Helper.m - helper methods (category) for UIImage class
 
 Authors
 	Jurgis Kirsakmens

 */

#import "UIImage+Helper.h"


@implementation UIImage (Helper)

// Returns 1x1 pixel image with designated color
+ (UIImage *) imageWithColor :(UIColor *)pColor {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // Create 1x1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    // Fill it with color
    [pColor setFill];
    UIRectFill(rect);
    // Get image from context
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
