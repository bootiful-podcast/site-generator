#!/usr/bin/env bash

export APP_NAME=site-generator
export TASK_NAME=${APP_NAME}-task
#-b java_buildpack -u none --no-route
cf push --no-start -u process --no-route -p target/${APP_NAME}.jar ${APP_NAME}
cf set-env ${APP_NAME} GIT_PASSWORD $GIT_PASSWORD
cf set-env ${APP_NAME} GIT_USERNAME $GIT_USERNAME
cf set-env ${APP_NAME} GIT_URI $GIT_URI
cf restart ${APP_NAME}
echo "about to run the task..."
cf run-task ${APP-NAME} ".java-buildpack/open_jdk_jre/bin/java cp . org.springframework.boot.loader.JarLauncher" --name ${APP_NAME}