# 												SpringMVC第一天

ssm:mybatis+spring+springmvc

# 1.回顾Servlet

先分析我们之前所写的Servlet： 

![1](Img/1.png)

分析以上我们所熟悉的Servlet的代码，可以得出如下结论：

1、传统代码的弊端：在Servlet里存在获取请求参数、页面跳转代码冗余的问题。

2、springmvc的优势：可以解决Servlet里获取请求参数、页面跳转代码用于的问题。

# 2.SpringMVC概述

## 2.1.SpringMVC介绍

HttpServlet   Servlet

![2](Img/2.png)

那SpringMVC到底是什么呢？我们用一句话概括：SpringMVC是一个基于MVC设计模式的WEB层框架。 

## 2.2.MVC设计模式

MVC,全名是(Model View Controller)的缩写，是一种软件设计模式，或软件设计思想。以下是MVC的具体含义：

1、Model:模型，用来处理数据，一般是一个实体类，例如User类；

2、View:视图，用来显示界面，可以是JSP或Html；

3、Controller:控制器，用来决定哪个界面来展示模型；

MVC设计模式其实是一种软件设计思想；MVC设计模式有多种实现方式，其中，JSP+Servlet+JavaBean就是其中的实现方式之一。

![3](Img/3.png)

但是，JSP+Servlet+JavaBean这种实现方式中，Servlet存在着接收请求参数、页面跳转代码冗余的问题。所以，这种实现方式不是最好的MVC的实现。SpringMVC框架就是一种更好的MVC设计模式的实现方式。 

## 2.3.SpringMVC在项目中的作用

JavaEE开发规范规定，一个Java web项目应该要分为三层：

1、WEB层:页面数据显示、页面跳转调度；

2、业务层:业务处理和功能逻辑、事务控制；

3、持久层:数据存取和封装、和数据库打交道；

![4](Img/4.png)

注意：MVC和JavaEE三层架构规范不是同一个概念，一定要区分开来。 

# 3.SpringMVC快速入门

## 3.1.创建web工程

![5](Img/5.png)

## 3.2.引入依赖

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <parent>
        <artifactId>itcast-parent</artifactId>
        <groupId>cn.itcast.parent</groupId>
        <version>0.0.1-SNAPSHOT</version>
    </parent>
    <modelVersion>4.0.0</modelVersion>

    <groupId>cn.itcast</groupId>
    <artifactId>springmvc</artifactId>
    <version>1.0.0-SNAPSHOT</version>
    <packaging>war</packaging>

    <dependencies>
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-webmvc</artifactId>
        </dependency>
        <dependency>
            <groupId>org.slf4j</groupId>
            <artifactId>slf4j-log4j12</artifactId>
        </dependency>
        <!-- JSP相关 -->
        <dependency>
            <groupId>jstl</groupId>
            <artifactId>jstl</artifactId>
        </dependency>
        <dependency>
            <groupId>javax.servlet</groupId>
            <artifactId>servlet-api</artifactId>
        </dependency>
        <dependency>
            <groupId>javax.servlet</groupId>
            <artifactId>jsp-api</artifactId>
        </dependency>
    </dependencies>
    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.tomcat.maven</groupId>
                <artifactId>tomcat7-maven-plugin</artifactId>
                <configuration>
                    <port>8080</port>
                    <path>/</path>
                </configuration>
            </plugin>
        </plugins>
    </build>
</project>
```

顺便把log4j.properties文件引入进来： 

![6](Img/6.png)

## 3.3.配置web.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://java.sun.com/xml/ns/javaee"
           xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
           xsi:schemaLocation="http://java.sun.com/xml/ns/javaee
        http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd"
           version="2.5">
    <!-- springmvc入口 -->
    <servlet>
        <servlet-name>springmvc</servlet-name>
        <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
        <!-- 项目启动时，就加载并实例化 -->
        <load-on-startup>1</load-on-startup>
    </servlet>
    <!-- 
        /*拦截所有请求
        /拦截所有请求，不包括jsp
        *.do表示拦截所有以.do结尾的请求
     -->
    <servlet-mapping>
        <servlet-name>springmvc</servlet-name>
        <url-pattern>*.do</url-pattern>
    </servlet-mapping>
</web-app>
```

