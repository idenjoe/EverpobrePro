//
//  EverpobreNotesViewController.m
//  Everpobre
//
//  Created by José Manuel Rodríguez Moreno on 25/01/16.
//  Copyright (c) 2016 José Manuel Rodríguez Moreno. All rights reserved.
//

#import "EverpobreNotesViewController.h"
#import "KCGNote.h"
#import "KCGNoteCellView.h"
#import "KCGPhoto.h"
#import "KCGNoteViewController.h"
#import "KCGNotebook.h"

static NSString *cellId = @"NoteCellId";

@interface EverpobreNotesViewController ()

@end

@implementation EverpobreNotesViewController

#pragma mark -  View Lifecicle
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self registerCell];
    
    self.title = @"Notas";
    self.detailViewControllerClassName = NSStringFromClass([KCGNoteViewController class]);
    
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                         target:self
                                                                         action:@selector(addNote:)];
    self.navigationItem.rightBarButtonItem = add;
    
}

#pragma mark - cell registration
-(void) registerCell{
    
    UINib *nib = [UINib nibWithNibName:@"KCGNoteCollectionViewCell"
                                bundle:nil];
    [self.collectionView registerNib:nib
          forCellWithReuseIdentifier:cellId];
}

#pragma mark - Data Source
-(UICollectionViewCell*) collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // Obtener el objeto
    KCGNote *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Obtener la celda
    KCGNoteCellView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId
                                                                      forIndexPath:indexPath];
    // Configurarla
    [cell observeNote:note];
    
    
    // Devolcerla
    return cell;
}

#pragma mark - Utils
-(void) addNote:(id) sender{
    
    [KCGNote noteWithName:@"Nueva nota"
                 notebook:self.notebook
                  context:self.notebook.managedObjectContext];
    
}

#pragma mark -  Delegate
//-(void) collectionView:(UICollectionView *)collectionView
//didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    // Obtener el objeto
//    KCGNote *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
//    
//    // Crear el controlador
//    KCGNoteViewController *noteVC = [[KCGNoteViewController alloc] initWithModel:note];
//    
//    // Hacer un push
//    [self.navigationController pushViewController:noteVC
//                                         animated:YES];
//    
//}































@end
