---
title: 论PHP框架是如何诞生的?
date: 2017-05-23 16:05:28
updated: 2017-05-23 16:05:28
categories:
 - php
---

你好，我是“老周”，这是新博客的开篇文章，如果我从没有学习过`PHP`开发，但是我会一些`HTML`和`CSS`，我听说过一些`PHP`框架，但是我却没有使用过这些框架，我该怎么进入`PHP`开发者的行列呢？还有为什么学习了原生的`PHP`，我还要去学习那些框架呢？这些框架究竟有什么好处？为什么会产生框架？我最初学习`PHP`的时候上面的问题都想过，纠结啊！这篇文章应该会比较长，我打算从`PHP`的基础开始罗列，做一个简单的页面，然后慢慢演化成框架！嗯，这样会把框架是如何诞生的这个问题给理清，对于今后学习框架会有好处！

<!--more-->

## 第一步：安装PHP运行环境

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

## 第二步：选择一个适合你的编辑器

在开写代码之前，我们需要找一款适合自己的代码编辑器或者是IDE集成开发环境，网上有人说自己喜欢使用记事本来写代码，这纯粹就是“二逼青年找存在感”，就像给你一把斧头去砍树，你却一定要用石锛, 何苦要做用树叶盖住了屁股却盖不住蛋蛋的原始人呢！





