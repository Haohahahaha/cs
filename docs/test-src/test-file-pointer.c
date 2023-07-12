// This program will show what the fopen() returns, with it, I can know some
// concept such as `index`. The number of an entry in the open file table—that
// is, the index is also a memory address.

// Author: Haorui Zhang
// Date: 2023-07-12

#include <stdio.h>

int main () {
	
	FILE *fp;
	int ret = 0;

	fp = fopen("../index.md", "r");
	if (fp == NULL) {
		perror("\033[31m[system] \033[37mfile open failed!\n\n");
	} else {
		printf("\033[32m[system] \033[37mfile open successfully!\n\n");
	}
	
	printf("\033[33m[test] \033[37mThe address of the memory pointed to by the file pointer is: \033[40;33m%d\033[0m\n\n", fp);

	ret = fclose(fp);
	if (ret != 0) {
		perror("\033[31m[system] \033[37mfile close failed!\n\n");
	} else {
		printf("\033[32m[system] \033[37mfile close successfully!\n\n");
	}
	
	return 0;
}
