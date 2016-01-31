#import "_KCLocation.h"
@import CoreLocation;

@interface KCLocation : _KCLocation {}
// Custom logic goes here.

+(instancetype)locationWithCLLocation:(CLLocation *)location forNote:(KCGNote *)note;
@end
