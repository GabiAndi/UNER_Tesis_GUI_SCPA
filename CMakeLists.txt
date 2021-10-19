cmake_minimum_required(VERSION 3.5)

project(GUI_SCPA VERSION 0.0.1 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 COMPONENTS Gui REQUIRED)
find_package(Qt6 COMPONENTS Quick REQUIRED)
find_package(Qt6 COMPONENTS Network REQUIRED)

set(PROJECT_SOURCES
    main.cpp
    hmimanager.cpp
    hmimanager.h
    src.qrc
)

qt_add_executable(${PROJECT_NAME}
    ${PROJECT_SOURCES}
)

target_link_libraries(${PROJECT_NAME} PRIVATE Qt6::Gui)
target_link_libraries(${PROJECT_NAME} PRIVATE Qt6::Quick)
target_link_libraries(${PROJECT_NAME} PRIVATE Qt6::Network)

qt_import_qml_plugins(${PROJECT_NAME})