## 3.4.创建Controller 

提示：以前是由Servlet来处理请求，现在是由Controller来处理请求

![7](Img/7.png)

```java
/**
 * Controller类要实现Controller接口
 * @author xiaokaibo
 *
 */
public class HelloController implements Controller {

    /**
     * 处理请求
     */
    @Override
    public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        System.out.println("hello请求进来了...");
        ModelAndView mv = new ModelAndView();
        //添加一个数据，页面上可以取出这个数据
        mv.addObject("msg", "这是第一个springmvc程序");
        //设置视图的名字
        mv.setViewName("hello");
        return mv;
    }

}
```

那么这个Controller类该如何访问呢？访问HelloController之后又该往哪个页面跳转呢？接着往下看。 

## 3.5.创建springmvc的配置文件

Controller类写好之后，需要在springmvc的配置文件里配置。

那么SpringMVC的配置文件放在哪呢？又该怎么命名呢？

![8](Img/8.png)

由此，我们知道springmvc默认读取/WEB-INF/{servlet-name}-servlet.xml这个文件，因为我们在web.xml中配置的servlet-name是springmvc，所以在WEB-INF下创建springmvc-servlet.xml: 

![9](Img/9.png)

## 3.6.配置Controller类

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
        http://www.springframework.org/schema/beans/spring-beans.xsd">
    <!-- 
                   把Controller交给spring管理，
                   在浏览器中通过id属性的值来访问
                   而我们在web.xml中配置的DispatcherServlet的访问路径是*.do
                   为了能够让请求进入springmvc框架，所以id的值以do结尾
     -->
    <bean id="/hello.do" class="cn.itcast.controller.HelloController"></bean>

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

## 3.7.创建页面 

![10](Img/10.png)

## 3.8.测试

![11](Img/11.png)

## 3.9.运行流程

![12](Img/12.png)

![13](Img/13.png)

## 3.10.springmvc整体结构

![14](Img/14.png)

在springmvc中，

V:页面（jsp）

C:入口DispatcherServlet

M:Handler(业务模型)。说明：MVC中的Model包含两种：数据模型和业务模型，在jsp+servlet+javabean中，javabean更多充当的是数据模型；而在springmvc中，Handler充当的是业务模型，在其中包含一些简单的业务规则。

# 4.SpringMVC注解配置

## 4.1.  Xml配置的弊端

每个Controller类只能完成一个用户请求（处理一个业务逻辑）。 

## 4.2.  创建Controller类

![15](Img/15.png)

```java
@Controller
public class Hello2Controller {

    @RequestMapping("show1")
    public ModelAndView test1(){
        ModelAndView mv = new ModelAndView();
        mv.addObject("msg", "这是第一个基于注解的springmvc程序");
        //设置视图名称为hello2，将来会被解析到/WEB-INF/jsp/hello2.jsp
        mv.setViewName("hello2");
        return mv;
    }
}
```

## 4.3.  开启注解扫描

在springmvc-servlet.xml中开启注解扫描： 

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
        http://www.springframework.org/schema/beans/spring-beans.xsd http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context.xsd">
    <context:component-scan base-package="cn.itcast.controller"></context:component-scan>
    <!--
                   把Controller交给spring管理，
                   在浏览器中通过id属性的值来访问
                   而我们在web.xml中配置的DispatcherServlet的访问路径是*.do
                   为了能够让请求进入springmvc框架，所以id的值以do结尾
            -->
    <bean id="/hello.do" class="cn.itcast.controller.HelloController"></bean>

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

## 4.3.  创建页面

![16](Img/16.png)

hello2.jsp： 

