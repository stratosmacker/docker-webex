#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <unistd.h>
#include <QFile>
#include <QProcess>
#include <QDebug>
#include <QList>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_pushButton_clicked()
{

    QFile xauth_file("/tmp/.docker.xauth");
    xauth_file.open(QIODevice::WriteOnly|QIODevice::Truncate);


    QProcess xauth, *docker;
    xauth.start("bash -c '/usr/bin/xauth nlist :0 | sed -e 's/^..../ffff/' | xauth -f " + xauth_file.fileName() + " nmerge -'");
    docker = new QProcess(this);

    qDebug() << docker->exitCode();
    execlp("/usr/bin/docker", "docker", "run", "-it", "--volume=/tmp/.X11-unix:/tmp/.X11-unix:rw", "--volume=/tmp/.docker.xauth:/tmp/.docker.xauth:rw", "--env=XAUTHORITY=/tmp/.docker.xauth", "--env=DISPLAY=:0", "--user=webex", "webex", NULL);

    docker->waitForFinished();
    QString output(docker->readAll());
    qDebug() << "test "<< output;

}
