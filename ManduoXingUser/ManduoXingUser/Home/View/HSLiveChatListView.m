//
//  HSLiveChatListView.m
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/29.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "HSLiveChatListView.h"
@interface HSLiveChatListView ()

@end

static NSString * cellID = @"HSLiveChatListCell";

@implementation HSLiveChatListView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)configUI{
    
    [self addSubview:self.chatTableView];
    
}

-(void)receiveMsg:(HSLiveChatModel*)model{
    
    
    [self.sourceArr addObject:model];
    [self.chatTableView beginUpdates];
       NSIndexPath *index = [NSIndexPath indexPathForRow:self.sourceArr.count-1 inSection:0];
    [self.chatTableView insertRowsAtIndexPaths:@[index] withRowAnimation:(UITableViewRowAnimationNone)];
    [self.chatTableView endUpdates];

    [self.chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:self.sourceArr.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
      
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.sourceArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HSLiveChatListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    HSLiveChatModel * model = self.sourceArr[indexPath.row];
    
    cell.model = model;
    
    return cell;
    
    
}


-(NSMutableArray*)sourceArr{
    if (!_sourceArr) {
        _sourceArr = @[].mutableCopy;
    }
    
    return _sourceArr;
}
-(UITableView*)chatTableView{
    if (!_chatTableView) {
        _chatTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height) style:(UITableViewStylePlain)];
        _chatTableView.estimatedRowHeight = 50;
        _chatTableView.delegate = self;
        _chatTableView.dataSource = self;
        _chatTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _chatTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        [_chatTableView registerClass:[HSLiveChatListCell class] forCellReuseIdentifier:cellID];
        
    }
    
    return _chatTableView;
    
    
}
@end
