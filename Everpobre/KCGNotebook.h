#import "_KCGNotebook.h"

@interface KCGNotebook : _KCGNotebook {}
// Custom logic goes here.
+(instancetype) notebookWithName:(NSString*) name
                         context:(NSManagedObjectContext *)context;

@end
