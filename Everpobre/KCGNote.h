#import "_KCGNote.h"

@class KCGNotebook;

@interface KCGNote : _KCGNote {}
// Custom logic goes here.

+(instancetype)noteWithName:(NSString *) name
                   notebook: (KCGNotebook*) notebook
                    context:(NSManagedObjectContext*) context;

@end
