//
//  RITLPhotoBrowerController.m
//  RITLPhotoDemo
//
//  Created by YueWen on 2016/12/29.
//  Copyright © 2016年 YueWen. All rights reserved.
//

#import "RITLPhotoBrowerController.h"
#import "RITLPhotoBrowerViewModel.h"
#import "UIKit+YPPhotoDemo.h"

@interface RITLPhotoBrowerController ()

/// @brief 展示图片的collectionView
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

/// @brief 底部的tabBar
@property (nonatomic, strong) UITabBar * bottomBar;

/// @brief 顶部的bar
@property (nonatomic, strong)UINavigationBar * topBar;

/// @brief 返回
@property (nonatomic, strong)UIButton * backButtonItem;

/// @brief 选择
@property (nonatomic, strong)UIButton * selectButtonItem;

/// @brief 高清图的响应Control
@property (strong, nonatomic) IBOutlet UIControl * highQualityControl;

/// @brief 选中圆圈
@property (strong, nonatomic) IBOutlet UIImageView * hignSignImageView;

/// @brief 原图:
@property (strong, nonatomic) IBOutlet UILabel * originPhotoLabel;

/// @brief 等待风火轮
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView * activityIndicatorView;

/// @brief 照片大小
@property (strong, nonatomic) IBOutlet UILabel *photoSizeLabel;

/// @brief 发送按钮
@property (strong, nonatomic) UIButton * sendButton;

/// @brief 显示数目
@property (strong, nonatomic) UILabel * numberOfLabel;

@end

@implementation RITLPhotoBrowerController


-(instancetype)initWithViewModel:(id <RITLCollectionViewModel> )viewModel
{
    if (self = [super init])
    {
        _viewModel = viewModel;
    }
    
    return self;
}


+(instancetype)photosViewModelInstance:(id <RITLCollectionViewModel> )viewModel
{
    return [[self alloc] initWithViewModel:viewModel];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - lazy

#pragma mark - Create Views
-(UICollectionView *)collectionView
{
    if (_collectionView == nil)
    {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.width + 10, self.height) collectionViewLayout:flowLayout];
        //初始化collectionView属性
//        _collectionView.dataSource = _browerDatasource;
//        _collectionView.delegate = _browerDelegate;
        
#ifdef __IPHONE_10_0
        
//        _collectionView.prefetchDataSource = _browerPreDataSource;
#endif
        
        
        _collectionView.pagingEnabled = true;
        _collectionView.showsHorizontalScrollIndicator = false;
//        [_collectionView registerClass:[YPPhotoBrowerCell class] forCellWithReuseIdentifier:reuserIdentifier];
    }
    
    return _collectionView;
}


-(UINavigationBar *)topBar
{
    if (_topBar == nil)
    {
        _topBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
        _topBar.barStyle = UIBarStyleBlack;
        
        [_topBar setViewColor:[[UIColor blackColor] colorWithAlphaComponent:0.6]];
        
        [_topBar addSubview:self.backButtonItem];
        [_topBar addSubview:self.selectButtonItem];
    }
    
    return _topBar;
}

-(UIButton *)backButtonItem
{
    if (_backButtonItem == nil)
    {
        _backButtonItem = [[UIButton alloc]initWithFrame:CGRectMake(5, 0, 45, 30)];
        _backButtonItem.center = CGPointMake(_backButtonItem.center.x, _topBar.center.y);
        [_backButtonItem setTitle:@"<" forState:UIControlStateNormal];
        [_backButtonItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_backButtonItem.titleLabel setFont:[UIFont systemFontOfSize:30]];
        [_backButtonItem.titleLabel setTextAlignment:NSTextAlignmentCenter];
//        [_backButtonItem addTarget:self action:@selector(backItemDidTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _backButtonItem;
}


-(UIButton *)selectButtonItem
{
    if(_selectButtonItem == nil)
    {
        _selectButtonItem = [[UIButton alloc]initWithFrame:CGRectMake(_topBar.width - 35, 0, 25, 25)];
        _selectButtonItem.center = CGPointMake(_selectButtonItem.center.x, _topBar.center.y + 4);
        [_selectButtonItem setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
        
//        [_selectButtonItem addTarget:_browerDelegate action:NSSelectorFromString(@"selectButtonDidTap:") forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _selectButtonItem;
}

-(UITabBar *)bottomBar
{
    if (_bottomBar == nil)
    {
        _bottomBar = [[UITabBar alloc]initWithFrame:CGRectMake(0, self.height - 44, self.width, 44)];
        _bottomBar.barStyle = UIBarStyleBlack;
        [_bottomBar setViewColor:[[UIColor blackColor] colorWithAlphaComponent:0.6]];
        
        [_bottomBar addSubview:self.highQualityControl];
        [_bottomBar addSubview:self.sendButton];
        [_bottomBar addSubview:self.numberOfLabel];
    }
    
    return _bottomBar;
}


-(UIControl *)highQualityControl
{
    if (_highQualityControl == nil)
    {
        _highQualityControl = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, 150, _bottomBar.height)];
        [_highQualityControl addSubview:self.hignSignImageView];
        [_highQualityControl addSubview:self.originPhotoLabel];
        [_highQualityControl addSubview:self.activityIndicatorView];
        [_highQualityControl addSubview:self.photoSizeLabel];
        
//        [_highQualityControl addTarget:_browerDelegate action:NSSelectorFromString(@"controlAction:") forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _highQualityControl;
}



-(UIImageView *)hignSignImageView
{
    if (_hignSignImageView == nil)
    {
        _hignSignImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 15, 15)];
        _hignSignImageView.center = CGPointMake(_hignSignImageView.center.x, _highQualityControl.center.y);
        _hignSignImageView.layer.cornerRadius = _hignSignImageView.bounds.size.width / 2.0f;
        _hignSignImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _hignSignImageView.layer.borderWidth = 1.0f;
    }
    
    return _hignSignImageView;
}


