/*

 NSDate+Helper.h - helper methods (category) for NSDate class
 
 Authors
 	- Jurgis Kirsakmens

 */


#import "NSDate+Helper.h"


@implementation NSDate (Helper)


// Returns date from string accoring to DATEFORMAT
+ (NSDate *) stringToDate :(NSString *)pString {
	NSDate *reply;
	if (pString == nil)
		reply = nil;
	else {
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:DATEFORMAT];
		reply = [dateFormatter dateFromString:pString];
	}
	return reply;
}


// Converts string in JSON format (e.g. @"2010-03-08T05:55:47") to NSDate
+ (NSDate*) JSONStringToDate :(NSString*)pJSONdateString {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'"];
    NSDate *date = [dateFormat dateFromString:pJSONdateString];
    return date;
}


// Returns only date form datatime (sets time component according to DATENOTIMEFORMAT) 
+ (NSDate *) dateWithoutTime :(NSDate *)pDate {
    NSDate *reply;
	if (pDate == nil)
		reply = nil;
	else {
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:DATENOTIMEFORMAT];
		reply = [NSDate stringToDate:[NSString stringWithString:[dateFormatter stringFromDate:pDate]]];
	}
	return reply;
}


// Returns date with time component set to last second of the date (23:59:59)
+ (NSDate *) dateWithLastSecond :(NSDate *)dateTime{
    // get todays date (without time component i.e. 00:00:00)
    NSDate *date = [NSDate dateWithoutTime:dateTime];
    // add 26 hours -1 second to get next day (taking into account potencial daylight saving hour +1h) and calculate date component only
    date = [NSDate dateWithoutTime:[date dateByAddingTimeInterval:26*3600-1]];
	// return last second of previous day
	return [date dateByAddingTimeInterval:-1];
}



// Returns string from date according to DATEFORMAT
- (NSString *) stringValue {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:DATEFORMAT];
    return [dateFormatter stringFromDate:self];
}


// returns number of days (as of number of midnights beween) from another date (absolut value)
- (int) daysFromDate :(NSDate *)pDate {
    NSUInteger unitFlags = NSDayCalendarUnit;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:unitFlags fromDate:self toDate:pDate options:0];
    return abs([components day]);
}



// Returns second from date
- (int) getSecond {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSSecondCalendarUnit fromDate:self];
    return [components second];
}


// Returns minute from date
- (int) getMinute {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSMinuteCalendarUnit fromDate:self];
    return [components minute];
}


// Returns hour from date
- (int) getHour {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSHourCalendarUnit fromDate:self];
    return [components hour];
}


// Returns day from date
- (int) getDay {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit fromDate:self];
    return [components day];
}


// Returns month from date
- (int) getMonth {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSMonthCalendarUnit fromDate:self];
    return [components month];
}


// Returns year from date
- (int) getYear {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:self];
    return [components year];
}

@end

