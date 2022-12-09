cmake_minimum_required(VERSION 3.13...3.25)

project(Blackjack
LANGUAGES C Fortran
)

enable_testing()

# --- auto-ignore build directory
if(NOT EXISTS ${PROJECT_BINARY_DIR}/.gitignore)
  file(WRITE ${PROJECT_BINARY_DIR}/.gitignore "*")
endif()


if(CMAKE_Fortran_COMPILER_ID STREQUAL "GNU")
  add_compile_options(-Wall -Wextra
  $<$<COMPILE_LANGUAGE:Fortran>:-fimplicit-none>
  )
elseif(CMAKE_Fortran_COMPILER_ID MATCHES "^Intel")
  add_compile_options(
  $<$<COMPILE_LANGUAGE:Fortran>:-warn>
  )
endif()

set(CMAKE_Fortran_MODULE_DIRECTORY ${PROJECT_BINARY_DIR}/include)

add_library(shuffler OBJECT src/shuffler.f90)
add_library(blackjack OBJECT src/blackjack.f90)
target_link_libraries(blackjack PRIVATE shuffler)

add_executable(c_blackjack src/blackjack.c)
target_link_libraries(c_blackjack PRIVATE blackjack shuffler)
set_property(TARGET c_blackjack PROPERTY LINKER_LANGUAGE C)  # needed for Ifort

add_executable(f_blackjack app/main.f90)
target_include_directories(f_blackjack PRIVATE ${PROJECT_BINARY_DIR}/include)
target_link_libraries(f_blackjack PRIVATE blackjack shuffler)

add_test(NAME C
COMMAND ${CMAKE_COMMAND} -Dexe:FILEPATH=$<TARGET_FILE:c_blackjack> -P ${CMAKE_CURRENT_SOURCE_DIR}/tests/test_hit.cmake
)

add_test(NAME Fortran
COMMAND ${CMAKE_COMMAND} -Dexe:FILEPATH=$<TARGET_FILE:f_blackjack> -P ${CMAKE_CURRENT_SOURCE_DIR}/tests/test_hit.cmake
)

# random order
add_executable(rand_order app/rand_order.f90)
target_link_libraries(rand_order PRIVATE shuffler)
