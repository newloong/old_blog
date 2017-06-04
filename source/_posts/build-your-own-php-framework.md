---
title: 论PHP框架是如何诞生的?
date: 2017-05-23
updated: 2017-06-04
categories:
 - php
---

> 本文已经过二次修订，源码地址： https://github.com/zhoujiping/build-your-own-php-framework

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

## 安装 Mysql

一个 Web 站点上会有很多的数据，我们可以把这些数据放在文件中进行储存，比如像我这个新博客中的文章，就是存储在文件中的。 但是如果一个 Web 站点的数据会经常需要增删改查，那就需要一个数据库来保存它们了。我们经常使用的数据库管理系统有 `SQLite, Mysql, NOSQL, MongoDB` 等， 可以根据自己的需要来选择其中一个或几个搭配使用，不过 `Mysql` 和 `PHP` 基本已经成了黄金搭档了。

如果已经安装了集成开发环境的话，那你就可以直接使用数据库了，你也可以单独安装它，在 Windows 下可以下载安装包直接安装， 在 Mac Os 系统上，我们可以通过 `Homebrew` 来安装 `Mysql`， 具体的安装方法可以看我下面这篇文章中的安装 Mysql 的部分

> [全新安装Mac OS Sierra (10.12)并使用HomeBrew安装ZSH + MNMP (Mac + Nginx + Mysql + Php) 开发环境](http://blog.zhoujiping.com/notes/mnmp.html)

## 登录 Mysql 数据库

开启`mysql`服务后，（如何开启，可以 Google）, 在终端通过`mysql -u 用户名 -p 密码` 就可以登录到`mysql`中, 如下:

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

## 常用的一些 Mysql 命令

### 查看 Mysql 内所有数据库 `show databases;`

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

### 创建一个新的数据库 `create database 数据库名`

我们可以使用 `create database 数据库名` 来创建一个数据库， 如我们现在创建一个 `test` 的数据库, 如下：

```bash

    # 下面的 mysql> 代表目前你处于 mysql 的环境中
    # create database test;  是sql语句，不是命令，不要忘记了分号
    mysql> create database test; 
```

### 切换当前数据库 `use 数据库名`

现在通过 `show databases;` 就能看见刚才创建的 `test` 数据库了，当你要具体操作某一个数据库的时候，你得通过`use 数据库名` 切换到你要操作的数据库，`Mysql` 数据库管理系统可以存放很多的数据库，你需要先指定使用哪个数据库，然后才可以对应进行操作。

```bash

    mysql> use test;

    Database changed
```

### 查看所有数据表 `show tables;`

一个数据库中会存在很多表，一个表中会存在很多字段，你可以把数据库想象成一个文件夹，把数据库表想象成 Excel 文件，把数据库的字段想象成 Excel  文件中的每一个列。一个文件夹中可以有很多的 Excel 文件， 一个 Excel 文件中也可以有很多的列， 同理，一个数据库中有很多的表，一个表中有很多的字段（字段就相当于列）。

通过 `show tables;` 我们可以查看指定数据库的所有数据表：

```bash

    mysql> show tables;
    Empty set (0.00 sec) # 目前我们还没有建立表，是空的
```

### 创建数据表 `create table 数据表名`

我们刚才说了，数据表就相当于是 Excel 文件，那每个文件都会有个名称，并且每个 Excel 文件中会存在很多列, 我们的数据表把这个列叫做字段，我们可以通过 `create table 数据表名(字段1， 字段2 ...)` 来创建一个包含字段的数据表，我们先来看一条创建表的 Sql 语句, 比如我们创建一个 `users` 表， 这个 `users` 表有 `id`, `name`, `is_admin` 三个字段。

按照上面我们给出的创建表的语句模版，我们可以写出像下面这样的 `Sql` 语句:

```sql

    create table users (id, name, is_admin);
```

上面这样的语句运行的时候是会出错的，原因是我们给数据库表创建字段的时候还需要指定它的类型，如 `id`, 应该是整形的，`name` 应该是字符串类型的， `is_admin` 应该是 Boolean 型的。 另外为了避免表中的数据重复，我们通常会将 `id` 设置为主健，并让它的数字能主动增长，而不用手动插入， 同时像 `name` 这种字段的值我们希望是必填的，所以会加上 `NOT NULL` 这样的附加条件， 所以我们的 Sql 语句太多是这样的：

```Sql
    
    create table users ( 
        id integer PRIMARY KEY AUTO_INCREMENT, 
        name varchar(255) NOT NULL, 
        is_admin boolean NOT NULL
    );
```

更多关于字段的类型和属性，访问官网： https://dev.mysql.com/doc/refman/5.7/en/create-table.html 


### 查看数据表字段属性 `describe 数据表名`

通过 `describe 数据表名;` 可以查看这个表内每个字段的具体属性，比如我们看下刚才创建的`users`表各字段属性：

```bash

    mysql> describe users;
    +----------+--------------+------+-----+---------+----------------+
    | Field    | Type         | Null | Key | Default | Extra          |
    +----------+--------------+------+-----+---------+----------------+
    | id       | int(11)      | NO   | PRI | NULL    | auto_increment |
    | name     | varchar(255) | NO   |     | NULL    |                |
    | is_admin | tinyint(1)   | NO   |     | NULL    |                |
    +----------+--------------+------+-----+---------+----------------+
```

### 插入数据到表中 `insert into 数据表名 (字段 ...) values (值 ...)`

现在我们已经有了数据表，而且也在数据表定义了三个字段，我们可以为每个字段添加数据了。通过`insert into 数据表名 (字段 ...) values (值 ...)` ，如下：

```bash

    insert into users (name, is_admin) values('周继平', true);
```

### 查询表中的所有数据 `select * from 表名`

```bash

    mysql> select * from users;
    +----+-----------+----------+
    | id | name      | is_admin |
    +----+-----------+----------+
    |  1 | 周继平    |        1 |
    +----+-----------+----------+
```

> sql 也是一门语言， 需要花时间单独去学习，上面只是简单的例举了下，官方文档在： https://dev.mysql.com/doc/ 

##  用Mysql客户端管理工具来管理Mysql数据库

通常很少真有人一直在命令行去操作数据库，在 `Mac` 上可以使用 `Sequel pro` 来管理， 在 `Windows` 上可以用 `Navcat`

> Sequel pro - http://www.sequelpro.com/  免费, 简单易用，只支持 `Mac` 系统
> Querious - http://www.araelium.com/querious/ 只支持 `Mac` 系统，收费
> Navcat - https://www.navicat.com.cn  收费，支持`Mac`, `Windows`, `Linux`

## 开始开发一个 todoList 的 小项目

Mysql 我们也安装完了， 简单的 Sql 语句也学了一些， 下面我们开始开发一个待办任务列表 todoList 的小项目。

## 编写 Task 类

现代的 PHP 开发都是基于面像对象的，我们可以将任何东西都看作对象，对象可以创建一个或多个，有些对象会有一些相同的特征，所以我们会基于一个模版来创建这些对象，而这个模版我们可以称呼为“类”, 我们用关键词 "class" 即可以声明一个类。

现在我们要开发一个 代表任务列表 的项目， 首先我们会需要有任务这个对象 `$task`, 那就必须先有 `Task` 这个类, 我们在 `index.php` 中先定义这个类， 如下：

```php

    <?php 

    class Task 
    {
        // 任务的描述
        protected $description;

        // 该任务是否完成
        protected $completed = false;
        
        // 构造函数， 创建 Task 对象的时候会被调用
        public function __construct($desc)
        {
            $this->description = $desc;
        }
    }

    $taskOne = new Task('写博客');
    $taskTwo = new Task('中午去幼儿园打小男孩');

    var_dump([$taskOne, $taskTwo]);
    die;
```

上面的 `Task` 就是一个类，我们可以通过 `new 类名` 来创建对象，像上面我们通过`new Task('xx')` 创建了两个任务。我们希望在创建任务对象的时候能将具体的任务内容也生成，PHP 给每个类都提供了一个构造方法 `__construct`,这个方法会在你创建一个对象的时候自动调用，php 给我们提供的类式这样的方法我们叫做魔术方法，魔术方法都是以 `__` 开始的。

我们再来看 `Task`, 在这个类中有 `$description, $completed ` 两个变量， 有`__construct` 这个函数，不过在类中，我们把像上面这样的变量叫做类的“属性”，把函数叫做类的“方法”。

在 `$description` 前面的 `protected` 这个关键词是用来限定访问权限的, 一共有三种权限：

> private - 使用了该修饰符的属性和方法只能在类的内部调用;
> protected - 使用了该修饰符的属性和方法可以在该类和该类的子类中调用
> public - 使用了该修饰符的属性和方法在类的内外部或者子类中都可以调用

看构造函数中的这句代码 `$this->description = $desc;`  `$this` 代表的是当前对象，如果是`$taskOne`对象调用了 `$description` 属性， 那这里的 `$this` 就代表`$taskOne` 这个对象， 如果是`$taskTwo`调用 `$description` 属性， 这里的 `$this` 就代表 `$taskTwo` 这个对象。这里的 `->` 符号是对象调用属性和方法的操作符。

上面说到 `$compoleted` 是被 `protected` 修饰的，所以我们不能在类外部直接调用它，但是我们可以编写一个方法，在这个方法中返回 `completed` 这个属性, 如下:

```php

    public  function isComplete()
    {
        return $this->completed;
    }
```

这样就可以通过 `$taskOne->isComplete()` 来获取 `$taskOne` 对象的 `$completed`的值了。为什么不直接将`$compoleted`　的访问权限修改成 `public` 呢？ 这里主要是为了安全性的考虑，我们可以在`isComplete()` 方法添加一些判断条件，只将`$completed` 返回给符合条件的对象。这里就扩充代码了。

在开发的时候，最好不要预先就将属性的访问修饰符设置成`public`, 先将属性设置成 `private`, 然后根据需要来修改访问权限。

既然 `$completed` 属性是 `protected`(受保护的)，那么在类的外部我们也不能修改它的值， 要修改它的值，我们还得再编写一个方法，如下：

```php

    public function complete()
    {
        $this->completed = true;
    }
```

## 创建 todolist 数据库

现在我们去创建一个`todolist`的数据库，然后在当中创建一个`tasks`的表, 字段有自增长的主健`id`, 文本( text )类型的`description`, 和 boolean 类型的`completed` ， 自己创建一下，然后 `tasks` 表中随意插入点数据。

![task数据库数据](/images/php/step_1/4.jpg)

## 什么是 PDO 扩展？

现在我们的数据库已经有了，我们如何通过 PHP 去连接数据库操作执行对应的操作呢？ 很久很久以前，我们会用`mysql_connect()`这样的函数， 但是这种函数存在很大的安全问题，具体安全问题回头再说。 现在 PHP 提供了一些更好的数据库扩张来操作数据库, 首先 PHP 提供了一些像 `DBA`, `ODBC`, `PDO`等数据库抽象层，我们使用`PDO`来连接我们的数据库。

PHP 数据对象 （PDO） 扩展为PHP访问数据库定义了一个轻量级的一致接口。实现 PDO 接口的每个数据库驱动可以公开具体数据库的特性作为标准扩展功能。 利用 PDO 扩展自身并不能实现任何数据库功能；必须使用一个 具体数据库的 PDO 驱动 来访问数据库服务。PDO 提供了一个 数据访问 抽象层，这意味着，不管使用哪种数据库，都可以用相同的方法来查询和获取数据。

## 创建 PDO 资源对象

我们可以通过下面这句代码来创建一个 PDO 的资源对象

```php

    $pdo = PDO('mysql:host=127.0.0.1;dbname=todolist', 'username', 'my_password');
```

> - mysql - 告诉pdo我要连接的是 mysql 数据库
> - host=127.0.0.1 地址，你的mysql装在哪个服务器上，IP或地址是多少，我们跑在本地，所以是127.0.0.1或localhost
> - dbname - 数据库名
> - username - 登录mysql的用户名
> - my_password - 登录mysql的密码

这里我们通过 `new PDO()` 创建了 PDO 的资源对象， 并将该对象赋值给 `$pdo` 变量, 代码没有任何问题，但是可能会因为数据库软件没有运行，或者是用户名和密码输错而导致异常，从而导致不能正常的连接数据库，如果出错了，PDO 对象会自动抛出一个 `PDOException` 的异常，我们再写代码的时候最好是要将这个异常给捕获的，通过`try...catch`就可以来处理了，如下：

```php

    try {
        $pdo = new PDO('mysql:host=127.0.0.1;dbname=todolist', 'username', 'my_password');
    } catch (PDOException $e) {
        die('Sorry, could not connect');
    }
```

按照字面意思的翻译就是 我们试着通过 PDO 去连接数据库， 如果连接成功，那就继续执行代码，如果出现了异常，PDO 会自动抛出这个 PDOException 的异常，我们在 catch 中捕获它。可以自己尝试一下。

## 获取数据表 tasks 中的所有数据

现在我们已经成功的通过 PDO 连接数据库，并创建了 PDO 的资源对象，下面可以通过`$pdo`对象去执行 sql 语句来操作数据库了，通常为了安全起见，都需要对 `sql` 语句进行预处理，然后执行它，如下：

```php

    // 预处理 sql 语句, 返回 PDOStatement 对象
    $statement = $pdo->prepare('select * from tasks');

    // 执行预处理语句
    $statement->execute();

    // 通过 PDOStatement 对象的 fetchAll() 方法
    $tasks = $statement->fetchAll(PDO::FETCH_OBJ);
```

> PDO 官方文档 http://php.net/manual/zh/book.pdo.php 

## 为什么使用 PDO 扩展？

为什么要使用 PDO 扩展， 而不使用以前的 `mysql_connect()` 之类的函数呢？ 这里主要是为了防止`sql注入`的安全问题, 在正式项目中我们基本不会查询出一个表中的所有数据显示给用户，通过都会有一些限定条件，比如说，我们现在想要查询出已完成的任务或着是只查询出未完成的任务， sql 语句如下：

```sql

    select * from tasks where completed = ?;
```

`?` 这里的值是可变的，是由用户传递过来的，我们希望用户通过传`1` 或者 `0` 来获取完成或者未完成的任务列表，但是往往用户不会这么做，如果用户输入`1 or true`, 或者是 `0 or true`   如果不做处理，就会把所有的任务都读取出来了。而使用 PDO 扩展， 它有一个 sql 语句的预处理机制， 可以防止这些 sql 注入问题的发生。如果是像`mysql_connect()`函数就不具备这种功能了，不过所幸的是自 `php5.5` 开始已经废除了这个函数，所以说安装最新的 PHP 版本是非常用必要的。


## Model层对象和数据库返回对象的对应

我们打印出 `$tasks` 的结果，如下：

![tasks的对象](/images/php/step_1/5.jpg)

从上图我们可以看出 `$tasks` 数组中包含的是两个是两个php标准对象(stdClass)， 但是如果我们在获取对象的时候能得到两个`Task` 对象， 那就能将 `Task` 类和数据库中的 `tasks` 表给对应起来，再将`Task`类的属性和`tasks`表中的字段也一一对应起来，那就可以很方便的使用 `Task` 类来操作 `tasks` 数据表了。现在的`ORM`其实就是这个思想。如何做到，很简单，我们只需要给`$statement->fetchAll(PDO::FETCH_OBJ);` 改写一下即可：

```php

    $tasks = $statement->fetchAll(PDO::FETCH_CLASS, 'Task');
```

将常量 `PDO::FETCH_OBJ` 换成 `PDO::FETCH_CLASS` 常量，并通过第二个参数`Task` 指定返回的对象是 `Task` 类的对象， 这里使用了 PHP 的反射机制，它会去寻找`Task`类，并创建其对象。我们现在还没有'Task'类，我们去根目录下新建一个`Task.php`的文件，在里面定义 `Task` 类， 如下：

```php

    <?php 

    class Task 
    {
        // 任务的描述
        protected $description;

        // 该任务是否完成
        protected $completed;
        
        // 获取 $completed 的值
        public  function isComplete()
        {
            return $this->completed;
        }

        // 设置任务已完成 
        public function complete()
        {
            $this->completed = true;
        }
    }
```

index.php 中的代码如下：

```php

    <?php 

    require 'Task.php';

    try {
        $pdo = new PDO('mysql:host=127.0.0.1;dbname=todolist', 'username', 'my_password');
    } catch (PDOException $e) {
        die('Sorry, could not connect');
    }

    // 预处理 sql 语句, 返回 PDOStatement 对象
    $statement = $pdo->prepare('select * from tasks');

    // 执行预处理语句
    $statement->execute();

    // 通过 PDOStatement 对象的 fetchAll() 方法
    $tasks = $statement->fetchAll(PDO::FETCH_CLASS, 'Task');
```

现在返回的 $tasks 数组中就都是 `Task` 类的对象了

![ORM](/images/php/step_1/6.jpg)

我们在 `Task` 类中声明的任何属性和方法，都能够被 `$tasks` 内的对象调用了。

## 第一次代码重构

首先什么是代码重构？代码重构的意思是在不影响功能的前提下对现有代码的结构进行改变，对类，方法进行重命名，对代码、接口进行抽取，对字段进行重新封装等。

现在我们已经能够成功的连接到数据库，并拿到数据表中的数据，同时也做了类与表的简单映射，不过我们的代码很乱，我们来做一次简单的重构。

首先我们来看 `index.php` 中的通过 PDO 连接数据库这一段代码，我们将其封装为一个函数，放进到 `functions.php` 中, 如下：

```php

    function connectToDb()
    {
        try {
            return new PDO('mysql:host=localhost;dbname=mytodo', 'username', 'my_password');
        } catch (PDOException $e) {
            die($e->getMessage());
        }
    }
```

然后将获取 `Tasks` 表中所有数据的代码也封装成一个函数，放在 `functions.php` 中，如下：

```php

    function fetchAllTasks($pdo)
    {
        $statement = $pdo->prepare('select * from tasks');
        $statement->execute();

        return $statement->fetchAll(PDO::FETCH_CLASS, 'Task');
    }
```

下面在 `index.php` 中引入 `functions.php` 和 `Task.php`, 并调用刚才定义好的两个函数, 现在还是得到相同的结果。

```php

    <?php 

    require 'functions.php';
    require 'Task.php';

    $pdo = connectToDb();
    $tasks = fetchAllTasks($pdo);

    var_dump($tasks);
```

## 第二次代码重构

就眼前来看，第一次重构后的代码好像还挺清晰的，代码量也不多，但事实上像目前这样的代码是不具备可扩展和可复用性的。比如说像 `fetchAllTasks()` 这样的函数，这种函数基本没法复用，比如说想获取所有的评论呢？是不是也要写个`fetchAllComments()` 的函数？ 这样明显就有问题了。

另外一个严重的问题是我们没有基于面向对象开发，代码的可读性不高，不易于维护和扩展。我们先来重构和数据库相关的代码，目前我们只做了通过 PDO 连接数据库和查询数据库表所有数据的功能。我们先针对我们写好的两个函数一个个的来重构。

既然这两个函数都是作用在数据库的，那么我们先在根目录下建立一个`database`的文件夹，然后看`connectToDb()`这个函数,它的作用在于连接数据库 `Connect to Database`。

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

这里我们将`make()` 方法设置成静态的`(static)`, 静态方法可以用类名直接调用，不用实例化对象调用，如果不采用静态方法，我们需要先通过 `new Connection` 去实例化一个 `Connection`的对象， 然后再去调用`make()` 方法。而使用静态方法，我们可以直接使用类名去调用方法, 类式这样 `Connection::make()`， 对于静态方法的使用，通常情况下需慎用，它可能会增大内存的开销，不过在这里的这种情况，使用静态方法还算可以，我们把这个方法完善下：

```php

    public static function make()
    {
        try {
            return new PDO('mysql:host=localhost;dbname=mytodo', 'username', 'my_password');
        } catch (PDOException $e) {
            die($e->getMessage());
        }
    }
```

下面再来看`fetchAllTasks()`这个函数，刚才也说了这个函数不具备复用性。其实我们现在是需要一个类，这个类最好能提供一些方便好用的查询方法给我们，它能将一些常用的`SQL`语句进行封装，这样在以后开发的时候我就不用再去写那些原生的，难于阅读和维护的原生`sql`语句, 既然这样，我们就需要重新构建一个查询的类，我们把这个取名为 `QueryBuilder`， 目前它还应该有一个`selectAll()`的方法。 在`database`文件夹下创建 `QueryBuilder.php`的文件，声明`QueryBuilder`类， 该类当中有一个`selectAll()`的方法， 如下：

```php

    require 'Connection.php';

    class QueryBuilder
    {
        public function selectAll($table, $className)
        {
            $statement = Connection::make()->prepare("select * from {$table}");

            $statement->execute();

            return $statement->fetchAll(PDO::FETCH_CLASS, $className);
        }
    }
```

这里的`Connection::make()`是硬编码式的写在这里的，如果`Connection`类修改了`make()`方法的名称，那么这里就会出错，同时在代码阅读体验上太差，不能一眼看出`Connection::make()`返回的结果是什么，还是需要和以前一样使用变量`$pdo`比较好。改成`$statement = $pdo->prepare("select * from {$table}");` 会好一些。

这个`$pdo`变量在如何传递进来呢？放在`selectAll()`参数内? 这样显然不好，以后如果编写其他的方法还需要重复的传进来，其实可以说`QueryBuilder` 类中大多数方法都会依赖于 `PDO` 的这个资源对象，我们给`QueryBuilder`类定义一个 `PDO` 对象的属性，当`QueryBuilder` 创建的时候通过构造函数将 `$pdo` 对象自动赋值给`QueryBuilder`类的的 `$pdo`属性, 如下所示:

```php

    class QueryBuilder
    {
        protected $pdo;

        public function __construct(PDO $pdo)
        {
            $this->pdo = $pdo;
        }

        public function selectAll($table, $className)
        {
            $statement = $this->pdo->prepare("select * from {$table}");

            $statement->execute();

            return $statement->fetchAll(PDO::FETCH_CLASS, $className);
        }
    }
```

下面我们修改下 `index.php` 中的代码， 将我们编写好的文件引入进来，如下：

```php

    require 'database/Connection.php';
    require 'database/QueryBuilder.php';
    require 'Task.php';

    $pdo = Connection::make();

    $query = new QueryBuilder($pdo);

    $tasks = $query->selectAll('todos', 'Task');

    var_dump($tasks);
```

### 创建引导文件

现在我们会发现 `index.php` 中的代码变的很杂乱，面条式的代码，像创建`PDO`资源对象和实例化查询构建器这些代码都属于引导程序，我们把它们独立出来，在根目录建立`bootstrap.php`， 将这部分代码放入到该文件中，如下：

```php

    require 'database/Connection.php';
    require 'database/QueryBuilder.php';

    return  new QueryBuilder(
        Connection::make()
    );
```

对应的修改下 `index.php` 中的代码如下：

```php

    $query = require 'bootstrap.php';

    require 'Task.php';

    $tasks = $query->selectAll('tasks', 'Task');

    var_dump($tasks);
```
### 创建配置文件

现在的代码相对好很多了，不过我们现在是把连接数据库的用户名和密码以硬编码（hard code, 写死的意思）的方式放在`Connection`类中，这样做既不方便管理，同时也不安全，我们需要建立一个`config.php`的配置文件， 在当中我们建立一个关联数组来存放相关的配置信息，如下：

```php

    return [
        'database' => [
            'name'          => 'todolist',
            'username'      => 'username',
            'password'     => 'my_password',
            'connection'    => 'mysql:host=127.0.0.1',
            'options'       => [] // 这个一会再说它的作用
        ]
     ];
 ```

 对应修改 Connection 类中的 make() 方法：

 ```php

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
```

我们给`make()`方法添加了参数，在`bootstrap.php` 中也要更改下

```php

    $config = require 'config.php';

    require 'database/Connection.php';
    require 'database/QueryBuilder.php';

    return  new QueryBuilder(
        Connection::make($config['database'])
    );
```

### 显示 PDO 执行出错的提示

好了，这样可以跑通，在配置文件中我们加了个`'options'=> []` 的配置，这个是做什么用的呢？这里可以添加一些我们需要的额外配置，比如说在 `$tasks = $query->selectAll('tasks', 'Task');`这里如果我们传入一个不存在的数据表，按目前的代码，运行后没有任何的提示，我们把配置文件中的`options`设置下

```php
    'options' => [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION
    ]
```

当 PDO 执行时产生的错误就能够提示出来了，比如我们传入一个不存在的表时， 就会出现下面这样的错误:

```

    Fatal error: Uncaught PDOException: SQLSTATE[42S02]: Base table or view not found: 1146 Table 'mytodo.todoss' doesn't exist in /Users/zhoujiping/Code/php-learning/database/
```

> PDO::ATTR_ERRMODE的更多预设值访问  http://php.net/manual/en/pdo.setattribute.php 可以自己都试下

## 单一入口和mvc架构

现在我们再来添加两张页面`about.php`和`contact.php`， 按照之前我们说的逻辑层和视图层分离的原则，我们还需要建立`about.view.php`和`contact.view.php`， 并在`about.php`和`contact.php`中引入它们的视图文件。然后我们可以通过`http://localhost:8888/about.php` 或 `http://localhost:8888/contact.php` 之类的 uri 来访问这些页面, 像这种方式我们称为多入口方式，这种方式对于小型项目还能管理，项目过大了，管理起来就会比较麻烦了。

现在的框架基本都是采用单一入口的模式，什么是单一入口，其实就是整个站点只有 `index.php` 这一个入口，我们访问的任何 uri 都是先经过 `index.php` 页面，然后在`index.php`中根据输入的 uri 找到对应的文件或者代码运行，然后返回数据。

我们把现有的文件目录结构再优化下， 像`database` 内的文件，以及`bootstrap.php` 文件，这些都是属于一些核心的文件，我们可以建立一个文件夹叫做 `core`, 然后把`database`文件夹和 `bootstrap.php`放在这里面，我们之前也说过要把逻辑和视图分离开来，那么新建一个 `views` 的文件夹专门用来存放视图文件，对于视图文件我们需要规定下命名规则，统一为 `xxx.view.php` 这样的格式，针对逻辑层我们新建一个 `controllers` 的文件夹。在 `controllers` 中存放逻辑层的文件。

根目录下再新建一个 `models` 的文件夹， 将`Task.php` 放入该文件夹中。

`models`文件夹中的文件主要和数据打交道， `controllers` 文件夹内的文件主要用来处理业务逻辑，而`views`文件夹内的文件主要是用来显示数据所用的，这就是最基础的MVC架构。

现在我们重新编排过的目录如下：

```php

    ├── index.php
    ├── config.php
    ├── controllers
    ├── core
    │   ├── bootstrap.php
    │   └── database
    │       ├── Connection.php
    │       └── QueryBuilder.php
    ├── models
    │   └── Task.php
    └── views
```

接下来怎么做？ 我们先来理一下思路，假定我们访问 `http://localhost:8888/about` 这个路由，是想让它运行`about.php` 中的内容，然后将最终的结果回显在浏览器上。步骤类式下面这样的：

> 1. 访问 http://localhost:8888/about 这条路由时，首先会进入到 `index.php` 中。
> 2. 然后在`index.php`中会通过一些方法去找到与这条路由对应需要执行的文件，一般我们都会把这些文件放在控制器中
> 3. 执行控制器文件中的逻辑代码，最终将数据通过对应的视图层显示出来。

事实上我们访问的`http://localhost:8888/about`, 它的真正的路由应该是类式`http://localhost:8888/index.php?action=about`这样的路由，然后通过`Apache`或者是`Nginx`做路由跳转，就可以实现成类式`http://localhost:8888/about`这样的路由了。具体的设置可以自行 Google. 

如果你使用的也是`valet`集成开发环境, 我们可以在项目根目录使用命令 `valet link my-php-framework` 生成一个 `my-php-framework.dev` 的本地域名，以后就用这个域名来运行。

现在根据上面我们整理的步骤，我们一步一步的来实现它们，首先我们先在`controllers`下新建`index.php, about.php和contact.php`, 在`views`文件夹下建立它们对应的视图文件， 视图文件中先编写些 html 代码，能区分页面就行，控制器中的文件只需要写一句将对应的视图文件引入进来的代码即可，如`require views/xxx.view.php;`。

## 编写路由类 Router

按照上面的步骤，第一步很好解决，这里不做说明，可以自行 Google, 或者你如果安装的是 Valet 集成环境，只需要按照我上面的一条命令即可，不用进行任何额外的配置。

我们主要来看第二步，如何将路由与控制器中的类对应起来，其实这也很简单，我们之前学过关联数组，我们只要定义一个关联数组将相对路径，如`about` 作为 key, 将控制器中对应的类的路径做为 value 保存起来即可。然后我们只要获取到用户输入的 uri, 通过这个 uri 中的相对路径去到我们定义好的关联数组中去查找对应的 value 值，就能找到这条路由对应的控制器类的文件，最后将其引入进来执行，就能完成这样的功能了。

基于面向对象的开发方式，我们首先会需要一个路由的对象 `$router`, 这个对象会有一个`$routes`的属性用来存放关联数组，还会需要有一个`$router->define()`的方法，这个方法的主要作用是将我们定义的关联数组赋值给`$router->routes`属性，最后还需要一个`$router->direct()`的方法， 这个方法的作用是通过用户输入的 uri 返回对应的控制器类的路径。

现在我们假定我们需要的对象和方法都已经已经存在了，我们先去根目录下的`index.php`中调用它们，如下：

```php

    // 加载引导文件，并且获取创建好的 `QueryBuilder` 的对象
    $query = require 'core/bootstrap.php';

    // 创建路由对象
    $router = new Router;

    // 定义路由
    $router->define([
        '' => 'controllers/index.php',
        'about' => 'controllers/about.php',
        'contact' => 'controllers/contact.php'
    ]);

    // 引入 与相对路径 $uri 对应的控制器类的路径
    // 比如说相对路径如果是 about， 下面这句代码就等价于 require 'controllers/about.php';
    // 这里还存在一个问题，$uri 的值我们如何获得，后面再解决它
    require $router->direct($uri);
```

> 注意： 我们之前更改了很多文件的目录，自己查看并修正下 `require` 文件的路径。

下面我们就可以去实现我们的类了，很明显，`Router` 类也是属于核心文件中的，我们在`core` 文件夹下建立一个`Router.php` 的文件，我们实现上面的两个方法，如下：

```php

    class Router
    {
        protected $routes = [];

        public function define($routes)
        {
            $this->routes = $routes;
        }

        public function direct($uri)
        {
            // 如果数组中存在 $uri 这样的路由, 那么返回对应的路经
            if (array_key_exists($uri, $this->routes)) {
                return $this->routes[$uri];
            }
            
            // 不存在，抛出异常，以后关于异常的可以自己定义一些，比如404异常，可以使用NotFoundException
            throw new Exception('No route defined for this URI');
        }    
    }
```

## 获取浏览器访问网址中的相对路径

到目前为止差不多已经实现了我们的功能，不过上面说了还有一个问题，就是`$uri`的值我们还没有获得，如何获取它呢？
比如说用户在浏览器输入 `http://my-php-framework.dev/about` 这条 uri，我们如何获取当中的相对路径`about`, 在 php 中有一个 全局的 `$_SERVER` 变量, 我们可以在入口页面加上`var_dump($_SERVER);` 打印出它的值来查看一下.

![var_dump](/images/php/step_1/8.jpg)

可以在`$_SERVER['REQUEST_URI']` 中获取我们要的 uri, 不过需要去掉字符串前的 `/`, 我们可以使用 PHP 提供的 `trim($string)`函数来处理，`trim($string)` 默认去掉 $string 字符串两边的空格，但如果`trim($string, '/')`这样，就可以去掉字段串前后的 `/`  字符。 这样就我们可以正确的得 `$uri` 了，我们在入口页面上添加上这条代码：

```php

    // 加载引导文件，并且获取创建好的 `QueryBuilder` 的对象
    $query = require 'core/bootstrap.php';

    // 获取用户在地址栏输入的相对路径，并去除头尾的 / 字符
    $uri = trim($_SERVER['REQUEST_URI'], '/');

    // 创建路由对象
    $router = new Router;

    // 定义路由
    $router->define([
        '' => 'controllers/index.php',
        'about' => 'controllers/about.php',
        'contact' => 'controllers/contact.php'
    ]);

    // 引入 与相对路径 $uri 对应的控制器类的路径
    // 比如说相对路径如果是 about， 下面这句代码就等价于 require 'controllers/about.php' 
    require $router->direct($uri);
```

> 不要忘记在 `bootstrap.php` 中将 `Router.php` 引入进来。

## 第三次代码重构

### 将路由定义独立出来

我们已经实现了单一入口和路由分发的功能，不过我们的代码还没有经过优化，我们看入口页面中的定义路由的这段代码:

```php

    $router->define([
    '' => 'controllers/index.php',
    'about' => 'controllers/about.php',
    'contact' => 'controllers/contact.php'
    ]);

一个稍微大点的 App 都会存在很多的路由，我们可以预见这段代码会不限量的增加，所以我们需要把这段代码独立出来，另外一点是我们往往可以通过路由就行大致的了解整个App的大致情况，所以将路由独立成一个页面是非常有必要的。  我们在根目录下创建`routes.php` 的文件，将这段代码移过去。然后在入口页面引入进来就可以了。再继续看入口页面的这三句代码：

```php

    $router = new Router;
    require 'routes.php';
    require $router->direct($uri);
```

这三句代码还是面条式的，语言化不强，我们如果将`require 'routes.php';` 封装成`$router->load('router.php')`, 可读性就会好很多，同时我们让`load()`方法返回`$router`对象，那么就可以通过链式调用`direct()`方法，我们再把`load()`方法写成静态的，那么实例化 $router 对象的代码也可以省略了，最终可以将代码写成这样：

```php

    // 链式调用
    require Router::load('routes.php')
                   ->direct($uri);
```

> 这里将 `load()` 方法写成静态的还是有好处的，因为 $router 对象在整个 App 中并不需要多个，如果采用实例化对象的方式，我们也需要使用单列模式，而不是像之前那样实例化对象。

我们去实现 `Router` 类的 `load()` 方法:

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

### 将请求 Request 分离出来

通过一次http请求的周期一般是发送 Request 请求， 服务器处理，然后响应客户端 Response, 从整体来看，我们是还需要`Request`和`Response`两个类的，类中需要编写有针对请求和响应的各种方法。这里先不做扩张，以后再看吧！

不过我们来看下入口页面的 `$uri = trim($_SERVER['REQUEST_URI'], '/');`  这句代码，它就属于http请求的范畴，我们可以编写`Request::uri()`这样的方法来代替它。我们还是先调用再去实现具体的方法，入口页面现在的代码如下：

```php

    $query = require 'core/bootstrap.php';

    require Router::load('routes.php')
        ->direct(Request::uri());
```

下面我们在`core`目录下建立 `Request.php` 并且实现静态的 `uri()` 方法, 如下：

```php

    class Request
    {
        public static function uri()
        {
            return trim($_SERVER['REQUEST_URI'], '/');
        }
    }
```

> 别忘记了在`bootstrap.php`中引入`Request.php`这个类。

### 优化 bootstrap.php 文件中的变量 $config

我们现在采用单一入口模式开发一个 Web App, 因此`bootstrap.php`中的`$config`这个变量的生命周期会很长，几乎就是一个全局变量了，你会发现你再控制器类中可以使用它，在视图文件中也可以使用它，我们把这个变量命名成`$app['config']` 这样的可读性会好很多，现在`bootstrap.php`中的代码如下：

```php

    $app = [];
    $app['config'] = require 'config.php';
    require 'core/database/Connection.php';
    require 'core/database/QueryBuilder.php';
    require 'core/Router.php';
    require 'core/Request.php';

    return  new QueryBuilder(
        Connection::make($app['config']['database'])
    );
```


## 视图文件的拆分

通常一张视图文件都会包含一些重复的部分，如头部，底部，导航条等，为方便维护，这些部分都会把它们独立出来，比如我们现在为每个页面添加导航菜单。 在`views`下新建`partials`文件夹，然后先建立一个`nav.php`,用来存放导航条, 如下：

```html
<nav>
    <ul>
        <li><a href="/">Home</a></li>
        <li><a href="/about">About</a></li>
        <li><a href="/contact">Contact</a></li>
    </ul>
</nav>
```

然后在其他的`xx.view.php`视图中通过 `require('partials/nav.php');` 引入进来，同理可用把`head`部分也独立出来。这里不贴代码了。

## CSS和JS文件

对于网站的css和js以及一些静态的资源文件，我们可以在根目录下建立一个`public`的文件夹，`css`和`js`文件我们可以通过`gulp`或者`webpack`将其打包后放在这里，然后在`views`页面中引入进来即可。另外根目录下的入口文件`index.php`也应该放置在这里，然后将站点的根目录指向`public`，这样会安全很多，不过这里我们就不这么操作了。

> 小问题： 上面的`nav.php`是可以在`head.php`中就包含的，但是通常我更喜欢把它们分开`head.php`基本对应`<head>`部分，我不想把`<body>` 中的也融合进去，有必要的话我会建立`head.php`和`header.php`两个文件，在`header.php`中在包含`nav.php`，或者将`nav.php`的内容直接放在`header.php`中，我感觉文件的命名和内部的内容需要对应，这样可读性会好些。

## 解决路由中存在的一些问题

我们现在只做了显示 todolist 的列表，那如果要像数据库插入一条任务呢？先在`index.view.php`中添加一个表单，如下：

```html

    <form action="/tasks" method="GET">
        <textarea name="description" id="description" cols="50" rows="3"  required></textarea>
        <button type="submit">Submit</button>
    </form>
```

在`routes.php` 中添加上对应的`tasks` 路由

```php

    $router->define([
        ''          => 'controllers/index.php',
        'about'     => 'controllers/about.php',
        'contact'   => 'controllers/contact.php',
        'tasks'     => 'controllers/add-task.php'
    ]);
```

在控制器中建立`add-task.php`, 先输入 `var_dump($_SERVER)`, 测试一下，毫无悬念的出错了，出错原因是提示找不到路由，这很正常，我们之前的思路是以用户输入的`uri`的相对路径为`key`, 去寻找`$router->routes`数组中对应的值是否存在，我们在`Request.php`中的`uri()`方法出了问题。我们现在的方法是下面这样的：

```php

    public static function uri()
    {
        return trim($_SERVER['REQUEST_URI'], '/');
    }
```

我们只是去除了 uri 两端的 `/` 字符， 而现在的 uri 是 `/tasks?description=test` , 当去除它两端的`/`, 那就变成了`tasks?description=test`, 而我们定义的路由是`tasks`, 所以肯定是找不到的。

需要提取出我们需要的相对路径，可以使用 php 的原生函数 `parse_url` 函数的官方文档在这里  http://www.php.net/manual/en/function.parse-url.php 通过 `parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);` 就可以得到正确的 `/tasks` 了，然后再去除两端的 `/`, 关于 `PHP_URL_PATH` 常量的意思，查下文档就行。现在 `uri()` 改成如下：

```php

    public static function uri()
    {
        return trim(
            parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH), '/'
        );
    }