-(UILabel *)originPhotoLabel
{
    if (_originPhotoLabel == nil)
    {
        //计算字的大小
        NSAttributedString * constWord = [[NSAttributedString alloc]initWithString:@"原图:" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
        
        CGFloat width = [constWord boundingRectWithSize:CGSizeMake(100, 30) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.width;
        
        _originPhotoLabel = [[UILabel alloc]initWithFrame:CGRectMake(_hignSignImageView.maxX + 5, 0, width, 25)];
        _originPhotoLabel.center = CGPointMake(_originPhotoLabel.center.x, _highQualityControl.center.y);
        _originPhotoLabel.font = [UIFont systemFontOfSize:13];
//        _originPhotoLabel.textColor = self.deselectedColor;
        _originPhotoLabel.text = @"原图:";
        
    }
    
    return _originPhotoLabel;
}



-(UIActivityIndicatorView *)activityIndicatorView
{
    if (_activityIndicatorView == nil)
    {
        _activityIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _activityIndicatorView.frame = CGRectMake(_originPhotoLabel.maxX + 5, 0, 15, 15);
        _activityIndicatorView.center = CGPointMake(_activityIndicatorView.center.x, _highQualityControl.center.y);
        _activityIndicatorView.hidesWhenStopped = true;
    }
    
    return _activityIndicatorView;
}



-(UILabel *)photoSizeLabel
{
    if (_photoSizeLabel == nil)
    {
        _photoSizeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_originPhotoLabel.maxX + 5, 0, _highQualityControl.width - _photoSizeLabel.originX , 25)];
        _photoSizeLabel.center = CGPointMake(_photoSizeLabel.center.x, _highQualityControl.center.y);
        _photoSizeLabel.font = [UIFont systemFontOfSize:13];
//        _photoSizeLabel.textColor = self.deselectedColor;
        _photoSizeLabel.text = @"";
    }
    
    return _photoSizeLabel;
}

-(UIButton *)sendButton
{
    if (_sendButton == nil)
    {
        _sendButton = [[UIButton alloc]initWithFrame:CGRectMake(_bottomBar.width - 50 - 5, 0, 50, 40)];
        _sendButton.center = CGPointMake(_sendButton.center.x, _bottomBar.center.y - _bottomBar.originY);
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sendButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_sendButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
        
//        [_sendButton addTarget:self action:@selector(sendButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _sendButton;
}

-(UILabel *)numberOfLabel
{
    if (_numberOfLabel == nil)
    {
        _numberOfLabel = [[UILabel alloc]initWithFrame:CGRectMake(_sendButton.originX - 20, 0, 20, 20)];
        _numberOfLabel.center = CGPointMake(_numberOfLabel.center.x, _sendButton.center.y);
//        _numberOfLabel.backgroundColor = self.selectedColor;
        _numberOfLabel.textAlignment = NSTextAlignmentCenter;
        _numberOfLabel.font = [UIFont boldSystemFontOfSize:14];
        _numberOfLabel.text = @"8";
        _numberOfLabel.textColor = [UIColor whiteColor];
        _numberOfLabel.layer.cornerRadius = _numberOfLabel.width / 2.0;
        _numberOfLabel.clipsToBounds = true;
    }
    
    return _numberOfLabel;
}




-(id<RITLCollectionViewModel>)viewModel
{
    if (!_viewModel)
    {
        _viewModel = [RITLPhotoBrowerViewModel new];
    }
    
    return _viewModel;
}

@end