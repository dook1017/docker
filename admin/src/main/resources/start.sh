#!/bin/sh

JAR_NAME=banking-loan-admin-1.0-SNAPSHOT.jar
JVM="-server -Xms512m -Xmx512m -XX:PermSize=64M -XX:MaxNewSize=128m -XX:MaxPermSize=128m -Djava.awt.headless=true -XX:+CMSClassUnloadingEnabled -XX:+CMSPermGenSweepingEnabled"
APP_DIR=`pwd`

export SPRING_PROFILES_ACTIVE=$2
echo \$SPRING_PROFILES_ACTIVE=$SPRING_PROFILES_ACTIVE
echo \$APP_DIR=$APP_DIR


#使用说明,用来提示输入参数
usage() {
    echo "用法: sh 执行脚本.sh [start|stop|restart|status] SPRING_PROFILES_ACTIVE"
    echo "例如: sh start.sh start dev"
    exit 1
}

if [ -z "$2" ]; then
    echo "ERROR:SPRING_PROFILES_ACTIVE is not set ，please pass parameter \$2 !"
    exit 1
fi

start(){
    PID=`ps -ef|grep $JAR_NAME|grep -v grep|awk '{print $2}'`
    if [ -n "$PID" ]; then
        echo "$JAR_NAME is running !pid is $PID"
    else
        cd $APP_DIR
        nohup java $JVM -jar $JAR_NAME --logging.config=config/log4j2-$SPRING_PROFILES_ACTIVE.properties --spring.profiles.active=$SPRING_PROFILES_ACTIVE >/dev/null &
        if [ $? -eq 0 ]; then
            echo "$JAR_NAME is started success !"
        else
            echo "$JAR_NAME is started failed !"
        fi
    fi
}

stop(){
   PID=`ps -ef|grep $JAR_NAME|grep -v grep|awk '{print $2}'`
   kill -9 $PID
   echo "$JAR_NAME is stopped !"
}

case "$1" in
    start)
        start
    ;;
    stop)
        stop
    ;;
    restart)
        stop
        start
    ;;
*)
usage
;;
esac
exit $?