```

现在再测试一下，没有问题了。 下面把 `index.view.php` 中的表单发送方式改成`post`, 然后将`add-task.php`中的内容改成`var_dump($_REQUEST);` 这里的 `$_REQUEST` 可以接受通过`get`或是 `post` 方法传递来的参数值。我们通过表单提交（post 请求方式）后可以正确访问，没有问题，但是我们刷新页面，请求方式变成了`get`, 还是能显示页面，这是我们不希望看见的，如何解决这个问题呢？显然我们要去修改 Router 类的`define()` 方法，基本上我们会想到给`define()` 再新添加一个参数做为标识符来解决这个问题，但是这样使用起来就太麻烦了，假定 `Router` 类中有`get()`和`post()` 两个方法可以解决这个问题，那调用起来就会方便很多，而且代码可读性也非常强，我们先去 `routes.php` 中调用，回头再来编写这两个方法，现在 `routes.php` 中代码如下：

```php

    $router->get('', 'controllers/index.php');
    $router->get('about', 'controllers/about.php');
    $router->get('contact', 'controllers/contact.php');
    $router->post('tasks', 'controllers/add-task.php');
```

嗯，这样以来，代码的可读性也好了很多，下面我们就来想想如何实现 `Router` 类的`get()`和`post()`方法，大体思路如下：

> 1. 在`$router->routes` 数组中定义 key 为`GET` 和 `POST` 的一维数组
> 2. 建立`get` 方法，将`get`方式的路由放进`GET`数组中
> 3. 建立`post`方法，将`post`方式的路由放进`POST`数组中
> 4. 判断用户访问的路由的请求方式，根据请求方式和相对路径分别对应到`GET`或是`POST`数组中查询相对路径对应的值返回。


Router 类中需要修改和添加的代码如下：

```php

    protected $routes = [
        'GET'   => [],
        'POST'  => []
    ];
    
    // 当定义Get路由时候，把对应的$uri和$controller以健值对的形式保存在$this->routes['GET']数组中
    public function get($uri, $controller)
    {
        $this->routes['GET'][$uri] = $controller;
    }
    
    // 当定义POST路由时候，把对应的$uri和$controller以健值对的形式保存在$this->routes['POST']数组中
    public function post($uri, $controller)
    {
        $this->routes['POST'][$uri] = $controller;
    }
