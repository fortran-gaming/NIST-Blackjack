cmake_minimum_required(VERSION 3.15)

project(Blackjack
LANGUAGES C Fortran)

include(CTest)

if(CMAKE_Fortran_COMPILER_ID STREQUAL GNU)
  add_compile_options(-Wall -Wextra)
  string(APPEND CMAKE_Fortran_FLAGS " -fimplicit-none")
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL Intel)
  if(WIN32)
    string(APPEND CMAKE_Fortran_FLAGS " /warn")
  else()
    string(APPEND CMAKE_Fortran_FLAGS " -warn")
  endif()
endif()

add_library(blackjack OBJECT blackjack.f90)

add_executable(c_blackjack blackjack.c)
target_link_libraries(c_blackjack blackjack)
set_target_properties(c_blackjack PROPERTIES LINKER_LANGUAGE C)  # needed for Ifort

add_executable(f_blackjack main.f90)
target_link_libraries(f_blackjack blackjack)

if(BUILD_TESTING)
find_package(Python COMPONENTS Interpreter)
if(Python_FOUND)
  add_test(NAME C
    COMMAND Python::Interpreter -m pytest -k c -v
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/tests)

  add_test(NAME Fortran
    COMMAND Python::Interpreter -m pytest -k fortran -v
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/tests)
endif()
endif()
