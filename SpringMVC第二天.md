# 			SpringMVC第二天

​		

# 1.案例：查询用户列表

## 1.1.编写Controller

创建UserController类：

![1](Img/1.png)

UserController:

```java
@Controller
@RequestMapping("user")
public class UserController {

    @RequestMapping("findAll")
    public String findAllUsers(Model model){
        List<User> users = new ArrayList<User>();
        for (int i = 0; i < 10; i++) {
            User user = new User();
            user.setUsername("张三" + (i+1));
            user.setAge(20 + i);
            user.setIncome(10000.0+i);
            user.setIsMarry(true);
            user.setHobby(new String[]{"篮球","足球","排球"});
            users.add(user);
        }
        model.addAttribute("users", users);
        //返回视图名称
        return "users";
    }

}
```

## 1.2.创建页面

创建users.jsp页面：

```jsp
<%--
  Created by IntelliJ IDEA.
  User: xiaokaibo
  Date: 2018/8/23
  Time: 09:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <style type="text/css">
        #customers {
            font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
            width: 100%;
            border-collapse: collapse;
        }

        #customers td, #customers th {
            font-size: 1em;
            border: 1px solid #98bf21;
            padding: 3px 7px 2px 7px;
        }

        #customers th {
            font-size: 1.1em;
            text-align: left;
            padding-top: 5px;
            padding-bottom: 4px;
            background-color: #A7C942;
            color: #ffffff;
        }

        #customers tr.alt td {
            color: #000000;
            background-color: #EAF2D3;
        }
    </style>

</head>
<body>
<table id="customers">
    <tr>
        <th>用户名</th>
        <th>年龄</th>
        <th>收入</th>
        <th>婚姻状态</th>
        <th>兴趣爱好</th>
    </tr>

    <c:forEach items="${users}" var="user">
        <tr>
            <td>${user.username}</td>
            <td>${user.age}</td>
            <td>${user.income}</td>
            <td>
                <c:choose>
                    <c:when test="${user.isMarry}">
                        已婚
                    </c:when>
                    <c:otherwise>
                        未婚
                    </c:otherwise>
                </c:choose>
            </td>
            <td>
                <c:forEach items="${user.hobby}" var="hobby" varStatus="status">
                    ${hobby}
                    <!-- 每个值用逗号分开 -->
                    <c:if test="${!status.last}">
                        ,
                    </c:if>
                </c:forEach>
            </td>
        </tr>
    </c:forEach>
    
</table>

</body>
</html>
```

浏览器测试访问：

![2](Img/2.png)

# 2.转发及重定向

## 2.1.转发

当Controller中方法的返回值为字符串时，默认为视图名称。当返回值字符串以”forward:”或者”redirect:”开头，则会被认为是转发或重定向。

 使用方法如下：

 转发：”forward:/hello/show27.do”   或者   ”forward:show27.do”

 重定向：”redirect:/hello/show27.do”   或者   ”redirect:show27.do”

在Hello2Controller中增加test26及test27两个方法：

```java
 	@RequestMapping("show26")
    public String test26(){
        return "forward:/hello/show27.do?type=forward";
    }

    @RequestMapping("show27")
    public String test27(Model model,@RequestParam("type") String type){
        model.addAttribute("msg", "转发或重定向：type=" + type);
        return "hello2";
    }
```

测试：

![3](Img/3.png)

## 2.2.重定向

在Hello2Controller中增加test28方法：

```java
  	/**
     * 重定向到/hello/show27.do
     * @return
     */
    @RequestMapping("show28")
    public String test28(){
        return "redirect:/hello/show27.do?type=redirect";
    }
```

测试：

![4](Img/4.png)

# 3.JSON

## 3.1.引入依赖

我们查询到的数据不是json格式的，需要利用json工具包把我们查询到的数据转换成json。因此，需要引入jackson的依赖。

```xml
		<!-- Jackson Json处理工具包 -->
		<dependency>
			<groupId>com.fasterxml.jackson.core</groupId>
			<artifactId>jackson-databind</artifactId>
		</dependency>
```

## 3.3.@ResponseBody

当一个处理请求的方法标记为@ResponseBody时，表示该方法需要输出其它视图（json、xml），springmvc默认通过json转化器转化输出。

在Hello2Controller中增加test29方法：

```java
 	@RequestMapping("show29")
    @ResponseBody
    public List<User> test29(){
        List<User> users = new ArrayList<User>();
        for(int i = 0;i < 10;i++){
            User user = new User();
            user.setUsername("小红" + (i+1));
            user.setAge(20 + i);
            user.setMarry(false);
            user.setIncome(10000.0);
            user.setHobby(new String[]{"篮球","足球","排球"});
            users.add(user);
        }
        return users;
    }
```

浏览器测试访问：

![21](Img/21.png)

## 3.4.配置mvc注解驱动

配置mvc注解驱动，会自动注册消息转换器，通过消息转换器把Controller的返回值转换成json

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:mvc="http://www.springframework.org/schema/mvc"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
        http://www.springframework.org/schema/beans/spring-beans.xsd
        http://www.springframework.org/schema/context
        http://www.springframework.org/schema/context/spring-context.xsd
        http://www.springframework.org/schema/mvc
        http://www.springframework.org/schema/mvc/spring-mvc.xsd">



    <context:component-scan base-package="cn.itcast.controller"/>
    <mvc:annotation-driven/>

    <!--
            配置视图解析器
            prefix：指定视图所在的目录
            suffix：指定视图的后缀名
            例如：prefix="/WEB-INF/jsp/", suffix=".jsp",当viewname="test"时，
            跳转到/WEB-INF/jsp/test.jsp页面
    -->
    <bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
        <property name="prefix" value="/WEB-INF/jsp/"></property>
        <property name="suffix" value=".jsp"></property>
    </bean>

