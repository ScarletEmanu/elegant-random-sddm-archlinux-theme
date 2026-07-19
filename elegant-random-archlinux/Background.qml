import QtQuick 2.15
import Qt.labs.folderlistmodel 2.10

FocusScope {
    id: sceneBackground

    property var sceneBackgroundType
    property alias sceneBackgroundImage: sceneImageBackground.source

    FolderListModel {
        id: folderModel
        nameFilters: ["*.jpg", "*.jpeg", "*.png", "*.bmp", "*.gif"]
        folder: Qt.resolvedUrl("images")
        sortField: FolderListModel.Unsorted

        onCountChanged: {
            if (count > 0) {
                var i = Math.floor(Math.random() * count)
                sceneRandomBackground.source = folderModel.get(i, "filePath")
            }
        }
    }

    Image {
        id: sceneImageBackground
        anchors.fill: parent
        sourceSize.width: parent.width
        sourceSize.height: parent.height
        fillMode: Image.PreserveAspectCrop
        visible: parent.sceneBackgroundType === "image"
        smooth: true;
    }

    Image {
        id: sceneRandomBackground
        anchors.fill: parent
        sourceSize.width: parent.width
        sourceSize.height: parent.height
        fillMode: Image.PreserveAspectCrop
        smooth: true;
        visible: parent.sceneBackgroundType === "random" && source !== ""
        asynchronous: true
    }
}
