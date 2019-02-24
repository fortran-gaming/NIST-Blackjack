cmake_minimum_required(VERSION 3.1)
project(Blackjack C Fortran)

add_library(blackjack blackjack.f90)

add_executable(c_blackjack blackjack.c)
target_link_libraries(c_blackjack blackjack)

add_executable(f_blackjack main.f90)
target_link_libraries(f_blackjack blackjack)
