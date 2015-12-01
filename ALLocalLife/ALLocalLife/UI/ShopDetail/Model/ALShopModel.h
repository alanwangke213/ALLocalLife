//
//  ALShopModel.h
//  ALLocalLife
//
//  Created by 王可成 on 15/11/30.
//  Copyright © 2015年 AL. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol goodsItem <NSObject>
@end
@protocol commentItem <NSObject>
@end

@interface goodsItem : JSONModel
@property (nonatomic ,assign) NSInteger id;
@property (nonatomic ,copy) NSString *title;
@property (nonatomic ,copy) NSString *price;
@property (nonatomic ,copy) NSString *intro;
@end



@interface commentItem : JSONModel
@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,copy) NSString *photo;
@property (nonatomic ,copy) NSString *time;
@property (nonatomic ,copy) NSString *comment;
@end


@interface ALShopModel : JSONModel

@property (nonatomic ,assign) NSInteger id;
@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,copy) NSString *cover;
@property (nonatomic ,copy) NSString *address;
@property (nonatomic ,copy) NSString *lon;
@property (nonatomic ,copy) NSString *lat;
@property (nonatomic ,copy) NSString *intro;
@property (nonatomic ,copy) NSString *phone;
@property (nonatomic ,copy) NSString *server;
@property (nonatomic ,assign) NSInteger score;

@property (nonatomic ,strong) NSArray<goodsItem> *goods;
@property (nonatomic ,strong) NSArray<commentItem> *comment_list;
@end
