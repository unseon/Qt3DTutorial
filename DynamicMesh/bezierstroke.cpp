#include "bezierstroke.h"
#include <QSize>

BezierStroke::BezierStroke(Qt3DCore::QNode *parent)
    : Qt3DRender::QGeometryRenderer(parent),
      m_p0(0.0f, 0.0f, 0.0f),
      m_p1(0.0f, 0.5f, 0.0f),
      m_p2(0.5f, 0.5f, 0.0f),
      m_p3(0.5f, 1.0f, 0.0f),
      m_resolutionX(21),
      m_resolutionZ(21),
      m_width(0.5f),
      m_geometry(nullptr),
      m_vertexArray(nullptr)
{
    updateComponents();
}

QVector3D BezierStroke::p0() const
{
    return m_p0;
}

void BezierStroke::setP0(const QVector3D &p)
{
    if (m_p0 == p)
        return;

    m_p0 = p;
    updateVertexPositions();
    emit p0Changed();
}

QVector3D BezierStroke::p1() const
{
    return m_p1;
}

void BezierStroke::setP1(const QVector3D &p)
{
    if (m_p1 == p)
        return;

    m_p1 = p;
    updateVertexPositions();
    emit p1Changed();
}

QVector3D BezierStroke::p2() const
{
    return m_p2;
}

void BezierStroke::setP2(const QVector3D &p)
{
    if (m_p2 == p)
        return;

    m_p2 = p;
    updateVertexPositions();
    emit p2Changed();
}

QVector3D BezierStroke::p3() const
{
    return m_p3;
}

void BezierStroke::setP3(const QVector3D &p)
{
    if (m_p3 == p)
        return;

    m_p3 = p;
    updateVertexPositions();
    emit p3Changed();
}

qreal BezierStroke::width() const
{
    return m_width;
}

void BezierStroke::setWidth(const qreal &width)
{
    m_width = width;
}

void BezierStroke::updateComponents()
{
    if (m_geometry != nullptr) {
        delete m_geometry;
        delete m_vertexBuffer;
        delete m_vertexAttribute;
        delete m_indexBuffer;
        delete[] m_vertexArray;
    }

    int vertCount = m_resolutionX * m_resolutionZ;


    m_geometry = new Qt3DRender::QGeometry();
    m_vertexBuffer = new Qt3DRender::QBuffer();
    m_vertexArray = new float[vertCount * 3];
    m_vertexByteArray.setRawData(reinterpret_cast<char *>(m_vertexArray), vertCount * 3 * sizeof(float));
    //m_vertexBuffer->data().setRawData(reinterpret_cast<char *>(m_vertexArray), vertCount * 3 * sizeof(float));
    m_vertexBuffer->setData(m_vertexByteArray);

    updateVertexPositions();

    m_vertexAttribute = new Qt3DRender::QAttribute();
    m_vertexAttribute->setAttributeType(Qt3DRender::QAttribute::VertexAttribute);
    m_vertexAttribute->setVertexBaseType(Qt3DRender::QAttribute::Float);
    m_vertexAttribute->setVertexSize(3);
    m_vertexAttribute->setCount(vertCount);
    m_vertexAttribute->setName(Qt3DRender::QAttribute::defaultPositionAttributeName());
    m_vertexAttribute->setBuffer(m_vertexBuffer);

    m_geometry->addAttribute(m_vertexAttribute);


    //uv
    m_uvBuffer = new Qt3DRender::QBuffer();

    QByteArray uvs;
    uvs.resize(vertCount * 2 * sizeof(float));

    float *uvData = reinterpret_cast<float *>(uvs.data());

    if (m_resolutionX > 0 && m_resolutionZ > 1) {
        for (int ix = 0; ix < m_resolutionX; ix++) {
            int offsetIdx = ix * m_resolutionZ * 2;
            float u = float(ix) / (m_resolutionX - 1);
            for (int iz = 0; iz < m_resolutionZ; iz++) {
                float v = float(iz) / (m_resolutionZ - 1);
                uvData[offsetIdx + iz * 2] = u;
                uvData[offsetIdx + iz * 2 + 1] = v;
            }
        }
    }
    m_uvBuffer->setData(uvs);

    m_uvAttribute = new Qt3DRender::QAttribute();
    m_uvAttribute->setAttributeType(Qt3DRender::QAttribute::VertexAttribute);
    m_uvAttribute->setVertexBaseType(Qt3DRender::QAttribute::Float);
    m_uvAttribute->setVertexSize(2);
    m_uvAttribute->setCount(vertCount);
    m_uvAttribute->setName(Qt3DRender::QAttribute::defaultTextureCoordinateAttributeName());
    m_uvAttribute->setBuffer(m_uvBuffer);

    m_geometry->addAttribute(m_uvAttribute);

    setPrimitiveType(Qt3DRender::QGeometryRenderer::PrimitiveType::Lines);
    //setPrimitiveType(Qt3DRender::QGeometryRenderer::PrimitiveType::Points);

    if (this->primitiveType() == QGeometryRenderer::PrimitiveType::Points) {
        // index
        QByteArray indices;
        indices.resize(m_resolutionX * m_resolutionZ * sizeof(unsigned int));
        unsigned int *idxData = reinterpret_cast<unsigned int *>(indices.data());

        for (int ix = 0; ix < m_resolutionX; ix++) {
            for (int iz = 0; iz < m_resolutionZ; iz++) {
                *idxData++ = ix * m_resolutionZ + iz;
            }
        }

        m_indexBuffer = new Qt3DRender::QBuffer();
        m_indexBuffer->setData(indices);

        m_indexAttribute = new Qt3DRender::QAttribute();
        m_indexAttribute->setAttributeType(Qt3DRender::QAttribute::IndexAttribute);
        m_indexAttribute->setVertexBaseType(Qt3DRender::QAttribute::UnsignedInt);
        m_indexAttribute->setCount(m_resolutionX * m_resolutionZ);
        m_indexAttribute->setBuffer(m_indexBuffer);

        m_geometry->addAttribute(m_indexAttribute);

    } else if (this->primitiveType() == QGeometryRenderer::PrimitiveType::Triangles) {

    } else if (this->primitiveType() == QGeometryRenderer::PrimitiveType::Lines) {
        // index
        QByteArray indices;
        int indexSize = (m_resolutionX * (m_resolutionZ - 1) + (m_resolutionX - 1) * m_resolutionZ) * 2;
        indices.resize(indexSize * sizeof(unsigned int));
        unsigned int *idxData = reinterpret_cast<unsigned int *>(indices.data());

        for (int ix = 0; ix < m_resolutionX; ix++) {
            for (int iz = 0; iz < m_resolutionZ - 1; iz++) {
                *idxData++ = ix * m_resolutionZ + iz;
                *idxData++ = ix * m_resolutionZ + iz + 1;
            }
        }

        for (int iz = 0; iz < m_resolutionZ; iz++) {
            for (int ix = 0; ix < m_resolutionX - 1; ix++) {
                *idxData++ = ix * m_resolutionZ + iz;
                *idxData++ = (ix + 1) * m_resolutionZ + iz;
            }
        }

        m_indexBuffer = new Qt3DRender::QBuffer();
        m_indexBuffer->setData(indices);

        m_indexAttribute = new Qt3DRender::QAttribute();
        m_indexAttribute->setAttributeType(Qt3DRender::QAttribute::IndexAttribute);
        m_indexAttribute->setVertexBaseType(Qt3DRender::QAttribute::UnsignedInt);
        m_indexAttribute->setCount(indexSize);
        m_indexAttribute->setBuffer(m_indexBuffer);

        m_geometry->addAttribute(m_indexAttribute);
    }

    setGeometry(m_geometry);
}

