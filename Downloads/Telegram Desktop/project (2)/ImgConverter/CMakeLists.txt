cmake_minimum_required(VERSION 3.11)

project(Negate CXX)
set(CMAKE_CXX_STANDARD 17)

# добавляем новую переменную - путь к LibJPEG
set(LIBJPEG_DIR CACHE STRING "LibJPEG static library directory")
if(NOT LIBJPEG_DIR)
    message(FATAL_ERROR "Please, specify LibJPEG directory via -DLIBJPEG_DIR=<dir>")
endif()
message(STATUS "LibJPEG dir is ${LIBJPEG_DIR}, change via -DLIBJPEG_DIR=<dir>")

if (CMAKE_SYSTEM_NAME MATCHES "^MINGW")
    set(SYSTEM_LIBS -lstdc++)
else()
    set(SYSTEM_LIBS)
endif()

# Исправлен путь к ImgLib как относительный в ../ImgLib
add_subdirectory(../ImgLib ImgLibBuildDir)

add_executable(imgconv main.cpp)

target_include_directories(imgconv PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/../ImgLib")

# Линковка с LibJPEG
target_link_directories(imgconv PUBLIC
    "${LIBJPEG_DIR}/lib/$<IF:$<CONFIG:Debug>,Debug,Release>"
    )

target_link_libraries(imgconv ImgLib ${SYSTEM_LIBS})
