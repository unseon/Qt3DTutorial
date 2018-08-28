#ifndef BEZIERCURVEBUFFER_H
#define BEZIERCURVEBUFFER_H

#include <Qt3DRender/QBuffer>
#include <QtGui/qvector3d.h>

class BezierCurveBuffer : public Qt3DRender::QBuffer
{
    Q_OBJECT
public:
    explicit BezierCurveBuffer(Qt3DCore::QNode *parent = nullptr);

    QVector3D calcCubicPosition(float t, QVector3D p1, QVector3D p2, QVector3D p3, QVector3D p4);
    QVector3D calcCubicTangent(float t, QVector3D p1, QVector3D p2, QVector3D p3, QVector3D p4);
    QVector3D calcCubicOffset(float t, float offset, QVector3D p1, QVector3D p2, QVector3D p3, QVector3D p4);


signals:

public slots:
};

#endif // BEZIERCURVEBUFFER_H
