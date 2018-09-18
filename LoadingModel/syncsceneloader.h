#ifndef SYNCSCENELOADER_H
#define SYNCSCENELOADER_H

#include <Qt3DCore/qcomponent.h>
#include <QUrl>

class SyncSceneLoader : public Qt3DCore::QComponent
{
    Q_OBJECT
    Q_PROPERTY(QUrl source READ source WRITE setSource NOTIFY sourceChanged)

public:
    explicit SyncSceneLoader(Qt3DCore::QNode *parent = nullptr);
    ~SyncSceneLoader();

    QUrl source() const;
    void setSource(const QUrl &source);

signals:
    void sourceChanged();

private:
    QUrl m_source;
};

#endif // SYNCSCENELOADER_H
