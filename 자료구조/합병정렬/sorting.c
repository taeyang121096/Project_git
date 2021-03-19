
#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include<string.h>
#include<stdlib.h>

#define SWAP(x,y,t)((t)=(x),(x)=(y),(y)=(t))
#define MAX_SIZE 1000
#define MAX_MAJOR 100
#define MAX_NAME 100 
#define MAX 10
typedef struct element {
	int key;
	char major[MAX_MAJOR];
	char name[MAX_NAME];
	int grade;
}element;

element sorted[MAX_SIZE];

void merge(element* information, int left, int mid, int right) {
	int i, j, k, l;
	i = left; j = mid + 1; k = left;

	while (i <= mid && j <= right) {
		if (information[i].key <= information[j].key)
			sorted[k++] = information[i++];
		else
			sorted[k++] = information[j++];
	}
	if (i > mid)
		for (l = j; l <= right; l++)
			sorted[k++] = information[l];
	else
		for (l = i; l <= mid; l++)
			sorted[k++] = information[l];
	for (l = left; l <= right; l++)
		information[l] = sorted[l];
}
void merge_sort(element* information, int left, int right) {
	int mid;
	if (left < right) {
		mid = (left + right) / 2;
		merge_sort(information, left, mid);
		merge_sort(information, mid + 1, right);
		merge(information, left, mid, right);
	}

}
void main() {
	struct element information[MAX_SIZE];
	int size = 0;
	int size1 = 0;
	FILE* file_pointer = NULL;
	FILE* file_pointer1 = NULL;

	file_pointer = fopen("students.txt", "r");
	file_pointer1 = fopen("sorting.txt", "w");

	if (file_pointer == NULL) {
		printf("파일 오픈 실패\n");
		return;
	}
	if (file_pointer == NULL) {
		printf("파일 오픈 실패\n");
		return;

	}

	while (fscanf(file_pointer, "%d %s %s %d", &information[size].key, &information[size].name, &information[size].major, &information[size].grade) != EOF)
	{
		size++;
	}
	size--;

	merge_sort(information, 0, size);
	while (size1 != size + 1) {
		fprintf(file_pointer1,"%d %s %s %d\n", information[size1].key, information[size1].name, information[size1].major, information[size1].grade);
		size1++;
	}

	fclose(file_pointer);
	fclose(file_pointer1);
	size1 = 0;

	while (size1 != size + 1) {
		printf("%d %s %s %d\n", information[size1].key, information[size1].name, information[size1].major, information[size1].grade);
		size1++;
	}

	printf("정렬 되었습니다.\n");
	system("pause");
}