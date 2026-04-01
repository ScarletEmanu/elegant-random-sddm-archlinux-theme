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
        smooth: true;
    }

    Image {
        id: sceneRandomBackground
        anchors.fill: parent
        sourceSize.width: parent.width
        sourceSize.height: parent.height
        fillMode: Image.PreserveAspectCrop
        smooth: true;
        visible: source !== ""
        asynchronous: true
    }

    states: [
        State {
            name: "imageBackground"
            when: sceneBackgroundType === "image"
            PropertyChanges {
                target: sceneImageBackground
                visible: true
            }
            PropertyChanges {
                target: sceneRandomBackground
                visible: false
            }
        },
        State {
            name: "randomBackground"
            when: sceneBackgroundType === "random"
            PropertyChanges {
                target: sceneImageBackground
                visible: false
            }
            PropertyChanges {
                target: sceneRandomBackground
                visible: true
            }
	    }
    ]
}
