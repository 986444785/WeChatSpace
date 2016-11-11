

#import "GSKSpotyLikeHeaderView.h"
#import "UIImage+ImageEffects.h"
#import <Masonry/Masonry.h>

static const CGSize kUserImageSize = {.width = 64, .height = 64};

@interface GSKSpotyLikeHeaderView ()

@property (nonatomic) UIImageView *backgroundImageView;
@property (nonatomic) UIImageView *blurredBackgroundImageView;
@property (nonatomic) UIImageView *userImageView; // redondear y fondo blanco
@property (nonatomic) UILabel *title;

@property (nonatomic,strong) UILabel * nick_lanle;
@property (nonatomic,strong) UILabel * info_lable;

@end 

@implementation GSKSpotyLikeHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.minimumContentHeight = 64;
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
        [self setupViewConstraints];
    }
    return self;
} 

- (void)setupViews {
    self.backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"news_defualt"]];
//    self.backgroundImageView = [[UIImageView alloc]init];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.backgroundImageView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.backgroundImageView];


    //图片模糊效果

    UIImage * blurImage = [[UIImage imageNamed:@"news_defualt"] blurImage];

    self.blurredBackgroundImageView = [[UIImageView alloc] initWithImage:blurImage];
//    self.blurredBackgroundImageView = [[UIImageView alloc]init];
    self.blurredBackgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.blurredBackgroundImageView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.blurredBackgroundImageView];

    self.userImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"news_defualt"]];
//    self.userImageView = [[UIImageView alloc]init];
    self.userImageView.clipsToBounds = YES;
    self.userImageView.layer.cornerRadius = kUserImageSize.width / 2;
    self.userImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.userImageView.layer.borderWidth = 4;
    [self.contentView addSubview:self.userImageView];


    //昵称
    _nick_lanle = [UILabel new];
    _nick_lanle.textColor = [UIColor whiteColor];
    [self.contentView addSubview:_nick_lanle];
//    _nick_lanle.text = @"+叔叔我们不约+";


    self.title = [[UILabel alloc] init];
//    self.title.text = @"女·22岁·处女座·3.9km·1小时前";
    self.title.textColor = [UIColor whiteColor];
    self.title.font = [UIFont boldSystemFontOfSize:16];
    [self.contentView addSubview:self.title];


    self.info_lable = [UILabel new];
    [self.contentView addSubview:self.info_lable];
    self.info_lable.text = @"就羡慕你们这群人，年纪轻轻就认识才华横溢的我";
    self.info_lable.textColor = [UIColor whiteColor];
    self.info_lable.font = [UIFont systemFontOfSize:13];

}

/** 
 *  更新数据 
 */
-(void)updateHeadviewWithmodel:(NearDynamicModel *)model{
//    NSDictionary * userDic = dic[@"user"];

    self.nick_lanle.text = model.nickName;

//    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:model.avatarImage]];

    UIImage * image = [self.userImageView.image blurImage];

    self.blurredBackgroundImageView.image = image;

    self.backgroundImageView.image = self.userImageView.image;

    NSString * sex = [model.sex integerValue] == 1 ? @"男" : @"女" ;

    NSString * age = model.age;
    if (age.length>0) {
        age = [NSString stringWithFormat:@"·%@岁",age];
    }else{
        age = @"";
    }

    self.title.text = [NSString stringWithFormat:@"%@%@",sex,age];

    self.info_lable.text = model.signature;
}

-(void)updateHeadviewWithDic:(NSDictionary *)dic{

    NSDictionary * userDic = dic[@"user"];

    self.nick_lanle.text = userDic[@"nickname"];

//    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:userDic[@"avatar"]]];

    UIImage * image = [self.userImageView.image blurImage];

    self.blurredBackgroundImageView.image = image;

    self.backgroundImageView.image = self.userImageView.image;

    NSString * sex = [userDic[@"sex"] integerValue] == 1 ? @"男" : @"女" ;

    NSString * age = userDic[@"age"];
    if (age.length>0) {
        age = [NSString stringWithFormat:@"·%@岁",age];
    }else{
        age = @"";
    }

    self.title.text = [NSString stringWithFormat:@"%@%@",sex,age];

    self.info_lable.text = userDic[@"signature"];

}



- (void)setupViewConstraints {
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.width.equalTo(self.contentView.mas_width);
        make.height.equalTo(self.contentView.mas_height);
    }];

    [self.blurredBackgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.backgroundImageView);
    }];

    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.contentView.mas_centerY).offset(-10);
        make.width.equalTo(@(kUserImageSize.width));
        make.height.equalTo(@(kUserImageSize.height));
    }];


    [self.nick_lanle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.height.equalTo(@25);
        make.top.equalTo(self.contentView.mas_top).offset(30);

        make.width.lessThanOrEqualTo(self.contentView.mas_width).offset(-80);
    }];


    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.userImageView.mas_bottom).offset(10);
    }];

    [self.info_lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.title.mas_bottom).offset(10);
    }];

}

- (void)didChangeStretchFactor:(CGFloat)stretchFactor {
    CGFloat alpha = 1;
    CGFloat blurAlpha = 1;
    if (stretchFactor > 1) {
        alpha = CGFloatTranslateRange(stretchFactor, 1, 1.12, 1, 0);
        blurAlpha = alpha;
    } else if (stretchFactor < 0.8) {
        alpha = CGFloatTranslateRange(stretchFactor, 0.2, 0.8, 0, 1);
    }
    
    alpha = MAX(0, alpha);
    self.blurredBackgroundImageView.alpha = blurAlpha;
    self.userImageView.alpha = alpha;
    self.title.alpha = alpha;
    self.info_lable.alpha = alpha;
}



CGFloat CGFloatTranslateRange(CGFloat value, CGFloat oldMin, CGFloat oldMax, CGFloat newMin, CGFloat newMax) {
    CGFloat oldRange = oldMax - oldMin;
    CGFloat newRange = newMax - newMin;
    return (value - oldMin) * newRange / oldRange + newMin;
}

@end