```

现在我们要判断实际访问的路由是哪种请求方式，如果是`GET` 请求，我们则去`$this->routes['GET']`数组中查询相对路径对应值，如果是`POST` 请求，我们则去`$this->routes['POST']`数组中查询相对路径对应值，所以 Router 类中的`direct()` 方法我们还需要改写下,如下:

```php
    
    // 这里的 $requestType 是请求方式，GET 或者是 POST
    // 通过请求方式和 $uri 查询对应请求方式的数组中是否定义了路由
    // 如果定义了，则返回对应的值，没有定义则抛出异常。

    public function direct($uri, $requestType)
    {
        if (array_key_exists($uri, $this->routes[$requestType])) {
            return $this->routes[$requestType][$uri];
        }
        
        throw new Exception('No route defined for this URI');
    }   
``` 

入口页面调用`direct()`方法的地方，需要加上第2个参数，如下：

```php

    require Router::load('routes.php')
        ->direct(Request::uri(), Request::method());
```

看上面的 `Request::method()` 这个方法是用来获取访问的路由的请求方式的，这也属于 `Request` 的范畴，所以我们在`Request`中去实现这个方法。实现方式非常的简单，不用解释，如下：

```php

    public static function method()
    {
        return $_SERVER['REQUEST_METHOD'];
    }
