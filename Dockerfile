# 高考志愿智能填报推荐系统 Dockerfile
# 用于开发环境构建

FROM maven:3.8-openjdk-11 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src

# 强制设置Java 11编译版本（覆盖pom.xml中的旧配置）
RUN mvn clean package -DskipTests \
    -Dmaven.compiler.source=11 \
    -Dmaven.compiler.target=11 \
    -Dproject.build.sourceEncoding=UTF-8

FROM tomcat:9-jdk11
# 删除默认应用
RUN rm -rf /usr/local/tomcat/webapps/*
# 复制构建产物
COPY --from=builder /app/target/demo2.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
