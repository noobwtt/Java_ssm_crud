# java\_ssm\_crud

简介：使用Spring+SpringMVC+Mybatis框架，实现对员工的增删改查和部门的增删改查


* 框架：Spring+SpringMVC+Mybatis
* 数据库：MySQL
* 前端框架：Bootstrap
* 项目管理：MAVEN
* 开发工具：IntelliJ IDEA
* 开发环境：Win10

---

**【页面】**：

点击左侧的员工信息后:

![员工管理2](https://user-images.githubusercontent.com/48614834/122351473-bdae1c80-cf80-11eb-941e-6343b8796f89.png)



**【数据库建表】**：

tbl_dept表：

```
CREATE TABLE `tbl_dept` (
  `dept_id` int NOT NULL AUTO_INCREMENT,
  `dept_name` varchar(255) NOT NULL,
  `dept_leader` varchar(45) NOT NULL,
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
```

tbl_emp表：

```
CREATE TABLE `tbl_emp` (
  `emp_id` int NOT NULL AUTO_INCREMENT,
  `emp_name` varchar(255) NOT NULL,
  `gender` char(1) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `d_id` int DEFAULT NULL,
  PRIMARY KEY (`emp_id`),
  KEY `fk_id_idx` (`d_id`),
  CONSTRAINT `fk_id` FOREIGN KEY (`d_id`) REFERENCES `tbl_dept` (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2006 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
```

tbl_dept数据:
```
INSERT INTO `tbl_dept` VALUES (1,'开发部'),(2,'测试部');
```

tbl_emp数据:批量生成


**【mybatis逆向工程】：**

在建了员工表和部门表的前提下，通过逆向工程的配置文件src/main/resources/mbg.xml，运行src/main/java/

com/wtt/utils/MBGTest.java，即可通过逆向工程创建出所需要的bean和mapper接口以及mapper接口的映射文件。


**【批量生成】：**
spring配置文件中配置SqlSessionTemplate，运行src/main/java/com/wtt/utils/MapperTest.java即可批量生成emp表测试数据


**【员工信息CRUD】：**

	增删改查流程：发送ajax请求→controller对应方法接受请求→调用service层方法→调用dao层方法对数据库的增删改查


查询(pagehelper分页)：

	点击左侧的员工信息后跳转到employeePage页并发送ajax请求进行员工分页数据的查询，
	
	查到后以json字符串形式返回给游览器，对json解析后，在页面显示。
查询(搜索框):

	搜索框输入员工id后，点击搜索，发送ajax请求，查询指定id的员工，并在页面显示。

新增：

	点击左侧的新增员工后，弹出模态框，发送ajax请求，查询到部门信息，使其显示在模态框的下拉列表中。
	
	在模态框输入员工信息后，点击保存，发送ajax请求，将新增员工保存。

删除(单个删除和批量删除)：

	单个删除：点击每条数据后面的删除按钮后，点击确认删除后，发送ajax请求，通过id删除员工。
	批量删除：勾选要删除数据的checkbox，然后点击面板头部的删除，发送ajax请求，批量删除员工。

修改：

	点击编辑按钮后，弹出模态框，发送ajax请求查询员工信息并显示在模态框中，
	
	可以对员工的邮箱，性别，所属部门进行修改。
	
	修改后，点击更新按钮，发送ajax请求，更新员工信息。


**【校验】：**

员工名正则：^([\u4e00-\u9fa5]{2,5}|[a-zA-Z\s]{3,20})$

邮箱正则：^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$

	前端校验：

	 1)点击保存按钮时校验 

	 2)input框内容改变时校验,内容改变时发送ajax请求，controller层中对应方法收到后进行校验员工名和邮箱,邮箱进行了正则校验和数据唯一性校验

	后端校验：
	  JSR303校验方法：
	   1)pom中添加hibernate-validator依赖
	   2)在实体类上加上相应的正则校验
	   3)controller方法参数前加上注解@Valid，添加参数BindingResult接收校验结果

**【配置文件】：**

src/main/resources/jdbc.properties：数据库配置文件

src/main/resources/applicationContext.xml :spring配置文件(整合了mybatis)

src/main/resources/mybatis-config.xml：mybatis配置文件

src/main/resources/spring-mvc.xml： springmvc配置文件

src/main/resources/mbg.xml： mybatis逆向工程配置文件

src/main/webapp/WEB-INF/web.xml：web.xml配置文件

src/main/resources/mapper/*:mapper接口的映射文件





