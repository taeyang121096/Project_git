#define _CRT_SECURE_NO_WARNINGS
#include<string.h>
#include<stdlib.h>
#include<stdio.h>
#include<memory.h>

#define MAX_WORD_SIZE 100
#define MAX_MEANING_SIZE 200
int count = 0;

typedef struct {
	char word[MAX_WORD_SIZE];
	char meaning[MAX_MEANING_SIZE];
}element;

typedef struct TreeNode {
	element key;
	struct TreeNode *left, *right;
}TreeNode;

int compare(element e1, element e2);
void menu();
void insert_node(TreeNode **root, element key);
void delete_node(TreeNode **root, element key);
void display1(TreeNode *p);
void display2(TreeNode *p);
void display3(TreeNode *p);
void read_file(TreeNode *root,FILE *file_pointer);
void write_file(TreeNode *root,FILE *file_pointer);
TreeNode *search(TreeNode *root, element key);

void main() {
	char command;
	int select;
	element e;
	TreeNode *root = NULL;
	TreeNode *tmp = NULL;
	FILE *file_pointer=NULL;
	do {
		menu();
		rewind(stdin);
		scanf_s("%c", &command, sizeof(command));

		switch (command) {
		case'i':
			printf("단어: ");
			scanf_s("%s", e.word, sizeof(e.word));
			printf("뜻: ");
			scanf_s("%s", e.meaning, sizeof(e.meaning));
			insert_node(&root, e);
			count++;
			break;
		case'd':
			printf("단어:");
			scanf_s("%s", e.word, sizeof(e.word));
			delete_node(&root, e);
			count--;
			break;
		case'p':

			printf("1.전위 순회\n");
			printf("2.중위 순회\n");
			printf("3.후위 순회\n");
			scanf_s("%d", &select);
			switch (select) {
			case 1:
				display1(root);
				break;
			case 2:
				display2(root);
				break;
			case 3:
				display3(root);
				break;
			}
			printf("\n");
			break;
		case's':
			printf("단어:");
			scanf_s("%s", e.word, sizeof(e.word));
			tmp = search(root, e);
			if (tmp != NULL)
				printf("뜻:%s \n", (tmp->key).meaning);
			if (tmp == NULL)
				printf("입력하신 단어가 없습니다.\n");
			break;
		case 'o':
			file_pointer = fopen("dictionary.txt", "r");
			read_file(root,file_pointer);
			fclose(file_pointer);
			break;
		case 'v':
			file_pointer = fopen("dictionary.txt", "w");
			write_file(root,file_pointer);
			fclose(file_pointer);
			break;
		}

	} while (command != 'q');
	return;
}

int compare(element e1, element e2) {
	return strcmp(e1.word, e2.word);
}

void menu() {
	printf("**************\n");
	printf("i: 입력\n");
	printf("d: 삭제\n");
	printf("s: 탐색\n");
	printf("p: 출력\n");
	printf("o: 파일 열기\n");
	printf("v: 파일 저장\n");
	printf("q: 종료\n");
	printf("**************\n");
}

void display1(TreeNode *p) {
	if (p != NULL) {

		printf("%s   %s\n", p->key.word, p->key.meaning);
		display1(p->left);
		display1(p->right);
	}
}
void display2(TreeNode *p) {
	if (p != NULL) {
		display2(p->left);
		printf("%s   %s\n", p->key.word, p->key.meaning);
		display2(p->right);
	}

}
void display3(TreeNode *p) {
	if (p != NULL) {
		display3(p->left);
		display3(p->right);
		printf("%s   %s\n", p->key.word, p->key.meaning);
	}

}


void write_file(TreeNode *root,FILE *file_pointer) {

	if (file_pointer == NULL) {
		printf("파일 오픈 실패\n");
		return;
	}
	if (root) {
		
		fprintf(file_pointer, "%s %s\n", root->key.word, root->key.meaning);
		write_file(root->left,file_pointer);
		write_file(root->right,file_pointer);
	}
}
void read_file(TreeNode *root,FILE *file_pointer) {
	

	if (file_pointer == NULL) {
		printf("파일 오픈 실패\n");
		return;
	}
	if (root) {
		
		fscanf(file_pointer, "%s %s", root->key.word, root->key.meaning);
		printf("%s  %s\n", root->key.word, root->key.meaning);
		read_file(root->left,file_pointer);
		read_file(root->right,file_pointer);
	}
	
	return;
}

TreeNode *search(TreeNode *root, element key) {
	TreeNode *p = root;
	while (p != NULL) {
		switch (compare(key, p->key)) {
		case -1:
			p = p->left;
			break;
		case 0:
			return p;
		case 1:
			p = p->right;
			break;
		}

	}
	return p;
}

void insert_node(TreeNode **root, element key) {
	TreeNode *p, *t;
	TreeNode *n;

	t = *root;
	p = NULL;

	while (t != NULL) {
		if (compare(key, t->key) == 0) {
			printf("입력하신 단어가 있습니다.\n");
			return;
		}
		p = t;
		if (compare(key, t->key) < 0)t = t->left;
		else t = t->right;
	}

	n = (TreeNode *)malloc(sizeof(TreeNode));
	if (n == NULL)return;

	n->key = key;
	n->left = n->right = NULL;
	if (p != NULL) {
		if (compare(key, p->key) < 0)
			p->left = n;
		else p->right = n;
	}
	else *root = n;

}

void delete_node(TreeNode **root, element key) {
	TreeNode *p, *child, *succ, *succ_p, *t;
	p = NULL;
	t = *root;
	while (t != NULL && compare(t->key, key) != 0) {
		p = t;
		t = (compare(key, t->key) < 0) ? t->left : t->right;
	}
	if (t == NULL) {
		printf("key is not in the tree\n");
		return;
	}
	if ((t->left == NULL) && (t->right == NULL)) {
		if (p != NULL) {
			if (p->left == t)
				p->left = NULL;
			else   p->right = NULL;
		}
		else
			*root = NULL;
	}
	else if ((t->left == NULL) || (t->right == NULL)) {
		child = (t->left != NULL) ? t->left : t->right;
		if (p != NULL) {
			if (p->left == t)
				p->left = child;
			else p->right = child;
		}
		else
			*root = child;
	}
	else {
		succ_p = t;
		succ = t->right;
		while (succ->left != NULL) {
			succ_p = succ;
			succ = succ->left;
		}
		if (succ_p->left == succ) {
			succ_p->left = succ->right;
		}
		else
			succ_p->right = succ->right;
		t->key = succ->key;
		t = succ;
	}
	free(t);
}


