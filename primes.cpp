#include "primes.h"

using namespace std;

short int* factors_sieve;
int factors_max;

std::ostream& operator<<(std::ostream& os, const int* a) {
    int i = 0;
    while(a[i]) os << a[i++] << " ";
    os << endl;
    return os;
}

clock_t start_time, last_time;

void timer_start() {
    start_time = clock();
    last_time = start_time;
}

void timer_lap() {
    clock_t current_time = clock();
    double elapsed_secs = double(current_time - last_time) / CLOCKS_PER_SEC;
    cout << "Lap Time: " << elapsed_secs << " seconds" << endl;
}

void timer_stop() {
    clock_t end_time = clock();
    double elapsed_secs = double(end_time - start_time) / CLOCKS_PER_SEC;
    if(last_time != start_time) {
        timer_lap();
    }
    cout << "Elapsed Time: " << elapsed_secs << " seconds" << endl;
}

void prime_setup(int prime_max) {
    factors_sieve = new short int[prime_max];
    int i = 2;
    factors_max = (int)log2(prime_max)+2;
    int q;
    while(i*i < prime_max) {
        if(factors_sieve[i] == 0) {
            q = i;
            for(int r = q; r <= prime_max; r += q) {
                factors_sieve[r] = i;
            }
        }
        i++;
    }
}

short int is_prime(int n) {
    if(factors_sieve[n] == 0 || factors_sieve[n] == n)
    {
        return true;        
    }
    return false;
}

int* prime_factors(int n) {
    int* factors = new int[factors_max];
    int i = 0;
    int factor = factors_sieve[n];
    int number = n;
    while(true) {
        if(factor == 0 || factor == number) {
            factors[i] = number;
            break;
        }
        factors[i] = factor;
        number /= factor;
        factor = factors_sieve[number];
        i++;
    }
    factors[i+1] = 0;
    return factors;
}

