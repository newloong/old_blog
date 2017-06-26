---
title: 用一些简单的规则来编写简洁的代码
date: 2017-06-25
updated: 2017-06-25
categories:
 - php
---

好不客气的说，很多时候我们去维护别人所写的代码时，或者是查看一些第三方的SDK时，很多时候都会有一种暴走的冲动，即使是很多大公司的SDK也是一样，阅读他们的代码如同在欣赏一个丑女，让人退避三舍。对于这一点，免不然的又要来点赞下 Laravel 和 Rails 为我们所封装的方法，以及它们内部的源码，先不谈作者功底怎么样，但是那一手漂亮的代码，是其它大部分框架所不具备的。有很多人说 Laravel 的源码写的好差，好乱，跳来跳去，无法阅读。那只能说是自己的功底还停留在初级层面，坐井观天，意淫着自己的强大而已。

通常想要编写出一些相对能让后续接受人还能接受的代码，通常我们需要注意以下几点，虽然在真正编写代码的时候很难完全做到下面几点，但是可以试着去遵守这些规则：

## 尽量不用缩写和无意义的字符

比如说我们写接口的时候，一般从数据库中拿取的数据都会经过处理后再返回，这里会用到 `Translator` 类, 如果我们命名的时候用下面这样的缩写:

```php

    class Trnsltr
    {

    }
```

上面这样的缩写还算是有点意义，但是这样会出现两个问题，一是不能马上理解到这个类的意思是 `Translator`, 其次是调用者使用这个类的时候很容易拼写错误，当你输入 `Translator` 这个单词时，是非常顺畅的，因为你脑海中有这个单词，而输入 `Trnsltr` 时，只能去对照着单词去抄写，这会让调用者使用起来非常恼火。

再来看一个列子:

```php
    
    foreach ($people as $x) {

        // ... code ....

        $x->name;
    }
```

在循环语句中，很多人会这么写，采用没有任何意义的变量，如 `$x`, `$y` 等，比如上面的代码，如果这条循环语句中有10条以上的代码，在第6条代码后出现 `$x->name` 这样的代码时，就很难一眼看出 `$x` 究竟是代表什么了。但是如果将上面的代码中的 `$x` 换成有意思的单词，如 `$person`, 那就容易理解多了，如下：

```php
    
    foreach ($people as $person) {

        // ... code ....

        $person->name;
    }
```

所以，永远不要使用一个没有意义的单词缩写，尤其是使用单个字符来作为变量或者是方法名或类名。

再继续看一个例子：

```php

    class User
    {
        public function fetch($billingIdentifier)
        {
            // 
        }
    }
 ```

上面的 `fetch($billingIdentifier)` 方法只是想通过账单ID来获取用户, 在这里我们来看参数 `$billingIdentifier`, 这个时候这样的变量又可以优化了，可以写成 `$billingId` 了，为什么呢？ 对于一些单词，如果有大家都熟知和遵循的简写方式的话，那就使用简写。这样会更加的清晰明了。

我们试着去调用下上面的方法 `$user->feach(1)`, 这样的方法名其实也还可以，如果调用者查看下你的参数命名也能知道大体意思，不过我们可以尽量的让方法名更有意义点，比如说使用：`fetchAUserByTheirBillingId($billingId)`，嗯，这样意思是很清楚了，但是视乎阅读体验更差了，我们需要改的简短点，我们知道这个方法是由 `$user` 对象来调用的，所以方法中就不用出现`user` 单词了，那可以改成这样`fetchByBillingId($id)` , 虽然方法名还是有点长，但是至少让调用者准确的知道它的功能了。

而在 `The Thoughtworks Anthology` 的书中，中文名： 《软件开发沉思录》 中说到方法名和类名和变量名不能超过2个单词，上面的方法名明显是违反了这个规则，基于这个规则我们其实将方法名更改为：`fetchBy($billingId)` 视乎更好一点，但问题是，这也只是视乎更好一些，完全要符合规则去写，你必须要对你的代码进行多次重构，才有可能达到，但现实是你的老板给你那么多时间来重构吗？ 所以退而求其次，像 fetchByBillingId($id) 这样的方法名，或者是`fetchBy($billingId)` 我认为都可以用，并没多大问题，毕竟咱们国情不一样。

## 尽量不要使用 else 语句

最经典的使用 `if .. else` 的语句的代码应该就是下面这张图了:

![经典的if..else](/images/php/step_2/1.jpg)

