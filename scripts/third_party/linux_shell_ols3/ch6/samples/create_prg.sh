#! /bin/bash

echo "���b���� hello.c ...."
echo
cat <<'EOF' > hello.c
#include <stdio.h>

int main() {
    printf("Hello world!\n");
    return 0;
}
EOF

echo "�sĶ hello.c ...."
echo
# �sĶ hello.c�A���Ͱ�����
gcc -o hello hello.c

# �Y�sĶ���\�A�N����C
if [ $? -eq 0 ]; then
   echo "���� hello ...."
   echo
   ./hello
else
   echo 'Compile ERROR: hello.c'
fi
