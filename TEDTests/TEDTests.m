//
//  TEDTests.m
//  TEDTests
//
//  Created by Mikk Pavelson on 12/03/15.
//  Copyright (c) 2015 mp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "MasterViewController.h"
#import "AppDelegate.h"

@interface TEDTests : XCTestCase {
@private
  UIApplication         *app;
  AppDelegate           *appDelegate;
  MasterViewController  *masterViewController;
}

@end

@implementation TEDTests

- (void)setUp {
  [super setUp];
  
  app = [UIApplication sharedApplication];
  appDelegate = [[UIApplication sharedApplication] delegate];
  masterViewController = appDelegate.masterController;
}

- (void)tearDown {
  // Put teardown code here. This method is called after the invocation of each test method in the class.
  [super tearDown];
}

- (void)testExample {
  // This is an example of a functional test case.
  XCTAssert(YES, @"Passed");
}

- (void)testMyMethod {
  // given
  NSNumber *parameters1 = @([masterViewController add:4 to:3]);
  NSNumber *parameters2 = @([masterViewController add:1 to:-3]);
  NSNumber *parameters3 = @([masterViewController add:0 to:3]);
  NSNumber *parameters4 = @([masterViewController add:-2 to:0]);
  
  // when
  NSNumber *answer1 = @(7);
  NSNumber *answer2 = @(-1);
  NSNumber *answer3 = @(3);
  NSNumber *answer4 = @(-2);
  
  // then
  XCTAssertEqualObjects(parameters1, answer1, @"4+7 not correct!");
  XCTAssertEqualObjects(parameters2, answer2, @"1+(-1) not correct!");
  XCTAssertEqualObjects(parameters3, answer3, @"0+3 not correct!");
  XCTAssertEqualObjects(parameters4, answer4, @"-2+0 not correct!");
}

- (void)testPerformanceExample {
  // This is an example of a performance test case.
  [self measureBlock:^{
    
  }];
}

@end
