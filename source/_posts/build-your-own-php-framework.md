---
title: 论PHP框架是如何诞生的?
date: 2017-05-23
updated: 2017-06-01
categories:
 - php
---
> 提前说明： 本博客不支持响应式，不支持 IE, 请使用标准浏览器打开。

你好，我是“老周”，这是新博客的开篇文章，也是“PHP 相关知识技能整理系列” 的第一章，这一章的内容主要是先使用原生的PHP开发出一些简单的页面， 然后将这些页面一步一步的，经过多次重构，最终演变成一个简单的PHP MVC 框架，我们会借鉴 `Laravel` 框架的用法及其思想来慢慢完成我们自己的这个小框架。为什么要借用 `Laravel` 框架的思想，这里就不去做推销了，单凭它是全世界 PHP 开发人员使用最多的一款框架，就值得我们去研究和借鉴了。

自己写一个框架的目的并不是为了使用它，只是为了让我们能更清楚的了解和使用其他框架，为更好的学习和使用框架打下一个扎实的基础。

## 本文章适合的人群

> 虽然这个博客上的文章都是老周自己学习整理使用，但是不免会被老铁们看见，这篇文章针对有一定的 PHP 基础的人员。对于没有 PHP 基础的老铁们可能需要多看几遍，一些欠缺的知识点需要通过 Google 去搜索查阅。

## 安装PHP运行环境

`PHP`是一种脚本语言，要运行一段`PHP`的脚本，需要通过 PHP 解析器去解析它，如果你使用的是`Windows`操作系统， 那么请自己搜索下安装方法，如果你使用的是`Mac`系统，我们可以通过`Homebrew`来安装。

`Mac OS` 系统自带了版本为 5.6 的`PHP`，可以打开`终端(Terminal)` 输入命令 `php -v` 查看

```bash

    $ php -v

    PHP 5.6.30 (cli) (built: Feb  7 2017 16:06:52) 
    Copyright (c) 1997-2016 The PHP Group
    Zend Engine v2.6.0, Copyright (c) 1998-2016 Zend Technologies
```

这个版本会比较老，截止到我写这篇文章的时候(2017-06-01)已经是`PHP 7.15`版本了，我们通过`Homebrew`来安装新的版本,首先安装`Homebrew`。

### 在 Mac 系统使用 Homebrew 安装 PHP

首先安装`Homebrew`, 它是一个`Mac OS`上的包管理工具，类式于`centos` 下的`yum`工具，`ubuntu`下的`apt-get`工具。