```jsp
<%--
  Created by IntelliJ IDEA.
  User: xiaokaibo
  Date: 2018/7/24
  Time: 23:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <h1>${msg}</h1>
</body>
</html>
```

## 4.5.  测试

![17](Img/17.png)

## 4.6.注解程序分析 

打开DispatcherServlet.properties: 

![18](Img/18.png)

![19](Img/19.png)

我们发现，springmvc还会给我们提供一个基于注解的Handler映射器和适配器，通过观察日志信息也能发现这一点： 

![20](Img/20.png)

# 5.RequestMapping映射请求

## 5.1.标准URL映射

语法：@RequestMapping(value=”xxx”)

 可以定义在Controller类上，也可以定义在Controller类中的方法上。

 如果Controller类上和方法上都加了@RequestMapping，那么该请求路径就是：类上的@RequestMapping的value+方法上的@RequestMapping的value;如果value不以/开头，springmvc会自动加上。

 Controller类上的@RequestMapping可以省略，此时请求路径就是：方法上的@RequestMapping的value.

```java
@Controller
@RequestMapping("hello")
public class Hello2Controller {

    @RequestMapping("show1")
    public ModelAndView test1(){
        ModelAndView mv = new ModelAndView();
        mv.addObject("msg", "这是第一个基于注解的springmvc程序");
        //设置视图名称为hello2，将来会被解析到/WEB-INF/jsp/hello2.jsp
        mv.setViewName("hello2");
        return mv;
    }
}
```

![27](Img/27.png)

## 5.2.ant风格映射

?：通配一个字符

*:通配0个或多个字符

**:通配0个或多个路径

```java
/**
 * ?通配一个字符
 */
@RequestMapping("sss?/show2")
public ModelAndView test2(){
    ModelAndView mv = new ModelAndView();
    mv.setViewName("hello2");
    mv.addObject("msg", "ant风格映射：?");
    return mv;
}

/**
 * *通配0个或多个字符
 */
@RequestMapping("aa*/show3")
public ModelAndView test3(){
    ModelAndView mv = new ModelAndView();
    mv.setViewName("hello2");
    mv.addObject("msg", "ant风格映射：*");
    return mv;
}

/**
 * **通配0个或多个路径
 */
@RequestMapping("**/show4")
public ModelAndView test4(){
    ModelAndView mv = new ModelAndView();
    mv.setViewName("hello2");
    mv.addObject("msg", "ant风格映射：**");
    return mv;
}
```

## 5.3.占位符映射

语法：@RequestMapping(value=”user/{userId}/{userName}”)

请求路径：<http://localhost:8080/springmvc/user/1/james>

这种请求方式虽然和*很类似，却比通配符*更强大，占位符除了可以起到通配的作用，最精要的地方就在于可以传递参数。

例如：@PathVariable(“userId”) Long userId  可以接收userId参数；@PathVariable(“userName”) String userName  可以接收userName参数。

注意：@PathVariable(key)中的key值一定要与占位符的名字一致，而形参的名字可以自定义。

```java
/**
 * 占位符映射
 */
@RequestMapping("show5/{id}/{name}")
public ModelAndView test5(@PathVariable("id")Long id, @PathVariable("name")String name){
    ModelAndView mv = new ModelAndView();
    mv.setViewName("hello2");
    mv.addObject("msg", "占位符映射：id:" + id + ";name:" + name);
    return mv;
}
```

![29](Img/29.png)

如果传递过来的参数类型和接收参数的形参类型不一致，则会自动转换；如果转换失败（例如：id传的是abc字符串，而是方法的形参定义的是Long），则会报400错误（参数列表错误）。 

![30](Img/30.png)

## 5.4.限定请求方法映射 

```java
/**
 * 限定请求方法映射
 */
@RequestMapping(value="show6",method= RequestMethod.POST)
public ModelAndView test6(){
    ModelAndView mv = new ModelAndView();
    mv.setViewName("hello2");
    mv.addObject("msg", "限定请求方法映射");
    return mv;
}
```

