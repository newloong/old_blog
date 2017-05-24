---
title: 论PHP框架是如何诞生的?
date: 2017-05-23
updated: 2017-05-25
categories:
 - php
---

你好，我是“老周”，这是新博客的开篇文章，如果我从没有学习过`PHP`开发，但是我会一些`HTML`和`CSS`，我听说过一些`PHP`框架，但是我却没有使用过这些框架，我该怎么进入`PHP`开发者的行列呢？还有为什么学习了原生的`PHP`，我还要去学习那些框架呢？这些框架究竟有什么好处？为什么会产生框架？我最初学习`PHP`的时候上面的问题都想过，纠结啊！这篇文章应该会比较长，我打算从`PHP`的基础开始罗列，做一个简单的页面，然后慢慢演化成框架！嗯，这样会把框架是如何诞生的这个问题给理清，对于今后学习框架会有好处！

<!--more-->

## 安装PHP运行环境

再这之前还有一个非常重要的问题要想清楚，你真的决定要做程序员了？还没有想好是吧，赶紧关了页面吧！如果你还有其它的路可走，那就不要进入这行了，俗话说"好男不当兵，有出路就不做程序员！"，嗨，老铁！ 如果还有出路，就别做程序员了。

`PHP`是一个脚本语言，要运行一段`PHP`的脚本，需要安装PHP解析器，如果你使用的是`Windows`操作系统， 那么自己搜索下安装方法，如果你使用的是`Mac`系统，我们可以通过`Homebrew`来安装。

`Mac`系统自带了版本为 5.6 的`PHP`，可以打开`终端(Terminal)` 输入命令 `php -v` 查看

```bash
$ php -v

PHP 5.6.30 (cli) (built: Feb  7 2017 16:06:52) 
Copyright (c) 1997-2016 The PHP Group
Zend Engine v2.6.0, Copyright (c) 1998-2016 Zend Technologies
```

这个版本会比较老，截止到我写这篇文章的时候(2017-5-23)已经是`PHP 7.15`了，我们通过`Homebrew`来安装新的版本,首先安装`Homebrew`。

### 在 Mac 系统使用 Homebrew 安装 PHP

