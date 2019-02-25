cmake_minimum_required(VERSION 3.1)
project(Blackjack C Fortran)
enable_testing()

add_library(blackjack blackjack.f90)

add_executable(c_blackjack blackjack.c)
target_link_libraries(c_blackjack blackjack)

add_executable(f_blackjack main.f90)
target_link_libraries(f_blackjack blackjack)

find_package(Python3 COMPONENTS Interpreter)
if(Python3_FOUND)
  add_test(NAME C
    COMMAND Python3::Interpreter -m pytest -k c -v
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/tests)

  add_test(NAME Fortran
    COMMAND Python3::Interpreter -m pytest -k fortran -v
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/tests)

endif()
