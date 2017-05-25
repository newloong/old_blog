{% extends '_layout.swig' %}
{% import '_macro/post.swig' as post_template %}
{% import '_macro/sidebar.swig' as sidebar_template %}

{% block title %}周继平的博客 - 记录和整理与 Web 开发相关的一些资料{% endblock %}

{% block page_class %}
  {% if is_home() %} page-home {% endif %}
{% endblock %}

{% block content %}
 <h1 class="zjp-home-h1">最新动态</h1>
  <blockquote>
  <ul>
      <li>博客现在采用 Hexo 搭建了，这样可以把写的文章都保存在 github 上，省的备份，主题是采用 Next 的，自己做了一些小修改，以前的博客域名更改为：<a href="http://blog.zhoujiping.com" target="_blank">http://blog.zhoujiping.com</a>, 如果以前的老博客文章对你还有帮助，你还可以继续查看，不过以后文章都会发布在这里。</li>
  </ul>
  </blockquote>
  <section id="posts" class="zjp-home">
  <h3>目前正在写的文章 - <a href="/php/PHP框架是如何诞生的/">论PHP框架是如何诞生的?</a></h3>
  <p>
  你好，我是“老周”，这是新博客的开篇文章，如果我从没有学习过PHP开发，但是我会一些HTML和CSS，我听说过一些PHP框架，但是我却没有使用过这些框架，我该怎么进入PHP开发者的行列呢？还有为什么学习了原生的PHP，我还要去学习那些框架呢？这些框架究竟有什么好处？为什么会产生框架？我最初学习PHP的时候上面的问题都想过，纠结啊！</p>
  <p>
  这篇文章应该会比较长，我打算从PHP的基础开始罗列，做一个简单的页面，然后慢慢演化成框架！嗯，这样会把框架是如何诞生的这个问题给理清，对于今后学习框架会有好处！<a href="/php/PHP框架是如何诞生的/">点击阅读全文</a>
  </p>


 <h3>为什么改用Hexo搭建新博客？</h3>
  主要有三点原因：
  <ol>
    <li><p>以前的<a href="http://blog.zhoujiping.com">老博客</a>使用 typecho 搭建的， 每次写文章都要进入后台编写，写作体验不是很好，现在换成了 Hexo 搭建， 在本机上用 Sublime Text 上编写文章感觉好很多，这样个人感觉思路会更清晰点。</p></li>

    <li><p>现在自己的记忆越来越差了，感觉已经进入了老年痴呆的行列，自己写的文章过几天都连自己都找不到了，所以新的博客我希望有一条清晰可见的导航，能让我一目了然的知道我之前写过什么，今后写的该放在那里，而且也想好好的把 web 开发的知识相对系统的给自己整理下，于是就有了现在的像右边这样的导航栏结构。 其中带书本标志的是一个大系列，带 > 标志的是属于这个系列的，顺序基本是按照从初级到高级来编排的。</p></li>

    <li><p>以前的代码都放在 Coding 上, 基本都是私有的，博客的文章都是存放在自己服务器的数据库中，事实上这些文章放在 Github 上会更好，至少省得备份了，这个博客在 Github 上的地址是 <a href="https://github.com/zhoujiping/blog">https://github.com/zhoujiping/blog</a>， 如果本博客的文章对你也有用，你可以 Watch 它。</p></li>
  </ol>

  <h3>免责声明</h3>
  <p>
    本人不是大牛，在本人博客上的文章主要是用来给自己整理和备忘的，有些时候的文章很多是自己对某个问题的思考，你在阅读这些文章的时候请保持批判的心态，文章的内容仅代表在我我目前眼界下的观点。

    另外本人以前有八年的时间都在开办对外汉语培训机构，所以免不了啰嗦和一些说教，文章中出现类式的言语请自动过滤。
  </p>

  <h3>最新发布的文章</h3>
  <table>
    <tr>
      <th width="70%">文章标题</th>
      <th width="15%">创建时间</th>
      <th width="15%">最后更新时间</th>
    </tr>
    {% for post in page.posts %}
        <tr>
            <td width="70%"><a href="{{ post.path }}">{{ post.title }}</a></td>
            <td width="15%">{{ date(post.date, 'YYYY-M-D') }}</td>
            <td width="15%">{{ date(post.updated, 'YYYY-M-D') }}</td>
        </tr>  
    {% endfor %}
  </table>
  </section>

  {% include '_partials/pagination.swig' %}
{% endblock %}

{% block sidebar %}
  {{ sidebar_template.render(false) }}
{% endblock %}
