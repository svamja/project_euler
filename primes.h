#include <iostream>
#include <string.h>
#include <fstream>
#include <ctime>
#include <cmath>

#define SIEVE_SIZE 100

using namespace std;

std::ostream& operator<<(std::ostream& os, const int* a);

void prime_setup(int);
void prime_setup(int prime_max);
short int is_prime(int n);
int* prime_factors(int n);

void timer_start();
void timer_lap();
void timer_stop();

