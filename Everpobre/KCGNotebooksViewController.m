//
//  KCGNotebooksViewController.m
//  Everpobre
//
//  Created by José Manuel Rodríguez Moreno on 18/01/16.
//  Copyright © 2016 José Manuel Rodríguez Moreno. All rights reserved.
//

#import "KCGNotebooksViewController.h"
#import "KCGNotebook.h"
#import "KCGNote.h"
#import "KCGNotesViewController.h"
#import "EverPobreNotesViewController.h"
#import "KCNotebookTableViewCell.h"

@interface KCGNotebooksViewController ()

@end

@implementation KCGNotebooksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerNibs];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 160;
    self.title = @"Everpobre Pro";
    
    // Creamos botón de barra de +
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewNotebook:)];
    
    // Lo añadimos
    self.navigationItem.rightBarButtonItem = btn;
}

-(void)registerNibs{
    UINib *nib = [UINib nibWithNibName:@"KCNotebookTableViewCell"
                                bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"notebooksCell"];
}

-(void) addNewNotebook:(id) sender{
    
    [KCGNotebook notebookWithName:@"New Notebook"
                          context:self.fetchedResultsController.managedObjectContext];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"notebooksCell";
    
    // Averiguar qué libreta es
    KCGNotebook *nb = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Crear la celda
    KCNotebookTableViewCell *cell = (KCNotebookTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        // Creamos la celda de la nada
        cell = [[KCNotebookTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    // Sincronizar libreta -> celda
    cell.name.text = nb.name;
    
    // Devolvemos la celda
    return cell;
}


#pragma mark - Navigation
-(void) tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Obtener la libreta
    KCGNotebook *nb = [self.fetchedResultsController
                       objectAtIndexPath:indexPath];
    
    // Crear el fetch request
    NSFetchRequest *r = [[NSFetchRequest alloc] initWithEntityName:[KCGNote entityName]];
    
    // Configurarlo con un predicado
    r.fetchBatchSize = 25;
    r.sortDescriptors = @[[NSSortDescriptor
                           sortDescriptorWithKey:KCGNoteAttributes.name
                           ascending:YES
                           selector:@selector(caseInsensitiveCompare:)],
                          [NSSortDescriptor
                           sortDescriptorWithKey:KCGNoteAttributes.modificationDate
                           ascending:NO]];
    r.predicate = [NSPredicate predicateWithFormat:@"notebook == %@", nb];
    
    // Crear el fetchedResults
    NSFetchedResultsController *fc = [[NSFetchedResultsController alloc] initWithFetchRequest:r managedObjectContext:nb.managedObjectContext sectionNameKeyPath:nil cacheName:[[NSUUID new]UUIDString]];
    
    // layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    CGSize size = self.view.frame.size;
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.itemSize = CGSizeMake((size.width/2) -30, 150);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    // View controller
    EverpobreNotesViewController *nVC = [EverpobreNotesViewController coreDataCollectionViewControllerWithFetchedResultsController:fc
                                                                                                               layout:layout];
    
    nVC.notebook = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    
    // Pushearlo
    [self.navigationController pushViewController:nVC
                                         animated:YES];
}


@end












