// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to KCGPhoto.h instead.

@import CoreData;

extern const struct KCGPhotoAttributes {
	__unsafe_unretained NSString *imageData;
} KCGPhotoAttributes;

extern const struct KCGPhotoRelationships {
	__unsafe_unretained NSString *notes;
} KCGPhotoRelationships;

@class KCGNote;

@interface KCGPhotoID : NSManagedObjectID {}
@end

@interface _KCGPhoto : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) KCGPhotoID* objectID;

@property (nonatomic, strong) NSData* imageData;

//- (BOOL)validateImageData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *notes;

- (NSMutableSet*)notesSet;

@end

@interface _KCGPhoto (NotesCoreDataGeneratedAccessors)
- (void)addNotes:(NSSet*)value_;
- (void)removeNotes:(NSSet*)value_;
- (void)addNotesObject:(KCGNote*)value_;
- (void)removeNotesObject:(KCGNote*)value_;

@end

@interface _KCGPhoto (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitiveImageData;
- (void)setPrimitiveImageData:(NSData*)value;

- (NSMutableSet*)primitiveNotes;
- (void)setPrimitiveNotes:(NSMutableSet*)value;

@end
