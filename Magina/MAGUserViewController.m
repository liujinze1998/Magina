//
//  MAGUserViewController.m
//  Magina
//
//  Created by liujinze on 2020/10/26.
//

#import "MAGUserViewController.h"
#import <Masonry.h>
#import "MyHeader.h"
#import "EditViewController.h"
#import "People.h"

@interface MAGUserViewController ()

@end

@implementation MAGUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    self.ImaName = @"touxiang.jpeg";
    People* peo = [People SharedInstance];
    self.num = peo.like;
}

- (void)editButTouchup{
    EditViewController* editVC = [[EditViewController alloc]init];
    [self.navigationController pushViewController:editVC animated:YES];
}



- (void)worksButTouch{
    self.ImaName = @"work.jpeg";
    NSLog(@"点击works按钮");
    People* peo = [People SharedInstance];
    self.num = peo.works;
    [self.collectionView reloadData];
}

- (void)likeButTouch{
    self.ImaName = @"touxiang.jpeg";
    NSLog(@"点击like按钮");
    People* peo = [People SharedInstance];
    self.num = peo.like;
    [self.collectionView reloadData];
}

- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        flowLayout.headerReferenceSize = CGSizeMake(375,448 );//头部大小
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 375, 448+170) collectionViewLayout:flowLayout];
        
        //定义每个UICollectionView 的大小
        flowLayout.itemSize = CGSizeMake(124,168);
        //注册cell和ReusableView（相当于头部）
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
        
        //设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        //定义每个UICollectionView 横向的间距
        flowLayout.minimumLineSpacing = 1.5;
        //定义每个UICollectionView 纵向的间距
        flowLayout.minimumInteritemSpacing = 0;
        //定义每个UICollectionView 的边距距
        //flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 5, 5);//上左下右
        //背景颜色
        _collectionView.backgroundColor = [UIColor whiteColor];
        //自适应大小
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _collectionView;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.num;
}

#pragma mark 定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark 每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"cell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    UIImageView* imaView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:self.ImaName]];
    //imaView.frame = [self test:imaView.frame.size ima2Size:cell.frame.size];
    imaView.frame= CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
    imaView.contentMode = UIViewContentModeScaleAspectFit;
    cell.backgroundColor = [UIColor blackColor];
    [cell addSubview: imaView];
    
    // Configure the cell
    
    return cell;
}

- (CGRect)test:(CGSize) ima1 ima2Size:(CGSize) ima2{
    CGRect ret;
    float fIma1 = ima1.width/ima1.height;
    float fIma2 = ima2.width/ima2.height;
    if(fIma1>fIma2){
        float newWidth = ima2.width;
        float newHei = ima1.height*ima2.width/ima1.width;
        ret = CGRectMake(0, ima2.height/2-newHei/2, newWidth, newHei);
    }
    else{
        float newWidth = ima1.width*ima2.height/ima1.height;
        float newHer = ima2.height;
        ret = CGRectMake(ima2.width/2-newWidth/2, 0, newWidth, newHer);
    }
    return ret;
}

#pragma mark 头部显示的内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                                            UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
    MyHeader* header = [[MyHeader alloc]init];
    headerView.backgroundColor =[UIColor blackColor];
    header.fatherView =self.view;
    [headerView addSubview:header.view];
    //编辑资料
    UIButton* but = [[UIButton alloc]init];
    [headerView addSubview:but];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView.mas_left).with.offset(130);
        make.top.equalTo(headerView.mas_top).with.offset(140);
        make.size.mas_equalTo(CGSizeMake(156, 40));
    }];
    [but setTitle:@"编辑资料" forState:UIControlStateNormal];
    but.backgroundColor = [UIColor grayColor];
    [but addTarget:self action:@selector(editButTouchup) forControlEvents:UIControlEventTouchUpInside];
    //three btn
    People* peo = [People SharedInstance];
    UIButton* btn1 = [[UIButton alloc]init];
    [headerView addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView.mas_left).with.offset(16);
        make.top.equalTo(headerView.mas_top).with.offset(408);
        make.size.mas_equalTo(CGSizeMake(114, 40));
        
    }];
    [btn1 setTitle:[[NSString alloc]initWithFormat:@"作品%ld",peo.works] forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor blackColor];
    [btn1 addTarget:self action:@selector(worksButTouch) forControlEvents:UIControlEventTouchUpInside];
    btn1.adjustsImageWhenHighlighted=YES;
    btn1.showsTouchWhenHighlighted=YES;
    UIButton* btn2 = [[UIButton alloc]init];
    [headerView addSubview:btn2];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView.mas_left).with.offset(130);
        make.top.equalTo(headerView.mas_top).with.offset(408);
        make.size.mas_equalTo(CGSizeMake(114, 40));
        
    }];
    [btn2 setTitle:[[NSString alloc]initWithFormat:@"动态%ld",peo.dyna] forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor blackColor];
    UIButton* btn3 = [[UIButton alloc]init];
    [headerView addSubview:btn3];
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView.mas_left).with.offset(244);
        make.top.equalTo(headerView.mas_top).with.offset(408);
        make.size.mas_equalTo(CGSizeMake(114, 40));
        
    }];
    [btn3 setTitle:[[NSString alloc]initWithFormat:@"喜欢%ld",peo.like] forState:UIControlStateNormal];
    btn3.backgroundColor = [UIColor blackColor];
    [btn3 addTarget:self action:@selector(likeButTouch) forControlEvents:UIControlEventTouchUpInside];
    btn3.adjustsImageWhenHighlighted=YES;
    btn3.showsTouchWhenHighlighted=YES;
    return headerView;
}

- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"hello world");
    [self.collectionView reloadData];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
