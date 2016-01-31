//
//  KCGNotesViewController.m
//  Everpobre
//
//  Created by José Manuel Rodríguez Moreno on 21/01/16.
//  Copyright © 2016 José Manuel Rodríguez Moreno. All rights reserved.
//

#import "KCGNotesViewController.h"
#import "KCGNote.h"
#import "KCGPhoto.h"
#import "KCGNotebook.h"
#import "KCGNoteViewController.h"

@interface KCGNotesViewController ()
@property (nonatomic, strong) KCGNotebook *notebook;
@end


@implementation KCGNotesViewController

-(id) initWithFetchedResultsController:(NSFetchedResultsController *)aFetchedResultsController style:(UITableViewStyle)aStyle notebook:(KCGNotebook*) notebook{
    
    if (self = [super initWithFetchedResultsController:aFetchedResultsController style:aStyle]) {
        _notebook = notebook;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *itm = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewNote:)];
    
    self.navigationItem.rightBarButtonItem = itm;
    
}

-(void) addNewNote:(id) sender{
    
    [KCGNote noteWithName:@"Nueva nota"
                 notebook:self.notebook
                  context:self.notebook.managedObjectContext];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Data Source
-(UITableViewCell*) tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"NoteCell";
    
    // Obtener la nota
    KCGNote *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Crear la celda
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    // Sinc nota -> celda
    cell.imageView.image = note.photo.image;
    cell.textLabel.text = note.name;
    cell.detailTextLabel.text = note.text;
    
    // Devolver la celda
    return cell;
    
    
    
}

-(void) tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Obtener la nota
    KCGNote *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    
    // Crear el controlador
    KCGNoteViewController *nVC = [[KCGNoteViewController alloc]
                                  initWithModel:note];
    
    // Hacer el push
    [self.navigationController pushViewController:nVC
                                         animated:YES];
    
    
}





















@end
