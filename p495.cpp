#include "primes.h"
#include <algorithm>

using namespace std;

#define RESULT_CARRY 1
#define RESULT_FAILED 2
#define RESULT_SUCCESS 3

void read_slots(char* str, int** slots, int slot_count, int ball_count) {
    int k = 0;
    if(strlen(str) != (slot_count - 1)*ball_count) {
        cout << "ERROR: reading slots";
        return;
    }
    for(int i = 0; i < slot_count - 1; i++) {
        for(int j = 0; j < ball_count; j++) {
            slots[i][j] = str[k++] - '0';
        }
    }
}

void print_slots(int** slots, int slot_count, int ball_count) {
    for(int i = 0; i < slot_count; i++) {
        for(int j = 0; j < ball_count; j++) {
            cout << slots[i][j];
        }
        cout << " ";
    }
    cout << endl;
}

void copy_slot(int* slot_1, int* slot_2, int ball_count) {
    for(int j = 0; j < ball_count; j++) {
        slot_1[j] = slot_2[j];
    }
}

int compare_slots(int* slot_1, int* slot_2, int* balls, int ball_count) {
    int i = 0;
    while(slot_1[i] == slot_2[i]) {
        i++;
        if(i == ball_count) {
            return 0;
        }
    }
    if(slot_1[i] < slot_2[i]) {
        return -1;
    }
    return 1;
}

int increment_slot(int* slot, int* balls, int ball_count) {
    int carry = 1;
    int j = ball_count - 1;
    while(carry && j >= 0) {
        slot[j]++;
        if(slot[j] > balls[j]) {
            slot[j] = 0;
        }
        else {
            carry = 0;
        }
        j--;
    }
    if(carry && j == -1) {
        return 1;
    }
    return 0;
}

int update_complement(int** slots, int slot_count, int* balls, int ball_count) {
    int sum;
    for(int j = 0; j < ball_count; j++) {
        sum = 0;
        for(int i = 0; i < slot_count - 1; i++) {
            sum += slots[i][j];
        }
        slots[slot_count-1][j] = balls[j] - sum;
        if(slots[slot_count-1][j] < 0) return RESULT_FAILED;
    }
    if(compare_slots(slots[slot_count-2], slots[slot_count-1], balls, ball_count) != -1) {
        return RESULT_FAILED;
    }
    return RESULT_SUCCESS;
}

int try_increment_at(int** slots, int slot_count, int* balls, int ball_count, int slot_pos) {
    int carry = increment_slot(slots[slot_pos], balls, ball_count);
    if(carry) {
        return RESULT_CARRY;
    }

    // Last slot, it was fine!
    if(slot_pos == slot_count - 1) {
        return RESULT_SUCCESS;
    }

    // Copy and Try Incrementing Next
    copy_slot(slots[slot_pos + 1], slots[slot_pos], ball_count);
    return try_increment_at(slots, slot_count, balls, ball_count, slot_pos + 1);

}

int increment_slots(int** slots, int slot_count, int* balls, int ball_count) {
    int result;
    for(int i = slot_count - 2; i >= 0; i--) {
        result = try_increment_at(slots, slot_count, balls, ball_count, i);

        if(result == RESULT_CARRY) {
            continue; // Try incrementing the next slot now;
        }
        else if(result == RESULT_FAILED) {
            i++; // try again for this slot
        }
        else {
            // Try Updating Complement now
            result = update_complement(slots, slot_count, balls, ball_count);
            if(result == RESULT_FAILED) {
                // Try incrementing from right most digit
                i = slot_count-1;
                continue;
            }
            else {
                return RESULT_SUCCESS;
            }
        }
    }
    return RESULT_FAILED;
}


void get_next_slots(int** slots, int slot_count, int* balls, int ball_count) {
    increment_slots(slots, slot_count, balls, ball_count);
    if(update_complement(slots, slot_count, balls, ball_count)) {
        print_slots(slots, slot_count, ball_count);
        cout << "E" << endl;
    }
    else {
        print_slots(slots, slot_count, ball_count);
    }
}