用到了框架提供的RequestMethod枚举类，源代码截图如下： 

![31](Img/31.png)

如果通过浏览器输入地址直接访问，也就是发送get请求，结果： 

![32](Img/32.png)

地址栏无法模拟post请求，需要使用浏览器插件，模拟POST请求，下图为chrome浏览器的模拟插件： 

![33](Img/33.png)

安装过程参见教程： 

![33](Img/34.png)

插件安装完成之后，模拟发送POST请求： 

![35](Img/35.png)

点击步骤7，可以查看响应效果： 

![36](Img/36.png)

## 5.5.限定请求参数映射

语法：@RequestMapping(value=””,params=””)

 params=”id”    :     请求参数中必须有id

 params=”!id”   :     请求参数中不能包含id

 params=”id=1”  :     请求参数中id的值必须为1

 params=”id!=1”  :    请求参数中id的值必须不能等于1

 params={“id”,”name”}  :   请求参数中必须包含id和name两个参数

```java
/**
 * 请求参数中必须带有id
 * @return
 */
@RequestMapping(value="show7",params="id")
public ModelAndView test7(){
    ModelAndView mv = new ModelAndView();
    mv.setViewName("hello2");
    mv.addObject("msg", "限定请求参数的映射：必须有id");
    return mv;
}

/**
 * 请求参数中不能带有id
 * @return
 */
@RequestMapping(value="show8",params="!id")
public ModelAndView test8(){
    ModelAndView mv = new ModelAndView();
    mv.setViewName("hello2");
    mv.addObject("msg", "限定请求参数的映射：不能有id");
    return mv;
}

/**
 * 请求参数中id必须等于1
 * @return
 */
@RequestMapping(value="show9",params="id=1")
public ModelAndView test9(){
    ModelAndView mv = new ModelAndView();
    mv.setViewName("hello2");
    mv.addObject("msg", "限定请求参数的映射：id=1");
    return mv;
}

/**
 * 请求参数中id必须不为1
 * @return
 */
@RequestMapping(value="show10",params="id!=1")
public ModelAndView test10(){
    ModelAndView mv = new ModelAndView();
    mv.setViewName("hello2");
    mv.addObject("msg", "限定请求参数的映射：id!=1");
    return mv;
}

/**
 * 请求参数中必须有id name
 * @return
 */
@RequestMapping(value="show11",params={"id","name"})
public ModelAndView test11(){
    ModelAndView mv = new ModelAndView();
    mv.setViewName("hello2");
    mv.addObject("msg", "限定请求参数的映射：请求参数中必须有id,name");
    return mv;
}
```

## 5.6.组合注解

@GetMapping：相当于@RequestMapping(method=RequestMethod.GET)

@PostMapping：相当于@RequestMapping(method=RequestMethod.POST)

@PutMapping：相当于@RequestMapping(method=RequestMethod.PUT)

@DeleteMapping：相当于@RequestMapping(method=RequestMethod.DELETE)

```java
/**
 * 组合注解之GetMapping
 * @return
 */
@GetMapping(value="show12")
public ModelAndView test12(){
    ModelAndView mv = new ModelAndView();
    mv.setViewName("hello2");
    mv.addObject("msg", "组合注解之@GetMapping");
    return mv;
}

/**
 * 组合注解之PostMapping
 * @return
 */
@PostMapping(value="show13")
public ModelAndView test13(){
    ModelAndView mv = new ModelAndView();
    mv.setViewName("hello2");
    mv.addObject("msg", "组合注解之@PostMapping");
    return mv;
}

/**
 * 组合注解之PutMapping
 * @return
 */
@PutMapping(value="show14")
public ModelAndView test14(){
    ModelAndView mv = new ModelAndView();
    mv.setViewName("hello2");
    mv.addObject("msg", "组合注解之@PutMapping");
    return mv;
}

/**
 * 组合注解之DeleteMapping
 * @return
 */
@DeleteMapping(value="show15")
public ModelAndView test15(){
    ModelAndView mv = new ModelAndView();
    mv.setViewName("hello2");
    mv.addObject("msg", "组合注解之@DeleteMapping");
    return mv;
}
```

