ObjCHelpers
===========

ObjectiveC helper categories and classes for cross-project use.

# UIImage helper methods

<pre>
+ (UIImage *) imageWithColor :(UIColor *)pColor;
</pre>

# NSDate helper methods

<pre>
+ (NSDate *) stringToDate :(NSString *)pString;
+ (NSDate*) JSONStringToDate :(NSString*)pJSONdateString;
+ (NSDate *) dateWithoutTime :(NSDate *)pDate;
+ (NSDate *) dateWithLastSecond :(NSDate *)dateTime;
- (NSString *) stringValue;
- (int) daysFromDate :(NSDate *)pDate;
- (int) getSecond;
- (int) getMinute;
- (int) getHour;
- (int) getDay;
- (int) getMonth;
- (int) getYear;
</pre>

### Use

Add needed helper classes from Classes folder to your app target.

Add test classes for helpers you are using to your unittests target (should be configured with OCHamcrest) if interested.

### Creators

[Jurgis Kirsakmens](http://github.com/xjki)  
[@xjki](https://twitter.com/xjki)

## License

Use at your own risk. No need to give credit in your app - no one reads this stuff anyway. 
The license is otherwise MIT standard.