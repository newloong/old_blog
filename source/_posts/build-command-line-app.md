---
title: 编写一个基于命令行的PHP应用
date: 2017-06-25
updated: 2017-06-27
categories:
 - php
---

## PHP的命令行模式

什么是PHP命令行模式？ 通常我们编写的 APP 都是基于浏览器的，用户通过浏览器访问网页，提交一些参数过来，服务器处理后返回视图给他们。而PHP除了这种模式外，还有一种命令行模式也很强大，我们可以在命令行中执行 PHP 的函数，也可以执行一个 PHP 文件，比如说可以在命令行执行  `php -r "echo 'Hello world';"` 来输出 Hello World. 也可以编写一个 PHP 文件来执行, 比如说在 laravel 中我们经常会用到 `php artisan` 的命令，比如我们新建一个 `artisan.php`, 当中代码如下：

```php
 
    echo "This is artisan.php file \n";
```

在该文件所在的目录下执行 `php artisan.php` 就能在命令行中打印出 This is artisan.php file 这句话了。那命令行的参数是如何得的呢？比如说在使用 laravel 的时候，我们可以通过 `php artisan make:model User` 来创建 `User` 模型，我们如何获得这些参数呢？其实在命令行中，这些参数都会被保存在 `$argv` 数组中。我们将 `artisan.php` 的后缀 `.php` 去除， 然后在该文件中添加 `var_dump($argv);` 这句代码，下面我们在命令行执行 `php artisan make:model User`,输出如下：

```bash

    $ php artisan make:model User 
    This is artisan.php file 
    array(3) {
      [0]=>
      string(11) "artisan"
      [1]=>
      string(10) "make:model"
      [2]=>
      string(4) "User"
    }
```

通过输出，我们看见我们可以获得文件名 `artisan` 以及其余的参数。好的，我们可以在命令行执行PHP文件，可以拿到参数，也能回显出结果，那么理论上来说，像所有的`php artisan`下的命令我们都是可以编写出来的。不过我们执行下 laravel 框架自带的 `php artisan` 或者是 Laravel 给我们提供的 laravel安装器 Laravel Installer 命令，发现它们的输出格式优雅，且都是具有统一格式的，我们执行下 `laravel -v`, 输出如下：

![laravel Installer](/images/php/step_3/1.png)

这是如何做到的，我们到 Github  上去翻看下 `Laravel Installer` 或者是 `Homestead`, 或者是 `php artisan` 的源码中的 `composer.json` 文件， 会发现它们都依赖于 ` "symfony/console": "~2.3|~3.0"` 这个包，那我们首先要来了解下这个包。

## 如何使用 symfony 的 console包

到 github 上搜索下这个包，源码地址在： https://github.com/symfony/console 大致看下目录，它主要是实现了 `InputInterface` 和 `OutputInterface` 这两个接口，它也提供了文档地址： https://symfony.com/doc/master/components/console.html

首先我们建立一个文件夹，比如 `mkdir symfony-console-demo`， 在这个文件夹中建立`composer.json`, 当中的配置如下：

```json

    {
        "require": {
            "symfony/console": "~3.0"
        }
    }
```

> 上面的 "~3.0"  的 "~" 的意思是 ">=3.0 && < 4.0", 也就是帮我们安装 3.0 - 4.0 之间的包。

执行 `composer install` 命令后，就会帮我们安装好`symfony/console`包了，我安装完后，其版本号是 `v3.3.2`。

下一步要做的就是引入 `vendor/autoload.php` 文件了，这个在第一章中都已经用过了，我们先在根目录下创建一个入口文件，这里我们不叫 `index.php`了，我们得取一个有意义的名字，因为我们以后要在命令行通过 `php 文件名` 来执行的，这里我就取名叫 `zhoujiping` 吧，后缀我们就把它省略了，就像 `laravel installer` 的入口文件叫 `laravel`, `artisan` 的入口文件叫 `artisan` 一样。
编辑下 `zhoujiping` 这个文件的内容如下：

```php
    
    <?php

    require __DIR__ . '/vendor/autoload.php';

    use Symfony\Component\Console\Application;
    
    // 根据第二章的说明，这里的 $app 可以写成 $application，
    // 但是 $app 是一个通用的缩写，大家都知道，所以这里使用了简写。
    $app = new Application();

    $app->run();
```

