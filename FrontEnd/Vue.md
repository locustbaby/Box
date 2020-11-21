#### Vue

##### 参考资料

```markdown
Vue api: https://cn.vuejs.org/v2/api/index.html
Vue js:  https://cn.vuejs.org/
Bootstrap-Vue: https://bootstrap-vue.js.org/
Axios: https://www.kancloud.cn/yunye/axios/234845
```

##### Vue jinjia2 冲突

```html
# 修改Vue 
// ES6 模板字符串
Vue.config.delimiters = ['${', '}']
// 修改文本插值的定界符。

Vue.config.unsafeDelimiters = ['{!!', '!!}']
// 修改原生 HTML 插值的定界符。

# 修改JinJia
app.jinja_env.variable_start_string = '{{ '
app.jinja_env.variable_end_string = ' }}'
# 修改Vue
// 1.x
Vue.config.delimiters = ['{[', ']}']

// 2.x
new Vue({
    delimiters: ['{[', ']}']
})
```

##### sss