//
//  DDViewController.m
//  tableview
//
//  Created by DengOC on 2017/1/28.
//  Copyright © 2017年 sf. All rights reserved.
//

#import "DDViewController.h"
#import "DDCell.h"
#import <Masonry/Masonry.h>
@interface DDViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * sectionData;
}
@property (nonatomic,weak) UITableView * tableView ;
@property (nonatomic ,strong) UIView * ButtonView ;
@end

@implementation DDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    sectionData = [ NSMutableArray array];
    [self initBarbutton];
    [self initData];
    
    
    [self.view addSubview:self.ButtonView];
    [self.ButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@45);
        make.bottom.equalTo(self.view).offset(45);
    }];
    [self initIU];
    
}
-(void) showEitingView:(BOOL) s
{
    [self.ButtonView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.view).offset(s ? 0:45);

    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}
-(UIView *)ButtonView
{
    if (!_ButtonView) {
        
        _ButtonView = [[UIView alloc]init];
        UIButton * btnR = [[UIButton alloc]init];
        UIButton * btnL = [[UIButton alloc]init];
        btnL.backgroundColor = [UIColor redColor];
        btnR.backgroundColor = [UIColor lightGrayColor];
        
        [btnL addTarget:self action:@selector(btnLClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnR addTarget:self action:@selector(btnLClick:) forControlEvents:UIControlEventTouchUpInside];
        [_ButtonView addSubview:btnR];
        [_ButtonView addSubview:btnL];
        [btnL setTitle:@"全选" forState:UIControlStateNormal];
        [btnR setTitle:@"删除" forState:UIControlStateNormal];
        
        [btnR mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(_ButtonView);
            make.width.equalTo(_ButtonView).multipliedBy(0.5);
        }];
        [btnL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(_ButtonView);
            make.width.equalTo(_ButtonView).multipliedBy(0.5);
        }];
    }
    return _ButtonView;
}
-(void)btnLClick :(UIButton * ) sedner
{
    if ([[sedner titleForState:UIControlStateNormal]  isEqualToString:@"全选"]) {
        [sedner setTitle:@"全不选" forState:UIControlStateNormal];
        [sectionData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        }];
    }else
    if ([[sedner titleForState:UIControlStateNormal]  isEqualToString:@"全不选"]) {
        [sedner setTitle:@"全选" forState:UIControlStateNormal];
        [self.tableView reloadData];
    }else
    if ([[sedner titleForState:UIControlStateNormal]  isEqualToString:@"删除"]) {
        NSMutableIndexSet * set = [[NSMutableIndexSet alloc]init];
        [[self.tableView indexPathsForSelectedRows]  enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [set addIndex:obj.row];
        }];
        [sectionData removeObjectsAtIndexes:set];
        [self.tableView deleteRowsAtIndexPaths:[self.tableView  indexPathsForSelectedRows] withRowAnimation:UITableViewRowAnimationFade];
    }
};
-(void)btnRClick {};
-(void) initBarbutton
{
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(itmeToll:)];
    self.navigationItem.rightBarButtonItem = item;
}

-(void) itmeToll:(UIBarButtonItem *) b
{
    if (sectionData.count <1) {
        return;
    }else
    if ([b.title isEqualToString:@"编辑"]){
        b.title = @"取消";
        [self.tableView setEditing:YES animated:YES];
        [self showEitingView:YES];
    }else {
    b.title =@"编辑";
        [self.tableView setEditing:NO animated:YES];
        [self showEitingView:NO];
    }
    
    
}
-(void) initData
{
    
    for (int i = 0; i<40; i++) {
        [sectionData addObject:@(i)];
    }
}
-(void) initIU{
    UITableView * tableView =  [[UITableView alloc]init];//[[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 88) style:UITableViewStylePlain];
    tableView.delegate     = self;
    tableView.dataSource = self;
//    [tableView registerClass:[DDCell class] forCellReuseIdentifier:@"dequeueReusableCellWithIdentifier"];
    [self.view addSubview:tableView];
   
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.ButtonView.mas_top);
    }];
    self.tableView = tableView;
    
    

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.isEditing) {
        return;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

 -(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"tableviewEdting";
    DDCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[DDCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text =  [NSString stringWithFormat:@"%@",sectionData[indexPath.row] ] ;
    return cell;

}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return sectionData.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

@end
