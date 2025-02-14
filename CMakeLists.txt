cmake_minimum_required (VERSION 3.0)
project (phntm_16 C)
set (CMAKE_C_STANDARD 99)

include (FetchContent)
set (FETCHCONTENT_QUIET FALSE)
set (BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)
set (BUILD_GAMES    OFF CACHE BOOL "" FORCE)

set (PROJECT_OUT_DIR "build")
set (PROJECT_OUT_FILE "phantom")
set (PROJECT_OUT "${PROJECT_OUT_DIR}/${PROJECT_OUT_FILE}")

FetchContent_Declare (
    raylib
    GIT_REPOSITORY "https://github.com/raysan5/raylib.git"
    GIT_TAG "master"
    GIT_PROGRESS TRUE
)

FetchContent_Declare (
    lua
    GIT_REPOSITORY "https://github.com/marovira/lua"
    GIT_TAG "master"
    GIT_PROGRESS TRUE
)

FetchContent_MakeAvailable (raylib)
FetchContent_MakeAvailable (lua)

find_package (lua REQUIRED)

file (GLOB_RECURSE PROJECT_SOURCES CONFIGURE_DEPENDS "${CMAKE_CURRENT_LIST_DIR}/source/*.c")
set  (PROJECT_INCLUDE "${CMAKE_CURRENT_LIST_DIR}/source/")

add_executable             (${PROJECT_NAME})
set_target_properties      (${PROJECT_NAME} PROPERTIES OUTPUT_NAME ${PROJECT_OUT})
target_sources             (${PROJECT_NAME} PRIVATE ${PROJECT_SOURCES})
target_include_directories (${PROJECT_NAME} PRIVATE ${PROJECT_INCLUDE})
target_link_libraries      (${PROJECT_NAME} PRIVATE raylib PRIVATE lua::lua)