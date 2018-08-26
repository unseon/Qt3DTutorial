#include "beziercurvebuffer.h"

#include <QtGui/qvector3d.h>

BezierCurveBuffer::BezierCurveBuffer(Qt3DCore::QNode *parent)
    : Qt3DRender::QBuffer(Qt3DRender::QBuffer::VertexBuffer, parent)
{
    QByteArray ba;
    ba.resize(3 * sizeof(QVector3D));
    QVector3D *posData = reinterpret_cast<QVector3D *>(ba.data());
    posData[0] = QVector3D(0.0f, 1.0f, 0.0f);
    posData[2] = QVector3D(1.0f, 0.0f, 0.0f);
    posData[1] = QVector3D(-1.0f, 0.0f, 0.0f);

    // Put the data into the buffer
    setData(ba);
}
