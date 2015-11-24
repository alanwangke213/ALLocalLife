//
//  ALHomeModel.m
//  ALLocalLife
//
//  Created by 王可成 on 15/11/23.
//  Copyright © 2015年 AL. All rights reserved.
//

#import <JSONModel.h>

@protocol GuessItem;
@protocol FamousItem;
@protocol GroupItem;
@protocol FocusItem;

#pragma mark - guess
@interface GuessItem :JSONModel

@property (nonatomic ,assign) NSInteger orginalprice;
@property (nonatomic ,assign) NSInteger price;
@property (nonatomic ,copy) NSString *title;
@property (nonatomic ,assign) NSInteger score;
@property (nonatomic ,copy) NSString *intro;
@property (nonatomic ,copy) NSString *cover;
@property (nonatomic ,copy) NSString *name;
@end



@interface GuessModel : JSONModel

@property (nonatomic, strong) NSArray<GuessItem> *list;

@end


#pragma mark - Famous
@interface FamousItem :JSONModel

@property (nonatomic ,assign) NSInteger score;
@property (nonatomic ,copy) NSString *intro;
@property (nonatomic ,copy) NSString *cover;
@property (nonatomic ,copy) NSString *name;
@end


@interface FamousModel : JSONModel

@property (nonatomic, strong) NSArray<FamousItem> *list;

@end

#pragma mark - GroupModel
@interface GroupItem :JSONModel

@property (nonatomic ,copy) NSString *title;
@property (nonatomic ,assign) NSInteger id;
@property (nonatomic ,copy) NSString *cover;

@end


@interface GroupModel : JSONModel

@property (nonatomic, strong) NSArray<GroupItem> *list;

@end


#pragma mark - FocusModel

@interface FocusItem : JSONModel

@property (nonatomic ,copy) NSString *title;
@property (nonatomic ,copy) NSString *cover;
@property (nonatomic ,copy) NSString *link;
@property (nonatomic ,copy) NSString *res_name;
@property (nonatomic ,copy) NSString *res_id;
@property (nonatomic ,assign) NSInteger id;

@end



@interface FocusModel : JSONModel

@property (nonatomic ,strong) NSArray<FocusItem> *list;

@end

#pragma mark - HomeModel


@interface ALHomeModel : JSONModel

@property (nonatomic ,strong) FamousModel *famous;
@property (nonatomic ,strong) FocusModel *focus;
@property (nonatomic ,strong) GroupModel *group;
@property (nonatomic ,strong) GuessModel *guess;

@end
