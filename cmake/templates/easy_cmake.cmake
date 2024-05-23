# This file was autogenerated by:
# {{scriptfile}}
# Use it in your CMake configuration by `include()`'ing it.
# You can also copy it in your sketch's folder and edit it to fit your project.

cmake_minimum_required(VERSION 3.21)

# STEP 1: set up bases of environment
# -----------------------------------------------------------------------------

file(REAL_PATH "{{corepath}}" CORE_PATH EXPAND_TILDE)
file(TO_CMAKE_PATH "{{"${CORE_PATH}"}}" CORE_PATH)

file(REAL_PATH "{{userlibs}}" USER_LIBS EXPAND_TILDE)
file(TO_CMAKE_PATH "{{"${USER_LIBS}"}}" USER_LIBS)

set(BOARDNAME "{{boardname or "@board_name_here@"}}")

list(APPEND CMAKE_MODULE_PATH {{"${CORE_PATH}"}}/cmake)
set(CMAKE_TOOLCHAIN_FILE toolchain)


# You may remove this block when using this file as the sketch's CMakeLists.txt
if (NOT ${CMAKE_PARENT_LIST_FILE} STREQUAL ${CMAKE_CURRENT_LIST_FILE})
    # When we are imported from the main CMakeLists.txt, we should stop here
    # not to interfere with the true build config.
    return()
endif()

project("{{tgtname+"_project" if tgtname else "@project_name_here@"}}")

# STEP 2: configure the build
# -----------------------------------------------------------------------------

# Uncomment and pick the relevant value for each keyword!
# The first value listed is the default (when the feature is supported by the board)
# This means that leaving everything commented out yields the default config
include(set_board)
set_board("{{"${BOARDNAME}"}}"
  # SERIAL generic / disabled / none
  # USB none / CDCgen / CDC / HID
  # XUSB FS / HS / HSFS
  # VIRTIO disable / generic / enabled
  # BOOTLOADER dfuo / dfu2 / hid
)

include(overall_settings)
overall_settings(
  # STANDARD_LIBC
  # PRINTF_FLOAT
  # SCANF_FLOAT
  # DEBUG_SYMBOLS
  # LTO
  # NO_RELATIVE_MACRO
  # UNDEF_NDEBUG
  # OPTIMIZATION "s"
  # BUILD_OPT ./build.opt
  # DISABLE_HAL_MODULES ADC I2C RTC SPI TIM DAC EXTI ETH SD QSPI
  # CORE_CALLBACK
)

# STEP 3: configure your sketch
# -----------------------------------------------------------------------------
include(external_library)
# I cannot tell the dependencies of the library ahead-of-time
# Please write them in using the DEPENDS ... clause
# The same directives apply as for `build_sketch()` just below.
{% for libdir in libs | sort %}
external_library(PATH "{{"${USER_LIBS}"}}/{{libdir}}")
{% endfor %}

include(build_sketch)
build_sketch(TARGET "{{tgtname or "@binary_name_here@"}}"
  SOURCES
  {% for file in scrcfiles | sort %}
  {{file}}
  {% else %}
  ./file1.ino
  ./file2.ino
  ./file3.cpp
  ./file4.c
  ./file5.S
  {% endfor %}

  # Uncomment the lines below to bind libraries to your sketch
  # Legitimate names after the DEPENDS keywords are:
  # - libraries declared with external_library
  # - libraries from the libraries/ folder of Arduino_Core_STM32

  # DEPENDS
  # SD
  # Wire
  # SPI
)

# STEP 4: optional features
# -----------------------------------------------------------------------------

include(insights)
insights(TARGET "{{tgtname or "@binary_name_here@"}}"
  # DIRECT_INCLUDES
  # TRANSITIVE_INCLUDES
  # SYMBOLS
  # ARCHIVES
  # LOGIC_STRUCTURE
)
