{% extends '_layout.swig' %}
{% import '_macro/post.swig' as post_template %}
{% import '_macro/sidebar.swig' as sidebar_template %}

{% block title %}{{ config.title }}{% if theme.index_with_subtitle and config.subtitle %} - {{config.subtitle }}{% endif %}{% endblock %}

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
  <h3>目前正在写的文章 - <a href="/与-PHP-相关的知识和技能整理/PHP框架是如何诞生的/">论PHP框架是如何诞生的?</a></h3>
  <p>
  你好，我是“老周”，这是新博客的开篇文章，如果我从没有学习过PHP开发，但是我会一些HTML和CSS，我听说过一些PHP框架，但是我却没有使用过这些框架，我该怎么进入PHP开发者的行列呢？还有为什么学习了原生的PHP，我还要去学习那些框架呢？这些框架究竟有什么好处？为什么会产生框架？我最初学习PHP的时候上面的问题都想过，纠结啊！</p>
  <p>
  这篇文章应该会比较长，我打算从PHP的基础开始罗列，做一个简单的页面，然后慢慢演化成框架！嗯，这样会把框架是如何诞生的这个问题给理清，对于今后学习框架会有好处！<a href="/与-PHP-相关的知识和技能整理/PHP框架是如何诞生的/">点击阅读全文</a>
  </p>


   <h3>如何阅读新博客</h3>
    <p>
          新博客的内容基本会按从初级到高级的顺序来写，在这张页面会列举出最近的动态，右边的导航栏带 `书本` 图标的是一个系列的主目录, 带`>` 图标的是具体的栏目，栏目内可能还会分出许多文章，如果是新手，可以按顺序阅读。可以在 `Github` 上 `Watch` 或 `Star` 本博客，但是请不要`Fuck(fork)`它，因为这个主题我随意修改的，有很多地方很乱，你会晕！ 这样一旦博客更新，你会第一时间知道。该博客的 `Github` 地址为:
    <a href="https://github.com/zhoujiping/blog">https://github.com/zhoujiping/blog</a>
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
