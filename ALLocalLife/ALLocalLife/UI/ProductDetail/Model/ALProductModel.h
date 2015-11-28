//
//  ALProductModel.h
//  ALLocalLife
//
//  Created by 王可成 on 15/11/27.
//  Copyright © 2015年 AL. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import <UIKit/UIKit.h>

@interface ALProductModel : JSONModel

@property (nonatomic ,assign) NSInteger id;
@property (nonatomic ,copy) NSString *title;
@property (nonatomic ,copy) NSString *content;
@property (nonatomic ,assign) NSInteger price;
@property (nonatomic ,assign) NSInteger goods_anapshot_id;
@property (nonatomic ,assign) NSInteger shop_id;
@property (nonatomic ,copy) NSString *shop_name;
@property (nonatomic ,copy) NSString *address;
@property (nonatomic ,copy) NSString *phone;
@property (nonatomic ,assign) CGFloat lon;
@property (nonatomic ,assign) CGFloat lat;
@property (nonatomic ,strong) NSArray *goods_list;
@end