```

到目前为止，路由中存在的一些问题已经解决了，下面我们需要把 form 表单传递过来的数据插入到数据库中。

> 实际项目中还会使用到 `put/patch`, `delete` 的请求方式，可以自己试着写上。


## 使用 PDO 动态插入数据到数据库

现在我们可以正常的获取 `post` 请求的数据了，我们需要把`form`表单传递过来的`description`的值存储到数据库中，再此之前我们先将`bootstrap.php` 中的`QueryBuilder`对象储存到`$app['database']`中， 这样在我们在入口页面直接引入`bootstrap.php`即可，不用再去接受`QueryBuilder`对象，耦合性会低一下，`bootstrap.php`更改的代码如下，入口页面自己改下：

```php

    $app['database'] = new QueryBuilder(
        Connection::make($app['config']['database'])
    );
```

假设我们的`QueryBuilder`对象已经拥有一个`create`的方法， 那么在`add-task.php`中就可以这样调用.

```php

    $app['database']->create('tasks', [
        'description' => $_POST['description'],
        'completed'   => 0
    ]);
```

在`QueryBuilder.php`中我们怎么样实现这个方法呢？我们肯定需要类式下面这样的一条 Sql 语句

```sql

    insert to tasks (description, completed) values ('测试发布任务', fasle);
