# 从 0 到 1

1. [概览](#TOC-概览)
2. [前期准备](#TOC-前期准备)
3. [开始](#TOC-开始)
    * [新建 Maven 项目](#TOC-新建-Maven-项目)
    * [检查初始项目目录与文件](#TOC-检查初始项目目录与文件)
    * [添加依赖](#TOC-添加依赖)
        * [集成 Spring](#TOC-集成-Spring)
        * [集成 Spring MVC](#TOC-集成-Spring-MVC)
        * [集成 MyBatis](#TOC-集成-MyBatis)
        * [Web 相关](#TOC-Web-相关)
        * [日志](#TOC-日志)
    * [构建文件目录](#TOC-构建文件目录)
    * [编写配置文件](#TOC-编写配置文件)
        * [applicationContext.xml](#TOC-applicationContext.xml)
        * [springmvc-config.xml](#TOC-springmvc-config.xml)
        * [mybatis-config.xml](#TOC-mybatis-config.xml)
        * [web.xml](#TOC-web.xml)
        * [log4j.properties](#TOC-log4j.properties)
4. [发起 Issue](#TOC-发起-Issue)
5. [展望](#TOC-展望)

## <a name="TOC-概览"></a>概览

教你从 0 开始搭建 Web 开发。

## <a name="TOC-前期准备"></a>前期准备

* IntelliJ IDEA
* Maven
* Tomcat
* MySQL

## <a name="TOC-开始"></a>开始

### <a name="TOC-新建-Maven-项目"></a>新建 Maven 项目（截图）

1. 打开 IntelliJ IDEA
2. Create New Project 或 File -> New -> Project...
3. Maven -> 勾选 "Create from archetype" -> org.apache.maven.archetypes:maven-archetype-webapp -> Next
4. 起名
    * Name：`ocean`，填写项目名
    * Location：项目放在哪
    * Artifact Coordinates
        * GroupId：`org.example`，是公司、团体、组织机构等的唯一标识。通常约定以创建这个项目的组织名称的逆向域，如：org.apache 等
        * ArtifactId：`ocean`，项目的唯一标识，可以理解为项目名，与上面填写的 Name 一致
        * version: `1.0-SNAPSHOP`，版本，按照默认即可，无需修改
    * Next
5. 设置 Maven
    * Maven home directory：`/usr/local/Cellar/maven/3.6.3_1/libexec`
        - 如何找到上面的地址（可能仅适用于通过 Homebrew 安装的 Maven）：在终端中输入：`mvn -v` 即可看见
    * User setting file：`/Users/XXX/.m2/settings.xml`
        - XXX 是你的用户名，一般在 Macintosh HD/Users/XXX 目录下可以看见，下同
        - 会自动勾选 Override
    * Local repository：`/Users/XXX/.m2/repository`
        - 会自动勾选 Override
    * Properties：默认即可，无需修改或添加  
        - 可能会遇到构建 Maven 项目过慢的情况，可以添加如下属性：`archetypeCatalog=internal`
    * Finish
6. 进入项目后，右下角会提示：Maven projects need to be imported，勾选 Enable Auto-Import 即可
7. 完成

### <a name="TOC-检查初始项目目录与文件"></a>检查初始项目目录与文件

1. 初始项目目录（截图）
2. 初始项目文件
    * web.xml
    
    ```xml
    <!DOCTYPE web-app PUBLIC
    "-//Sun Microsystems, Inc.//DTD Web Application 2.3//EN"
    "http://java.sun.com/dtd/web-app_2_3.dtd" >

    <web-app>
      <display-name>Archetype Created Web Application</display-name>
    </web-app>
    ```
    
    * index.jsp
    
    ```jsp
    <html>
      <body>
        <h2>Hello World!</h2>
      </body>
    </html>
    ```
    
    * pom.xml
    
    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    
    <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
      <modelVersion>4.0.0</modelVersion>

      <groupId>org.example</groupId>
      <artifactId>ocean</artifactId>
      <version>1.0-SNAPSHOT</version>
      <packaging>war</packaging>

      <name>ocean Maven Webapp</name>
      <!-- FIXME change it to the project's website -->
      <url>http://www.example.com</url>

      <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <maven.compiler.source>1.7</maven.compiler.source>
        <maven.compiler.target>1.7</maven.compiler.target>
      </properties>

      <dependencies>
        <dependency>
          <groupId>junit</groupId>
          <artifactId>junit</artifactId>
          <version>4.11</version>
          <scope>test</scope>
        </dependency>
      </dependencies>

      <build>
        <finalName>ocean</finalName>
        <pluginManagement><!-- lock down plugins versions to avoid using Maven defaults (may be moved to parent pom) -->
          <plugins>
            <plugin>
              <artifactId>maven-clean-plugin</artifactId>
              <version>3.1.0</version>
            </plugin>
            <!-- see http://maven.apache.org/ref/current/maven-core/default-bindings.html#Plugin_bindings_for_war_packaging -->
            <plugin>
              <artifactId>maven-resources-plugin</artifactId>
              <version>3.0.2</version>
            </plugin>
            <plugin>
              <artifactId>maven-compiler-plugin</artifactId>
              <version>3.8.0</version>
            </plugin>
            <plugin>
              <artifactId>maven-surefire-plugin</artifactId>
              <version>2.22.1</version>
            </plugin>
            <plugin>
              <artifactId>maven-war-plugin</artifactId>
              <version>3.2.2</version>
            </plugin>
            <plugin>
              <artifactId>maven-install-plugin</artifactId>
              <version>2.5.2</version>
            </plugin>
            <plugin>
              <artifactId>maven-deploy-plugin</artifactId>
              <version>2.8.2</version>
            </plugin>
          </plugins>
        </pluginManagement>
      </build>
    </project>
    ```

3. 替换代码
    * 将初始 web.xml 中文件代码替换为下面的代码
  
    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <web-app xmlns="http://java.sun.com/xml/ns/javaee"
             xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
             xsi:schemaLocation="
                http://java.sun.com/xml/ns/javaee
                http://java.sun.com/xml/ns/javaee/web-app_3_0.xsd"
             version="3.0">
    </web-app>
    ```

    此举是为了避免在 web.xml 中添加配置时出现下列异常，详见 [Stack Overflow](https://stackoverflow.com/questions/12472541/the-content-of-element-type-must-match-in-web-xml)
     
    > The content of element type "web-app" must match "(icon?,display-name?,description?,distributable?,context-param*,filter*,filter- mapping*,listener*,servlet*,servlet-mapping*,session-config?,mime-mapping*,welcome-file-list?,error-page*,taglib*,resource-env- ref*,resource-ref*,security-constraint*,login-config?,security-role*,env-entry*,ejb-ref*,ejb-local-ref*)".

### <a name="TOC-添加依赖"></a>添加依赖

需要在 pom.xml 文件中添加相关依赖

#### <a name="TOC-集成-Spring"></a>集成 Spring

1. 管理 Spring 相关依赖的版本

将其放置在 `<dependencies />` 后面，`<build />` 之前。

```
<dependencyManagement>
  <dependencies>
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-framework-bom</artifactId>
      <version>4.3.4.RELEASE</version>
      <type>pom</type>
      <scope>import</scope>
    </dependency>
  </dependencies>
</dependencyManagement>
```

2. Spring 上下文，核心依赖

```
<dependency>
  <groupId>org.springframework</groupId>
  <artifactId>spring-context</artifactId>
</dependency>
```

3. Spring JDBC

```
<dependency>
  <groupId>org.springframework</groupId>
  <artifactId>spring-jdbc</artifactId>
</dependency>
```

4. Spring 事物

```
<dependency>
  <groupId>org.springframework</groupId>
  <artifactId>spring-tx</artifactId>
</dependency>
```

5. Spring 面向切面编程

```
<dependency>
  <groupId>org.springframework</groupId>
  <artifactId>spring-aop</artifactId>
</dependency>
```

6. Spring AOP 依赖

```
<dependency>
  <groupId>org.aspectj</groupId>
  <artifactId>aspectjweaver</artifactId>
  <version>1.8.2</version>
</dependency>
```

7. Java 事物接口

```
<dependency>
  <groupId>javax.transaction</groupId>
  <artifactId>javax.transaction-api</artifactId>
  <version>1.2</version>
</dependency>
```
    
#### <a name="TOC-集成-Spring-MVC"></a>集成 Spring MVC

1. Spring Web 核心

```
<dependency>
  <groupId>org.springframework</groupId>
  <artifactId>spring-web</artifactId>
</dependency>
```

2. Spring MVC

```
<dependency>
  <groupId>org.springframework</groupId>
  <artifactId>spring-webmvc</artifactId>
</dependency>
```

#### <a name="TOC-集成-MyBatis"></a>集成 MyBatis

1. MyBatis

```
<dependency>
  <groupId>org.mybatis</groupId>
  <artifactId>mybatis</artifactId>
  <version>3.4.1</version>
</dependency>
```

2. MyBatis 与 Spring 整合

```
<dependency>
  <groupId>org.mybatis</groupId>
  <artifactId>mybatis-spring</artifactId>
  <version>1.3.1</version>
</dependency>
```

3. MySQL 驱动

```
<dependency>
  <groupId>mysql</groupId>
  <artifactId>mysql-connector-java</artifactId>
  <version>5.1.38</version>
</dependency>
```
  
#### <a name="TOC-Web-相关"></a>Web 相关

1. 支持 Servlet

```
<dependency>
  <groupId>javax.servlet</groupId>
  <artifactId>servlet-api</artifactId>
  <version>2.5</version>
  <scope>provided</scope>
</dependency>
```

2. 支持 JSP

```
<dependency>
  <groupId>javax.servlet.jsp</groupId>
  <artifactId>jsp-api</artifactId>
  <version>2.1</version>
  <scope>provided</scope>
</dependency>
```

3. 支持 JSTL

```
<dependency>
  <groupId>javax.servlet</groupId>
  <artifactId>jstl</artifactId>
  <version>1.2</version>
</dependency>
```

4. JSON

```
<dependency>
  <groupId>com.fasterxml.jackson.core</groupId>
  <artifactId>jackson-databind</artifactId>
  <version>2.10.2</version>
</dependency>
```

#### <a name="TOC-日志"></a>日志

1. Log4j

```
<dependency>
  <groupId>log4j</groupId>
  <artifactId>log4j</artifactId>
  <version>1.2.17</version>
</dependency>
```

### <a name="TOC-构建文件目录"></a>构建文件目录

1. 新建目录
    
    * java
        * src/main/java/org/example/controller
        * src/main/java/org/example/mapper
        * src/main/java/org/example/model
        * src/main/java/org/example/service
        * src/main/java/org/example/service/impl
    * resources
        * src/main/resources/org/example/mapper
    * webapp
        * src/webapp/static
        * src/web/WEB-INF/jsp
    
2. 新建配置文件

    * Spring 配置文件：applicationContext.xml
    * Spring MVC 配置文件：springmvc-config.xml
    * MyBatis 配置文件：mybatis-config.xml
    * Log4j 配置文件：log4j.properties
    
3. 添加 jQuery 和 Bootstrap

    * src/webapp/static/jquery-x.y.z.min.js
    * src/webapp/static/bootstrap-x.y.z-dist

### <a name="TOC-编写配置文件"></a>编写配置文件

#### <a name="TOC-applicationContext.xml"></a>applicationContext.xml

1. 扫描 Service 的实现类

```
<context:component-scan base-package="org.example.service.impl"/>
```

2. 连接数据库

```
<bean id="dataSource" class="org.apache.ibatis.datasource.pooled.PooledDataSource">
  <property name="driver" value="com.mysql.jdbc.Driver"/>
  <property name="url" value="jdbc:mysql://localhost:3306/XXX?characterEncoding=utf-8"/>
  <property name="username" value="YYY"/>
  <property name="password" value="ZZZ"/>
</bean>
```

3. 配置 MyBatis SqlSessionFactory

```
<bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
  <property name="configLocation" value="classpath:mybatis-config.xml"/>
  <property name="dataSource" ref="dataSource"/>
  <property name="mapperLocations" value="classpath:org/example/mapper/*xml" />
  <property name="typeAliasesPackage" value="org.example.model"/>
</bean>
```

4. 配置 MapperScannerConfigurer

```
<bean class="org.mybatis.spring.mapper.MapperScannerConfigurer">
  <property name="addToConfig" value="true"/>
  <property name="basePackage" value="org.example.mapper"/>
</bean>
```

5. 开启基于注解的事务

```
<aop:aspectj-autoproxy/>
<aop:config>
  <aop:pointcut id="appService" expression="execution(* org.example.service..*Service*.*(..))"/>
  <aop:advisor advice-ref="txAdvice" pointcut-ref="appService"/>
</aop:config>
```

6. 配置事物增强

```
<tx:advice id="txAdvice" transaction-manager="transactionManager">
  <tx:attributes>
    <tx:method name="select*" read-only="true"/>
    <tx:method name="find*" read-only="true"/>
    <tx:method name="get*" read-only="true"/>
    <tx:method name="*"/>
  </tx:attributes>
</tx:advice>
```

7. 配置事物管理器

```
<bean id="transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
  <property name="dataSource" ref="dataSource"/>
</bean>
```

#### <a name="TOC-springmvc-config.xml"></a>springmvc-config.xml

1. 启用 Controller 注解支持

```
<mvc:annotation-driven />
```

2. 配置静态资源映射规则

```
<mvc:resources mapping="/static/**" location="static/"/>
```

3. 扫描 controller 包下的类

```
<context:component-scan base-package="org.example.controller"/>
```

4. 配置视图解析器

```
<bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
  <property name="viewClass" value="org.springframework.web.servlet.view.JstlView"/>
  <property name="prefix" value="/WEB-INF/jsp/"/>
  <property name="suffix" value=".jsp"/>
</bean>
```

#### <a name="TOC-mybatis-config.xml"></a>mybatis-config.xml

```
<settings>
  <setting name="logImpl" value="LOG4J"/>
  <setting name="cacheEnabled" value="true"/>
  <setting name="mapUnderscoreToCamelCase" value="true"/>
  <setting name="aggressiveLazyLoading" value="false"/>
</settings>
```

#### <a name="TOC-web.xml"></a>web.xml

1. 启用 Spring

```
<context-param>
  <param-name>contextConfigLocation</param-name>
  <param-value>classpath:applicationContext.xml</param-value>
</context-param>

<listener>
  <listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
</listener>
```

2. 使用 Spring MVC 的 Dispatcher Servlet 前端控制器，拦截所有请求

```
<servlet>
  <servlet-name>springmvc</servlet-name>
  <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
  <init-param>
    <param-name>contextConfigLocation</param-name>
    <param-value>classpath:springmvc-config.xml</param-value>
  </init-param>
  <load-on-startup>1</load-on-startup>
</servlet>

<servlet-mapping>
  <servlet-name>springmvc</servlet-name>
  <url-pattern>/</url-pattern>
</servlet-mapping>
```

3. 字符编码过滤器，解决 Spring MVC 中文乱码

```
<filter>
  <filter-name>SpringEncodingFilter</filter-name>
  <filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>
  <init-param>
    <param-name>encoding</param-name>
    <param-value>UTF-8</param-value>
  </init-param>
  <init-param>
    <param-name>forceEncoding</param-name>
    <param-value>true</param-value>
  </init-param>
</filter>

<filter-mapping>
  <filter-name>SpringEncodingFilter</filter-name>
  <url-pattern>/*</url-pattern>
</filter-mapping>
```

#### <a name="TOC-log4j.properties"></a>log4j.properties

```
log4j.rootLogger=DEBUG, stdout

log4j.logger.org.example=DEBUG

log4j.logger.org.example.mapper=TRACE

### Console output...
log4j.appender.stdout=org.apache.log4j.ConsoleAppender
log4j.appender.stdout.layout=org.apache.log4j.PatternLayout
log4j.appender.stdout.layout.ConversionPattern=%5p [%t] - %m%n
```

## <a name="TOC-发起-Issue"></a>发起 Issue

## <a name="TOC-展望"></a>展望
