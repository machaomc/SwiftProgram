//
//  XMLParser.h
//  TKUtil
//
//  Created by liubao on 14-11-7.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TreeNode.h"

/**
 *  NSXMLParser中主要有三个委托方法来解析XML：
 
 1、parser：didStartElement： 当解析器对象遇到xml的开始标记时，调用这个方法。
 
 2、parser：didEndElement：当解析器对象遇到xml的结束标记时，调用这个方法。
 
 3、parser：foundCharacters：当解析器找到开始标记和结束标记之间的字符时，调用这个方法。
 
 */
@interface XMLParser : NSObject
{
    NSMutableArray      *stack;
}

+ (XMLParser *) sharedInstance;
- (TreeNode *) parseXMLFromURL: (NSURL *) url;
- (TreeNode *) parseXMLFromData: (NSData*) data;
@end