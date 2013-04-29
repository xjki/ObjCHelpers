//
//  NSDate+HelperTests.m
//  Created by Jurgis Kirsakmens on 28.10.12.
//

// use OCHarmcrest framework and helpers : https://github.com/hamcrest/OCHamcrest
#define HC_SHORTHAND
#import <OCHamcrestIOS/OCHamcrestIOS.h>
#import <SenTestingKit/SenTestingKit.h>

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "NSDate+Helper.h"

@interface NSDateHelperTests : SenTestCase {}
@end


@implementation NSDateHelperTests

- (void) setUp {
    // set up code there
    [super setUp];
}


- (void) tearDown {
    // tear-down code here.
    [super tearDown];

}


// Test [NSDate daysFromDate]
- (void) testDaysFromDate {
    // test for today
    NSDate *today = [NSDate date];
    assertThatInt([today daysFromDate:today], equalToInt(0)); 
    assertThatInt([today daysFromDate:[today dateByAddingTimeInterval:-(60 * 60)]], equalToInt(0)); // today-1 hour = 0
    // test for yesterday
    NSDate *otherday = [today dateByAddingTimeInterval:-(60 * 60 * 24)]; 
    assertThatInt([today daysFromDate:otherday], equalToInt(1));
    // test for tommorow
    otherday = [today dateByAddingTimeInterval:+(60 * 60 * 24)];
    assertThatInt([today daysFromDate:otherday], equalToInt(1)); 
    // test for last year
    otherday = [today dateByAddingTimeInterval:+(60 * 60 * 24 * 365)];
    assertThatInt([today daysFromDate:otherday], equalToInt(365));

    // check if spring daylight saving time doesnt affect calculation (UK, LV, test for GMT timezone as well)
    // Sunday, March 31, 2013 at 3:00:00 AM clocks were turned forward 1 hour to 4:00:00AM (LV)
    NSDate *startDate = [NSDate stringToDate:@"2013-03-30 00:00:00"];
	NSDate *endDate = [NSDate stringToDate:@"2013-03-31 00:00:00"];
    assertThatInt([startDate daysFromDate:endDate], equalToInt(1));
    startDate = [NSDate stringToDate:@"2013-03-31 00:00:00"];
    assertThatInt([startDate daysFromDate:endDate], equalToInt(0));
    endDate = [NSDate stringToDate:@"2013-04-01 00:00:00"];
    assertThatInt([startDate daysFromDate:endDate], equalToInt(1));
    startDate = [NSDate stringToDate:@"2013-03-30 00:00:00"];
    endDate = [NSDate stringToDate:@"2013-04-05 23:59:59"];
    assertThatInt([startDate daysFromDate:endDate], equalToInt(6));

    // check if autumn dayligh saving time is properly calculated  (UK, LV, test for GMT timezone as well)
    // Sunday, October 27, 2013 at 4:00:00 AM clocks are turned backward 1 hour to 3:00:00 AM LV)
    startDate = [NSDate stringToDate:@"2013-10-26 00:05:43"];
	endDate = [NSDate stringToDate:@"2013-10-27 14:12:06"];
    assertThatInt([startDate daysFromDate:endDate], equalToInt(1));
	startDate = [NSDate stringToDate:@"2013-10-27 02:12:06"];
    assertThatInt([startDate daysFromDate:endDate], equalToInt(0));
	endDate = [NSDate stringToDate:@"2013-10-30 14:12:06"];
    assertThatInt([startDate daysFromDate:endDate], equalToInt(3));
    startDate = [NSDate stringToDate:@"2013-10-24 00:00:00"];
    endDate = [NSDate stringToDate:@"2013-10-30 23:59:59"];
    assertThatInt([startDate daysFromDate:endDate], equalToInt(6));

}


// Test [NSDate dateToString] and [NSDate stringValue] methods
- (void) testDateDateToStringToDate {
    NSDate *todayDate = [NSDate date];
	NSString *todayString = [todayDate stringValue];
    assertThat(todayString, notNilValue());
    assertThatInt((int)[[NSDate stringToDate:todayString] timeIntervalSince1970],
       equalToInt((int)[todayDate timeIntervalSince1970]));

	NSString *pastdateString = @"1972-05-12 01:54:12";
	NSDate *pastdateDate = [NSDate stringToDate:pastdateString];
    assertThat([pastdateDate stringValue], equalTo(pastdateString));

    // test date component methods
    assertThatInt([pastdateDate getDay], equalToInt(12));
    assertThatInt([pastdateDate getMonth], equalToInt(5));
    assertThatInt([pastdateDate getYear], equalToInt(1972));
    assertThatInt([pastdateDate getHour], equalToInt(1));
    assertThatInt([pastdateDate getMinute], equalToInt(54));
    assertThatInt([pastdateDate getSecond], equalToInt(12));
}


// Test [NSDate JSONStringToDate] method
- (void) testJSONStringToDate {
	NSString *dateString = @"1972-05-12 01:54:12";
	NSString *JSONString = @"1972-05-12T01:54:12";
    assertThat([NSDate stringToDate:dateString], equalTo([NSDate JSONStringToDate:JSONString]));
}



// Test [NSDate onlyDate] method
- (void) testOnlyDate {
	NSDate *dateWithTime=[NSDate stringToDate:@"1956-11-26 12:05:43"];
    assertThat([NSDate dateWithoutTime:dateWithTime], notNilValue());
    // should be equal to date without time component
    assertThat([NSDate dateWithoutTime:dateWithTime], equalTo([NSDate stringToDate:@"1956-11-26 00:00:00"]));
}


// Test [NSDate dateWithLastSecond] method
- (void) testDateWithLastSecond {
	NSDate *date1=[NSDate stringToDate:@"2010-09-04 00:00:00"];
	NSDate *date2=[NSDate stringToDate:@"2010-09-04 23:59:00"];
	NSDate *date3=[NSDate stringToDate:@"2012-03-24 00:00:00"];
	NSDate *date4=[NSDate stringToDate:@"2012-03-24 23:59:59"];
	NSDate *date5=[NSDate stringToDate:@"2012-10-28 00:00:00"];
	NSDate *date6=[NSDate stringToDate:@"2012-10-28 23:59:00"];

    assertThat([NSDate dateWithLastSecond:date1], equalTo([NSDate stringToDate:@"2010-09-04 23:59:59"]));
    assertThat([NSDate dateWithLastSecond:date2], equalTo([NSDate stringToDate:@"2010-09-04 23:59:59"]));
    assertThat([NSDate dateWithLastSecond:date3], equalTo([NSDate stringToDate:@"2012-03-24 23:59:59"])); // DST start date Latvia
    assertThat([NSDate dateWithLastSecond:date4], equalTo([NSDate stringToDate:@"2012-03-24 23:59:59"])); // DST start date Latvia
    assertThat([NSDate dateWithLastSecond:date5], equalTo([NSDate stringToDate:@"2012-10-28 23:59:59"])); // DST end date Latvia
    assertThat([NSDate dateWithLastSecond:date6], equalTo([NSDate stringToDate:@"2012-10-28 23:59:59"])); // DST end date Latvia
}


@end
