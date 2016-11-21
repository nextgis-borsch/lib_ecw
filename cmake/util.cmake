################################################################################
# Project:  external projects
# Purpose:  CMake build scripts
# Author:   Dmitry Baryshnikov, polimax@mail.ru
################################################################################
# Copyright (C) 2015, NextGIS <info@nextgis.com>
# Copyright (C) 2015 Dmitry Baryshnikov
#
# This script is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#
# This script is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this script.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

function(check_version major minor service build)

    # parse the version number from gdal_version.h and include in
    # major, minor and rev parameters

    file(READ ${CMAKE_BINARY_DIR}/lib/include/ECWJP2BuildNumber.h VERSION_H_CONTENTS)

    string(REGEX MATCH "NCS_ECWJP2_VER_MAJOR[ \t]+([0-9]+)"
      MAJOR_VERSION ${VERSION_H_CONTENTS})
    string (REGEX MATCH "([0-9]+)"
      MAJOR_VERSION ${MAJOR_VERSION})
    string(REGEX MATCH "NCS_ECWJP2_VER_MINOR[ \t]+([0-9]+)"
      MINOR_VERSION ${VERSION_H_CONTENTS})
    string (REGEX MATCH "([0-9]+)"
      MINOR_VERSION ${MINOR_VERSION})
    string(REGEX MATCH "NCS_ECWJP2_VER_SERVICE[ \t]+([0-9]+)"
      SRV_VERSION ${VERSION_H_CONTENTS})
    string (REGEX MATCH "([0-9]+)"
      SRV_VERSION ${SRV_VERSION})
    string(REGEX MATCH "NCS_ECWJP2_VER_SERVICE[ \t]+([0-9]+)"
      BLD_VERSION ${VERSION_H_CONTENTS})
    string (REGEX MATCH "([0-9]+)"
      BLD_VERSION ${BLD_VERSION})
      
    set(${major} ${MAJOR_VERSION} PARENT_SCOPE)
    set(${minor} ${MINOR_VERSION} PARENT_SCOPE)
    set(${service} ${SRV_VERSION} PARENT_SCOPE)
    set(${build} ${BLD_VERSION} PARENT_SCOPE)
    
endfunction(check_version)

function(report_version name ver)

    string(ASCII 27 Esc)
    set(BoldYellow  "${Esc}[1;33m")
    set(ColourReset "${Esc}[m")
        
    message(STATUS "${BoldYellow}${name} version ${ver}${ColourReset}")
    
endfunction()  


# macro to find packages on the host OS
macro( find_exthost_package )
    if(CMAKE_CROSSCOMPILING)
        set( CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER )
        set( CMAKE_FIND_ROOT_PATH_MODE_LIBRARY NEVER )
        set( CMAKE_FIND_ROOT_PATH_MODE_INCLUDE NEVER )
        if( CMAKE_HOST_WIN32 )
            SET( WIN32 1 )
            SET( UNIX )
        elseif( CMAKE_HOST_APPLE )
            SET( APPLE 1 )
            SET( UNIX )
        endif()
        find_package( ${ARGN} )
        SET( WIN32 )
        SET( APPLE )
        SET( UNIX 1 )
        set( CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY )
        set( CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY )
        set( CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY )
    else()
        find_package( ${ARGN} )
    endif()
endmacro()


# macro to find programs on the host OS
macro( find_exthost_program )
    if(CMAKE_CROSSCOMPILING)
        set( CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER )
        set( CMAKE_FIND_ROOT_PATH_MODE_LIBRARY NEVER )
        set( CMAKE_FIND_ROOT_PATH_MODE_INCLUDE NEVER )
        if( CMAKE_HOST_WIN32 )
            SET( WIN32 1 )
            SET( UNIX )
        elseif( CMAKE_HOST_APPLE )
            SET( APPLE 1 )
            SET( UNIX )
        endif()
        find_program( ${ARGN} )
        SET( WIN32 )
        SET( APPLE )
        SET( UNIX 1 )
        set( CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY )
        set( CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY )
        set( CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY )
    else()
        find_program( ${ARGN} )
    endif()
endmacro()


# macro to find path on the host OS
macro( find_exthost_path )
    if(CMAKE_CROSSCOMPILING)
        set( CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER )
        set( CMAKE_FIND_ROOT_PATH_MODE_LIBRARY NEVER )
        set( CMAKE_FIND_ROOT_PATH_MODE_INCLUDE NEVER )
        if( CMAKE_HOST_WIN32 )
            SET( WIN32 1 )
            SET( UNIX )
        elseif( CMAKE_HOST_APPLE )
            SET( APPLE 1 )
            SET( UNIX )
        endif()
        find_path( ${ARGN} )
        SET( WIN32 )
        SET( APPLE )
        SET( UNIX 1 )
        set( CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY )
        set( CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY )
        set( CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY )
    else()
        find_path( ${ARGN} )
    endif()
endmacro()
