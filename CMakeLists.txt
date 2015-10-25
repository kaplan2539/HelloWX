CMAKE_MINIMUM_REQUIRED(VERSION 2.6.2)
 
PROJECT("Hello WX")

MESSAGE( "CMAKE_SOURCE_DIR=${CMAKE_SOURCE_DIR}" )
MESSAGE( "CMAKE_ROOT=${CMAKE_ROOT}" )
 
FIND_PACKAGE(wxWidgets COMPONENTS core base REQUIRED)
 
INCLUDE( "${wxWidgets_USE_FILE}" )
 
SET(SRCS main.cpp)
SET( MAIN_EXECUTABLE hello )
 
ADD_EXECUTABLE("${MAIN_EXECUTABLE}" ${SRCS})
TARGET_LINK_LIBRARIES(${MAIN_EXECUTABLE} ${wxWidgets_LIBRARIES})
INSTALL(TARGETS ${MAIN_EXECUTABLE} DESTINATION bin)

SET (ICON_FILE "${CMAKE_SOURCE_DIR}/icon.png")

IF(APPLE)

  SET( CPACK_BUNDLE_PLIST           "${CMAKE_CURRENT_BINARY_DIR}/Info.plist" )
  SET( CPACK_BUNDLE_NAME            "${PROJECT_NAME}" )
  SET( CPACK_BUNDLE_ICON            "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.icns" )
  SET( CPACK_BUNDLE_STARTUP_COMMAND "${CMAKE_CURRENT_BINARY_DIR}/mac_run.sh" )
  SET( CPACK_GENERATOR              "Bundle" )
	
  SET( MACOSX_BUNDLE_EXECUTABLE_NAME      "${CMAPE_BUNDLE_NAME}" )  #CFBundleExecutable         
  SET( MACOSX_BUNDLE_INFO_STRING          "" )  #CFBundleGetInfoString      
  SET( MACOSX_BUNDLE_ICON_FILE            "${CPACK_BUNDLE_NAME}" ) #CFBundleIconFile
  SET( MACOSX_BUNDLE_GUI_IDENTIFIER       "" )  #CFBundleIdentifier         
  SET( MACOSX_BUNDLE_LONG_VERSION_STRING  "" ) 	#CFBundleLongVersionString  
  SET( MACOSX_BUNDLE_BUNDLE_NAME          "${CPACK_BUNDLE_NAME}" )  #CFBundleName               
  SET( MACOSX_BUNDLE_SHORT_VERSION_STRING "" )	#CFBundleShortVersionString 
  SET( MACOSX_BUNDLE_BUNDLE_VERSION       "" )  #CFBundleVersion            
  SET( MACOSX_BUNDLE_COPYRIGHT            "" )  #NSHumanReadableCopyright   

  CONFIGURE_FILE( "${CMAKE_SOURCE_DIR}/mac/mac_run.sh.in" 
                  "${CMAKE_CURRENT_BINARY_DIR}/mac_run.sh" @ONLY )

  CONFIGURE_FILE( "${CMAKE_ROOT}/Modules/MacOSXBundleInfo.plist.in" 
                  "${CMAKE_CURRENT_BINARY_DIR}/Info.plist" )

  ADD_CUSTOM_COMMAND( TARGET ${MAIN_EXECUTABLE} 
                      COMMAND ${CMAKE_SOURCE_DIR}/mac/mac_create_icns.sh "${ICON_FILE}" "${CPACK_BUNDLE_ICON}"
                      DEPENDS "${ICON_FILE}"
                    )

ENDIF()

SET( CPACK_PACKAGE_FILE_NAME "${PROJECT_NAME}" )

INCLUDE( CPack )
