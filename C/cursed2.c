#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <limits.h>

int isEven(long long nbr) {
  if (nbr == 0) {
    return 1;
  }
  int itter = 1;
  if (nbr < 0) {
    itter *= -1;
  }
  int even = 1;
  long long counter = 0;
  while (counter != nbr) {
    if (counter % 10000000000 == 0) {
      printf("%lld -> %d\n", counter, even);
    }
    counter += itter;
    even *= -1;
  }
  printf("%lld -even?-> %d\n\n", nbr, even);
  return even;
}

int main(int argc, char** argv) {
  if (argc < 2) {
    printf("Usage: %s <integer>\n", *argv);
    return -1;
  }
  char *endptr;
  errno = 0;
  long long value = strtoull( *(argv + 1), &endptr, 10);
  if (errno == ERANGE || *endptr != '\0') {
    printf("Invalid or out-of-range integer: %s\n", argv[1]);
    return 1;
  }
  isEven(value);
  return 0;
}
