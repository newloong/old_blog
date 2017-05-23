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
  <h3>接下来的计划</h3>
  <table>
      <tr>
          <td>
              把php的知识在整理一遍吧！
          </td>
      </tr>
  </table>

  <h3>最新发布的文章</h3>
  <table>
    {% for post in page.posts %}
        <tr>
            <td width="70%">文章标题：<a href="{{ post.path }}">{{ post.title }}</a></td>
            <td width="30%">发布日期：{{ date(post.date, 'YYYY-M-D') }}</td>
        </tr>  
    {% endfor %}
  </table>
  </section>

  {% include '_partials/pagination.swig' %}
{% endblock %}

{% block sidebar %}
  {{ sidebar_template.render(false) }}
{% endblock %}
