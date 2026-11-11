cmake_minimum_required(VERSION 3.13...3.25)

project(Blackjack
LANGUAGES C Fortran
)

enable_testing()

file(GENERATE OUTPUT .gitignore CONTENT "*")

if(CMAKE_Fortran_COMPILER_ID STREQUAL "GNU")
  add_compile_options($<$<COMPILE_LANGUAGE:Fortran>:-fimplicit-none>
  "$<$<AND:$<COMPILE_LANGUAGE:Fortran>,$<CONFIG:Debug>>:-Wall;-Wextra>"
  )
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL "IntelLLVM")
  add_compile_options($<$<COMPILE_LANGUAGE:Fortran>:-warn>)
endif()

add_library(shuffler src/shuffler.f90)
add_library(blackjack OBJECT src/blackjack.f90)
target_include_directories(blackjack PUBLIC $<TARGET_PROPERTY:Fortran_MODULE_DIRECTORY>)
target_link_libraries(blackjack PUBLIC shuffler)

add_executable(c_blackjack src/blackjack.c)
target_link_libraries(c_blackjack PRIVATE blackjack)
set_property(TARGET c_blackjack PROPERTY LINKER_LANGUAGE C)  # needed for IntelLLVM

add_executable(f_blackjack app/main.f90)
target_link_libraries(f_blackjack PRIVATE blackjack)

add_test(NAME C
COMMAND ${CMAKE_COMMAND} -Dexe:FILEPATH=$<TARGET_FILE:c_blackjack> -P ${CMAKE_CURRENT_SOURCE_DIR}/tests/test_hit.cmake
)

add_test(NAME Fortran
COMMAND ${CMAKE_COMMAND} -Dexe:FILEPATH=$<TARGET_FILE:f_blackjack> -P ${CMAKE_CURRENT_SOURCE_DIR}/tests/test_hit.cmake
)

# random order
add_executable(rand_order app/rand_order.f90)
target_link_libraries(rand_order PRIVATE shuffler)
