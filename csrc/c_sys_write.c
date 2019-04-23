#include <unistd.h>

int
main(int argc, char **argv) {
  write(1, "hello world!", 12);
  return 0;
}