首先安装`Homebrew`, 一个`Mac`上的包管理工具，可以进入 Homebrew 的官网： [https://brew.sh/](https://brew.sh) 查看安装方法，很简单，就一句命令:

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

安装完后，我们就可以使用了，通常我们要安装一个软件，可能会不知道软件名，所以可以通过`brew search 软件名`搜索，如下：

```bash
$ brew search php
```

搜索后，会列出一堆和`php`相关的软件，我们找到我们需要的，然后通过`brew install 软件名` 来安装, 如安装`php 7.0`版本

```bash
$ brew install homebrew/php/php70
```

### 安装集成的供新手用的 PHP 运行环境

网络上有很多集成了`Apache, Nginx, Mysql, PHP`的运行环境，下面罗列下，你目前可以使用它们，不过以后你会摒弃它们的，因为现在用的比较多的还是`Homestead`和`Valet`,这两个以后再谈，现在不用关心它们。下面的软件尝试去安装一个吧，下面的内容需要使用`Mysql`，所有自行安装吧。

> - ** MAMP ** - http://www.mamp.info 它提供`Mac`和`Windows` 两个版本。
> - ** WampServer**  - http://www.wampserver.com 它提供`Windows`版本。
> - ** XAMPP**  - https://www.apachefriends.org 它提供`Mac`, `Windows`和`Linux`版本。
> - ** 自己折腾MNMP ** - http://blog.zhoujiping.com/notes/mnmp.html 想自己配置，看我这篇文章，目前不建议配

## 选择一个适合你的编辑器

在开写代码之前，我们需要找一款适合自己的代码编辑器或者是IDE集成开发环境，网上有人说自己喜欢使用记事本来写代码，这纯粹就是“二逼青年找存在感”，就像给你一把铁斧去砍树，你却一定要用石锛, 何苦要做用树叶盖住了屁股却盖不住蛋蛋的原始人呢！

现在的代码编辑器众多，很多编辑器也都能安装自己喜欢的主题，众多的编辑器也导致了大家的评选，这完全没有必要，它只是一个编辑器或者是一个集成开发环境而已，没有必要去争论它，用任何一个都不会提升你的逼格，选择一款你喜欢的即可。为什么这也要唠叨，因为曾经我就深深的陷入选择编辑器还是`IDE`而不能自拔。

我目前无论是写`PHP`项目，写前端，还是写博客，都是采用`Sublime text`这款编辑器, 官方网站是：https://www.sublimetext.com/ 支持`Windows, Mac, Linux`, 它是一款收费软件， 但是不付钱也可以终身使用，只不过隔半小时会提示你付钱。

另外你也可以使用`Atom`, 官网是： https://atom.io/ ，或者你也可以使用`PhpStorm`, 这是一款 IDE， 官网是： http://www.jetbrains.com/phpstorm/ 自己选择一个安装好即可。如果你喜欢用`Sublime Text`这块编辑器，以后也可以看下我写的这篇文章

> [让代码编辑神器Sublime Text 3 更好的为我们工作 - Sublime Text 3使用小教程](http://blog.zhoujiping.com/tooling/sublime.html)

##  在命令行输出 “Hello World”

先打开终端，执行下面的操作, 注意 `$` 这个符号是代表下面的命令是在终端下操作，不要当作命令执行了。

```bash
    $ cd                    # 切换到当前用户的主目录
    $ mkdir php-learning    # 建立 php-learning 文件夹
    $ cd php-learning       # 进入 php-learning 文件夹
    $ touch index.php       # 建立 index.php 文件
    $ subl index.php        # 使用 Sublime Text 打开 index.php 文件
                            # 如果你不是用 brew 安装的 Sublime Text, 可能无法执行 subl 命令
                            # 那就自己手动打开 Sublime Text 即可。
```

在 `index.php` 输入下面的代码

```php
    <?php

    echo 'Hello World';
```

上面的`<?php` 是 php 脚本的标记符，代表这是一个 php 文件,  `echo` 是 php 的一个语法操作符，打印和输出的意思，`Hello World` 被包含在单引号中，代表它是一个字符串，也可以使用双引号包含它。 使用单引号或是双引号有一定的区别，这个以后再讨论，最后的分号是代表一句代码的结束，不写会报错。
我们在终端执行 `php index.php`, 就能得到被解析后的结果。

```bash
$ php index.php

Hello World%
```

如果去掉 `index.php` 中的 `<?php` 标识符，php 代码就不会被解析，会被当作字符串输出，自己测试下。也可以尝试不写分号或者是单引号，运行一下代码，看看出错信息都提示了什么。要养成看出错提示（以后看日志）的好习惯，不能一出错就拷贝错误信息去搜索找答案，这样不好。

## 在浏览器中输出 "Hello World"

在终端输入 `php -h`， 会列出 `php` 这个命令的用法， 同理在终端要使用其他命令的时候，都可以使用 `命令 -h`
或者是 `命令 --help` 来查看这个命令大致的用法。 回头来看 `php -h` 的输出信息，会发现下面这样一条

```bash
-S <addr>:<port> Run with built-in web server.
```
这句英文的意思是： 启动内置的Web服务器，`<addr>` 是地址，`<port>` 是端口，以后会学习`Linux`， 那时候再了解它们吧！我们可以这么跑

```bash
$ php -S localhost:8888

PHP 7.0.18 Development Server started at Tue May 23 23:01:26 2017
Listening on http://localhost:8888
Document root is /Users/zhoujiping/Code/php-learning
Press Ctrl-C to quit.
```
自己看下提示信息，好像会明白点什么，现在在浏览器输入 http://localhost:8888 就能看见输出的 Hello World 了。

## PHP 的变量

什么是变量？ 为什么需要变量？ 先不考虑这个问题，先来看下变量怎么用， 下面是 `index.php` 改写过的代码。

```php
    <?php
    
    $greenting = 'Hello World';

    echo $greenting;
```

上面的 `$greenting` 就是一个变量，它可以用来存储数据，它必须以`$`开头，后面你可以随便取个英文名字，在`php`的变量命名规则中，说到变量不能以数字开头，只能包含数字、字符和下划线等，变量会区分大小写之类的规则，这些不用去刻意去记，比如说，你命名个变量使用数字开头的，如 `$8hello`, 怎么看都会别扭不是，按照下面的方式去写就可以，一看就记住。

> - 使用英文去命名你的变量，不要用拼音;
> - 变量包含两个及以上的英文单词，第二个开始的英文单词首字母大写，如： $studentName 这个命名方法就是传说的小驼峰命名法;
> - 不要贪图简短，变量名需要有描述意义，因为代码的可读性非常重要;
> - 如果变量存储多个数据，需要使用复数形式;

上面的代码运行后会出现相同的结果， 但是这样貌似还不能体现变量的作用，我们再改写下

```php
    <?php

        $name = '周继平';

        echo 'Hello，' . $name;
```

上面代码中的点号 `.`  它是一个操作符，是用来连接 php 的字符串的，运行下代码，看下输出就明白这个点号的作用了。

> 像 `echo 'Hello，' . $name;` 这句代码，你也可以这些写 `echo "Hello, $name";`双引号会解析当中的变量 `$name`，虽然执行效率会慢一点点点，但是这点慢可以忽略不计，你依然可以用双引号的写法。你还可以写的更可读一点，像这样 `echo "Hello, {$name}";`。

对于`$name = '周继平';` 这句代码，`周继平`是变量`$name`的值， 这个值是会变动的，比如我想输出 `Hello, 张三`,我们只需要将`$name`的值设置为张三即可，而`张三`这个值，我们可能会从前端传来，也可能从数据库中查询出来，所以有了变量，我们就可以在不改变代码的前提下，得到不同的值。还不明白，没有关系，继续往下看。

## 将 PHP 代码嵌入 HTML 中

可以说 PHP 这门语言就是用来开发 Web 应用的， 它能很好的嵌入到 HTML 中（先不要探讨前后端分离）, 我们改写 `index.php`的代码如下:
```php
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>将PHP代码嵌入到HTML中</title>
    <style>
        header {
            background-color: #f5f8fc;
            padding: 2em;
            text-align: center;
        }
    </style>
</head>
<body>
    
    <header>
        <h1>
            <?php

                $name = '周继平';
                
                echo "Hello, {$name}";

                // 注意下面这个php代码结束标识符，忘写会报错
            ?> 
        </h1>
    </header>

</body>
</html>
```

首先注意上面代码中的 `?>` 标识符，当把 php 代码嵌入到 html 中， php 解析器需要知道 php 代码是从哪里开始到哪里结束的，所以必须书写 `?>` 这个结束标识符， 而如果一个文件中只有纯粹的 php 代码，那就不要书写`?>`结束标识符，当然你在纯 php 文件中书写上`?>`是不会报错的，但是请不要这么做，我们得遵循前人总结的一些规矩，目前大家都在遵守的规矩一般出自 “PSR 规范” （PHP Standards Recommendation）， 我们运行一下上面的代码，结果如下：

![php嵌入html](/images/php/step_1/1.jpg)

通常我们看见的网址是这样的：

``` html
localhost:8888?key=value&order=asc
```
这里的`key=value` 或者是 `order=asc` 我们叫做`键值对`，所谓的键：就是你存的值的编号，而值：就是你存放的数据，我们可以通过上面这种方式将值传递给服务器，这些值会被保存在 PHP 提供的全局变量 `$_GET` 中, 我们更改下 `<header>` 标签内的代码

```php
<header>
    <h1>
        <?php
            var_dump($_GET);
            // $name = '周继平';

            // echo "Hello, {$name}";
        ?> 
    </h1>
</header>
```

上面的 `//` 是 php 语言的单行注释， `//` 之后的代码都不会被执行， `var_dump()` 是 php 提供的内置函数，这个函数可以打印出变量的类型和值。

访问： http://localhost:8888/?name=周继平  输出如下：

> array(1) { ["name"]=> string(9) "周继平" }

`array` 代表数组类型， `string` 代表字符串类型， `name` 为健，`周继平` 为值。现在我们就可以把代码改的实用点

```php
<header>
    <h1>
        <?php
            $name = $_GET['name']; // 获取健(key) 为 name 的值

            echo "Hello, {$name}";
        ?> 
    </h1>
</header>
```
现在我们访问 http://localhost:8888/?name=周继平 只要更换掉 `name` 所对应的值，页面上就会打印出你传递的值。

![get方式传递值](/images/php/step_1/2.jpg)

我们将上面的代码再更改的精简点：

```php
<header>
    <h1>
        <?php echo 'Hello, ' . $_GET["name"]; ?>
    </h1>
</header>
```
像这样的代码 `<?php echo 'Hello, ' . $_GET["name"]; ?>` 可以用`<?=` 来代替
`<?php echo`, 再来精简下代码

```php
<header>
    <h1>
        <?= 'Hello, ' . $_GET["name"]; ?> 
    </h1>
</header>
```

## 触摸一下 PHP 安全问题

现在我们可以随意的设置`name`的值了，但是用户可能会像下面这样输入:

```html
http://localhost:8888/?name=<a%20href="http://blog.zhoujiping.com">周继平的老博客</a>
```
这时候接受的值是一串 html 代码，如果后端不经过处理， 浏览器就会解析它，就会出现这样的情况

![代码注入](/images/php/step_1/3.jpg)

上面的`a`标签就会被解析，然后将结果显示在页面，当然仅仅针对目前这个案例，用户即使输入了也只会显示在自己的电脑上，所以并没有什么影响，但是如果我们以后深入的再探讨下，那么问题就会出来了，通过这里我们要知道的是传递给后端的值一定要做验证，这也是为什么很多框架都会有中间件这一层的原因,我们把代码改的稍微安全点，很简单，加一个`htmlspecialchars()`函数即可,关于函数以后再讨论。

```php
<header>
    <h1>
        <?php echo 'Hello, ' . htmlspecialchars($_GET["name"]); ?>
    </h1>
</header>
```
现在再访问刚才的网址， 输出就会变成

```
 Hello, <a href="http://blog.zhoujiping.com">周继平的老博客</a>
 ```

## PHP 显示和逻辑相分离

将 php 代码嵌入到 html 中， 我们就可以在页面中编写任何逻辑代码，比如整个变量，连接数据库，查询数据，验证数据，输出数据等等，如果把所有的东西都放在这个页面中，那在开发和维护上都会非常的痛苦，所以我们需要将它们拆分开来。让每个文件内做最小的事，很多的 php 框架就是这么干的。

比如我们之前写的 `index.php`, 我们就可以将它拆分，我们新建一个 `index.view.php` 的文件，将 html 的代码都放在这里

```php
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>index.view.php</title>
    <style>
        header {
            background-color: #f5f8fc;
            padding: 2em;
            text-align: center;
        }
    </style>
</head>
<body>
    
    <header>
        <h1>
            <!-- 这里只输出变量 -->
            Hello, <?=$name; ?>  
        </h1>
    </header>

</body>
</html>
```

将 `index.php` 改写为

```php
<?php 

    $name = '周继平';

    require 'index.view.php';
```

当 `index.php` 被运行时，会通过 `require` 将 `index.view.php` 包含进来， 所以当我们访问： http://localhost:8888/index.php  会得到相同的结果。 这就是最简陋的视图和逻辑分离。

## 索引数组

如果出现这样一个情况，我们需要输出几个人的名字，如果按照之前的做法我们会这么写：

```php
    // 在 index.php 中定义变量
    $nameOne = '周继平'; 
    $nameTwo = 'Zhou Jiping';
    $nameThree = 'Kuker Chou';

    // 在 index.view.php 中输出
    <header>
        <ul>
            <li>Hello, <?=$nameOne; ?></li>
            <li>Hello, <?=$nameTwo; ?></li>
            <li>Hello, <?=$nameThree; ?></li>
        </ul>
    </header>
```

这么写没有问题，程序可以跑通，但是不方便管理，检索和数据处理了，所以这时候我们需要数组来帮助我们，在现代 php 中，数组使用一对中括号 `[]` 来定义, 如：
```php
    $names = []; // 定义一个变量名为 $names 的空数组
```
如此，`index.php` 中的用三个变量来存储名字的代码就可以使用数组来做：

```php
    $names = [
        '周继平', 
        'Zhou Jiping',
        'Kuker Chou'
    ];
```

`$names` 就是一个索引数组，索引数组的每个元素都有个下标，从`0`开始，如通过 `$names[0]` 即可获得第一个元素的值，如果要遍历数组的值， 可以使用 `foreach` 语句， `foreach` 会从数组的第一个元素开始遍历至最后一个元素。`index.view.php` 中改写如下：

```php
    <header>
        <ul>
            <?php
                foreach ($names as $name) {
                    echo "<li>Hello, {$name}</li>";
                }
            ?>
        </ul>
    </header>
```

这样改写程序还是能够跑通， 不过像 `index.view.php` 中我们使用 `{ }` 会让代码看起来比较的凌乱，尤其是当双引号中的 html 标签变多的时候，这时候对于 `echo` 和控制结构（类式 `foreach`, `if`, `while`）的语句我们可以使用替代语法，`echo` 的替代语法我们已经用过了，如下：

```php
<?php echo $variable; ?>
// 可替代为
<?= $variable; ?>
```
而像上面的 `foreach` 语句可以这样替代

```php
    <header>
        <ul>
            <!-- 开始的 { 用 : 替代 -->
            <?php foreach ($names as $name) : ?> 
                 <li>Hello, <?= $name ?></li>
            <?php endforeach; ?>
            <!-- 结束的 } 用 endforeach 替代; -->
        </ul>
    </header>
```

如果你曾经用过一些模版引擎，是不是发现这样的书写已经有点它们的影子存在了。

> 关于更多的替代语法，请查阅这里 http://codeigniter.org.cn/user_guide/general/alternative_php.html

## 关联数组

上面我们说到索引数组，它可以包含一系列的元素，如果出现这样一个情况，我们将一个人的名字，年龄，肤色保存在一个数组中，如果使用索引数组，那么是这样的：

```php
$person = [
    '周继平',
    3,
    '狗屎色'
];
```
虽然用数组保存了这些元素，但是我们不知道这些元素究竟代表什么，如果我们可以将每个元素都设置一个 `key` , 那就会清楚很多，如下：

```php
$person = [
    'name' => '周继平',
    'age'  => 3,
    'skin_color' => '狗屎色'
];
```

想上面这样的数组就是关联数组，通过 `key => value` 的形式来定义一个元素, 如果想获取具体的元素的值，可以像 `$person['name']` 这样来获得，也可以通过 `foreach($array as $value)` 或是 `foreach($array as $key => $value)` 语句循环的操作它们, 请将 `index.php` 中的数组改成上面的关联数组，然后在 `index.view.php` 中我们这样输出：

```php
    <header>
        <ul>
            <?php foreach ($person as $key => $value) : ?>
                 <li><strong><?= $key; ?></strong>: <?= $value ?></li>
            <?php endforeach; ?>
        </ul>
    </header>
```

## 简单的调试

我们可以用 `echo` 输出字符串，但是不能输出一个数组的所有值，可以使用 `print`, 或者使用 `var_dump()` 函数，
我们经常会使用 `var_dump()` 来查看一个变量中具体有哪些值及其类型，如我们可以在 `index.php` 中 `$person` 数组下加上 `var_dump($person)` 这句代码来查看 `$person` 的值, 但是会发现`index.view.php`中的内容也输出了，这时候我们可以在其下在加上一句 `die()` 函数，让程序执行到这里结束，通过这两个函数就可以进行断点调试了
，如下：
```php
var_dump($person);
die();

// 或者这么写
die(var_dump($person));
```

## 布尔值和条件判断语句

在任何时候，人类都需要做出选择，写程序也一样，在 PHP 中有一种值的类型叫做布尔型`（Bollean）`, 它只有两个值 `true` 和 `false`, 它通常和判断语句 `if--else`一起使用。自己体会下就会明白，判断语句的语法结构如下:

```php
if (true) {
    // 
} elseif () {
    //
} else {
   //
}
```

## 函数

我们之前接触的`var_dump()` 这种就是函数，函数的定义如下：

```php
    function name($argment1, $argment2, ...) 
    {
        // code
    }
```
`function` 是 php 的一个关键字，代表你想定义一个函数， `name` 是你自己定义的一个名字，命名规则也是用小驼峰法，`$argment1, $argment2` 这些是函数的参数，其实就是变量，当你调用函数的时候，写上对应的值即可。

我们将刚才用语断点测试的代码写成一个函数，然后调用它，你就会明白怎么定义和调用函数了，首先要在与 `index.php` 同级目录下建立一个 `functions.php` 的文件，专门用来存放我们写的函数, 然后写上我们的断点调试函数，我们取名为 `dd`,
`dumper and die` 的意思。

```php
// functions.php
<?php

    function dd($data)
    {
        echo '<pre>';
        die(var_dump($data));
        echo '</pre>';
    }

```
我们在 `index.php` 中引入 `functions.php`, 并调用 `dd()` 函数

```php
<?php 

require 'functions.php';

$person = [
    'name' => '周继平',
    'age'  => 3,
    'skin_color' => '狗屎色'
];

dd($person);

require 'index.view.php';
```

上面是 PHP 最基础的部分，每一部分都是点到而已，但是这已经够了，你在学习的是一门计算机的语言，和学英语是一样的道理，重要的在于实践，往往很多时候我们无法动手做的原因在于对整个流程不清楚，你知道了一些基础和流程，就可以通过 google, github, stackoverflow, 还有 php 的官方文档来开启和深入你的 php 生涯了，实践很重要，尤其是语言，像我读大学的时候英语一直很差，后来自己开办了个老外学普通话的机构，说的多了，写的多了，自然而然的英文水平就提高了些。

当然，当你已经开发了几个项目后，你就得回头来系统的补下基础了，这个基础包括计算机系统原理，算法和数据结构，C语言等。

有了上面的基础了，下面我们开始接触下mysql, php 的面向对象，然后开始谈下框架的演变过程。

## 接触 Mysql

未完 。。。





























