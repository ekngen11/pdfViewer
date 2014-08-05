//
//  MyAppDelegate.m
//  PdfViewer
//
//  Created by Emmanuel Ngeno on 9/12/13.
//  Copyright (c) 2013 Emmanuel Ngeno. All rights reserved.
//

#import "MyAppDelegate.h"

@implementation MyAppDelegate

-(void) awakeFromNib
   
{
    //Intitializes a pdfDoc with an existing document.
    pdfDoc = [[PDFDocument alloc] initWithURL:[NSURL fileURLWithPath:@"/home/cshome/e/engeno/Desktop/LabWeek4.pdf"]];
    
    [_viewer setDocument:pdfDoc];
    
    //---FULSCREEN----
    //Automatically creates the FullScreen button
    [_window setCollectionBehavior:NSWindowCollectionBehaviorFullScreenPrimary];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowEnteringScreen:) name:NSWindowDidEnterFullScreenNotification object:[self window]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowExitingFullScreen:) name:NSWindowDidExitFullScreenNotification object:[self window]];
    
    [_pageNum setIntegerValue:1];
    [_myComboBox setStringValue:@"Single Page"];

}
  
- (IBAction)zoomIn:(id)sender {
    if ([_viewer canZoomIn]) {
        [_viewer zoomIn:self];
    }

}

- (IBAction)zoomOut:(id)sender {
    
    if ([_viewer canZoomOut]) {
        [_viewer zoomOut:self];
    }

}

- (IBAction)previousPage:(id)sender {
    
    if ([_viewer canGoBack]) {
        
        [_viewer goBack:self];
        
        pdfPage= [_viewer currentPage];
        pageNumber=[pdfPage label];
        NSInteger i=[pageNumber integerValue];

        [_pageNum setIntegerValue:i];
                
    }
    
}


-(IBAction)zoomToFit:(id)sender
{
    [_viewer setAutoScales:YES];
}


- (IBAction)nextPage:(id)sender {
    
    if([_viewer canGoToNextPage])
    {
        pdfPage= [_viewer currentPage];
        pageNumber=[pdfPage label];
        
        NSInteger i=[pageNumber integerValue];
        i++;
        [_pageNum setIntegerValue:i];
        
        [_viewer goToNextPage:self];
    }
    
}

- (IBAction)goToPage:(id)sender
{
    
    NSInteger x=[_pageNum integerValue];
    if (x<=[pdfDoc pageCount]) {
        x--;
        
        pdfPage= [pdfDoc pageAtIndex:x];
        
        [_viewer goToPage:pdfPage];
    }
    else{
        NSLog(@"The page number you selected is not in the document");
    }
    
    
}

- (IBAction)displayMode:(id)sender {
    
    if([_myComboBox indexOfSelectedItem]==0){
        [_viewer setDisplayMode:kPDFDisplaySinglePageContinuous];
    }
    
    else if ([_myComboBox indexOfSelectedItem]==1){
        [_viewer setDisplayMode:kPDFDisplaySinglePage];
    }
    
    else if ([_myComboBox indexOfSelectedItem]==2){
        [_viewer setDisplayMode:kPDFDisplayTwoUp];
    }
    else{
        [_viewer setDisplayMode:kPDFDisplayTwoUpContinuous];
    }
}

- (IBAction)searchText:(id)sender {
    if ([[_viewer document] isFinding])
        [[_viewer document] cancelFindString];
        
        if (![[_search stringValue] isEqualToString:searchText]) {
            searchResults = NULL;
        }
    
    if (searchResults == NULL){
        
        searchResults = [NSMutableArray arrayWithCapacity: 10];
        searchText=[sender stringValue];
        selectionPos=0;
    }

    NSArray *array= [[_viewer document] findString:[_search stringValue] withOptions: NSCaseInsensitiveSearch];
    if (array.count!=0) {
        [_viewer setCurrentSelection:array[selectionPos ]];
        selectionPos++;
        if (selectionPos>array.count-1){
            selectionPos=0;
        }
        [_viewer scrollSelectionToVisible:sender];
    }
    

    
    [[_viewer document] beginFindString: [sender stringValue] // 3
                            withOptions: NSCaseInsensitiveSearch] ;}

-(void) windowEnteringScreen:(NSNotification *) aNotification
{
    [_viewer setDisplayMode:kPDFDisplaySinglePage];
    [_toolBar setVisible:NO];
    
}

-(void ) windowExitingFullScreen:(NSNotification *) aNotification
{
    [_toolBar setVisible:YES];
}


@end
