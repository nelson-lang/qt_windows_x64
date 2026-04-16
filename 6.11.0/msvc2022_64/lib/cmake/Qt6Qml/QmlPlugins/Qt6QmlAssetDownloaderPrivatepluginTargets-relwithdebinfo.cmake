#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Qt6::QmlAssetDownloaderPrivateplugin" for configuration "RelWithDebInfo"
set_property(TARGET Qt6::QmlAssetDownloaderPrivateplugin APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(Qt6::QmlAssetDownloaderPrivateplugin PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELWITHDEBINFO "CXX"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/qml/Qt/labs/assetdownloader/qmlassetdownloaderprivateplugin.lib"
  )

list(APPEND _cmake_import_check_targets Qt6::QmlAssetDownloaderPrivateplugin )
list(APPEND _cmake_import_check_files_for_Qt6::QmlAssetDownloaderPrivateplugin "${_IMPORT_PREFIX}/qml/Qt/labs/assetdownloader/qmlassetdownloaderprivateplugin.lib" )

# Import target "Qt6::QmlAssetDownloaderPrivateplugin_init" for configuration "RelWithDebInfo"
set_property(TARGET Qt6::QmlAssetDownloaderPrivateplugin_init APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(Qt6::QmlAssetDownloaderPrivateplugin_init PROPERTIES
  IMPORTED_COMMON_LANGUAGE_RUNTIME_RELWITHDEBINFO ""
  IMPORTED_OBJECTS_RELWITHDEBINFO "${_IMPORT_PREFIX}/qml/Qt/labs/assetdownloader/objects-RelWithDebInfo/QmlAssetDownloaderPrivateplugin_init/QmlAssetDownloaderPrivateplugin_init.cpp.obj"
  )

list(APPEND _cmake_import_check_targets Qt6::QmlAssetDownloaderPrivateplugin_init )
list(APPEND _cmake_import_check_files_for_Qt6::QmlAssetDownloaderPrivateplugin_init "${_IMPORT_PREFIX}/qml/Qt/labs/assetdownloader/objects-RelWithDebInfo/QmlAssetDownloaderPrivateplugin_init/QmlAssetDownloaderPrivateplugin_init.cpp.obj" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