# 6.接收参数

## 6.1.接收请求路径中占位符的值

```java
	/**
	 * 占位符映射
	 */
	@RequestMapping("show5/{id}/{name}")
	public ModelAndView test5(@PathVariable("id")Double id,@PathVariable("name")String name){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("hello2");
		mv.addObject("msg", "占位符映射：id:" + id + ";name:" + name);
		return mv;
	}

```

浏览器测试： 

![37](Img/37.png)

## 6.2.接收普通的请求参数

语法：@RequestParam(value=”参数名”,required=”true/false”,defaultValue=””)

value：参数名

 required：是否必须，默认为true，表示该请求路径中必须包含该参数，如果不包含就报错。

 defaultValue：默认参数值，如果设置了该值，required=true将失效，自动为false,如果没有传该参数，就使用默认值

```java
/**
	 * 接收普通请求参数
	 * @return
	 */
	@RequestMapping("show16")
	public ModelAndView test16(@RequestParam("name")String name){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("hello2");
		mv.addObject("msg", "接收普通的请求参数：" + name);
		return mv;
	}
	
	/**
	 * 接收普通请求参数
	 * @return
	 */
	@RequestMapping("show17")
	public ModelAndView test17(@RequestParam(value="name",required=false)String name){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("hello2");
		mv.addObject("msg", "接收普通请求参数：" + name);
		return mv;
	}
	
	/**
	 * 接收普通请求参数
	 * @return
	 */
	@RequestMapping("show18")
	public ModelAndView test18(@RequestParam(value="name",required=true,defaultValue="hello")String name){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("hello2");
		mv.addObject("msg", "接收普通请求参数：" + name);
		return mv;
	}
```

## 6.3.基本数据类型的接收

在src/main/webapp下创建user.html

![38](Img/38.png)

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
<form action="/hello/show19.do" method="post">
    用户名：<input type="text" name="username"><br>
    年龄：<input type="text" name="age"><br>
    婚否：<input type="radio" name="marry" value="1" checked="checked">已婚
 <input type="radio" name="marry" value="0">未婚<br>
    收入：<input type="text" name="income"><br>
    爱好：<input type="checkbox" name="hobby" value="football">足球
    <input type="checkbox" name="hobby" value="basketball">篮球
    <input type="checkbox" name="hobby" value="yuball">羽毛球
    <br>
   <input type="submit" value="提交">
</form>

</body>
</html>
```

```java
	@RequestMapping("show19")
	public ModelAndView test19(@RequestParam("username")String username,@RequestParam("age")Integer age,@RequestParam("marry")Boolean isMarry,@RequestParam("income")Double income,@RequestParam(value="hobby",required=false)String[] hobby){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("hello2");
		StringBuffer sb = new StringBuffer();
		sb.append(username + "," + age + "," + marry + "," + income);
		if(hobby != null){
			for (String string : hobby) {
				sb.append("," + string);
			}
		}
		
		mv.addObject("msg", "基本数据类型的接收：" + sb.toString());
		return mv;
	}
```

## 6.4.对象的接收

封装实体类User：

![39](Img/39.png)

```java
public class User {

    private String username;
    private Integer age;
    private Boolean marry;
    private Double income;
    private String[] hobby;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public Boolean getMarry() {
        return marry;
    }

    public void setMarry(Boolean marry) {
        this.marry = marry;
    }

    public Double getIncome() {
        return income;
    }

    public void setIncome(Double income) {
        this.income = income;
    }

    public String[] getHobby() {
        return hobby;
    }

    public void setHobby(String[] hobby) {
        this.hobby = hobby;
    }

