#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>


#define MAX_CHAR_PER_LINE 1000
#define MAX_NAME 256
void warning(char*);
void error(char*);
void clearBuffer();

#define FALSE 0
#define TRUE 1

typedef struct {
	char a[MAX_CHAR_PER_LINE];
}element;

typedef struct {
	element data;
	struct ListNode* link;
}ListNode;

typedef struct {
	ListNode* head;
	int length;
}ListType;

void insert_node(ListNode** phead, ListNode* p, ListNode* new_node) {
	if (*phead == NULL) {
		*phead = new_node;
		(*phead)->link = NULL;
	}
	else if (p == NULL) {
		new_node->link = (*phead)->link;
		(*phead)->link = new_node;
	}
	else {
		new_node->link = p->link;
		p->link = new_node;
	}
}

void remove_node(ListNode** phead, ListNode* p, ListNode* removed) {
	if (*phead == NULL)
		return;
	else if (p == NULL) {
		(*phead) = (ListNode*)(*phead)->link;
	}
	else {
		p->link = removed->link;
	}
	free(removed);
}

void init(ListType* list) {
	if (list == NULL)
		return;

	list->length = 0;
	list->head = NULL;
}

ListNode* get_node_at(ListType * list, int pos) {
	if (pos < 0 || pos > list->length)
		return NULL;

	int i;
	ListNode * p = list->head;
	for (i = 0; i < pos-1; i++)
		p = p->link;

	return p;
}

int get_length(ListType * list) {
	return list->length;
}

void add(ListType * list, int pos, element data) {
	if (pos < 0 || pos > list->length)
		return;

	ListNode * p = get_node_at(list, pos);

	ListNode * new_node = (ListNode*)malloc(sizeof(ListNode));
	new_node->data = data;
	new_node->link = NULL;

	insert_node(&(list->head), p, new_node);
	list->length++;
}

void add_last(ListType * list, element data) {
	add(list, get_length(list), data);
}

void add_first(ListType * list, element data) {
	add(list, 0, data);
}

int is_empty(ListType * list) {
	return list->length == 0;
}

void delete(ListType * list, int pos) {

	if (is_empty(list) || pos > list->length)
		return;


	ListNode * p = get_node_at(list, pos - 1);
	remove_node(&(list->head), p, p != NULL ? (ListNode*)p->link : NULL);
	list->length--;
}

element get_entry(ListType * list, int pos) {

	ListNode* p = get_node_at(list, pos);
	return p->data;
}

void clear(ListType * list) {
	int i;
	for (i = 0; i < list->length; i++)  delete(list, i);
}

void display(ListType * list) {
	int i;
	ListNode* p = list->head;

	printf("**********\n");
	for (i = 0; i < list->length; i++) {
		printf("%s", p->data.a);
		p = (ListNode*)p->link;
	}
	printf("**********\n");
}

void warning(char* message) {
	fprintf(stderr, message);
}

void error(char* message) {
	fprintf(stderr, message);
	exit(1);
}

void help() {
	printf("**********\n");
	printf("i: 입력\n");
	printf("d: 삭제\n");
	printf("r: 파일읽기\n");
	printf("w: 파일쓰기\n");
	printf("v: 반전\n");
	printf("c: 변경\n");
	printf("f: 탐색\n");
	printf("q: 종료\n");
	printf("**********\n");
}

void read_file(ListType * buffer) {
	char fname[MAX_NAME];
	FILE* fd;
	element p;

	if (!is_empty(buffer)) {
		clear(buffer);
	}
	init(buffer);

	printf("파일 이름 : ");
	scanf("%s", fname);
	if ((fd = fopen(fname, "r")) == NULL) {
		warning("error");
		return;
	}
	while (fgets(p.a, MAX_CHAR_PER_LINE, fd)) {
		add_last(buffer, p);
	}

	fclose(fd);
	display(buffer);
}

void write_file(ListType * buffer) {

	FILE* fd;
	char fname[MAX_NAME];
	element p;
	int i;

	printf("파일 이름 : ");
	scanf("%s", fname);
	if ((fd = fopen(fname, "w")) == NULL) {
		warning("error");
		return;
	}
	for (i = 0; i < get_length(buffer); i++) {
		p = get_entry(buffer, i);
		fputs(p.a, fd);
	}
	fclose(fd);
	display(buffer);
}

void delete_line(ListType * buffer) {
	int position;

	if (is_empty(buffer)) {
		printf("지울 라인이 없습니다.\n");
	}
	else {
		printf("지우고 싶은 라인번호를 입력 : \n");
		scanf("%d", &position);
		delete(buffer, position);
	}
	display(buffer);
}

void insert_line(ListType * buffer) {
	int position;
	char line[MAX_CHAR_PER_LINE];
	element p;

	printf("입력행 번호 입력 : ");
	scanf("%d", &position);
	printf("내용을 입력 : ");
	clearBuffer();

	fgets(line, MAX_CHAR_PER_LINE, stdin);
	strcpy(p.a, line);
	add(buffer, position, p);
	display(buffer);
}
void delete_data(ListType* list, int pos)
{
	if (!is_empty(list) && (pos >= 0) && (pos < list->length)) {
		ListNode* p = get_node_at(list, pos - 1);
		remove_node(&(list->head), p, (p != NULL) ? p->link : NULL);
		list->length--;
	}
}
void change_line(ListType* buffer)
{
	int num;
	char s[MAX_CHAR_PER_LINE];
	element p;
	ListNode* tmp;
	tmp = buffer->head;
	printf("바꿀 라인 번호 : ");
	scanf("%d", &num);
	printf("입력할 내용 : ");
	clearBuffer();
	fgets(s, MAX_CHAR_PER_LINE, stdin);
	strcpy(p.a, s);
	add(buffer, num, p);
	delete_data(buffer, num + 1);
	display(buffer);
}
void reverse_lines(ListType* buffer)
{
	ListNode* p, *q, *r;
	p = buffer->head;
	q = NULL;
	while (p != NULL) {
		r = q;
		q = p;
		p = q->link;
		q->link = r;
	}
	buffer->head = q;
	display(buffer);
}
void find_line(ListType* buffer)
{
	ListNode* p = buffer->head->link;
	int i = 0;
	char name[20] = { 0 };
	printf("찾을 문자 입력:");
	scanf("%s", &name);
	while (p != NULL)
	{
		if (strstr(p->data.a, name) != NULL)//문자열이 포함 됐는지 검사 
		{
			printf("찾은 문자열의 순서는 %d번째 입니다.", i);
			return;
		}
		p = p->link;
		i++;
	}
	printf("문자열을 찾지 못했습니다.\n");
}


void do_command(ListType * buffer, char command)
{
	switch (command) {
	case 'd':
		delete_line(buffer);
		break;
	case 'i':
		insert_line(buffer);
		break;
	case 'r':
		read_file(buffer);
		break;
	case 'w':
		write_file(buffer);
		break;
	case 'v':
		reverse_lines(buffer);
		break;
	case 'c':
		change_line(buffer);
		break;
	case 'f':
		find_line(buffer);
		break;
	case 'q':
		exit(1);
		break;
	}
}

void clearBuffer() {
	int c;
	while ((c = getchar()) != '\n' && c != EOF);
}

int main() {
	char command;
	ListType buffer;

	init(&buffer);
	do {
		help();
		command = getchar();
		do_command(&buffer, command);
		clearBuffer();
	} while (command != 'q');

	return 0;
}