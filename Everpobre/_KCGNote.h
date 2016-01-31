// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to KCGNote.h instead.

#import <CoreData/CoreData.h>

extern const struct KCGNoteAttributes {
	__unsafe_unretained NSString *creationDate;
	__unsafe_unretained NSString *modificationDate;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *text;
} KCGNoteAttributes;

extern const struct KCGNoteRelationships {
	__unsafe_unretained NSString *location;
	__unsafe_unretained NSString *notebook;
	__unsafe_unretained NSString *photo;
} KCGNoteRelationships;

@class KCLocation;
@class KCGNotebook;
@class KCGPhoto;

@interface KCGNoteID : NSManagedObjectID {}
@end

@interface _KCGNote : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) KCGNoteID* objectID;

@property (nonatomic, strong) NSDate* creationDate;

//- (BOOL)validateCreationDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* modificationDate;

//- (BOOL)validateModificationDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* text;

//- (BOOL)validateText:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) KCLocation *location;

//- (BOOL)validateLocation:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) KCGNotebook *notebook;

//- (BOOL)validateNotebook:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) KCGPhoto *photo;

//- (BOOL)validatePhoto:(id*)value_ error:(NSError**)error_;

@end

@interface _KCGNote (CoreDataGeneratedPrimitiveAccessors)

- (NSDate*)primitiveCreationDate;
- (void)setPrimitiveCreationDate:(NSDate*)value;

- (NSDate*)primitiveModificationDate;
- (void)setPrimitiveModificationDate:(NSDate*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSString*)primitiveText;
- (void)setPrimitiveText:(NSString*)value;

- (KCLocation*)primitiveLocation;
- (void)setPrimitiveLocation:(KCLocation*)value;

- (KCGNotebook*)primitiveNotebook;
- (void)setPrimitiveNotebook:(KCGNotebook*)value;

- (KCGPhoto*)primitivePhoto;
- (void)setPrimitivePhoto:(KCGPhoto*)value;

@end
