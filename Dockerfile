FROM maven:3.9-eclipse-temurin-17 AS builder

ARG COMMIT=v0.16

RUN git clone https://github.com/JervenBolleman/void-generator.git
WORKDIR void-generator
RUN git checkout ${COMMIT}

RUN mvn package


FROM openjdk:25-ea-17-jdk

COPY --from=builder /void-generator/target/*.jar ./
COPY --from=builder /void-generator/target/void-generator-*uber.jar void-generator.jar

CMD ["java", "-jar", "void-generator.jar"]