还是看例子，比如我的博客给大家开通了一个投稿的功能，但是我周一要休息，不接受投稿，另外对于投稿的表单我得做些验证。 好了，就这么简单的需求，假设表单有了，那我们去实现 `store` 的方法，我们代码如下：

```php

    public function store()
    {
        $input = Request::all();
        $validation = Validator::make($input, ['username' => 'required']);

        if (date('l') !== 'Monday') {
            if ($validation->passes()) {
                Post::create($input);
                return Redirect::home();
            } else {
                return Redirect::back()->withInput()->withErrors($validation);
            }
        } else {
            throw new Exception('We do not work on Monday!!');
        }
    }
```

现在的代码有两处 `else` 语句， 我们先来去除中间的 `else`, 我们可以直接去掉它，不影响代码的执行：

```php

    if ($validation->passes()) {
        Post::create($input);
        return Redirect::home();
    }

    return Redirect::back()->withInput()->withErrors($validation);
```

很简单，`else` 就这样去掉了，但是我们再稍微优化下会更好，如下：

```php

    if ($validation->fails()) {
        return Redirect::back()->withInput()->withErrors($validation);
    }
    
    Post::create($input);
    return Redirect::home();
```

验证出错不是我们的业务逻辑，把它放在 `if` 中会更好，让真正的业务逻辑能顺畅的跑下来。这样别人查看你的代码时，就可以快速跳过`if`中的内容。按照这个思路，我们也可以把第一层的 `else` 拿掉了，代码如下：

```php

    public function store()
    {
        $input = Request::all();
        $validation = Validator::make($input, ['name' => 'required']);

        if (date('l') == 'Monday') {
            throw new Exception('We do not work on Monday!!');
        }

        if ($validation->fails()) {
            return Redirect::back()->withInput()->withErrors($validation);
        }

        Post::create($input);

        return Redirect::home();
    }
```

这样一来，不仅可读性强了，代码也会漂亮很多。当然还可以再简单点，我们把验证封装到 `validate` 方法中，代码就会变成下面这样：

```php

    public function store(Request $request)
    {
        if (date('l') == 'Monday') {
            throw new Exception('We do not work on Monday!!');
        }

        $this->validate($request, [
            'username' => 'required',
        ]);

        Post::create($input);
        return Redirect::home();
    }
```

像周一不工作这类代码如果需要多次用到的话，那就把它放到 `Request` 中，那么我们也可以把验证也放入 `Request` 中，比如编写一个`PostRequest` 的类，将验证代码都放在 `PostRequest` 中，然后让其依赖注入进来，最终代码如下：

```php

    public function store(PostRequest $request)
    {
        Post::create($request->all());
        
        return Redirect::home();
    }
```

再来看一个例子， 比如我将来搞了些视频教程放在博客上了，要订阅才能观看，根据订阅的时间长短先开出月订阅和终身订阅两种，代码如下：

```php

    public function signUp($subscription)
    {
        if ($subscription == 'monthly') {
            $this->createMonthlySubscription();
        } elseif ($subscription == 'forever') {
            $this->createForeverSubscription();
        }
    }
```

像上面这样的代码，如果将来要添加年订阅和季度订阅，那就会有很多的`if .. else`, 而且不好扩展，这里怎么改呢？ 首先在`signUp()` 这个方法中，我们是不用去考虑用户订阅的究极是哪一类用户，我们只要在`signUp()` 的时候顺便让用户订阅就行了，具体的订阅方式应该会需要几个类去分别实现，而这几个类会有一个接口`Subscription`, 这里其实就可以采用工厂模式来解决，具体这里不说了，大致的代码如下：

```php

    function signUp(Subscription $subscription)
    {
        // 如果是月订阅用户 $subscription 就是 MonthlySubscription 类的实例
        // 如果是终身订阅用户 $subscription 就是 ForeverSubscription 类的实例

        $subscription->create();
    }

    function getSubscriptionType($type)
    {
        if ($type == 'forever') {
            return new ForeverSubscription;
        }

        return new MonthlySubscription;
    }

    $subscription = getSubscriptionType($type);

    signUp($subscription);
```

## 代码使用一层缩进

我们还是来看例子，假设我们有一批银行账号，这些银行账号分为两种类型 `checking` 和 `saving` 类型，现在我们要筛选出 `saving` 类型的账号，同时这些账户是激活状态的。我们去创建一个银行账号集的类，并按需求把代码先写出来，通常可能会写出下面这样的代码(关于代码注释，我文章中的例子基本都是不正规的，不要纠结这个)：