```

向数据库中插入数据的 `sql` 语言为 `insert into 表名 (表字段1, 表字段2 ...) values ('对应的值', '对应的值')`, 这里的表名，表字段和值都是动态的，是由我们传递进来的，相当于上面的 `sql` 语句的模版是这样的 `insert into %s (%s) values (%s)`。 我们可以通过字符串链接符 `.` 来拼装我们需要的 sql 语句， 不过在 php 中还有一个更好的函数叫做 `sprintf()` 可以帮我们做到这点，比如说:

```php
    public function create($table, $parameters)
    {
       $sql  = sprintf(
        'insert into %s (%s) values (%s)',
        'one', 'two', 'three'
        );

       var_dump($sql); die;
    }
```

打印上面的 `$sql` 变量， 结果是 `string(36) "insert into one (two) values (three)"`, 看下结果就会知道`sprintf()`的用法了， 现在我们就来替换掉`one`, `two`, `three` 这三个值了， 首先`one`对应的是数据表名，就是我们参数中的`$table`。

`two`是数据表的字段名，也就是我们 `$parameters` 的 key, 通过 `array_keys($parameters)` 可以获取由 $parameters 健值组成的一维数组,类似于`[description, completed]`这样的，而我们这里需要的是 string 类型的, 类似这样的`(description, completed)`， 如何将数组转成需要的字符串呢？ 如果不知道这样的php函数， 可以通过 google ` php array to string` 这样的关键词去搜索，我们会发现 `implode()` 函数可以解决这个问题 `implode(', ', $parameters)`。

接着是`three` 字段对应的值，使用 PDO 插入数据都会需要经过一些 sql 语句的预处理，这里可以先用类式 `(:description, :completed)`这样的占位符， 然后执行的时候替换掉占位符即可。这样就能正确的插入数据到数据库了，完整的代码如下：

```php

    public function create($table, $parameters)
    {
       $sql  = sprintf(
            'insert into %s (%s) values (%s)',
            $table,
            implode(', ', array_keys($parameters)), 
            ':' . implode(', :',array_keys($parameters)) //  这句不喜欢可以用array_map处理下
        );

       try {
            $statement = $this->pdo->prepare($sql);
            $statement->execute($parameters);
       } catch (PDOException $e) {
           die($e->getMessage());        
       }
    }