int get_count(int** slots, int slot_count, int* balls, int ball_count) {
    int sum = 0;
    int r1, r2;
    r2 = update_complement(slots, slot_count, balls, ball_count);
    if(r2 == RESULT_SUCCESS) {
        sum += 1;
    }
    while(true) {
        print_slots(slots, slot_count, ball_count);
        r1 = increment_slots(slots, slot_count, balls, ball_count);
        if(r1 == RESULT_FAILED) {
            return sum;
        }
        sum += 1;
    }
    return sum;
}

int** alloc_slots(int slot_count, int ball_count) {
    int** slots = new int*[slot_count];
    for(int i = 0; i < slot_count; i++) {
        slots[i] = new int[ball_count];
        for(int j = 0; j < ball_count; j++) {
            slots[i][j] = 0;
            if(j == ball_count - 1) {
                slots[i][j] = i;
            }
        }
    }
    return slots;
}

int w(int n, int slot_count) {
    int* factors;
    factors = prime_factors(n);
    int* factor_counts = new int[20];

    int prev_factor = -1;
    int i = 0, j = -1;
    while(factors[i]) {
        if(prev_factor != factors[i]) {
            j++;
            factor_counts[j] = 0;
        }
        factor_counts[j]++;
        prev_factor = factors[i];
        i++;
    }
    factor_counts[j+1] = 0;
    int ball_count = j+1;
    sort(factor_counts, factor_counts + ball_count);
    int* balls = factor_counts;
    cout << balls;
    int** slots = alloc_slots(slot_count, ball_count);
    return get_count(slots, slot_count, balls, ball_count);
}

void get_factor_counts(int n, int* factor_counts) {
    int* factors = prime_factors(n);
    int prev_factor = -1;
    int i = 0, j = -1;
    while(factors[i]) {
        if(prev_factor != factors[i]) {
            j++;
            factor_counts[j] = 0;
        }
        factor_counts[j]++;
        prev_factor = factors[i];
        i++;
    }
    factor_counts[j+1] = 0;
    sort(factor_counts, factor_counts + j + 1);
}

int w_modified(int* ball_counts, int pick_count) {
}

int main() {
    timer_start();

    int slot_count = 3;
    int number = 144;

    prime_setup(number);
    cout << w(number, slot_count) << endl;
    
    timer_stop();
}


/*

DELETED LINES

        00 01 02  21     -> 1 2 4 18
        00 01 03  20     -> 1 2 8  9
        00 01 04E -
        00 01 10  13     -> 1 2 3 24
        00 01 11  12     -> 1 2 6 12
        00 01 12  11E
        00 02 03E
        00 02 10  12     -> 1 4 3 12
        00 02 11  11E
        00 03 04E
        00 03 10  11     -> 1 8 3 6
                - E
        00 04 10  10E
        00 10 11  03E
        00 02 03E -
        01 02 03E
        01 02 10  11     -> 2 4 3 6 
        10 11 12  11 E
        10 12 13E
        20 21 22  01 E 


    prime_setup(number);
    int* factor_counts = new int[20];
    get_factor_counts(18, factor_counts);
    cout << factor_counts;
    w_modified(factor_counts, slot_count);
    delete[] factor_counts;

        cout << " > j : " << j << " carry : " << carry << endl;
        print_slots(slots, slot_count, ball_count);


    char str[] = "002324";
    int** slots = alloc_slots(4, 2);
    int* balls = new int[2];
    balls[0] = 2;
    balls[1] = 4;
    read_slots(str, slots, 4, 2);
    print_slots(slots, 4, 2);
    int r = increment_slots(slots, 4, balls, 2);
    cout << "return : " << r << endl;
    print_slots(slots, 4, 2);


int increment_slots(int** slots, int slot_count, int* balls, int ball_count) {
    int j = slot_count - 2;
    int carry = 1;
    while(carry && j >= 0) {
        carry = increment_slot(slots[j], balls, ball_count);
        j--;
    }
    if(carry && j == -1) {
        cout << "Spill Over. carry : " << carry << " j : " << j << endl;
        return 1;
    }
    while(j < slot_count - 3) {
        j++;
        copy_slot(slots[j+1], slots[j], ball_count);
        if(increment_slot(slots[j+1], balls, ball_count)) {
            cout << "Spill Over. j : " << j << endl;
            return 1;
        }
    }
    return 0;
}

    int* balls = new int[ball_count];
    balls[0] = 2;
    balls[1] = 4;


*/
