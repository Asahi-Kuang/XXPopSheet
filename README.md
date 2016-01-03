# README
####弹出泡泡窗口。
#####点击按钮，弹出可选择弹窗。并可以进行页面跳转。

#####Author:Asahi-Kuang 
####E-mail:[asahikuang@yahoo.com](asahikuang@yahoo.com)
####[个人博客](http://asahi-kuang.github.io/MyBlog_MWeb/archives.html)

###Usage
--
1. 导入`XXPopSheetView`文件夹到工程。里面包含了`ArrayDataSource.h/.m`、`Defines.h`、`XXPopSheetView.h/.m`、`down@2x.png`、`up@2x.png`。
2. 导入头文件`XXPopSheetView.h`。
3. 定义全局变量```@property (nonatomic, strong)XXPopSheetView *pop;```
4. 在需要弹出的方法里完成代码```
	 _pop = [[XXPopSheetView alloc] initWithFrame:button.frame];
    NSArray *titles = @[@"title 1", @"title 2", @"title 3"];
    NSArray *images = @[@"image1", @"image2", @"image3"];
    FirstViewController *fVC = [[FirstViewController alloc] init];
    SecondViewController *sVC = [[SecondViewController alloc] init];
    ThirdViewController *tVC = [[ThirdViewController alloc] init];
    [_pop setTitles:titles];
    [_pop setImages:images];
    [_pop setViewControllers:@[fVC, sVC, tVC]];
    [_pop setPopViewWidth:180 andHeight:220];
    

ps. `titles`是表格显示的标题。`images`是cell图片。`setViewControllers:@[fVC, sVC, tVC]`是需要跳转的控制器数组(三个)。`setPopViewWidth:180 andHeight:220`设置泡泡的宽高。

截图：
![pic url](http://a4.qpic.cn/psb?/V106iJhq3r5pvo/85S6e7NquU0PVaHadgdSwNzJKrfkdVH0N2U3xY9Voww!/b/dFsBAAAAAAAA&bo=1AEvA9QBLwMCCS0!&rf=photoDetail)