```

现在可以成功的插入值到数据库了，我们在`add-name.php` 上再添加一条 `header('Location: /')` 让其执行成功后跳往首页，在首页上我们能成功的看见新添加的任务了。

![新添加的任务](/images/php/step_1/update_1.jpg)

> `controllers/index.php` 中的代码自己编写下, 方法我们之前都已经写好的。

## 添加 composer 依赖包管理

我们现在的项目中使用了一堆的`require` 语句, 这样的方式对项目管理并不是很好，现在有人为 php 开发了一个叫做 `composer` 的依赖包管理工具，非常好用，我们将其集成进来，composer 官方地址 https://getcomposer.org/ 按照提示进行全局安装即可。
我们先将 `bootstrap.php`中的下面4句代码注销

```php

    // require 'core/Router.php';
    // require 'core/Request.php';
    // require 'core/database/Connection.php';
    // require 'core/database/QueryBuilder.php';
```

然后在根目录下建立 `coomposer.json` 的配置文件,输入以下内容:

```json

    {
        "autoload": {
            "classmap": [
                "./"
            ]
        }
    }
```

上面的意思是将根目录下的所有的**类文件**都加载进来， 在命令行执行 `composer install` 后，在根目录会生成出一个`vendor`的文件夹，我们以后通过 `composer` 安装的任何第三方代码都会被生成在这里。 

下面在`bootstrap.php`添加`require 'vendor/autoload.php';` 即可。我们可以在`vendor/composer/autoload_classmap.php`文件中查看生成的文件对应关系。

## 实现第一个 依赖注入容器 DI Container 的雏形

什么是依赖注入容器`DI Container`? 一个听上去非常高大上的东西，先不要去纠结字面的意思，你可以这么想，把我们的 APP 想象成一个很大的盒子，把我们所写的一些功能，比如说配置，数据库操作等都扔到这个盒子里，在扔进去的时候你要给它们贴一个标签，以后可以通过这个标签把它们取出来用。大体就是这个意思。

我们来看`bootstrap.php` 中的代码， 其实 `$app` 这个数组就可以看成是一个容器，我们把配置文件扔到数组中，贴上`config`的标签（也就是健），把`QueryBuilder`也扔进去了，贴上标签`database`。之后我们可以通过`$app['config']`这样拿出我们需要的值。

我们为何不把`$app`数组做成一个对象呢！ 这样我们以后可以为其添加很多的属性和方法，会方便很多，需要对象就必须要有类，我们马上就可以在`core`文件夹内建立一个 `App.php` 的文件，当中包含`App`类。

下面看看我们需要哪些方法，先看 `$app['config'] = require 'config.php';` 这一句是把`config.php`放进到`App`的容器中，现在常用的说法是 注册`config` 到`App`, 或者是绑定`config` 到`App`, 那我们需要的方法可能是这样的。

```php

    $app->bind('config', require 'config.php');
    // 或者
    $app->register('config', require 'config.php');
    // 或者
    App::bind(config', require 'config.php');
    // 或者
    App::register('config', require 'config.php');
```

在我们写类的时候，可能不知道怎么动手，可以先尝试着调用假定存在的方法，再回头去完善类，之前我们也都是这么做的，这样相对会容易些，上面的几种方法个人感觉`App::bind(config', require 'config.php');`更好些，然后要取出`config`可以使用 `App::get('config')` 方法，下面去实现这两个方法。在`core/App.php` 中

```php

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
`bootstrap.php` 中目前代码如下：

```php
    
    require 'vendor/autoload.php';

    App::bind('config', require 'config.php');

    App::bind('database', new QueryBuilder(
        Connection::make(App::get('config')['database'])
    ));
```

将所有使用到`$app['config']`和`$app['database']`的地方全部用`App::get('config')`和`App::get('database')`替换过来，毫无疑问的会提示“找不到APP的错误”，原因是在我们的`autoload_classmap.php`文件中并没有导入`App.php`文件，我们需要在命令行执行 `composer dump-autoload` 来重新生成`autoload_classmap.php`文件。

## 第四次代码重构 - 重构控制器

### 新建控制器类

现在我们的控制器中的代码还都是一些面条式的代码, 并没有使用面向对象的方式去开发，我们来重构下，我们需要编写控制器类，然后让路由指向到对应的控制器的方法，这样在我们以后的工作流中就会方便很多。

我们在`controllers`文件夹下建立 `PagesController.php` 的文件, 编写以下的代码，将之前控制器中的文件中的代码都以方法的形式写在这个类中

```php

    class PagesController
    {
        public function home()
        {
            $tasks = App::get('database')->selectAll('tasks', 'Task');

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

现在可以将`controllers`文件夹下的`index.php`, `about.php`, `contact.php`都删除了，将路由文件中的代码改成下面这样：

### 更改路由文件

```php

    $router->get('', 'PagesController@home');
    $router->get('about', 'PagesController@about');
    $router->get('contact', 'PagesController@contact');
```

### 初次修改 `direct()` 方法

现在我的意图是这样的，以`about`路由举例，当我们访问`about`, 就会调用`PagesController`类的`about`方法, 在`about`方法中直接运行逻辑代码。所以我们需要修改`Router.php`中的`direct()`方法。

目前`direct()`是根据相对路径返回对应控制器类的路径，然后在入口页面将其引入进来执行，现在我们只需要通过实例化控制器类，然后调用对应的方法即可。 那`direct()`的核心代码应该是类式这样的：`(new PagesController)->about();` 我们暂且把这个功能命名为 `callAction()` 方法，先将定已经有了这个方法, 我们先去 `direct()`方法中调用它， 如下：

```php

    public function direct($uri, $requestType)
    {
        if (array_key_exists($uri, $this->routes[$requestType])) {
            return $this->callAction('这里应该有参数');
        }

        throw new Exception('No route defined for this URI');
    }
```

### 实现私有方法 `callAction()` 

下面考虑下 Router 类中的 `callAction()` 方法该怎么实现，刚才说了这个方法的核心是 `(new Controller)->action();` 不多考虑，我们给这个方法两个参数，$controller 和 $action, 代码如下：

```php

    private function callAction($controller, $action)
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

### `...` 运算符和 `explode()` 函数用法

上面的 `method_exists($obj, $action)` 方法是判断一个对象中是否某个方法，那在 `direct()` 中调用`callAction()`的参数我们该如何获取呢？ 我们现在的 `$this->routes[$requestType][$uri]`的值是类式于 `PagesController@about` 这样的字符串，我们只需将该值拆分为 `['PagesController', 'about']` 这样的数组，然后使用 php5.6 之后出现的 `...`运算符，将其作为参数传递，关于拆分字符串为数组，php 也给我们提供了一个这样的函数，叫做 `explode()`, 我们先看下这个函数的用法，
打开终端，输入 `php --interactive` 进入命令行交互模式

```bash

    $ php --interactive

    php > $values = explode('@', 'PagesController@about');
    php > var_dump($values);
    array(2) {
      [0]=>
      string(15) "PagesController"
      [1]=>
      string(4) "about"
    }

```

好了，现在就可以修改下`direct()` 这个方法了，如下：

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

关于`...explode('@', $this->routes[$requestType][$uri])` 这里的 `...` 操作符， 它会把一维数组中的第一个元素作为参数1， 第二个元素作为参数2，以此类推，这是 php5.6 后新出的语法，可以自己查阅文档。

### 修改入口页面的代码

ok, 现在将入口页面的这句代码`require Router::load('routes.php')->direct(Request::uri(), Request::method());`的 require 去掉吧。再测试之前不要忘记了在命令行运行 `composer dump-autoload` 来重新加载文件。

### 创建全局函数 view()

下面更改下 `PagesController` 的 `require 'views/about.view.php';` 这句代码，我们改成 `return view('about');` 这样，可读性会好很多。同时在 `psr标准中` 也有这样的规定，在声明一个类的文件中是不能存在 `require` 代码的。

我们在`core`下创建一个`helps.php`的文件，把所有的全局函数都放在这里，准确来说帮助函数的文件不应该放在这里，它并不属于核心文件，但是为了我们这里写的帮助函数基本都是给我们的框架使用的，不设计业务开发，所以暂时还是先放这里。`view()`函数很简单，如下：

```php

    function view($name)
    {
        $name = trim($name, '/');
        
        return require "views/{$name}.view.php";
    }
```

在`PagesController`的`home` 方法当中有`$tasks`对象集合， 我们怎么传递它到`view()`函数中呢？ 我们需要给`view()`设置第二个数组形式的参数，调用`view()`的时候，将数据以数组的形式传递给`view()`即可，如下：

```php

    return view('index', ['tasks' => $tasks]);
```

现在在`view()`函数中会出现问题了，我们传入的数据是一个数组，而在`index.view.php`中使用的是`$tasks`这样的变量，怎么转化？使用PHP提供的`extract()`函数可以做到这点，它可以将数组中的元素以变量的形式导入到当前的符号表，这句话不好懂，我们来演示下就明白了，还是进入 php 的命令行交互模式， 如下：

```bash

    php > $data = ['name' => 'zhoujiping', 'age' => 3];
    php > echo $name;
    PHP Notice:  Undefined variable: name in php shell code on line 1

    Notice: Undefined variable: name in php shell code on line 1
```

看上面的提示，我们就定义一个数组，然后想要输出变量 `$name` 的值，提示没有定义的变量，再看下面的测试：


```php

    php > $data = ['name' => 'zhoujiping', 'age' => 3];
    php > extract($data);
    php > echo $name;
    zhoujiping
    php > echo $age;
    3
```

使用了`extract()`函数就会自动帮我们定义好与数组 key 同名的变量，并将 key 对应的 value 赋值给了该变量，好了，下面我们把`view()`方法完善下，如下：

```php

    function view($name, $data =[])
    {
        extract($data);

        return require "views/{$name}.view.php";
    }
```

### 通过 composer 加载不是类的文件

下面自己把控制器中与`view()`相关的代码都更改过来，然后运行`composer dump-autoload`,它还是会提示找不到`view()`函数，原因在于我们的`composer.json`中的配置,我们需要将配置改成下面这样：

```json

    {
        "autoload": {
            "classmap": [
                "./"
            ],
            "files": [
                "core/helpers.php"
            ]
        }
    }
```

上面的`classmap`只会加载类文件，要加载普通的文件需要使用 `"files": []`，好了，最后别忘记了`composer dump-autoload`.

### 控制器和路由的一些命名规范

 现在我们只完成了`get`方式请求的页面，还有一个发布任务的路由还没有写，我们来做一下。 现在我们需要新建一个控制器类的文件 `TasksController.php`, 通常一个控制器类的路由和方法是按下面这样定义的：

 ```php

    // tasks 的列表页
    $router->get('tasks', 'TasksController@index');

    // 显示创建 Task 任务的表单
    $router->get('tasks／create', 'TasksController@create');

    // 存储Task到数据库
    $router->post('tasks', 'TasksController@store');
    
    // 显示具体的一个Task
    $router->get('tasks/{task}', 'TasksController@show');

    // 显示编辑具体的某个Task的表单
    $router->get('tasks/{task}/edit', 'TasksController@edit');

    // 修改具体的某个Task
    $router->put('tasks/{task}', 'TasksController@update');
    
    // 删除某个 Task
    $router->delete('tasks/{task}', 'TasksController@destroy');
```

我们在 `routes.php` 中修改下当中的路由：

```php

    $router->get('about', 'PagesController@about');
    $router->get('contact', 'PagesController@contact');

    $router->get('', 'TasksController@index');
    $router->post('tasks', 'TasksController@store');
```

我们将首页指向`TasksController`的`index()`方法， 并创建一条新路由，用于存储新创建的任务记录，然后将`TasksController`中的代码补全，如下：

```php

    class TasksController
    {
        public function index()
        {
            $tasks = App::get('database')->selectAll('tasks', 'Task');

            return view('index', compact('tasks'));
        }

        public function store()
        {
            App::get('database')->create('tasks', [
                'description' => $_POST['description'],
                'completed'   => 0
            ]);

            return redirect('/');
        }
    }
```

这里我们又调用了新的全局函数`redirect()`， 去`helpers.php`中创建它, 如下：

```php

    function redirect($path = '')
    {
        header("Location: /{$path}");
    }
```

##  使用命名空间 Namespace

从 PHP5.3 开始就支持命名空间了，关于命名空间的介绍看官方文档： http://php.net/manual/zh/language.namespaces.php 。其实也很简单，你把命名空间想象层文件夹就行了。关于更改成命名空间的代码去 github 上克隆代码下来查看即可。 https://github.com/zhoujiping/build-your-own-php-framework。

## 写在最后的话

本文章到这里先告一个段落了，虽然还有很多功能都没有实现，但是最近是不会再更新这篇文章了，如果有错会修正，按照这个思路，大家已经可以自己继续往下开发了。