//
//  MasterViewController.m
//  TED
//
//  Created by Mikk Pavelson on 12/03/15.
//  Copyright (c) 2015 mp. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Item.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "UtilityManager.h"

#define kXMLTagTitle                    @"title"
#define kXMLTagURLImage                 @"media:thumbnail"
#define kXMLTagURLVideo                 @"media:content"
#define kXMLDescription                 @"description"
#define kNetworkConnectionNone          @"kNetworkConnectionNone"
#define kNetworkConnectionReachable     @"kNetworkConnectionReachable"

@interface MasterViewController () <NSXMLParserDelegate>

@property (nonatomic, copy) NSString *element;
@property (nonatomic, strong) NSMutableDictionary *item;
@property (nonatomic, strong) NSXMLParser *parser;
@property (nonatomic, strong) NSMutableArray *feeds;
@property (nonatomic, strong) Item *currentItem;

- (void)setupNetworkObservation;
- (void)downloadData;
- (void)networkConnectionGotNone:(NSNotification *)notification;
- (void)networkConnectionReachable:(NSNotification *)notification;
- (void)downloadImageForCell:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath;

@end

@implementation MasterViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self setTitle:@"TED"];
  [self setFeeds:[NSMutableArray array]];
  
  UIBarButtonItem *retryButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(downloadData)];
  [self.navigationItem setRightBarButtonItem:retryButton];
  
  [self setupNetworkObservation];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  
  [[NSNotificationCenter defaultCenter] removeObserver:self name:kNetworkConnectionNone object:nil];
}

- (void)setupNetworkObservation
{
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkConnectionGotNone:) name:kNetworkConnectionNone object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkConnectionReachable:) name:kNetworkConnectionReachable object:nil];
  
  AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
  [manager startMonitoring];
  [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
    switch (status) {
      case AFNetworkReachabilityStatusReachableViaWWAN:
        [[NSNotificationCenter defaultCenter] postNotificationName:kNetworkConnectionReachable object:nil];
        break;
      case AFNetworkReachabilityStatusReachableViaWiFi:
        [[NSNotificationCenter defaultCenter] postNotificationName:kNetworkConnectionReachable object:nil];
        break;
      case AFNetworkReachabilityStatusNotReachable:
        [[NSNotificationCenter defaultCenter] postNotificationName:kNetworkConnectionNone object:nil];
      default:
        break;
    }
  }];
}

- (void)downloadData
{
  AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
  if (!manager.reachable)
  {
    [[UtilityManager sharedManager] showNetworkErrorAlert];
  }
  
  NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://feeds.feedburner.com/tedtalks_video"]];
  [parser setShouldResolveExternalEntities:NO];
  [parser setDelegate:self];
  [parser parse];
}

- (void)networkConnectionGotNone:(NSNotification *)notification
{
  if (self.feeds.count == 0)
  {
    [[UtilityManager sharedManager] showNetworkErrorAlert];
  }
}

- (void)networkConnectionReachable:(NSNotification *)notification
{
  if (self.feeds.count == 0)
  {
    [self downloadData];
  }
}

#pragma mark - XML parser delegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
  [self setElement:elementName];
  
  if ([self.element isEqualToString:kXMLTagTitle])
  {
    [self setCurrentItem:[Item item]];
  }
  else if ([self.element isEqualToString:kXMLTagURLImage])
  {
    [self.currentItem setUrlImage:[attributeDict objectForKey:@"url"]];
  }
  else if ([self.element isEqualToString:kXMLTagURLVideo])
  {
    [self.currentItem setUrlVideo:[attributeDict objectForKey:@"url"]];
  }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
  if ([self.element isEqualToString:kXMLTagTitle])
  {
    [self.currentItem appendToTitle:string];
  }
  else if ([self.element isEqualToString:kXMLDescription])
  {
    [self.currentItem appendToSummary:string];
  }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
  if (self.currentItem.allDataParsed)
  {
    [self.currentItem cleanUpSummary];
    [self.feeds addObject:self.currentItem];
    [self setCurrentItem:nil];
  }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
  [self.tableView reloadData];
  [self.navigationItem setRightBarButtonItem:nil];
}

#pragma mark - Table View

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 77.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return self.feeds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *identifier = @"CellIdentifier";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  
  if (!cell)
  {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    [cell.textLabel setNumberOfLines:0];
    [cell.textLabel setFont:[[UtilityManager sharedManager] appFontWithSize:15.0]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
  }
  
  Item *item = (self.feeds)[indexPath.row];
  [cell.textLabel setText:item.title];

  if (!item.imageThumb)
  {
    [cell.imageView setImage:nil];
    [self downloadImageForCell:cell inIndexPath:indexPath];
  }
  else
  {
    [cell.imageView setImage:item.imageThumb];
  }
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  Item *item = (self.feeds)[indexPath.row];
  DetailViewController *detailController = [[DetailViewController alloc] initWithItem:item];
  [self.navigationController pushViewController:detailController animated:YES];
}

- (void)downloadImageForCell:(UITableViewCell *)cell inIndexPath:(NSIndexPath *)indexPath
{
  Item *item = (self.feeds)[indexPath.row];
  __block Item *blockItem = item;
  __block UITableViewCell *blockCell = cell;
  __block UITableViewController *blockSelf = self;
  __block NSIndexPath *blockIndexPath = indexPath;
  
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:item.urlImage]];
    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    
    __block UITableViewCell *block2Cell = blockCell;
    [blockCell.imageView setImageWithURLRequest:request
                               placeholderImage:nil
                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                            [blockItem setImage:image];
                                            [block2Cell.imageView setImage:blockItem.imageThumb];
                                            [blockSelf.tableView reloadRowsAtIndexPaths:@[blockIndexPath] withRowAnimation:UITableViewRowAnimationNone];
                                          });
                                        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                          NSLog(@"errorLoadingImage: %@", error);
                                        }];
  });
}

@end
