#ifndef BEZIERSTROKE_H
#define BEZIERSTROKE_H

#include <QGeometryRenderer>
#include <QGeometry>
#include <QBuffer>
#include <QAttribute>
#include <QVector3D>
#include <QSize>

class BezierStroke : public Qt3DRender::QGeometryRenderer
{
    Q_OBJECT

    Q_PROPERTY(QVector3D p0 READ p0 WRITE setP0 NOTIFY p0Changed)
    Q_PROPERTY(QVector3D p1 READ p1 WRITE setP1 NOTIFY p1Changed)
    Q_PROPERTY(QVector3D p2 READ p2 WRITE setP2 NOTIFY p2Changed)
    Q_PROPERTY(QVector3D p3 READ p3 WRITE setP3 NOTIFY p3Changed)
    Q_PROPERTY(qreal width READ width WRITE setWidth NOTIFY widthChanged)
    Q_PROPERTY(unsigned int resolutionX READ resolutionX WRITE setResolutionX NOTIFY resolutionXChanged)
    Q_PROPERTY(unsigned int resolutionZ READ resolutionZ WRITE setResolutionZ NOTIFY resolutionZChanged)

public:
    explicit BezierStroke(Qt3DCore::QNode *parent = nullptr);

    QVector3D p0() const;
    void setP0(const QVector3D &p);

    QVector3D p1() const;
    void setP1(const QVector3D &p);

    QVector3D p2() const;
    void setP2(const QVector3D &p);

    QVector3D p3() const;
    void setP3(const QVector3D &p);

    QSize resolution() const;
    void setResolution(const QSize &resolution);

    qreal width() const;
    void setWidth(const qreal &width);

    void updateComponents();
    void updateVertexPositions();

    QVector3D calcCubicPosition(float t, QVector3D p0, QVector3D p1, QVector3D p2, QVector3D p3);
    QVector3D calcCubicTangent(float t, QVector3D p0, QVector3D p1, QVector3D p2, QVector3D p3);
    QVector3D calcCubicOffset(float t, float offset, QVector3D p0, QVector3D p1, QVector3D p2, QVector3D p3);


    unsigned int resolutionX() const;
    void setResolutionX(unsigned int resolutionX);

    unsigned int resolutionZ() const;
    void setResolutionZ(unsigned int resolutionZ);

signals:
    void p0Changed();
    void p1Changed();
    void p2Changed();
    void p3Changed();
    void resolutionXChanged();
    void resolutionZChanged();
    void widthChanged();

public slots:

private:
    Qt3DRender::QGeometry *m_geometry;

    Qt3DRender::QAttribute *m_vertexAttribute;
    Qt3DRender::QBuffer *m_vertexBuffer;
    QByteArray m_vertexByteArray;
    float* m_vertexArray;

    Qt3DRender::QAttribute *m_uvAttribute;
    Qt3DRender::QBuffer *m_uvBuffer;

    Qt3DRender::QAttribute *m_indexAttribute;
    Qt3DRender::QBuffer *m_indexBuffer;

    QVector3D m_p0;
    QVector3D m_p1;
    QVector3D m_p2;
    QVector3D m_p3;

    unsigned int m_resolutionX;
    unsigned int m_resolutionZ;
    qreal m_width;


};


#endif // BEZIERSTROKE_H