可以进入 `Homebrew` 的官网： [https://brew.sh/](https://brew.sh) 查看具体的安装和使用方法，安装很简单，就一句命令:

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

安装完 `Homebrew` 后，我们就可以使用它来安装我们需要的其他软件了。通常我们要安装一个软件，可能会不知道具体的软件名，我们可以通过`brew search 大致的软件名`搜索，如我们要安装 `PHP`, 我们可以使用`brew search php` 来搜索与`PHP`相关的软件，如下：

```bash
$ brew search php
```

搜索后，会列出一堆和`php`相关的软件，我们找到我们需要的，然后通过`brew install 软件名` 来安装, 如安装`php 7.0`版本

```bash
$ brew install homebrew/php/php70
```

安装完毕后， 通过`php -v`来查看目前的 `php` 版本是不是 `7.0`, 如果不是， 那么你需要修改系统的环境变量，这一步自己 `Google`。

### 安装集成的 PHP 开发运行环境

网上有很多集成了`Apache, Nginx, Mysql, PHP`的运行环境，我们罗列下：

> - ** Homestead ** - https://laravel.com/docs/5.4/homestead 一个预封装的`Vagrant box`，`Mac OS`和`Windows`都可以用，推荐使用。
> - ** Valet ** - https://laravel.com/docs/5.4/valet 专为 `Mac` 提供的极简主义开发环境,推荐使用。
> - ** MAMP ** - http://www.mamp.info 它提供`Mac`和`Windows` 两个版本，新手用
> - ** WampServer**  - http://www.wampserver.com 它提供`Windows`版本，新手用
> - ** XAMPP**  - https://www.apachefriends.org 它提供`Mac`, `Windows`和`Linux`版本，新手用
> - ** 自己折腾MNMP ** - http://blog.zhoujiping.com/notes/mnmp.html 会搭建出来就行，不推荐用。

## 选择一个适合你的编辑器

在开写代码之前，我们需要找一款适合自己的代码编辑器或者是IDE集成开发环境，网上有人说自己喜欢使用记事本来写代码，这纯粹就是“二逼青年找存在感”，就像给你一把铁斧去砍树，你却一定要用石锛, 何苦要做用树叶盖住了屁股却盖不住蛋蛋的原始人呢！

现在的编辑器和`IDE`众多，不要去争论谁好谁坏， 没有意义， 都可以去用一下，喜欢哪个用哪个，但同一公司内最好需要能统一开发环境。

我目前无论是写`PHP`项目，写前端，还是写博客，都是采用`Sublime text`这款编辑器, 官方网站是：https://www.sublimetext.com/ 支持`Windows, Mac, Linux`, 它是一款收费软件， 但是不付钱也可以终身使用，只不过隔半小时会提示你付钱。

另外你也可以使用`Atom`, 官网是： https://atom.io/ ，或者你也可以使用`PhpStorm`, 这是一款 IDE， 官网是： http://www.jetbrains.com/phpstorm/ 自己选择一个安装好即可。如果你喜欢用`Sublime Text`这块编辑器，以后也可以看下我写的这篇文章

> [让代码编辑神器Sublime Text 3 更好的为我们工作 - Sublime Text 3使用小教程](http://blog.zhoujiping.com/tooling/sublime.html)

##  开始我们的第一行代码

我们先建立一个文件夹来放置我们的接下来要开发的项目文件，先打开终端，执行下面的操作, 注意 `$` 这个符号是代表下面的命令是在终端下操作，不要当作命令执行了。

```bash

    $ cd                    # 切换到当前用户的主目录
    $ mkdir php-learning    # 建立 php-learning 文件夹
    $ cd php-learning       # 进入 php-learning 文件夹
    $ touch index.php       # 建立 index.php 文件
    $ subl index.php        # 使用 Sublime Text 打开 index.php 文件，通过 Homebrew 安装的 sublime 会有这个命令
```

在 `index.php` 输入下面的代码

```php

    <?php

    echo 'Hello World';
```

PHP 文件或者其代码都是以`<?php 或 <?=` 开头， 以`?>` 结尾。但根据`PSR-1`（PSR 是PHP标准规范）规定，纯 PHP 文件必须省略最后的结束标签`?>`。

我们可以通过两种方式来访问 `PHP` 的运行结果，它们分别是“命令行模式”和“浏览器模式”。

### 在命令行输出 "Hello World"

在命令行模式下，我们在终端执行 `php index.php`, 就能得到被解析后的结果。

```bash

    $ php index.php

    Hello World%
```

如果去掉 `index.php` 中的 `<?php` 开始标识符，`PHP` 代码就不会被解析，会被当作字符串输出，也可以尝试不写分号或者是单引号，运行一下代码，看看出错信息都提示了什么。要养成看出错提示（以后看日志）的好习惯，不能一出错就拷贝错误信息去搜索找答案，这样不好。

### 在浏览器中输出 "Hello World"

在终端输入 `php -h`， 会列出 `php` 这个命令的用法， 同理在终端要使用其他命令的时候，都可以使用 `命令 -h`
或者是 `命令 --help` 来查看这个命令大致的用法。 回头来看 `php -h` 的输出信息，会发现下面这样一条:

```bash

    -S <addr>:<port> Run with built-in web server.
```

这句英文的意思是： 启动内置的Web服务器，`<addr>` 是地址，`<port>` 是端口，我们来尝试下:

```bash

    $ php -S localhost:8888

    PHP 7.0.18 Development Server started at Thu Jun  1 16:52:26 2017
    Listening on http://localhost:8888
    Document root is /Users/zhoujiping/Code/my-php-framework
    Press Ctrl-C to quit.
```

现在在浏览器输入 http://localhost:8888 就能看见输出的  `Hello World` 了。

## PHP 的变量

什么是变量？ 为什么需要变量？ 先不考虑这个问题，先来看下变量怎么用， 下面是 `index.php` 中改写过的代码。

```php

    <?php
    
    $name = '周继平';
    echo 'Hello' . $name;
```

上面的 `$name` 就是一个变量，在 `PHP` 中，它可以用来存储任何类型的数据，它必须以`$`开头，后面你可以随便跟上英文名字，在`PHP`的变量命名规则中，说到变量不能以数字开头，只能包含数字、字符和下划线等，变量会区分大小写之类的规则，这些不用去刻意去记，比如说，你命名个变量使用数字开头的，如 `$8hello`, 怎么看都会别扭不是，按照下面的方式去写就可以，一看就记住。

> - 使用英文去命名你的变量，不要用拼音;
> - 变量包含两个及以上的英文单词，第二个开始的英文单词首字母大写，如： `$studentName` 传说的小驼峰命名法；
> - 变量包含两个及以上的英文单词，也可以用下划线`_`来连接单词，如：`$student_name` 传说中的蛇形命名法；
> - 不要贪图简短，变量名需要有描述意义，因为代码的可读性非常重要；
> - 如果变量存储多个数据，需要使用复数形式;


我们再来解释下上面中的点号 `.`  它是一个操作符，是用来连接 `PHP` 字符串的，如上面代码的输出就是 `Hello， 周继平`。

像 `echo 'Hello，' . $name;` 这句代码，你也可以这些写 `echo "Hello, $name";` 双引号会解析当中的变量 `$name`，虽然执行效率会慢一点点，但是没人会在意这点，你依然可以用双引号的写法。你还可以写的更清晰一点，像这样 `echo "Hello, {$name}";`。

> 小贴示： 我曾经看见过有人书写过这样的代码： `$name = '张三'; echo "$name是这期的冠军。";` 这样执行的时候肯定会报错，原因是什么呢？ 原因是 $name 前后没有空格，PHP 解析器把 `$name是这期的冠军。` 这一整串作为一个变量了，所以如果出现类式的情况，且汉字之间如果不允许出现空格，且你一定想用双引号的时候，你可以用`{}`将变量包裹起来。如：`$name = '张三'; echo "{$name}是这期的冠军。";` 这样就不会出错了。

对于`$name = '周继平';` 这句代码，`周继平`是变量`$name`的值， 这个值是会变动的，比如我想输出 `Hello, 张三`，我们只需要将`$name`的值设置为张三即可，而`张三`这个值，我们可能会从前端传来，也可能从数据库中查询出来，所以有了变量，我们就可以在不改变代码的前提下，得到不同的值。

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

                ?> 
            </h1>
        </header>
    </body>
    </html>
```

首先注意上面代码中的 `?>` 结束符，当把 php 代码嵌入到 html 中， php 解析器需要知道 php 代码是从哪里开始到哪里结束的，所以必须书写成对的 `<?php ?>` 开始和结束标识符，我们运行一下上面的代码，结果如下：

![php嵌入到html中](/images/php/step_1/1.jpg)

## 变量传递及全局变量$_GET

我们在访问别人的网站的时候，经常会看见类式下面这样的 `uri`: 

``` html

    localhost:8888?key=value&order=asc
```

这里的 `key=value` 或者是 `order=asc` 我们叫做`键值对`，也叫`key-value`, 什么叫做键值呢？

> - 所谓的键：其实就是一个标签，一个编号，通过这个编号去对应值(value)。
> - 所谓的值：值就是数据，就是键所对应的数据。

我们可以通过上面这种方式将键和值都传递给服务器，这些键值会被保存在 PHP 提供的全局变量 `$_GET` 数组中, 如：`$_GET['key']`我值为 value, `$_GET['order']`的值为 asc。 我们可以打印出`$_GET` 的值来看一下， 修改`<header>` 标签内的代码如下：

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

> 注： 上面的 `//` 是 php 语言的单行注释， `//` 之后的代码都不会被执行， `var_dump()` 是 php 提供的内置函数，这个函数可以打印出变量的类型和值。

如果只访问： http://localhost:8888 结果是 `array(0) { }` 一个空数组，如果访问 uri 的时候并带上键值对, 如：

```html

    http://localhost:8888/?name=zhoujiping&age=3
```

多个键值对中间用 `&` 符号连接, 输出的结果如下:

```bash

    array(2) { ["name"]=> string(10) "zhoujiping" ["age"]=> string(1) "3" }
```

> `array` 代表数组类型， `string` 代表字符串类型， `name` 和 `age`为健，`zhoujiping` 和 `3` 为值。

通过这个方式，我们就可以获取 uri 上的值了，可以通过这些值做一些逻辑处理之类的，我们现在就在页面上显示它们，如下：

```php

    <header>
        <h1>
            <?php
                $name = $_GET['name']; // 获取健(key) 为 name 的值
                $age = $_GET['age']; // 获取健(key) 为 name 的值

                echo "Hello, {$name}, are you {$age} years old?";
            ?> 
        </h1>
    </header>
```

现在访问上面的 uri, 页面上会显示 `Hello, zhoujiping, are you 3 years old?`。

## 使用 `<?=` 替代 `<?php echo`

我们将上面的代码写的相对简单点, 如下:

```php

    <header>
        <h1>
            <?php echo 'Hello, ' . $_GET["name"] . ', are you ' . $_GET['age'] . ' years old?'; ?>
        </h1>
    </header>
```

当你发现你的代码中出现`<?php echo`连接在一起的时候， 你就可以使用`<?=` 来替代它们，这样会让代码简洁一点, 如下：

```php

    <header>
        <h1>
            <?= 'Hello, ' . $_GET["name"] . ', are you ' . $_GET['age'] . ' years old?'; ?>
        </h1>
    </header>
```

## 接触一点 PHP 安全问题

现在我们可以随意的设置 uri 中的`name`值了，但是用户可能会像下面这样输入:

```html

    http://localhost:8888/?name=<a%20href="http://blog.zhoujiping.com">周继平的老博客</a>
```

这时候 `name` 对应的值是一串 html 代码，如果后端不经过处理， 浏览器就会解析它，就会出现下面这样的情况：

![代码注入](/images/php/step_1/3.jpg)

我们传给 `name` 的值是一串 html 代码， 浏览器会解析它们， 然后将结果显示在页面，当然仅仅针对目前这个案例，用户即使输入了也只会显示在自己的浏览器上，所以并没有什么影响，但是如果我们以后深入的再探讨下，那么问题就会出来了，通过这里我们要知道的是传递给后端的值一定要做验证和过滤，这也是为什么很多框架都会有中间件这一层的原因, 我们把代码改的稍微安全点，很简单，加一个 `htmlspecialchars()` 函数即可。

### `htmlspecialchars()`函数解析

htmlspecialchars() 函数， 官方文档的解释是将特殊字符转换为 HTML 实体编码，比如它会将`<` 转变成 `&lt;`, 将`>`转变成`&gt;`等，转化后`name`的值就不是可以运行的 html 代码了，所以运行不了，而在显示的时候，html 又会将这些实体编码重新转化回来，所以在页面上我们并不能看见这些实体编码，但是当你查看 html 源代码的时候，就能看见它们了。

```php

    <header>
        <h1>
            <?= 'Hello, ' . htmlspecialchars($_GET["name"]); ?>
        </h1>
    </header>
```

现在再访问刚才的网址， 页面上显示的内容就会像下面这样：

```

    Hello, <a href="http://blog.zhoujiping.com">周继平的老博客</a>
 ```

## PHP 文件的视图层和逻辑层相分离

将 php 代码嵌入到 html 中， 我们就可以在页面中编写任何逻辑代码，比如定义变量，连接数据库，查询数据，验证数据，输出数据等等，如果把所有的东西都放在这个页面中，那在开发和维护上就会非常的痛苦，所以我们需要将它们拆分开来。将不同的职责放置在不同的 php 文件中，在 `PSR-1` 规范中就已经提到了这点，所以我们也必须要将它们分离出来。

比如我们之前所写的 `index.php`, 我们就需要将它拆分开了，我们需要新建一个 `index.view.php` 的视图文件，视图文件中的 php 代码基本是用于数据输出的，而其余的代码大多是 html 代码, 有些公司会将视图层这一部分全交由前端来完成的，由此也可以看出视图层是不涉及逻辑代码的，我们将 html 代码都拷贝到`index.view.php`中，如下：

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

将 `index.php` 先改写为下面这样：

```php

    <?php 

    $name = '周继平';
    require 'index.view.php';
```

> 其实上面`index.php`中的代码将声明变量和引入文件放在同一个 php 文件中，也违反了 `psr-1` 的规范，不过我们现在先不去考虑它。

当 `index.php` 被运行时，会通过 `require` 将 `index.view.php` 包含进来，你可以把`require 'index.view.php';`想象成将`index.view.php`中的代码复制到当前文件中，所以当我们访问： http://localhost:8888/index.php  会得到相同的结果。 这就是最简陋的视图层和逻辑层分离。

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

这么写对于 PHP 解释器来说没有任何问题，但是对于人类来说，就很有问题，首先是代码啰嗦重复，可读性差，其次是不好扩展，不好维护。针对这种情况，PHP 的数组可以帮助我们解决，php 数组使用 `array()` 来定义，而从 php5.4 开始，数组可以使用一对中括号 `[]` 来定义, 所以现在写代码千万不要再用`array()`去定义数组了，可读性和代码的整洁度太差了。

我们将 `index.php` 中的三个变量换成数组来做，如下：

```php

    $names = ['周继平', 'Zhou Jiping', 'Kuker Chou'];
```

`$names` 就是一个索引数组，索引数组的每个元素都有个下标，从`0`开始，如通过 `$names[0]` 即可获得数组中第一个元素的值，如果要遍历数组的值， 可以使用 `foreach` 语句， `foreach` 会从数组的第一个元素开始遍历至最后一个元素。

我们将`index.view.php` 中改写如下：

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
这样就能够正确的打印出三个名字了。

> 像`[1，2，3]` 这样的数组我们叫做一维数组, 而像`[[1,2,3], [4,5,6]]`这样的我们叫做二维数组，一般使用到三维数组算是极限了，再多，开发者就会蒙了。

## 使用替代语法

为了让嵌套在 html 代码中的php代码更清晰易读，PHP 提供了一些流程控制的替代语法，包括 if，while，for，foreach 和 switch。替代语法的基本形式是把左花括号（{）换成冒号（:），把右花括号（}）分别换成 endif;，endwhile;，endfor;，endforeach; 以及 endswitch;。官方文档地址： http://php.net/manual/zh/control-structures.alternative-syntax.php

我们将 `index.view.php` 中的 `foreach` 使用替代语法来书写:

```php

    <header>
        <ul>
            <?php foreach ($names as $name) : ?> 
                 <li>Hello, <?= $name ?></li>
            <?php endforeach; ?>
        </ul>
    </header>
```

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

在开发的时候， 我们经常会需要查看下某个变量或者是某个函数返回值的具体结果是什么，我们可以使用 `var_dump()` 来查看一个变量中具体有哪些值及值的类型是什么，如我们可以在 `index.php` 中 `$person` 数组下加上 `var_dump($person)` 这句代码来查看 `$person` 的值, 但是会发现`index.view.php`中的内容也输出了，这时候我们还可以在其下在加上一句 `die()` 函数，意思是让程序执行到这里结束，通过这两个函数就可以进行断点调试了
，如下：

```php

    var_dump($person);
    die;

    // 或者这么写
    die(var_dump($person));
```

## 布尔值和条件判断语句

在任何时候，人类都需要做出选择，写程序也一样，在 PHP 中有一种值的类型叫做布尔型`（Boolean）`, 它只有两个值 `true` 和 `false`, 它通常和条件判断语句 `if--else` 一起使用。如下：

```php
if (true or false) {
    // do something
} elseif ( true or false) {
    // do something
} else {
   // do something
}
```

## 函数

我们之前接触的`var_dump()` 这种就是函数，函数的定义如下：

```php
    function name($argment1, $argment2 ...)  // 省略号代表还能有很多参数
    {
        // code
    }
```
`function` 是 php 的一个关键字，代表你想定义一个函数， `name` 是你自己给这个函数定义的一个名字，命名规则也是用小驼峰法，`$argment1, $argment2` 这些是函数的参数，其实就是变量，当你调用函数的时候，将值对应到每一个参数上就可以了。

我们将刚才用于断点测试的代码写成一个函数，然后调用它，你就会明白怎么定义和调用函数了，首先要在与 `index.php` 同级目录下建立一个 `functions.php` 的文件，专门用来存放我们写的函数, 然后写上我们的断点调试函数，我们取名为 `dd`, `dumper and die` 的意思。

```php

    <?php

    function dd($data)
    {
        echo '<pre>';
        die(var_dump($data));
        echo '</pre>';
    }
```

我们在 `index.php` 中引入 `functions.php`, 并调用 `dd()` 函数, 如下：

```php

    require 'functions.php';

    $person = [
        'name' => '周继平',
        'age'  => 3,
        'skin_color' => '狗屎色'
    ];

    dd($person);
```

上面是 PHP 最基础的部分，每一部分都是点到而已，因为每一个点如果要深入都能挖掘出很多的东西，但是初期来说，上面这点知识够了，你在学习的是一门计算机的语言，和学英语是一样的道理，重要的在于实践，往往很多时候我们无法动手做的原因是在于对整个开发流程不清楚，你知道了一些基础和流程后，就可以通过 Google, Github, Stack Overflow, 还有 php 的官方文档来开启和深入你的 php 生涯了，实践很重要，尤其是语言，像我读大学的时候英语一直很差，后来自己开办了个老外学普通话的机构，说的多了，写的多了，自然而然的英文水平就提高了些。

当然，当你已经开发了几个项目后，你就得回头来系统的补下基础了，这个基础包括计算机系统原理，编译原理，算法和数据结构，C语言等。

有了上面的基础了，下面我们开始接触下 Mysql Database 和 php 的面向对象，然后开始谈下框架的演变过程。

## 接触 Mysql

一个 Web 站点上会有很多的数据，我们可以把这些数据放在文件中进行储存，比如像我这个新博客中的文章，就是存储在文件中的。 但是如果一个 Web 站点的数据会经常需要增删改查，那就需要一个数据库来保存它们了。我们经常使用的数据库管理系统有 `SQLite, Mysql, NOSQL, MongoDB` 等， 可以根据自己的需要来选择其中一个或几个搭配使用，不过 `Mysql` 和 `PHP` 基本已经成了黄金搭档了。


# 二次修订到这里。。。。。下面未修订

比如说我们要开发一个 “待办事项列表”给自己使用，我们需要把这些 ”待办事项“ 存放在数据库中，我们用 `Mysql` 来做一下：

### Mac 上用 Brew 安装 Mysql
首先需要安装Mysql, 在 `Mac` 上可以通过 `brew` 来安装 `Mysql`， 具体的看我这篇文章中的安装 Mysql 的部分

> [全新安装Mac OS Sierra (10.12)并使用HomeBrew安装ZSH + MNMP (Mac + Nginx + Mysql + Php) 开发环境](http://blog.zhoujiping.com/notes/mnmp.html)

### 登录 Mysql 数据库
开启`mysql`服务后，在终端通过`mysql -u 用户名 -p 密码` 就可以登录到`mysql`中

```bash
    $ mysql -u root -p           
    Enter password: 
    Welcome to the MySQL monitor.  Commands end with ; or \g.
    Your MySQL connection id is 4
    Server version: 5.7.17 Homebrew

    Copyright (c) 2000, 2016, Oracle and/or its affiliates. All rights reserved.

    Oracle is a registered trademark of Oracle Corporation and/or its
    affiliates. Other names may be trademarks of their respective
    owners.

    Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

    mysql> 
```

### 查看 Mysql 内所有数据库

进入 `Mysql` 数据库中， 可以通过 `Sql` 语言来操作了，先通过 `show databases;`看一下我们目前有哪些数据库存在:

```bash
mysql> show databases;

+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
| zjpblog            |
+--------------------+
```

### 创建一个新的数据库 mytodo

下面来创建一个数据库存放我们的“待办事项”，取名为 `mytodo`, 通过 `create database mytodo;` 来创建

```bash
# 下面的 mysql> 代表目前你处于 mysql 的环境中
# create database mytodo;  是sql语句，不是命令，不要忘记了分号
mysql> create database mytodo; 
```

### 切换当前数据库

现在通过 `show databases;` 就能看见刚才创建的 `mytodo` 数据库了，当你要具体操作某一个数据库的时候，你得通过`use 数据库名` 切换到你要操作的数据库，`mysql`数据库管理系统内有这么多的数据库存在，你如果不指定用哪一个，那就乱套了。

```bash
    mysql> use mytodo;
    Database changed
```

### 查看所有数据表 table

一个数据库会内有很多的数据表 `tables`, 通过`show tables;` 可以查看所有的数据表：

```bash
mysql> show tables;
Empty set (0.00 sec) # 目前我们还没有建立表，是空的
```

### 创建数据表

你可以把数据库想象成一个文件夹，把数据库中的表想象成是 `excel` 文件，在每个`excel`文件内，你会给每个列取个名字，然后对应的填上你的数据，数据表也一样，只不过它的列叫做 “字段”,同时你在创建的时候需要指定每个“字段”内可以存放的值的类型，我们来创建一个 `todos` 的表。

```bash
mysql> create table todos (id     integer  PRIMARY KEY AUTO_INCREMENT, description text     NOT NULL, completed boolean NOT NULL);

#注解： create table todos (字段名   整形     主键         自增长         ,  字段名2      文本型    不为空); 
```
字段 `id`, 有一个`PRIMARY KEY`的属性，代表它是主键，是唯一的，`AUTO_INCREMENT` 是自增长的意思，你插入数据到表中的时候，不用手动为`id`添加值，它是自动生成。

### 查看数据表内所有字段的属性

通过 `describe 数据表名;` 可以查看这个表内每个字段的具体属性：
```bash
mysql> describe todos;
+-------------+------------+------+-----+---------+----------------+
| Field       | Type       | Null | Key | Default | Extra          |
+-------------+------------+------+-----+---------+----------------+
| id          | int(11)    | NO   | PRI | NULL    | auto_increment |
| description | text       | NO   |     | NULL    |                |
| completed   | tinyint(1) | NO   |     | NULL    |                |
+-------------+------------+------+-----+---------+----------------+
```
### 插入数据到 todos 表中

```bash
mysql> insert into todos (description, completed) values('写博客', false);
```
### 查询表中的所有数据

```bash
mysql> select * from todos;
+----+-------------+-----------+
| id | description | completed |
+----+-------------+-----------+
|  1 | 写博客      |         0 |
+----+-------------+-----------+
```
> 更多关于 `sql` 语句，访问： https://www.w3schools.com/sql/default.asp ， 可以快速浏览一下，熟悉点关键字，用的时候再去google。

###  用Mysql客户端管理工具来管理Mysql数据库

通常很少真有人一直在命令行去操作数据库，在 `Mac` 上可以使用 `Sequel pro` 来管理， 在 `Windows` 上可以用 `Navcat`

> Sequel pro - http://www.sequelpro.com/  免费, 简单易用，本人一直用这个，只支持 `Mac` 系统
> Querious - http://www.araelium.com/querious/ 只支持 `Mac` 系统，收费
> Navcat - https://www.navicat.com.cn  收费，支持`Mac`, `Windows`, `Linux`

## 接触 PHP 的类和对象

现代的 PHP 开发都是基于面像对象的，可以将任何东西都看作对象，我们可以创建一个或者多个对象，有些对象会有一些相同的特征，所以我们会基于一个模版来创建这些对象，而这个模版我们可以称呼为“类”, 我们用关键词 "class" 即可以声明一个类，如声明一个“待办事项的类”

```php
class Task 
{
    //
}
```

我们把 `index.php` 中的代码改成下面这样：

```php
<?php 

require 'functions.php';

class Task 
{
    protected $description;

    protected $completed = false;

    public function __construct($desc)
    {
        $this->description = $desc;
    }
}

$taskOne = new Task('写博客');
$taskTwo = new Task('中午去幼儿园打小男孩');

dd([$taskOne, $taskTwo]);

require 'index.view.php';
```

上面的 `Task` 就是一个类，我们可以通过 `new 类名` 来创建对象，像上面我们通过`new Task('xx')` 创建了两个任务。我们希望在创建任务对象的时候能将具体的任务内容也生成，PHP 给每个类都提供了一个构造方法 `__construct`,这个方法会在你创建一个对象的时候自动调用，php给我们提供的类式这样的方法我们叫做魔术方法，魔术方法都是以 `__` 开始的。

我们再来看 `Task`, 在这个类中有 `$description, $completed ` 两个变量， 有`__construct` 这个函数，不过再类中，我们把像上面这样的变量叫做类的“属性”，把函数叫做类的“方法”。

在 `$description` 前面的 `protected` 这个关键词是用来限定访问权限的, 一共有三种权限：

> private - 使用了改修饰的属性和方法只能在类的内部调用;
> protected - 使用了改修饰的属性和方法只能该类和该类的子类中调用
> public - 使用了改修饰的属性和方法只能在类的内外部或者子类中都可以调用

`$this->description = $desc;`  `$this` 代表当前对象，如果是`$taskOne`调用 description， `$this` 就代表`$taskOne` 这个对象， 如果是`$taskTwo`调用 description， `$this` 就代表`$taskTwo` 这个对象。这里的 `->` 符号就是对象调用属性和方法的操作符。

上面说到 `$compoleted` 是被 `protected` 修饰的，所以我们不能在类外部直接调用它，我们现在来编写一个方法：

```php
public  function isComplete()
{
    return $this->completed;
}
```

这样就可以通过 `$taskOne->isComplete()` 来获取`$completed`的值了，为什么不直接将`$compoleted`　的访问权限改成 public 呢？ 主要是为了安全性的考虑，最好不要预先就将属性设置成`public`, 这样任何对象就都能访问它或者去尝试修改它的值了，将属性设置成`private 或者 protected`, 然后通过一些方法来访问和修改属性，你可以在方法中编写一些处理或过滤的功能，这样就会好很多。基于这个想法，那么对象如果要修改`$completed`的值，那就需要下面的方法:

```php
    public function complete()
    {
        $this->completed = true;
    }
```

> 上面的代码可到 https://github.com/zhoujiping/build-your-own-php-framework 查看第一次提交的代码

## 通过 `PDO` 对象连接数据库

### 创建 PDO 资源对象

我们先在 `todos` 表中插入点数据

![task数据库数据](/images/php/step_1/4.jpg)

然后创建 `PDO` 资源对象，创建对象很多时候也叫“实例化一个对象”。

```php
// mysql - 告诉pdo我用的是mysql数据库
// host=127.0.0.1 地址，你的mysql装在哪个服务器上，IP或地址是多少，我们跑在本地，所以是127.0.0.1或localhost
// dbname - 数据库名
// username - 登录mysql的用户名
// my_password - 登录mysql的密码

$pdo = new PDO('mysql:host=127.0.0.1;dbname=mytodo', 'username', 'my_password');
```
`PDO` 是 PHP 提供的一个用来连接和操作数据库的类，我们先创建一个`$pdo`资源对象，这里会存在一个问题，就是很有可能因为数据库软件没有运行，或者是用户名和密码输错而导致异常，这里我们需要通过`try`和`catch`来处理异常.

### PDO连接不上数据库的异常处理

```php
try {
    $pdo = new PDO('mysql:host=127.0.0.1;dbname=mytodo', 'username', 'my_password');
} catch (PDOException $e) {
    die('Sorry, could not connect');
}
```
`try` 内的代码始终会运行一遍，如果出错了，会被抛出异常，该异常会被 `catch` 捕获住， 当捕获到异常，我们使用`die()`让程序停止运行。

### 通过 pdo 获取数据表 todos 中的内容

将 `index.php` 改成：

```php
<?php 

try {
    $pdo = new PDO('mysql:host=127.0.0.1;dbname=mytodo', 'username', 'your_password');
} catch (PDOException $e) {
    die('Sorry! Could not connect');
}

$statement = $pdo->prepare('select * from todos');

$result = $statement->fetchAll(PDO::FETCH_OBJ);

var_dump($result);
```

当我们正确的连接上数据库，会返回一个资源对象，接着需要预处理 `sql` 语句

```php
$statement = $pdo->prepare('select * from todos');
```
### sql 注入之类的安全问题
使用 `prepare` 的好处是为了避免一些 `sql` 注入的安全问题，这里不展开说，简单的说下吧！正常开发的时候我们的`sql`语句的部分内容是由用户传递过来的，如：

```sql
select * from todos where completed = ?;
```

比如这里是希望用户通过传`1` 或者 `0` 来获取完成或者未完成的任务列表，但是往往用户不会这么做，如果用户输入`1 or true`,如果不做处理，就会把所有的任务都读取出来了。所以当你看一些资料的时候要自己鉴别下，如果使用`mysql_connect()`函数去连接数据库，那是很不安全的，还好高版本已经不支持这个函数了，所以安装 `php` 版本的时候也最好安装最新的，比如现在一定要用 `php7` 了。

接着，我们可以执行预处理过的 sql 语句，然后获取所有的任务，但是我们可以通过传递 `PDO::FETCH_OBJ`参数来过滤输出内容，只要获取当中的对象.

```php
$statement->execute();

$results = $statement->fetchAll(PDO::FETCH_OBJ);
```
现在使用 `var_dump($results)` 打印出 `$results` 的值

![pdo获取数据库的值](/images/php/step_1/5.jpg)

### 对象和关系的映射

`$results` 是一个包含的是两个php标准对象(stdClass)的数组， 但是如果我们在获取对象的时候能得到两个`Task` 对象， 将对象和数据表的关系对应上，那之后开发就方便多了，我们来改写一下`$results = $statement->fetchAll(PDO::FETCH_OBJ);`

```php
$tasks = $statement->fetchAll(PDO::FETCH_CLASS, 'Task');
```
通过设置 `PDO::FETCH_CLASS`参数，可以返回一个具体的对象，`Task` 指定返回的具体对象，它是类`Task`的对象，现在我们还没有'Task'类，我们去新建一个`Task.php`的文件

```php
<?php

    class Task 
    {
        public $description;

        public $completed;
        
    }
```
在 `index.php` 中 `require 'Task.php'`, 现在 `var_dump($tasks)`, 如下：

![ORM](/images/php/step_1/6.jpg)

现在我们在 `Task` 类中新声明的任何属性和方法，都能够被 `$tasks` 内的对象调用了，从而实现了对象和关系映射（ORM）的雏型。

### 现在的文件和代码罗列

再看下现在已有的文件和代码：

`Task.php` 文件

```php
<?php

class Task 
{
    public $description;

    public $completed;
}
```

`index.php` 文件

```php
<?php 

require 'Task.php';

try {
    $pdo = new PDO('mysql:host=localhost;dbname=mytodo', 'username', 'my_password');
} catch (PDOException $e) {
    // 这里直接打印出具体的出错信息
    die($e->getMessage());
}

$statement = $pdo->prepare('select * from todos');
$statement->execute();
$tasks = $statement->fetchAll(PDO::FETCH_CLASS, 'Task');

require 'index.view.php';
```

`index.view.php` 文件

```php
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>index.view.php</title>
</head>
<body>
    <ul>
        <?php foreach ($tasks as $task) : ?>
             <li>
                <?php if ($task->completed) : ?>
                    <strike> <?= $task->description; ?> </strike>
                <?php else : ?>
                    <?= $task->description; ?>
                <?php endif; ?>
             </li>
        <?php endforeach; ?>
    </ul>
</body>
</html>
```

`functions.php` 文件

```php
<?php

function dd($data)
{
    echo '<pre>';
    die(var_dump($data));
    echo '</pre>';
}
```

### 初步优化代码

现在回头看 `index.php` 中的连接数据库和获取`todos`表中所有数据的代码，它们很凌乱，另外每次在别的文件中调用还需要重新写一遍，我们先把连接数据库的部分写成一个函数，放在`functions.php` 中

```php
function connectToDb()
{
    try {
        // 实例化PDO，并将pdo的资源对象返回给调用者
        return new PDO('mysql:host=localhost;dbname=mytodo', 'username', 'my_password');
    } catch (PDOException $e) {
        die($e->getMessage());
    }
}
```
在 `index.php` 中调用这个函数

```php

<?php 

require 'functions.php';
require 'Task.php';

    // 通过调用 connectToDb() 获取其返回的 PDO 资源对象，并赋值给 $pdo
    $pdo = connectToDb();

    $statement = $pdo->prepare('select * from todos');
    $statement->execute();
    $tasks = $statement->fetchAll(PDO::FETCH_CLASS, 'Task');

    require 'index.view.php';
```

`index.php` 中的获取所有任务的三条代码也将其写成函数，放到`functions.php` 中

```php
    function fetchAllTasks($pdo)
    {
        $statement = $pdo->prepare('select * from todos');
        $statement->execute();
        return $statement->fetchAll(PDO::FETCH_CLASS, 'Task');
    }
```
`index.php` 中调用 `fetchAllTasks($pdo)`

```php
<?php 

    require 'functions.php';
    require 'Task.php';

    $pdo = connectToDb();
    $tasks = fetchAllTasks($pdo);

    require 'index.view.php';
```

## 重构以上优化后的代码

上面优化的代码貌似还可以了，但是上面的代码可以说属于面向过程的，只注重实现功能，代码的可读性和可维护性，易用性都很差，现代的 php 都是面向对象编程了，所以我们有必要对代码进行重构，代码重构的意思是在不影响功能的前提下对现有代码的结构进行改变，对类，方法进行重命名，对代码、接口进行抽取，对字段进行重新封装等。

我们在看很多老外写的代码可以发现，他们的代码里一般会定义大量的类、接口、方法，类与类，类与接口之间很多是继承和实现的关系，方法的代码行数很少，超过20行代码的方法不多，看他们的代码感觉最多的就是方法之间的调来调去，不像我们很多人的代码，一个方法下来几十上百甚至两三百行都是最基本的语句构成，很少调用自己的方法。两相比较，可以看出，前者在结构上更清晰，通过类视图就可看出设计意图，并且总的代码量少于后者，而后者代码量庞大，代码冗余现象严重，结构不清晰，很难维护。

我们主要来重构下面的两个函数:

```php
$pdo = connectToDb();
$tasks = fetchAllTasks($pdo);
```

比如说，通常我们不应该编写 `fetchAllTasks()` 这样的函数，这种函数基本没法复用，比如说想获取所有的评论呢？是不是也要写个`fetchAllComments()` 的函数？ 这样明显就有问题了。

上面的两个函数都是作用在数据库的，那么我们先建立一个`database`的文件夹，然后看`connectToDb()`函数,它的作用在于连接数据库 `Connect to Database`。

基于面向对象的编程，我们会需要一个类，然后使用类的一个方法去连接数据库，类名通常是一个名词，方法可以是一个动作，用英文说大只就是 `make a database connection`, 好了，那么我们就在`database`文件夹中创建一个 `Connection.php` 的文件，在当中声明一个`Connection` 的类， 并且它有一个`make()`的方法。

```php
<?php 

class Connection
{
    public static function make()
    {
        //code
    }
}
```
> 类名的编写规则才用大驼峰法，也就是所有的英文字母的首字母都大写。

这里我们将`make()` 方法设置成静态的`(static)`, 静态方法可以用类名直接调用，不用实例化对象调用，如果不采用静态方法，我们需要这么调用：

```php
$connection = new Connection;
$connection->make();
```
而静态方法，是这么被调用的

```php
Connection::make();
```

对于静态方法的使用，通常情况下需慎用，它可能会增大内存的开销，不过在这里的这种情况，使用静态方法我觉得还挺不错的。我们把这个类完善下

```php
<?php 

    class Connection
    {
        public static function make()
        {
            try {
                return new PDO('mysql:host=localhost;dbname=mytodo', 'username', 'my_password');
            } catch (PDOException $e) {
                die($e->getMessage());
            }
        }
    }
```

现在在 `index.php` 中，就可以调用它了

```php
<?php 

    require 'functions.php';
    require 'database/Connection.php';
    require 'Task.php';

    $pdo = Connection::make();
    $tasks = fetchAllTasks($pdo);

    require 'index.view.php';
```

下面再来看`fetchAllTasks()`这个函数，刚才也说了这个函数不具备复用性，我们现在需要一个类，这个类最好能提供一些方便好用的查询方法给我们，它能将一些常用的`SQL`语句进行封装，这样在以后开发的时候我就不用再去写那些原生的，难于阅读和维护的原生`sql`语句, 既然这样，我们就需要重新构建一个查询的类，我们把这个取名为 `QueryBuilder`， 目前它还应该有一个`selectAll()`的方法。 在`database`文件夹下创建 `QueryBuilder.php`的文件

```php
<?php

    require 'Connection.php';

    class QueryBuilder
    {
        public function selectAll($table, $model)
        {
            $statement = Connection::make()->prepare("select * from {$table}");

            $statement->execute();

            return $statement->fetchAll(PDO::FETCH_CLASS, $model);
        }
    }
```
`index.php` 中的代码如下

```php
<?php 

    require 'functions.php';
    require 'database/QueryBuilder.php';
    require 'Task.php';
    
    $tasks = (new QueryBuilder)->selectAll('todos', 'Task');

    require 'index.view.php';
```

现在代码可以跑通， 但是`QueryBuilder`类中的这句代码好象还是有问题

```php
    $statement = Connection::make()->prepare("select * from {$table}");
```

这里的`Connection::make()`是硬编码式的写在这里的，如果`Connection`类修改了`make()`方法的名称，那么这里就会出错，同时在代码阅读体验上太差，不能一眼看出`Connection::make()`返回的结果是什么，还是需要和以前一样使用变量`$pdo`比较好。

```php
    $statement = $pdo->prepare("select * from {$table}");
```

这个`$pdo`变量在调用的时候该怎么传进来呢？放在`selectAll()`参数内? 这样不好，以后如果编写其他的方法还需要重复的传进来，嗯，`QueryBuilder` 类必须要依赖于 `PDO` 的一个资源对象，我们给`QueryBuilder`类定义一个 `PDO` 对象的属性，当`QueryBuilder`创建的时候自动给这个属性赋值,用构造函数可以解决，再改一下`QueryBuilder`类

```php
<?php

    class QueryBuilder
    {
        protected $pdo;

        public function __construct(PDO $pdo)
        {
            $this->pdo = $pdo;
        }

        public function selectAll($table, $model)
        {
            $statement = $this->pdo->prepare("select * from {$table}");

            $statement->execute();

            return $statement->fetchAll(PDO::FETCH_CLASS, $model);
        }
    }
```

`index.php` 中的代码

```php
<?php 

    require 'database/Connection.php';
    require 'database/QueryBuilder.php';
    require 'Task.php';

    $pdo = Connection::make();

    $query = new QueryBuilder($pdo);

    $tasks = $query->selectAll('todos', 'Task');

    require 'index.view.php';
```

这样会好一些，上面这种做法其实就是依赖注入，在很多的框架中都会使用到。现在`index.php` 还是太杂了，做的事太多了，像创建`PDO`和实例化查询构建器这种都属于引导程序，我们把它们独立出来，在根目录建立`bootstrap.php`

```php
<?php

    require 'database/Connection.php';
    require 'database/QueryBuilder.php';

    return  new QueryBuilder(
        Connection::make()
    );
```
再更改下`index.php`

```php
<?php 

    $query = require 'bootstrap.php';

    require 'Task.php';

    $tasks = $query->selectAll('todos', 'Task');

    require 'index.view.php';
```

差不多就先这样重构吧！ 问题还是有，比如说`$tasks = $query->selectAll('todos', 'Task');` 这句就不够语义化，暂时先把`Task`这个参数去掉吧。

## 查阅具体分支的代码

这部分的代码在 https://github.com/zhoujiping/build-your-own-php-framework 的 `refactor` 上，你可以按下面的方法进行查阅。

```bash
# 克隆代码到本地
git clone git@github.com:zhoujiping/build-your-own-php-framework.git
# 切换到 refactor 分支
git checkout refactor
```

## 使用配置文件

我们现在是把连接数据库的用户名和密码以硬编码（hard code, 写死的意思）的方式放在`Connection`类中，这样做既不方便管理，同时也不安全，我们来建立一个`config.php`的配置文件， 在里面定义一个数组来存放这些配置

```php
<?php 

     return [
        'database' => [
            'name'          => 'mytodo',
            'username'      => 'username',
            'password'     => 'my_password',
            'connection'    => 'mysql:host=127.0.0.1',
            'options'       => []
        ]
     ];
 ```

 将 `Connection.php` 更改下

 ```php
 <?php 

    class Connection
    {
        public static function make($config)
        {
            try {
                return new PDO(
                    $config['connection'] .';dbname=' . $config['name'],
                    $config['username'],
                    $config['password'],
                    $config['options']
                );
            } catch (PDOException $e) {
                die($e->getMessage());
            }
        }
    }
```

我们给`make()`方法添加了参数，在`bootstrap.php` 中也要更改下

```php
<?php

    $config = require 'config.php';

    require 'database/Connection.php';
    require 'database/QueryBuilder.php';

    return  new QueryBuilder(
        Connection::make($config['database'])
    );
```

好了，这样可以跑通，在配置文件中我们加了个`'options'=> []` 的配置，这个是做什么用的呢？这里可以添加一些我们需要的额外配置，比如说 `$tasks = $query->selectAll('todos');
` 这里如果我们传入一个不存在的数据表，按目前的代码，运行后没有任何的提示，我们把配置文件中的`options`设置下

```php
    'options'       => [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION
    ]
```

现在我们如果查询空表的话就能显示错误信息了，如下

```
Fatal error: Uncaught PDOException: SQLSTATE[42S02]: Base table or view not found: 1146 Table 'mytodo.todoss' doesn't exist in /Users/zhoujiping/Code/php-learning/database/QueryBuilder.php:16 Stack trace: #0 /Users/zhoujiping/Code/php-learning/database/QueryBuilder.php(16): PDOStatement->execute() #1 /Users/zhoujiping/Code/php-learning/index.php(5): QueryBuilder->selectAll('todosS') #2 {main} thrown in /Users/zhoujiping/Code/php-learning/database/QueryBuilder.php on line 16
```

> PDO::ATTR_ERRMODE的更多预设值访问  http://php.net/manual/en/pdo.setattribute.php 可以自己都试下

## 编写路由 Router

我们可以直接通过访问 php 文件的名字来运行 php 文件，我们建立 `about.php` 和 `contact.php`这两个文字，里面写一些 html 的代码， 然后通过 `http://localhost:8888/about.php` 就可以访问了。如果项目很小，就几张页面，而且逻辑不复杂， 这样做是可以的。如果逻辑复杂一点的，这么做就会有点难于维护了。按照现代 PHP 开发的规范，是需要统一入口文件的， 也就是说无论你访问哪一个URI，其实都是通过 `index.php` 这个文件进入的。 

我们需要把现有的文件目录结构再优化下， 像`database` 内的文件，以及`bootstrap.php` 文件，这些都是属于一些核心的文件，我们可以建立一个文件夹叫做 `core`, 然后把`database`文件夹和 `bootstrap.php`放在这里面，然后我们之前也说过要把逻辑和视图分离开来，那么新建一个 `views` 的文件夹专门用来存放视图文件，对于视图文件我们需要规定下命名规则，目前就先统一为 `xxx.view.php` 这样的格式吧，针对逻辑层我们新建一个 `controllers` 的文件夹。在 `controllers`。

到目前为止，我们做了简单的检索生成器`QueryBuiler`, 可以和数据库打交道了，这一块也可以称呼为模型层`Model`, 我们还建立了控制逻辑的层`controllers`, 以及视图层`views`, 已经是往`MVC`这边靠了。

现在优化好的目录如下：

```php
├── index.php    # 入口文件
├── config.php   # 配置文件
├── controllers  # 控制器层，写逻辑的地方
├── core         # 一些核心文件
│   ├── bootstrap.php
│   └── database
│       ├── Connection.php
│       └── QueryBuilder.php
└── views       # 视图层
    └── index.view.php
```

按照现在的结构，假设我们现在要访问一个路由为 `/about` 这样的页面，会发生什么事呢？ 首先根据统一入口规则，无论访问什么样的路由，都必须让它首先访问网站根目录下的 `index.php`, 事实上我们访问的`/about` 的路由全名应该是 `/index.php/about` 这样的。后期通过配置`Apache`或是`nginx`隐藏掉路由中的`index.php`,那么我们看见的路由就会变成`/about`了

### 安装 valet 运行环境

> 在Mac系统上，可以安装 `valet` 开发环境，它已经帮我们配置好了这些，安装说明 https://laravel.com/docs/5.4/valet 

先用 `valet` 生成一个 `my-php-framework.dev` 的本地域名，以后就用这个域名来运行。

### 统一入口页面

首先改写下 `index.php` 的内容, 因为是入口文件，所以要引入`bootstrap.php`引导文件

```php
<?php 
    //index.php

    $query = require 'core/bootstrap.php';

    die('无论你访问什么url,都会先访问index.php文件');
```

因为我们改了目录结构， 所以注意也要把`core/bootstrap.php` 中引入文件的路径也改正确, 如果使用 `valet` 的运行环境，现在就达到我们的要求了，比如我访问 `http://my-php-framework.dev/about`, 它会显示出`index.php`中的这句话。

![统一入口页面](/images/php/step_1/7.jpg)

接下来的事，应该是通过路由去找到控制器中对应的文件，控制器处理完逻辑，将数据让视图层来显示出来，我们在`controllers`中建立`about.php`, 在`views`中建立`about.view.php`文件, 下面是`about.php` 中的内容

```php
<?php

// controllers/about.php

require 'views/about.view.php';
```

### 路由分发
现在回到 `index.php` 入口页面，当用户访问`／about` 这条路由的时候，需要运行与`/about`相关的页面代码，我们已经将逻辑代码放在了`controllers/about.php`中了，现在需要程序能够正确的将`controllers/about.php`的内容包含进来运行，我们可以使用关联数组将路由和实际的控制器文件路径对应起来。

```php
$routes = [
    'about' => 'controllers/about.php'
];
```

当用户访问'/about'的时候，通过这个数组的`about`健就可以拿到`'controllers/about.php'`这个路径了。

我们先把这个路由数组单独放在一个文件中，命名为`routes.php`, 一个项目会有很多的路由存在，不要把它和别的逻辑杂合在一起。

现在要考虑怎么样做出这个路由的功能，基于面向对象的开发思想，我们首先会想到应该会存在一个`$router`的对象，这个对象有一个`define`的方法，将上面的代码改写下，如下：

```php
$router->define([
    ''        => 'controllers/index.php',
    'about'   => 'controllers/about.php',
    'contact' => 'controllers/contact.php',
]);
```

上面多定义了几个路由，自己加上对应的文件，既然需要`$router`的对象， 那应该需要一个`Router`的类，它也应该属于核心文件中的，我们在`core`文件夹中建立 `Router.php` 文件， 并先声明这个对象.

```php
<?php

    class Router 
    {
        protected $routers =[];

        public function define($routes)
        {
            $this->routes = $routes;
        }
    }
```

在`bootstrap.php`中我们要通过`require 'core/Router.php';`引入这个`Router.php`的文件,接下来在入口文件中创建`$router`这个对象，并调用`$router-define()`这个方法。

```php
<?php 

    $query = require 'core/bootstrap.php';

    $router = new Router;
    
    // $router调用define的代码都放在了routes.php中了，require进来就可以了。
    require 'routes.php';

```

到现在我们已经有了`$router`对象了，所有的路由也会在入口文件加载的时候通过`$router->define()`方法被赋值到`$router`的`$routes`属性中，下面我们只需要 `require` 路由对应的控制器类即可。

我们还会需要一个能够通过路由返回控制器类的实际路径的方法，方法就叫做`direct()`吧，先在入口页调用这个方法，然后再去实现它。

```php
<?php 

    // 加载引导文件，并且获取创建好的 `QueryBuilder` 的对象
    // 以后对数据库操作可以使用编写好的 `QueryBuilder` 的对象对方法
    $query = require 'core/bootstrap.php';

    // 创建路由对象
    $router = new Router;

    // 将自定义的路由赋给 $router 对象的$routes属性
    require 'routes.php';

    // 这里其实就是包含具体的控制器文件中的代码，因为['about' => 'controllers/about.php']
    // 这里相当于 require 'controllers/about.php`;
    require $router->direct('$uri');
```

接下来去实现`direct()` 这个方法， 在`Router` 类中编写下面的代码：

```php
<?php

    public function direct($uri)
    {
        // 如果数组中存在 $uri 这样的路由, 那么返还对应的值
        if (array_key_exists($uri, $this->routes)) {
            return $this->routes['$uri'];
        }
        
        // 不存在，抛出异常，以后这里改成 404 异常
        throw new Exception('No route defined for this URI');
    }
```

我们尝试把入口页面的`require $router->direct('$uri');`的 `$uri` 改成 `about`路由，能够正确的现实 about 的页面， 改成 `contact`, 能够访问 contact 页面了，改成`no-uri` 这样为定义的路由，就会抛出异常，差不多能实现我们的功能了。

### 获取用户输入的 uri
现在的问题是用户在浏览器输入 `http://my-php-framework.dev/about` 或者是 `http://my-php-framework.dev/contact`, 我们怎么拿到这个 uri呢? 在 php 中有一个 全局的 `$_SERVER` 变量, 我们在入口页面加上`var_dump($_SERVER);` 打印出它的值.

![var_dump](/images/php/step_1/8.jpg)

可以在`$_SERVER['REQUEST_URI']` 中获取我们要的 uri, 不过需要去掉字符串前的 `/`,可以使用 `trim($string)`函数来处理，`trim($string)` 默认去掉 $string 字符串两边的空格，但如果`trim($string, '/')`这样，就可以去掉字段串前后的 `/`  字符。 现在我们可以正确的得 `$uri` 了。

```php
<?php

    $uri = trim($_SERVER['REQUEST_URI'], '/');
```

入口页面 `index.php` 代码如下：

```php
<?php 

    // 加载引导文件，并且获取创建好的 `QueryBuilder` 的对象
    // 以后对数据库操作可以使用编写好的 `QueryBuilder` 的对象对方法
    $query = require 'core/bootstrap.php';

    // 获取用户在地址栏输入的 uri 并去除头尾的 / 字符
    $uri = trim($_SERVER['REQUEST_URI'], '/');

    // 创建路由对象
    $router = new Router;

    // 将自定义的路由赋给 $router 对象的$routes属性
    require 'routes.php';

    // 这里其实就是包含具体的控制器文件中的代码，因为['about' => 'controllers/about.php']
    // 这里相当于 require 'controllers/about.php`;
    require $router->direct($uri);
```

### 优化路由功能部分的代码

最基础的路由功能我们已经实现了，我们把入口页面的代码再优化下，我们理一下，我们其实是加载`routes.php`文件，然后返回其内数组的健所对应的值，我们写一句可读性好点的代码：

```php
<?php
    // 链式调用
    require Router::load('routes.php')
                  ->direct($uri);
```

这里的`Router::load('routes.php')`的功能是将`routes.php`中的数组赋给`$router->routes`属性，然后返回`$router`对象，`$router`再调用`direct($uri)`方法。看一下 `Router` 类中的 `load` 方法:

```php
    public static function load($file)
    {
        $router = new static;
        
        // 调用 $router->define([]);
        require $file;
        
        // 注意这里，静态方法中没有 $this 变量，不能 return $this;
        return $router;
    }
```

## 将 Request 分离出来

我们再来看 `$uri = trim($_SERVER['REQUEST_URI'], '/');`  这句代码，这种代码放这里的可读性太差了，任何人读到这里都会卡顿，如果把这句话换成 `Request::uri()` 那就语义话了。
这样入口文件就只有两句代码了.

```php
<?php 

$query = require 'core/bootstrap.php';

require Router::load('routes.php')
    ->direct(Request::uri());
```

我们来编写在`uri()` 方法， 在`core`下建立一个`Request.php`的类文件

```php
<?php

class Request
{
    public static function uri()
    {
        return trim($_SERVER['REQUEST_URI'], '/');
    }
}
```

好了，别忘记了在`bootstrap.php`中引入`Request.php`这个类。

## 优化下 bootstrap.php 文件中的变量 $config

看这句代码 `$config = require 'config.php';` 因为我们现在才用统一入口页面了，所以一个站点就是一个应用(APP), 因此这里的 `$config` 变量的生命周期很长，你会发现你再控制器类中可以使用它，在视图文件中也可以使用它，那么我们把这类的变量都放在一个`$app`的数组中应该会好一些,如下：
```php
<?php
// bootstrap.php

    $app = [];

    $app['config'] = require 'config.php';

    require 'core/Router.php';
    require 'core/Request.php';
    require 'core/database/Connection.php';
    require 'core/database/QueryBuilder.php';

    return  new QueryBuilder(
        Connection::make($app['config']['database'])
    );
```
## 重构后的代码和添加路由功能的版本 router

我把上面的代码放在了 `router` 分支上，使用`git checkout router` 可以切换到上面的代码.

## 视图文件的拆分

通常一张视图文件都会包含一些重复的部分，如头部，底部，导航条等，为方便维护，这些部分都会把它们独立出来，比如我们现在为每个页面添加导航菜单。 在`views`下新建`partials`文件夹，然后先建立一个`nav.php`,用来存放导航条

```html
<nav>
    <ul>
        <li><a href="/">Home</a></li>
        <li><a href="/about">About</a></li>
        <li><a href="/about/zhoujiping">About Zhoujiping</a></li>
        <li><a href="/contact">Contact</a></li>
    </ul>
</nav>
```

然后在其他的`xx.view.php`视图中通过 `require('partials/nav.php');` 引入进来，同理可用把`head`部分也独立出来。这里不贴代码了。

## CSS和JS文件

网站的css和js以及一些静态的资源文件我们在根目录下建立一个`public`的文件夹，然后分别建立对应的文件夹，其实`index.php`文件后期我们也要放在这里，后期会把网站的根目录指向这里，`css`和`js`文件我们可以通过`gulp`或者`webpack`将其打包后放在这里，这样我们网站的安全性会高很多。这里的文件夹自己建立，然后在`views`页面中引入进来即可。现在看下`index.view.php`页面，是不是清晰了很多, 其实用原生的php加上替代语法写视图文件也可以比较清晰的。我们自己的小项目很多时候并不用去选择框架做，自己搭建一个简单的框架去做，那样是最轻量的，开发效率也还是比较快的。

```php

    <?php require 'partials/head.php'; ?>
    <?php require 'partials/nav.php'; ?>

    <h1>Home Page</h1>

    <ul>
        <?php foreach ($tasks as $task) : ?>
             <li>
                <?php if ($task->completed) : ?>
                    <strike> <?= $task->description; ?> </strike>
                <?php else : ?>
                    <?= $task->description; ?>
                <?php endif; ?>
             </li>
        <?php endforeach; ?>
    </ul>

    <?php require 'partials/footer.php'; ?>
```

> 小问题： 上面的`nav.php`是可以在`head.php`中就包含的，但是通常我更喜欢把它们分开`head.php`基本对应`<head>`部分，我不想把`<body>` 中的也融合进去，有必要的话我会建立`head.php`和`header.php`两个文件，在`header.php`中在包含`nav.php`，或者将`nav.php`的内容直接放在`header.php`中，我感觉文件的命名和内部的内容需要对应，这样可读性会好些。

## php 常用操作数组的函数 `array_filter`, `array_map` 和 `array_colum`

### array_filter - 用回调函数过滤数组中的单元

这三个函数在`laravel`的源码中也用的挺多的，我们来讨论下，首先 `array_filter`，官方说明地址: http://www.php.net/manual/zh/function.array-filter.php 

** 用法： **

```php
array array_filter ( array $array [, callable $callback [, int $flag = 0 ]] )

// 代码中的写法一般为:

$array_filter_result = array_filter($array, function ($item) { // code });
```

** 解析：**

依次将 array 数组中的每个值传递到 callback 函数。如果 callback 函数返回 true，则 array 数组的当前值会被包含在返回的结果数组中。数组的键名保留不变。 如果没有提供 callback 函数， 将删除 array 中所有等值为 FALSE 的条目。这句话的意思是 `array_filter($array)` 可以返回值为空，为false

** 举例 **

一个博客的帖子会有发布状态和未发布状态，如下:

```php
<?php 

 class Post
 {
        public $title;

        public $published;

        public function __construct($title, $published)
        {
            $this->title = $title;

            $this->published = $published;
        }
     }

     $posts = [
        new Post('My First Post', true),
        new Post('My Second Post', true),
        new Post('My Third Post', true),
        new Post('My Fourth Post', false),
     ];
```

下面筛选出未发布的帖子

```php
 $unPublishedPosts = array_filter($posts, function ($post) {
    return $post->published === false;
 });
 ```
按照需求代码是上面这样的，优化下:

```php
 $unPublishedPosts = array_filter($posts, function ($post) {
    return ! $post->published;
 });

我们如果打印`$posts`的值，发现是没有改变的，所以`array_filter`是不会改变原数组的值的，所以在回调函数中不要去改变原数组，否则会出现未知错误。

### array_map 为数组的每个元素应用回调函数

** 用法 **

```php
array array_map ( callable $callback , array $array1 [, array $... ] )
```

** 说明 **

`array_map()`：返回数组，是为 array1 每个元素应用 callback函数之后的数组。 callback 函数形参的数量和传给 array_map() 数组数量，两者必须一样。 文档地址 http://php.net/manual/zh/function.array-map.php

** 例子 **

如果要把所有的帖子都设置成发布状态，那就可以使用`array_map` 来操作
```php
$modifyPosts = array_map(function ($post) {
    $post->published = true;
    return $post;
}, $posts);
```

`array_map` 很大的一个作用可以用来处理接口返回的数据，比如我想`$published` 返回的值为`1`或`0`可以这样：

```php
 $modifyPosts = array_map(function ($post) {
    $post->unpublished ? $post->published = 1 : $post->published = 0;
    return $post;
}, $posts);
```

### array_column — 返回数组中指定的一列

文档 http://php.net/manual/zh/function.array-column.php

比如我想返回所有的帖子标题， 我们可以通过 `array_map()` 来做到这点 

```php

     $titles = array_map(function ($post) {
        return $post->title;
    }, $posts);
```

用`array_column` 就更简单了
```
$titles = array_column($posts, 'title');
```
> 上面的$title 是针对 public 属性的才有效， 如果是`protected`或`private`属性的，类需要实现 __get() 和 __isset() 魔术方法，具体看文档。

`array_column()` 还可以添加第三个参数，第三个参数会作为 `title` 的 key 返回, 我们在`Post`类中加一个 `author`的属性，然后将代码改成这样：

```php
    $titles = array_column($posts, 'title', 'author');
```
返回的数据中会变成`author`, `title`为值的关联数组。

## 解决路由中已知的一些问题

开发 web 项目， 表单`form`是肯定少不了的，我们在`index.view.php`上写一个简单的来测试, 先来测试 `GET` 方式

```php
    <?php require 'partials/head.php'; ?>
    <?php require 'partials/nav.php'; ?>

    <h1>Submit Your Name</h1>

    <form action="/names" method="GET">
        <input type="text" name="name">
        <button type="submit">Submit</button>
    </form>

    <?php require 'footer.php'; ?>
```

`routes.php` 中添加上对应的`names` 路由

```php
<?php

    $router->define([
        ''                  => 'controllers/index.php',
        'about'             => 'controllers/about.php',
        'about/zhoujiping'  => 'controllers/about-zhoujiping.php',
        'contact'           => 'controllers/contact.php',
        'names'             => 'controllers/add-name.php'
    ]);
```

在控制器中建立`add-name.php`, 先输入 `var_dump($_SERVER)`, 然后测试一下，毫无悬念的出错了
![路由出错](/images/php/step_1/9.jpg)

出错原因是提示找不到路由，这很正常，我们之前的思路是以用户输入的`uri`的`path`为`key`, 去寻找`$router->routes`数组中对应的值是否存在，我们在`Request.php`中的`uri()`方法出了问题。我们现在的方法是这样的。

```php
    public static function uri()
    {
        return trim($_SERVER['REQUEST_URI'], '/');
    }
```

我们只是去除了 uri 两端的 `/` 字符， 而现在的 uri 是 `/names?name=zhoujiping` 去除了两头的`/`, 那就变成了`names?name=zhoujiping`, 而我们定义的路由是`names`, 所以肯定是找不到的，现在我们需要提取出正确的 `path`,可以使用 php 的原生函数 `parse_url` 函数的官方文档在这里  http://www.php.net/manual/en/function.parse-url.php 通过 `parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH); 就可以得到正确的 `/names` 了，然后再去除两端的 `/`, 关于 `PHP_URL_PATH` 常量的意思，查下文档就行。现在 `uri()` 改成如下：

```php

    public static function uri()
    {
        return trim(
            parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH), '/'
        );
    }
```

现在在测试一下，没有问题了，下面把`index.view.php` 中的 `form method` 改成`post`, 然后将`add-name.php`中的内容改成`var_dump($_REQUEST);` 这里的 `$_REQUEST` 可以接受通过`get`或是 `post` 方法传递来的参数值。我们通过表单提交（post 请求方式）后可以正确访问，没有问题，但是我们刷新页面，请求方式变成了`get`, 还是能显示页面，这是我们不希望看见的，我们希望这条路由仅仅提供给 `post` 方式， 而别的请求方式是不能访问的。这一步我们还没有做。

假设在路由页面 `routes.php` 我们的路由可以这么写：

```php
<?php

    $router->get('', 'controllers/index.php');
    $router->get('about', 'controllers/about.php');
    $router->get('about/zhoujiping', 'controllers/about-zhoujiping.php');
    $router->get('contact', 'controllers/contact.php');
    $router->post('names', 'controllers/add-name.php');
```

如果我们的`$router`对象具有`get()`和`post()` 方法，通过这些方法能指定路由的请求方式，那之前的问题就能解决了。解决的思路：

1. 在`$router->routes` 数组中定义 key 为`GET` 和 `POST` 的一维数组
2. 建立`get` 方法，将`get`方式的路由放进`GET`数组中
3. 建立`post`方法，将`post`方式的路由放进`POST`数组中
4. 判断用户访问的路由的请求方式，根据请求方式和 path 对应到`GET`或是`POST`数组中查询 path 对应的值返回。

需要更改的地方及代码如下：

** index.php **

```php

// require Router::load('routes.php')->direct(Request::uri());

// 修改为

require Router::load('routes.php')
    ->direct(Request::uri(), Request::method());
```

** Request.php 添加 method() 方法**

```php
    public static function method()
    {
        return $_SERVER['REQUEST_METHOD'];
    }
```

** Router.php 删除 define() 方法， 修改 routes 属性， 添加 get() 和 post() 方法， 修改 direct() 方法**

```php
<?php

    class Router 
    {
        protected $routes =[
            'GET'  => [],
            'POST' => []
        ];

        public static function load($file)
        {
            $router = new static;
            
            // 调用 $router->define([]);
            require $file;

            return $router;
        }

        public function get($uri, $controller)
        {
            $this->routes['GET'][$uri] = $controller;
        }

        public function post($uri, $controller)
        {
            $this->routes['POST'][$uri] = $controller;
        }

        public function direct($uri, $requestType)
        {
            if (array_key_exists($uri, $this->routes[$requestType])) {
                return $this->routes[$requestType][$uri];
            }

            throw new Exception('No route defined for this URI');
        }
    }
```
实际项目中还会使用到 `put/patch`, `delete` 的请求方式，可以用到的时候再加上这样的方法。


## 使用 PDO 动态插入数据到数据库

现在我们可以正常的获取 `post` 请求过来的数据，我们把`form`表单传递过来的`name`存储到数据库中，先在数据库中创建`users`表,
里面有一个类型为`string` 的 `name`字段。

我们先将`bootstrap.php` 中的`QueryBuilder`对象储存到`$app['database']`中， 其他对应的地方自己修改下。

```php
// bootstrap.php

$app['database'] = new QueryBuilder(
    Connection::make($app['config']['database'])
);
```

假设我们的`QueryBuilder`对象已经拥有一个`insert`的方法， 那么在`add-name.php`中就可以这样调用.

```php
    // insert($table, $parameters)
    $app['database']->insert('users', [
        'name' => $_POST['name']
    ]);
```

现在去`QueryBuilder.php`中实现这个方法.

```php
    // QueryBuilder.php
    public function insert($table, $paramters)
    {
        // insert to users (name, age) values ('zhoujiping', 3);
    }
```

向数据库中插入数据的 `sql` 语言为 `insert into 表名 (表字段1, 表字段2 ...) values ('对应的值', '对应的值')`, 这里的表名，表字段和值都是动态的，是由我们传递进来的，相当于上面的 `sql` 语句的模版是这样的 `insert into %s (%s) values (%s)`。 我们可以通过字符串链接符 `.` 来拼装我们需要的 sql 语句， 不过在 php 中还有一个更好的函数叫做 `sprintf()` 可以帮我们做到这点，比如说:

```php
    public function insert($table, $parameters)
    {
       $sql  = sprintf(
        'insert into %s (%s) values (%s)',
        'one', 'two', 'three'
        );

       var_dump($sql); die;
    }
```

打印上面的 `$sql` 变量， 结果是 `string(36) "insert into one (two) values (three)"`, 看下结果就会知道`sprintf()`的用法了， 现在我们就来替换掉`one`, `two`, `three` 这三个值了， 首先`one`对应的是数据表名，就是我们参数中的`$table`。

`two`是数据表的字段名，也就是我们 `$parameters` 的 key, 通过 `array_keys($parameters)` 可以获取由 $parameters 健值组成的一维数组,类似于`[name, age, email]`这样的，而我们这里需要的是 string 类型的, 类似这样的`(name, age, email)`， 如何将数组转成需要的字符串呢？ 如果不知道这样的php函数， 可以通过 google ` php array to string` 这样的关键词去搜索，我们会发现 `implode()` 函数可以解决这个问题 `implode(', ', $parameters)`。

接着是`three` 字段对应的值，使用 PDO 插入数据都会需要经过一些 sql 语句的预处理，这里可以先用类式 `(:name, :age, :email)`这样的占位符， 然后执行的时候替换掉占位符即可。这样就能正确的插入数据到数据库了，完整的代码如下：

```php

    public function insert($table, $parameters)
    {
       $sql  = sprintf(
            'insert into %s (%s) values (%s)',
            $table,
            implode(', ', array_keys($parameters)), 
            ':' . implode(', :',array_keys($parameters)) //  这句不喜欢可以用array_map处理下
        );

       try {
            $statement = $this->pdo->prepare($sql);
            $statement->execute($parameters); // 执行时替换 :name ['name' => '周继平'] 
       } catch (PDOException $e) {
           die($e->getMessage());
           // 如果是正式环境
           // die('Something went wrong.');
        }
    }

```
现在可以插入值到数据库了，不过页面上没有显示，先到数据库看下就行了，也可以在`add-name.php` 添加 `header('Location: /')` 让其暂时跳往首页。然后在`controllers/.index.php` 中使用`$app['database']->selectAll('users')`, 获取 users 数据， 在`index.view.php` 中显示它们，如下：

```php
    <?php foreach ($users as $user): ?>
        <li><?= $user->name; ?></li>
    <?php endforeach ?>
```

## 添加 composer 依赖包管理

现在看我们的`bootstrap.php`中有一堆的`require` 语句，这么操作显然很麻烦，现在有一个 php 的包依赖管理工具很流行，叫做 composer 官方地址为： https://getcomposer.org/ 先按照提示进行全局安装。先将 `bootstrap.php`中的下面4句代码注销

```php
    // require 'core/Router.php';
    // require 'core/Request.php';
    // require 'core/database/Connection.php';
    // require 'core/database/QueryBuilder.php';
```

然后在根目录下建立 `coomposer.json` 的文件,输入以下内容:

```json
    {
        "autoload": {
            "classmap": [
                "./"
            ]
        }
    }
```

上面的意思是将根目录下的所有文件都让其自动包含进来， 我们在命令行执行 `composer install`, 然后只需要在`index.php`添加`require 'vendor/autoload.php';` 即可。我们可以看见我们想要包含的文件都已经在`vendor/composer/autoload_classmap.php`文件中生成了对应关系。

## 实现第一个 依赖注入容器 DI Container 的雏形

什么是 依赖注入容器 DI Container? 一个听上去非常高大上的东西，先不要去纠结字面的意思，你可以这么想，把我们的 APP 想象成一个很大的盒子，把我们所写的一些功能，比如说配置，数据库操作的`QueryBuilder`都扔到这个盒子里，但是扔进去的时候你要给它们贴一个标签，以后可以通过这个标签把它们取出来用。大体就是这个意思。


我们来看`bootstrap.php` 中的代码， 其实 `$app` 这个数组就是一个容器，我们把配置文件扔到数组中，贴上`config`的标签，把`QueryBuilder`也扔进去了，贴上标签`database`。之后我们可以通过`$app['config']`这样拿出我们要的东东。

```php

    $app = [];

    $app['config'] = require 'config.php';

    $app['database'] = new QueryBuilder(
        Connection::make($app['config']['database'])
    );
```

我们为何不把`$app`数组做成一个对象呢！ 这样我们以后可以为其添加很多的属性和方法，会方便很多，需要对象就必须要有类，我们马上就可以在`core`文件夹内建立一个 `App.php` 的文件，当中包含`App`类。下面看看我们需要哪些方法，先看 `$app['config'] = require 'config.php';` 这一句是把`config.php`放进到`App`的容器中，现在常用的说法是 注册`config` 到`App`, 或者是绑定`config` 到`App`, 那我们需要的方法可能是这样的。

```php

    $app->bind('config', require 'config.php');
    // 或者
    $app->register('config', require 'config.php');
    // 或者
    App::bind(config', require 'config.php');
    // 或者
    App::register('config', require 'config.php');
```

在我们写类的时候，可能不知道怎么动手，可以先尝试着调用假定存在的方法，再回头去完善类，相对会容易些，上面的几种方法个人感觉`App::bind(config', require 'config.php');`更好些，然后要取出`config`可以使用 `App::get('config')` 方法，下面去实现这两个方法。在`core/App.php` 中

```php
<?php 

     class App
     {
        protected static $registries = [];

        public static function bind($key, $value)
        {
            static::$registries[$key] = $value;
        }

        public static function get($key)
        {
            if (! array_key_exists($key, static::$registries)) {
                throw new Exception("No {$key} is bound in the container.");
            }

            return static::$registries[$key];
        }
     }
 ```

将之前使用到`$app['config']`和`$app['database']`的地方全部用`App::get('config')`和`App::get('database')`替换过来，然后我们测试一下，毫无疑问的会提示“找不到APP的错误”，原因是在我们的`autoload_classmap.php`文件中并没有导入`App.php`文件，我们需要在命令行执行 `composer dump-autoload` 来重新生成`autoload_classmap.php`文件。


## 重构控制器为控制器类

现在我们的控制器中的代码还都是一些面条式的代码,现在我们将做出我们的控制器类，然后让路由指向到对应的控制器的方法，这样在我们以后的工作流中就会方便很多。

我们在`controllers`文件夹下建立 `PagesController.php` 的文件, 编写以下的代码

```php
<?php 

    class PagesController
    {
        public function home()
        {
            $users = App::get('database')->selectAll('users');

            require 'views/index.view.php';    
        }

        public function about()
        {
            require 'views/about.view.php';
        }

        public function contact()
        {
            require 'views/contact.view.php';
        }
    }
```

现在可以将`controllers`文件夹下的`index.php`, `about.php`, `contact.php`都删除了，现在我们访问首页肯定是出错的，因为我们的路由文件还没有改过来。我们可以将路由改成类式`laravel`框架的模样

```php
<?php

    $router->get('', 'controllers/PagesController@home');
    $router->get('about', 'controllers/PagesController@about');
    $router->get('contact', 'controllers/PagesController@contact');
```

我们现在使用 `composer` 的自动加载文件，路经换成下面这样也是能够找到对应的文件的。

```php

    $router->get('', 'PagesController@home');
    $router->get('about', 'PagesController@about');
    $router->get('contact', 'PagesController@contact');
```

比方说上面的`about`的路由，意思是当访问`about`,就调用`PagesController`类的`about`方法, 所以我们要修改`Router.php`中的`direct()`方法。目前我们通过`$this->routes[$requestType][$uri]` 返回的是类式`PagesController@home`这样的 uri， 现在事实上我们希望的是这样的代码 `(new PagesController)->home();` 我们先假定有这样的方法叫做 `callAction()`,改下下现在的`direct()`方法.

```php

    public function direct($uri, $requestType)
    {
        if (array_key_exists($uri, $this->routes[$requestType])) {
            return $this->callAction();
        }

        throw new Exception('No route defined for this URI');
    }
```

我们来建立 `callAction()` 方法, 大体是这样的：

```php

    public function callAction($controller, $action)
    {
        $controllerObj = new $controller;

        if (! method_exists($controllerObj, $action)) {
            throw new Exception(
                "{$controller} does not respond to the {$action} action."
            );
        }

        return $controllerObj->$action();
    }
```

上面的代码很简单，不用讲解，现在的问题是`direct()` 中调用`callAction()`的参数我们该如何获取，现在已经知道`$this->routes[$requestType][$uri]`的值是类式于 `PagesController@home` 这样的字符串，我们可以用`$this->routes[$requestType][$uri]` 将其拆分为 `['PagesController', 'home']` 这样的数组，然后使用 php5.6 之后出现的 `...`运算符，将其作为参数传递，我们具体来看下`explode()` 函数。

打开终端，输入 `php --interactive` 进入命令行交互模式

```bash
$ php --interactive

php > $values = explode('@', 'PagesController@home');
php > var_dump($values);
array(2) {
  [0]=>
  string(15) "PagesController"
  [1]=>
  string(4) "home"
}

```

现在看下`direct()` 方法:

```php

    public function direct($uri, $requestType)
    {
        if (array_key_exists($uri, $this->routes[$requestType])) {
            return $this->callAction(
                ...explode('@', $this->routes[$requestType][$uri])
            );
        }

        throw new Exception('No route defined for this URI');
    }
```

下面更改下 `PagesController` 的 `require 'views/about.view.php';` 这句代码，我们改成 `return view('about');` 这样，可读性会好很多。在`bootstrap.php` 上加上我们的这个`view()` 全局函数

```php

    function view($name)
    {
        $name = trim($name, '/');
        
        return require "views/{$name}.view.php";
    }
```

在看`PagesController`的`home` 方法当中有`$users`对象集合， 我们怎么传递它到`view`中呢？ 假设可以这样：

```php
    return view('index', ['users' => $users]);
```

更改全局函数`view()` 如下：

```php

    function view($name, $data =[])
    {
        extract($data);

        return require "views/{$path}.view.php";
    }
```

关于 `extract($data)`, 它可以将数组中将变量导入到当前的符号表， 看下输出就明白了，我们在命令行测试下：

```php
php > $data = ['user' => 'zhoujiping'];
php > extract($data);
php > echo $user;
zhoujiping
```

我们在`routes.php` 再创建这样一条路由:

```php
    $router->get('users', 'UsersController@index');
    $router->post('users', 'UsersController@store');
```

建立 `UsersController` 控制器

```php

<?php 

    class UsersController
    {
        public function index()
        {
            $users = App::get('database')->selectAll('users');

            return view('users', compact('users'));
        }

        public function store()
        {
            App::get('database')->insert('users', [
                'name' => $_POST['name']
            ]);

            return redirect('users');
        }
    }
```

视图层自己建立下， 看上面的`redirect()`全局函数， 如下

```php
    function redirect($path)
    {
        header("Location: /{$path}");
    }
```

## 命名空间

命名空间，把它想象成文件夹就可以了， 我们现在所有的类都在同一个命名空间下， 我们可以为类加上自己的命名空间





















