```php

    class BankAccounts
    {
        protected $accounts;

        public function __construct($accounts)
        {
            $this->accounts = $accounts;
        }

        public function filterBy($accountType)
        {
            $filtered = [];

            // 第 0 层
            foreach ($this->accounts as $account) {
                // 第 1层
                if ($account->type() == $accountType) {
                    // 第 2层
                    if ($account->isActive()) {
                        // 第 3层
                        $filtered[] = $account;
                    }
                }
            }

            return $filtered;
        }
    }
```

上面的代码很普通，没有理解难点，不做备注了， 我们现在看下`filterBy()` 方法中我们使用了3层的缩进，违反了规则，我们需要优化它，在优化之前，我们先编写个 `Account` 的类，先把我们的代码跑正确：

```php
    
    class Account
    {
        // 账号类型
        protected $type;
        
        // 构造函数私有，只能通过 open 方法创建实例
        private function __construct($type)
        {
            $this->type = $type;
        }
    
        // 开设账户，开设账户的时候要指定账户类型
        public static function open($type)
        {
            return new static($type);
        }

        public function type()
        {
            return $this->type;
        }
        
        // 假设账户都是激活的
        public function isActive()
        {
            return true;
        }
    }
```

好了，我们通过下面的代码来测试下，我试了下，可以得到包含两个 Account 对象的数组，没有问题。

```php
    
    $accounts = [
        Account::open('checking'),
        Account::open('saving'),
        Account::open('checking'),
        Account::open('saving')
    ];

    $bankAccounts = new BankAccounts($accounts);
    $savings = $bankAccounts->filterBy('saving');

    var_dump($savings);
```

好了，现在违反一层缩进原则的代码主要是在 `foreach` 语句中， 我们先去掉第3层缩进, 如下:

```php

    // 第 0 层
    foreach ($this->accounts as $account) {
        // 第 1层
        if ($account->type() == $accountType && $account->isActive()) {
            // 第 2层
            $filtered[] = $account;
        }
    }
```

上面代码中的 `$account->type() == $accountType && $account->isActive()` 这句影响阅读，将其封装成一个方法 `isOfType()` (If the account is of the type that was requested.) 其次我们可以使用 `array_filter()` 函数来代替 `foreach()`

```php
    
    public function filterBy($accountType)
    {
        // 第 0 层
        return array_filter($this->accounts, function ($account) use ($accountType) {
            // 第1层
            return $this->isOfType($accountType, $account);
        });
    }

    private function isOfType($accountType, $account)
    {
        return $account->type() == $accountType && $account->isActive();
    }
```

好了，现在的现在已经符合一级缩进的原则了，不过代码还能再优化下，比如说 `isOfType()` 方法，将其放置到 `Account` 类中会更好，这样不用将`$account` 做为变量传入了，这样更语义化。同时可以将 `type()` 和 `isActive()` 变成私有的，更安全。好了，最终的代码如下：

```php

    class BankAccounts
    {
        protected $accounts;

        public function __construct($accounts)
        {
            $this->accounts = $accounts;
        }

        public function filterBy($accountType)
        {
            // 第 0 层
            return array_filter($this->accounts, function ($account) use ($accountType) {
                // 第1层
                return $account->isOfType($accountType);
            });
        }
    }

    class Account
    {
        protected $type;

        //  构造函数私有，只能通过 open 方法创建实例
        private function __construct($type)
        {
            $this->type = $type;
        }

        public static function open($type)
        {
            return new static($type);
        }

        public function isOfType($accountType)
        {
            return $this->type() == $accountType && $this->isActive();
        }

        private function type()
        {
            return $this->type;
        }

        private function isActive()
        {
            return true;
        }
    }

    $accounts = [
        Account::open('checking'),
        Account::open('saving'),
        Account::open('checking'),
        Account::open('saving')
    ];

    $bankAccounts = new BankAccounts($accounts);
    $savings = $bankAccounts->filterBy('saving');

    var_dump($savings);
```

## 限制类属性的个数

`The Thoughtworks Anthology` 此书说到每个类的属性不应该超过2个，如果你使用的是 `Java`, 也许能做到，但是如果使用`php`进行开发的话，这个条件太过苛刻了，基本上很难做。`PHP` 大牛 `Rafael Dohms` （博客地址: http://doh.ms) 说一个类中整个`2到5`个属性那都没问题，`Laravel` 框架作者的好基友 `Jeffrey Way` 说，5个太多了，`2-4`个属性刚刚好。那具体多少个合适呢？ 反正像我这样连工作都不容易找的人是没法给出这种答案的，总之不要超过5个就差不多吧！

