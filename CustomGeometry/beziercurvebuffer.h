#ifndef BEZIERCURVEBUFFER_H
#define BEZIERCURVEBUFFER_H

#include <Qt3DRender/QBuffer>

class BezierCurveBuffer : public Qt3DRender::QBuffer
{
    Q_OBJECT
public:
    explicit BezierCurveBuffer(Qt3DCore::QNode *parent = nullptr);

signals:

public slots:
};

#endif // BEZIERCURVEBUFFER_H
