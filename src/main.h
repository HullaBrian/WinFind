#ifndef MAIN_H
#define MAIN_H

typedef struct Reg_ptr {
    char[MAX_PATH] value;
    char[MAX_PATH] data;
    struct Reg_ptr* next;
} REGISTRY_VALUE;

void append(REGISTRY_VALUE* head, REGISTRY_VALUE* reg_value);
void print(REGISTRY_VALUE* head);
void destroy(REGISTRY_VALUE* head);

#endif