跑题了！ 我们还是来看下这条规则，最容易举例的就是与 `User` 相关的类了，因为任何一个 APP 都离不开 `User`, 所以也很容易把与`User`相关的类做成了上帝对象，我们以`UsersController` 来举例，首先前提条件是你已经做到了面向对象开发了，通常在`UsersController`中可能需要做很多事情，比如说需要注册服务类`RegistrationService`, 需要发邮件的类`Mailer`, 需要记录日志的类`Logger`, 需要和数据库打交道的`UserRepository`类，需要支付啊，事件啊等等。 我们把这些罗列下，放入`UsersController`中，如下：

```php

     class UsersController
     {
        protected $userService;

        protected $registrationService;

        protected $userRepository;

        protected $stripe;

        protected $mailer;

        protected $userEventRepository;

        protected $logger;

        public function __construct(
            UserService $userService,
            RegistrationService $registrationService,
            UserRepository $userRepository,
            Stripe $stripe,
            Mailer $mailer,
            UserEventRepository $userEventRepository,
            Logger $logger
        )
        {
            // 
        }
     }
```

上面的这些对象类型的属性，在一个项目中，基本上说都是会用到的，如果这么去写的话，那`UsersController`就会变的非常的大，我们试着去拆分它们。首先来看 `UserService` 这个类和其它类不太一样，它描述的比较抽象，在 laravel 中，我们会经常用到的服务容器 `Services` 就是和这个一样的道理, 我们再看 `$userRepository` 和 `$userEventRepository`这两个属性，它应该是属于`UserService`的，我们应该把它们依赖注入到 `UserService` 中， 如下：

```php

     class UserService
     {
        protected $userRepository;

        protected $userEventRepository;

        public function __construct(
            UserRepository $userRepository, 
            UserEventRepository $userEventRepository
        )
        {
            $this->userRepository = $userRepository;
            $this->userEventRepository = $userEventRepository;
        }
     }
 ```

再来看`RegistrationService`这个属性, 我们可以在`UsersController`中编写`register()` 方法来解决它，但是这么一来会让该控制器中的方法又变的很多，所以对于这种情况，我们需要创建新的控制器来解决，如下：

```php

     class AuthController
     {
        protected $registrationService;

        public function __construct(RegistrationService $registrationService)
        {
            $this->registrationService = $registrationService;
        }

        public function register()
        {
            // use $this->registrationService
        }
     }
 ```

 再来看 `Stripe $stripe`， 它应该是在 `RegistrationService` 中依赖注入的，所以控制器中也可以去掉，最后对于`$mailer` 和 `$logger` 我们可以放在这里，也可以放到 `UserService` 中，不过要注意不要让`UserService`的属性变的过多，它也需要遵守这个原则，或者可以把`$mailer`放到监听中，通常发邮件都是触发一个事件，事件去调用监听，所以这里这两个属性也可以去掉。所以最后的代码如下：

 ```php

     class UsersController
     {
        protected $userService;

        public function __construct(UserService $userService)
        {
            // 
        }
     }

     class UserService
     {
        protected $userRepository;

        public function __construct(
            UserRepository $userRepository, 
            UserEventRepository $userEventRepository
        )
        {
            $this->userRepository = $userRepository;
            $this->userEventRepository = $userEventRepository;
        }
     }

     class AuthController
     {
        protected $registrationService;

        public function __construct(RegistrationService $registrationService)
        {
            $this->registrationService = $registrationService;
        }

        public function register()
        {
            // use $this->registrationService
        }
     }
 ```

好了，如果你使用过 laravel, 你是不是发现上面这样的做法非常熟悉，对，laravel 就是这样干的，而且比上面干的绝对要好的多的多，比如说我们还能像 laravel 一样，加上 Trait 来更好的解决，
laravel 就是那么的遵守原则。所以怎么还会有人说 laravel 的源码很乱呢？ 究竟是自身原因，还是 laravel 的原因呢？

上面的几条原则在 `The Thoughtworks Anthology` 书中都有提到，而且该书中介绍的原则要多的多，但是该书中的原则针对不同的语言并一定适用，比如说，书中说类的属性的个数不能超过2个，显然不适合PHP开发，比如说，书中说要把任何的原生数据类型封装成对象适用，这也不能完全使用于 PHP 开发，至少很多的优秀PHP框架都没这么干。

所以对于编程而言，没有什么绝对的对与不对，好与不好，你如果能搞出一些规则，然后有一大批人认为它可行，能跟随的使用它，那你就是对的，如果做不到，就是跟随他人为我们制定的规则，设计模式其实也就是这个理。


















