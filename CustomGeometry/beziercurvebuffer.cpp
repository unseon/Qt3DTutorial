#include "beziercurvebuffer.h"

#include <QtGui/qvector3d.h>

BezierCurveBuffer::BezierCurveBuffer(Qt3DCore::QNode *parent)
    : Qt3DRender::QBuffer(Qt3DRender::QBuffer::VertexBuffer, parent)
{
    QByteArray ba;
    ba.resize(60 * sizeof(QVector3D));
    QVector3D *posData = reinterpret_cast<QVector3D *>(ba.data());

    QVector3D p1(0.0f, 0.0f, 0.0f);
    QVector3D p2(0.0f, 0.5f, 0.0f);
    QVector3D p3(0.5f, 0.5f, 0.0f);
    QVector3D p4(0.5f, 1.0f, 0.0f);


    for (int i = 0; i < 40; i++) {
        float t = (float) i / 20.0f ;
        posData[i] = calcCubicPosition(t, p1, p2, p3, p4);
    }

    for (int i = 20; i < 40; i++) {
        float t = (float) (i - 20) / 20.0f ;
        posData[i] = calcCubicOffset(t, 0.2f, p1, p2, p3, p4);
    }

    for (int i = 40; i < 60; i++) {
        float t = (float) (i - 40) / 20.0f ;
        posData[i] = calcCubicOffset(t, -0.2f, p1, p2, p3, p4);
    }

//    posData[0] = QVector3D(0.0f, 1.0f, 0.0f);
//    posData[2] = QVector3D(1.0f, 0.0f, 0.0f);
//    posData[1] = QVector3D(-1.0f, 0.0f, 0.0f);

    // Put the data into the buffer
    setData(ba);
}

QVector3D BezierCurveBuffer::calcCubicPosition(float t, QVector3D p1, QVector3D p2, QVector3D p3, QVector3D p4)
{
    return (1-t) * (1-t) * (1-t) * p1
            + 3 * t * (1-t) * (1-t) * p2
            + 3 * t * t * (1-t) * p3
            + t * t * t *p4;
}

QVector3D BezierCurveBuffer::calcCubicTangent(float t, QVector3D p1, QVector3D p2, QVector3D p3, QVector3D p4)
{
    return - 3 * (1-t) * (1-t) * p1
            + 3 * (1-t) * (1-t) * p2 - 6 * t * (1-t) * p2
            - 3 * t * t * p3 + 6 * t * (1-t) * p3
            + 3 * t * t * p4;
}

QVector3D BezierCurveBuffer::calcCubicOffset(float t, float offset, QVector3D p1, QVector3D p2, QVector3D p3, QVector3D p4)
{
    QVector3D pos = calcCubicPosition(t, p1, p2, p3, p4);
    QVector3D tan = calcCubicTangent(t, p1, p2, p3, p4).normalized();
    QVector3D cross = QVector3D::crossProduct(tan, QVector3D(0.0f, 0.0f, 1.0f));

    return offset * cross + pos;
}
