/*

 NSDate+Helper.h - helper methods (category) for NSDate class
 
 Authors
 	Jurgis Kirsakmens

 */

#import <Foundation/Foundation.h>


#ifndef DATEFORMAT
    #define DATEFORMAT @"yyyy-MM-dd HH:mm:ss"
#endif
#ifndef DATENOTIMEFORMAT 
    #define DATENOTIMEFORMAT @"yyyy-MM-dd 00:00:00"
#endif


@interface NSDate (Helper)

// Returns date from string according to DATEFORMAT
+ (NSDate *) stringToDate :(NSString *)pString;

// Returns string from date according to DATEFORMAT
+(NSString *) dateToString :(NSDate *)pDate;

// Converts string in JSON format (e.g. @"2010-03-08T05:55:47") to NSDate
+ (NSDate*) JSONStringToDate :(NSString*)pJSONdateString;


// Returns only date form datatime (sets time component according to DATENOTIMEFORMAT
+ (NSDate *) dateWithoutTime :(NSDate *)pDate;

// Returns number of days from another date (absolut value)
- (int) daysFromDate :(NSDate *)pDate;

// Returns date with time component set to last second of the date (23:59:59)
+ (NSDate *) dateWithLastSecond :(NSDate *)dateTime;

// Returns seconds, minutes, hours, day, month, year from date
- (int) getSecond;
- (int) getMinute;
- (int) getHour;
- (int) getDay;
- (int) getMonth;
- (int) getYear;

@end
