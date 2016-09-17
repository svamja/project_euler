#include <iostream>
#include <string.h>
#include <fstream>
#include <ctime>
#include <cmath>

using namespace std;

#define SIEVE_SIZE 500000000
// #define SIEVE_SIZE 100

short int factors_sieve[SIEVE_SIZE];
const int factor_max = (int)log2(SIEVE_SIZE)+2;

void setup_sieve() {
    int i = 2;
    int q;
    while(i*i < SIEVE_SIZE) {
        if(factors_sieve[i] == 0) {
            q = i;
            for(int r = q; r <= SIEVE_SIZE; r += q) {
                factors_sieve[r] = i;
            }
        }
        i++;
    }
}

int* sieve_factors(int n) {
    int* factors = new int[factor_max];
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

short int is_prime_sieve(int n) {
    if(factors_sieve[n] == 0 || factors_sieve[n] == n)
    {
        return true;        
    }
    return false;
}

long int phi_pre_factored(int n, int* factors) {
    long int value = n;
    int i = 0;
    int prev_factor = -1;
    int factor;
    while(factors[i]) {
        factor = factors[i];
        // cout << value << "*" << (factor-1) << "/" << factor << " -> ";
        if(prev_factor != factor) {
            value = value * (factor - 1) / factor;
        }
        prev_factor = factor;
        i++;
    }
    // cout << value << endl;
    return value;
}

long int f_modified(int n) {
    if(is_prime_sieve(n)) {
        return n - 1;
    }
    int* factors = sieve_factors(n);
    long int phi_1 = phi_pre_factored(n, factors);
    // int phi_2 = phi_pre_factored(n*n, factors);
    long int phi_2 = n*phi_1;
    long int value = (phi_1*(n/2 + 1) + phi_2*(n/2)) % (n+1);
    delete[] factors;
    return value;
}

long int g_modified(int n) {
    long int sum = 1;
    long int phi_1;
    int* factors;
    // int f_value;
    for(int i = 3; i <= n; i += 2) {
        if(i % 10000000 == 1) {
            cout << i << endl;
        }
        // if(i % 1000 == 1) {
        //     cout << i << " : " << sum << endl;
        // }
        factors = sieve_factors(i);
        phi_1 = phi_pre_factored(i, factors);
        delete[] factors;
        sum += phi_1;
        // sum += f_modified(i);
    }
    return sum;
}

int main() {
    clock_t start_time = clock();
    setup_sieve();
    long int g = g_modified(SIEVE_SIZE);
    cout << g << endl;

    clock_t end_time = clock();
    double elapsed_secs = double(end_time - start_time) / CLOCKS_PER_SEC;
    cout << "Elapsed Time: " << elapsed_secs << " seconds" << endl;
}

/*
DELETED STUFF

    // Print Factors
    int num = 35;
    int i = 0;
    int* factors = sieve_factors(num);
    cout << num << " > ";
    while(factors[i]) cout << factors[i++] << " ";
    cout << endl;

    // Print Sieve
    for(int i = 0; i < SIEVE_SIZE; i++) cout << factors_sieve[i] << " ";
    cout << endl;

    // Print f
    int num = 2001;
    int f_value = f_modified(num);
    cout << num << " : " << f_value << endl;

    // Print series of f()
    long int f;
    for(int i = 499000101; i < 499000110; i += 2) {
        f = f_modified(i);
        cout << i << " : " << f << endl;
    }



*/