void BezierStroke::updateVertexPositions()
{
    qDebug() << "updateVertexPositions()";

    int vertCount = m_resolutionX * m_resolutionZ;

    if (m_resolutionX > 0 && m_resolutionZ > 1) {
        for (int ix = 0; ix < m_resolutionX; ix++) {
            int offsetIdx = ix * m_resolutionZ * 3;
            float offsetX = - m_width / 2 + m_width * ix / (m_resolutionX - 1);

            for (int iz = 0; iz < m_resolutionZ; iz++) {
                float t = float(iz) / (m_resolutionZ - 1);
                QVector3D vec = calcCubicOffset(t, offsetX, m_p0, m_p1, m_p2, m_p3);
                m_vertexArray[offsetIdx + iz * 3] = vec.x();
                m_vertexArray[offsetIdx + iz * 3 + 1] = vec.y();
                m_vertexArray[offsetIdx + iz * 3 + 2] = vec.z();
            }
        }
    }

    //m_vertexBuffer->data().setRawData(reinterpret_cast<char *>(m_vertexArray), vertCount * 3 * sizeof(float));

    //m_vertexByteArray = QByteArray::fromRawData(reinterpret_cast<char *>(m_vertexArray), vertCount * 3 * sizeof(float));
    m_vertexByteArray = QByteArray(reinterpret_cast<char *>(m_vertexArray), vertCount * 3 * sizeof(float));
    m_vertexBuffer->setData(m_vertexByteArray);

}

QVector3D BezierStroke::calcCubicPosition(float t, QVector3D p0, QVector3D p1, QVector3D p2, QVector3D p3)
{
    return (1-t) * (1-t) * (1-t) * p0
            + 3 * t * (1-t) * (1-t) * p1
            + 3 * t * t * (1-t) * p2
            + t * t * t *p3;
}

QVector3D BezierStroke::calcCubicTangent(float t, QVector3D p0, QVector3D p1, QVector3D p2, QVector3D p3)
{
    return - 3 * (1-t) * (1-t) * p0
            + 3 * (1-t) * (1-t) * p1 - 6 * t * (1-t) * p1
            - 3 * t * t * p2 + 6 * t * (1-t) * p2
            + 3 * t * t * p3;
}

QVector3D BezierStroke::calcCubicOffset(float t, float offset, QVector3D p0, QVector3D p1, QVector3D p2, QVector3D p3)
{
    QVector3D pos = calcCubicPosition(t, p0, p1, p2, p3);
    QVector3D tan = calcCubicTangent(t, p0, p1, p2, p3).normalized();
    QVector3D cross = QVector3D::crossProduct(tan, QVector3D(0.0f, 1.0f, 0.0f));

    return offset * cross + pos;
}

unsigned int BezierStroke::resolutionX() const
{
    return m_resolutionX;
}

void BezierStroke::setResolutionX(unsigned int resolutionX)
{
    m_resolutionX = resolutionX;
}

unsigned int BezierStroke::resolutionZ() const
{
    return m_resolutionZ;
}

void BezierStroke::setResolutionZ(unsigned int resolutionZ)
{
    m_resolutionZ = resolutionZ;
}
