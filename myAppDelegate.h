//
//  MyAppDelegate.h
//  PdfViewer
//
//  Created by Emmanuel Ngeno on 9/12/13.
//  Copyright (c) 2013 Emmanuel Ngeno. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

@interface MyAppDelegate : NSObject <NSApplicationDelegate>
{

    PDFDocument *pdfDoc;
    NSString *pageNumber;
    NSString *previousPage;
    PDFPage *pdfPage;
    NSMutableArray *searchResults;
    NSString *searchText;
    int selectionPos;
    
}


@property (assign) IBOutlet NSWindow *window;

@property (weak) IBOutlet PDFView *viewer;

@property (weak) IBOutlet NSSearchField *search;

@property (weak) IBOutlet NSComboBoxCell *myComboBox;

@property (weak) IBOutlet NSTextField *pageNum;

@property (weak) IBOutlet NSToolbar *toolBar;


-(IBAction)zoomToFit:(id)sender;
- (IBAction)zoomIn:(id)sender;
- (IBAction)zoomOut:(id)sender;
- (IBAction)previousPage:(id)sender;
- (IBAction)nextPage:(id)sender;
- (IBAction)goToPage:(id)sender;
- (IBAction)displayMode:(id)sender;
- (IBAction)searchText:(id)sender;
- (IBAction)enterFullScreen:(id)sender;

@end
