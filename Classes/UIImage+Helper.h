/*

 UIImage+Helper.h - helper methods (category) for UIImage class
 
 Authors
 	Jurgis Kirsakmens

 */


#import <UIKit/UIKit.h>

@interface UIImage (Helper)

// Returns 1x1 pixel image with designated color
+ (UIImage *) imageWithColor :(UIColor *)pColor;

@end