    @Override
    public String toString() {
        return "User{" +
                "username='" + username + '\'' +
                ", age=" + age +
                ", marry=" + marry +
                ", income=" + income +
                ", hobby=" + Arrays.toString(hobby) +
                '}';
    }
}
```

修改user.html的提交路径： 

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
<form action="/hello/show20.do" method="post">
    用户名：<input type="text" name="username"><br>
    年龄：<input type="text" name="age"><br>
    婚否：<input type="radio" name="marry" value="1" checked="checked">已婚
  <input type="radio" name="marry" value="0">未婚<br>
    收入：<input type="text" name="income"><br>
    爱好：<input type="checkbox" name="hobby" value="football">足球
    <input type="checkbox" name="hobby" value="basketball">篮球
    <input type="checkbox" name="hobby" value="yuball">羽毛球
    <br>
   <input type="submit" value="提交">
</form>
</body>
</html>
```

在Hello2Controller中增加test20方法： 

```java
@RequestMapping("show20")
public ModelAndView test20(User user){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("hello2");
		mv.addObject("msg", "对象数据的接收：" + user);
		return mv;
}
```

## 6.5.集合的接收

创建实体类UserVO

![40](Img/40.png)

```java
public class UserVO implements Serializable {

    private static final long serialVersionUID = 1L;

    private List<User> users;

    public List<User> getUsers() {
        return users;
    }

    public void setUsers(List<User> users) {
        this.users = users;
    }

    @Override
    public String toString() {
        return "UserVO [users=" + users + "]";
    }

}
```

通过浏览器访问： 

```java
@RequestMapping("show21")
	public ModelAndView test21(UserVO userVO){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("hello2");
		mv.addObject("msg", "集合类型的接收：" + userVO);
		return mv;
}
```

![41](Img/41.png)

## 6.6.获取Servlet API

在Controller中获取HttpServletRequest、HttpServletResponse及HttpSession

在Hello2Controller中增加test22方法： 

```java
@RequestMapping("show22")
	public ModelAndView test22(HttpServletRequest request,HttpServletResponse response,HttpSession session){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("hello2");
		StringBuffer sb = new StringBuffer();
		sb.append(request.toString() + "<br>");
		sb.append(response.toString() + "<br>");
		sb.append(session.toString() + "<br>");
		mv.addObject("msg", "访问Servlet API：<br>" + sb.toString());
		return mv;
	}

```

通过浏览器测试访问： 

![42](Img/42.png)

其实SpringMVC也有一个自己的内置对象，叫Model，表示数据模型

 在Hello2Controller中增加test23方法：

```java
	@RequestMapping("show23")
	public String test23(Model model,HttpServletRequest request,HttpServletResponse response,HttpSession session){
		StringBuffer sb = new StringBuffer();
		sb.append(request.toString() + "<br>");
		sb.append(response.toString() + "<br>");
		sb.append(session.toString() + "<br>");
		model.addAttribute("msg", "访问Servlet API：" + sb.toString());
       //返回视图名称
		return "hello2";
	}

```

ModelMap和Model是一样的效果： 

```java
@RequestMapping("show23")
	public String test23(ModelMap map,HttpServletRequest request,HttpServletResponse response,HttpSession session){
		StringBuffer sb = new StringBuffer();
		sb.append(request.toString() + "<br>");
		sb.append(response.toString() + "<br>");
		sb.append(session.toString() + "<br>");
		map.addAttribute("msg", "访问Servlet API2：" + sb.toString());
		//返回视图名称
		return "hello2";
	}

```

## 6.7.获取cookie

@CookieValue的使用方法同@RequestParam 

```java
	@RequestMapping("show25")
	public String test25(Model model,@CookieValue("JSESSIONID")String jsessionid){
		model.addAttribute("msg", "获取cookie,jsessionid:" + jsessionid);
		return "hello2";
	}

```

通过浏览器测试访问： 

![43](Img/43.png)