上面的代码不难理解，就是不要忘记了 `$app->run();` 这句代码，如果你使用过 `Slim` 框架，你会发现代码几乎一样，简单说下 `Slim`框架，`Slim`框架非常的小，它主要是实现了`psr-7`的接口，也就是封装了 Request 和 Response, 然后基于`pimple` 包实现了一个 `依赖注入容器`， 你所有的配置或者是功能都必须先注册到容器中，全部做完了，然后再通过`$app->run();`去执行，这里的道理一样。 这是题外话，不过你可以先研究下`Slim`， 再去研究下`Laravel`,上手会快很多。

下面我们在命令行执行 `php zhoujiping` 就会打印出下面这样的界面：

![第一个console应用](/images/php/step_3/2.png)

 像 `Laravel Installer` 执行的时候，我们只需要输入 `laravel` 命令即可，并不需要在前面加上 `php` 命令，这是怎么做到的，我们先来尝试运行 `./zhoujiping` 会出现 permission denied 的错误，原因是我们没有给 `zhoujiping` 文件加上可执行权限， 通过 `chmod +x ./zhoujiping` 命令即可加上。再次运行下，会出现下面这样的错误：

 ```bash
    ./zhoujiping: line 1: ?php: No such file or directory
    ./zhoujiping: line 3: //: is a directory
    ./zhoujiping: line 4: require: command not found
    ./zhoujiping: line 6: use: command not found
    ./zhoujiping: line 8: syntax error near unexpected token `('
    ./zhoujiping: line 8: `$app = new Application();'
```

原因是系统并不知道这个文件是 PHP 文件， 我们需要告诉系统你该用 php 的解析程序来解析它。 在文件的第一行加上 `#!/usr/bin/env php` 语句来告诉系统，请用php解析器来解析我。下面在执行 `./zhoujiping` 就能显示出和执行 `php zhoujiping` 相同的效果了。

下面来编写一个 `sayHelloTo` 的命令，代码如下，都是调用 `Symfony Console` 的方法，很语义化，不用解释：

```php

    #! /usr/bin/env php

    <?php

    require __DIR__ . '/vendor/autoload.php';

    use Symfony\Component\Console\Application;
    use Symfony\Component\Console\Input\InputInterface;
    use Symfony\Component\Console\Output\OutputInterface;

    $app = new Application('Symfony Console Demo', '1.0');

    $app->register('sayHelloTo') // 注册命令
        ->addArgument('name') // 获取指定的参数
        ->setCode(function(InputInterface $input, OutputInterface $output) {
            $output->writeln('Hello World'); //  打印并回车
        });

    $app->run();
```

执行 `./zhoujiping`, 结果如下：

![第一个symfony console程序](/images/php/step_3/3.png)

我们现在也可以执行 `./zhoujiping sayHelloTo` 的命令，会打印出 `Hello World` 字符串。

不过我们所写的命令是给他人使用的，像参数说明这种是不能少的，当用户想要查看命令该如何使用时，会通过 `./zhoujiping help sayHelloTo` 来查看具体的参数说明， 自己试着看下现在的输出，并没有多参数做说明，改写下`addArgument`处的代码：

```php

    addArgument('name', InputArgument::REQUIRED, 'Your Name')
```

这里的`InputArgument::REQUIRED` 说明 `name` 参数是必须的，这里需要带入` Symfony\Component\Console\Input\InputArgument;`命名空间，现在执行`./zhoujiping sayHelloTo` 会提示 missing: "name" 的错误， 换成`InputArgument::OPTIONAL` 则代表 `name` 参数是可选的。`Your Name` 是对`name`参数的说明，自己执行下命令就清楚了。

我们再来看上面的图，我们没有对命令 `sayHelloTo` 做说明，在`register('sayHelloTo')`语句在添加下面这条代码：

```php
    
    setDescription('Offer a greeting to the given person.')
```

现在我们执行 `./zhoujiping sayHelloTo person`, 显示的结果还是 Hello World, 我们来完善下这个功能, 代码如下：

```php

    $app->register('sayHelloTo')
        ->setDescription('Offer a greeting to the given person.')
        ->addArgument('name', InputArgument::OPTIONAL, 'Your Name')
        ->setCode(function(InputInterface $input, OutputInterface $output) {

            $message = 'Hello, ' . $input->getArgument('name');

            $output->writeln("<info>$message</info>");
        });
```

现在执行 `./zhoujiping sayHelloTo Lixiaorui`, 就会打印出 Hello, Lixiaorui 了， 注意上面的 `<info>` 标签，这个用法和`html`标签的用法一样，可以改变输出语句的颜色，你可以自己尝试下 `<comment>` 或者 `<error>` 等，更多的请看 `Symfony Console` 的文档。

到这里，我们已经做出一个非常简单的命令行应用了，如果你的应该只有一个比较简单的命令，那么我们可以按上面这么写。但是实际开发的时候我们的需求不会那么的简单，或者我们会需要多个命令，这时候我们需要把这些命令封装成类会好很多，下面来做一下。

在项目根目录下建立一个 `src` 的文件夹，在其中创建一个`SayHelloCommand.php`的类，先写点代码如下：

```php

    <?php 

    namespace Zhoujiping\Demo\Console;

    use Symfony\Component\Console\Command\Command;

    class SayHelloCommand extends Command
    {
        
    }
```

我们新建的`Command`类都必须继承自 `Symfony\Component\Console\Command\Command` 类，我们还需要改写下 `composer.json`文件，使用`psr-4`来自动加载我们所写的类，如下：

```json
    
    {
        "require": {
            "symfony/console": "~3.0"
        },
        "autoload": {
            "psr-4": {
                "Zhoujiping\\Demo\\Console\\": "src"
            }
        }
    }
```

命名空间你自己取，`composer.json` 中的命名空间要和你类中定义的命名空间一致。之后别忘记了`composer dump-autoload`命令.

在`SayHelloCommand`中我们必须重写`Symfony\Component\Console\Command\Command`中的 `configure()` 和 `execute()` 方法，`configure()`是用来写一些配置型的代码的，`execute()`写具体的逻辑代码，重写后我们的代码如下：

```php

    <?php 

    namespace Zhoujiping\Demo\Console;

    use Symfony\Component\Console\Command\Command;
    use Symfony\Component\Console\Input\InputInterface;
    use Symfony\Component\Console\Output\OutputInterface;
    use Symfony\Component\Console\Input\InputArgument;

    class SayHelloCommand extends Command
    {
        public function configure()
        {
            $this
                ->setName('sayHelloTo')
                ->setDescription('Offer a greeting to the given person.')
                ->addArgument('name', InputArgument::REQUIRED, 'Your Name');

        }

        public function execute(InputInterface $input, OutputInterface $output)
        {
            $message = 'Hello, ' . $input->getArgument('name');
            
            $output->writeln("<info>$message</info>");
            
        }
    }
```

根目录下`zhoujiping` 文件中的代码也修改更改下， 如下：

```php

    #! /usr/bin/env php

    <?php

    require __DIR__ . '/vendor/autoload.php';

    use Zhoujiping\Demo\Console\SayHelloCommand;
    use Symfony\Component\Console\Application;

    $app = new Application('Symfony Console Demo', '1.0');

    $app->add(new SayHelloCommand);

    $app->run();
```

> 如果你有多个命令，只需要通过 `$app->add(new CommandClass);` 不断的在这里添加即可。

现在我们还是可以成功执行 `./zhoujiping sayHelloTo Lixiaorui`, 还有一种情况，比如我们在使用 laravel 的 `artisan` 命令时，如使用 `php artisan make:model User --migration` 或者是 `php artisan make:model User -m` 这里的 `--migration` 和 `-m` 这样的可选操作，我们怎么样来编写。比如我们要编写这样的可选命令 `./zhoujiping sayHelloTo Lixiaorui --greeting='Hi'` Hi, Lixiaorui ，而不加可选参数的时候还是输出 Hello, Lixiaorui。

我们只需要在 `configure()` 方法中添加下面这条语句即可：

```php

    addOption(
        'greeting', // 可选参数  --greeting
        null, // 可选参数的别名, 如 --version 的别名 -V
        InputOption::VALUE_OPTIONAL,  //可选参数值的类型
        'Override the default greeting', //对可选参数的描述
        'Hello' // 不带可选参数，默认的输出
    );
```

然后在 `execute()` 中将输出语句更改下

```php
    
    $message = sprintf('%s, %s', $input->getOption('greeting'), $input->getArgument('name'));
```

好了，现在就达到我们的要求了。 到这里，基本的Symfony Console包的用法我们已经会了，更详细的内容可以访问它的官方文档。通过上面的知识，我们已经可以自己去开发一个 `Laravel Installer` 这样的应用了。

## 开发一个阉割版的 Laravel Installer

未完。。。。






