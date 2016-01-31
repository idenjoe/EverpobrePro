// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to KCGNote.m instead.

#import "_KCGNote.h"

const struct KCGNoteAttributes KCGNoteAttributes = {
	.creationDate = @"creationDate",
	.modificationDate = @"modificationDate",
	.name = @"name",
	.text = @"text",
};

const struct KCGNoteRelationships KCGNoteRelationships = {
	.location = @"location",
	.notebook = @"notebook",
	.photo = @"photo",
};

@implementation KCGNoteID
@end

@implementation _KCGNote

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Note";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Note" inManagedObjectContext:moc_];
}

- (KCGNoteID*)objectID {
	return (KCGNoteID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic creationDate;

@dynamic modificationDate;

@dynamic name;

@dynamic text;

@dynamic location;

@dynamic notebook;

@dynamic photo;

@end