</beans>
```

重启，再次测试：

![7](Img/7.png)

也可以安装jsonview插件显示json数据

![22](Img/22.png)

## 3.4.原理

![5](Img/5.png)



## 3.5.@RequestBody

@RequestBody用于把前端传过来的json格式参数，反向解析成对象并用参数接收

```java
	@RequestMapping("show25")
	public String test25(Model model,@RequestBody User user){
		model.addAttribute("msg", user);
		return "hello2";
	}
```

测试：

![8](Img/8.png)

# 4.文件上传

## 4.1.引入依赖

springmvc文件上传底层使用的还是apache的文件上传组件

```xml
<dependency>
			<groupId>commons-fileupload</groupId>
			<artifactId>commons-fileupload</artifactId>
			<version>1.3.1</version>
</dependency>
```

## 4.2.配置文件上传解析器

请求上传的文件由该上传解析器解析出来

```xml
 		<!-- 配置文件上传解析器 -->
        <bean id="multipartResolver" class="org.springframework.web.multipart.commons.CommonsMultipartResolver">
        	<!-- 上传文件的总大小不能超过10M -->
        	<property name="maxUploadSize" value="10485760"></property>
        	<!-- 设置默认编码 -->
        	<property name="defaultEncoding" value="UTF-8"></property>
        </bean>
```

注意：文件上传解析的id一定要是multipartResolver，因为springmvc底层会根据这个id获取文件上传解析器。

## 4.3.编写Controller

```java
@Controller
public class UploadController {

	/**
	 * @RequestParam("file")表示接收文件参数，类型是MultipartFile
	 * @return
	 * @throws IllegalStateException
	 * @throws IOException
	 */
	@RequestMapping("upload")
	public String upload(@RequestParam("file")MultipartFile file) throws IllegalStateException, IOException{
		if(file != null){
			//复制文件到某个目录
			file.transferTo(new File("C:\\upload\\" + file.getOriginalFilename()));
		}
		return "redirect:/success.html";
	}
}
```

## 4.4.编写页面

![9](Img/9.png)

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
    <h1>文件上传成功</h1>
</body>
</html>
```

## 4.5.测试

注意：上传文件的表单，提交方式一定要是POST;表单类型一定要是multipart/form-data,表示可以上传文件等二进制数据

![10](Img/10.png)

# 5.拦截器

## 5.1.介绍

当请求到达DispatcherServlet时，DispatcherServlet根据请求路径到HandlerMapping查询具体的Handler，从HandlerMapping返回的值是一个HandlerExecutionChain执行链，其中包含一个具体的Handler对象和Interceptors（拦截器集合）。

## 5.2.自定义拦截器

![11](Img/11.png)

```java
public class MyInterceptor implements HandlerInterceptor{

    /**
     * 前置方法，在Handler执行方法之前执行
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        System.out.println("preHandle...");
        return true;
    }

    /**
     * 后置方法，在Handler执行方法之后执行
     */
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
                           ModelAndView modelAndView) throws Exception {
        System.out.println("postHandle...");
    }

    /**
     * 完成方法，在视图渲染完成之后执行
     */
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
            throws Exception {
        System.out.println("afterCompletion...");
    }

}
```

## 5.3.配置自定义拦截器

在springmvc-servlet.xml中配置：

```xml
  <!-- 配置自定义拦截器 -->
    <mvc:interceptors>
        <mvc:interceptor>
            <!-- 拦截所有controller请求，包括多级路径也能被拦截
               例如:/hello.do    /hello/show1.do都能被拦截 -->
            <mvc:mapping path="/**"/>
            <!-- 自定义拦截器的全路径名 -->
            <bean class="cn.itcast.interceptor.MyInterceptor"></bean>
        </mvc:interceptor>
    </mvc:interceptors>
```

## 5.4.测试

![12](Img/12.png)

![13](Img/13.png)

## 5.5.配置多个拦截器

创建第二个自定义拦截器：

![14](Img/14.png)

```java
public class MyInterceptor2 implements HandlerInterceptor {

    /**
     * 前置方法，在Handler执行方法之前执行
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        System.out.println("preHandle2...");
        return true;
    }

    /**
     * 后置方法，在Handler执行方法之后执行
     */
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
                           ModelAndView modelAndView) throws Exception {
        System.out.println("postHandle2...");
    }

    /**
     * 完成方法，在视图渲染完成之后执行
     */
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
            throws Exception {
        System.out.println("afterCompletion2...");
    }


}
```

在springmvc-servlet.xml中配置拦截器：

```xml
<!-- 配置自定义拦截器 -->
        <mvc:interceptors>
        	<mvc:interceptor>
        		<!-- 拦截所有请求（多级路径） -->
        		<mvc:mapping path="/**"/>
        		<!-- 自定义拦截器的全路径名 -->
        		<bean class="cn.itcast.interceptor.MyInterceptor"></bean>
        	</mvc:interceptor>
        	
        	<mvc:interceptor>
        		<!-- 拦截所有请求（多级路径） -->
        		<mvc:mapping path="/**"/>
        		<!-- 自定义拦截器的全路径名 -->
        		<bean class="cn.itcast.interceptor.MyInterceptor2"></bean>
        	</mvc:interceptor>
        </mvc:interceptors>
```

测试结果：

![15](Img/15.png)

## 5.6.拦截器执行顺序

![16](Img/16.png)

![17](Img/17.png)

把MyInterceptor2中preHandle方法的返回值改为false，表示拦截器拦截了请求，不放行，直接返回

![18](Img/18.png)

测试结果如下：

![19](Img/19.png)

应用场景：登陆验证