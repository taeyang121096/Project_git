#define _CRT_NO_SECURE_WARNINGS
#include<stdio.h>
#include<stdlib.h>
#include<limits.h>
#include<windows.h>

#define TRUE 1
#define FALSE 0
#define MAX_VERTICES 100

typedef struct GraphType {
	int n;
	int adj_mat[MAX_VERTICES][MAX_VERTICES];
}GraphType;


int visited[MAX_VERTICES];
int parent[MAX_VERTICES];
int path[MAX_VERTICES];
int Start;

void dfs_mat_path(GraphType *g, int start, int goal) {
	int w, num;

	visited[start] = TRUE;
	if (start == goal) {
		num = 0;
		while(goal != Start){
			path[num] = goal;
			goal = parent[goal];
			num++;
		}
		if (goal == Start)
			path[num] = Start;
		printf("해의 경로는 : ");
		for (; num >0; num--)
			printf("%d->", path[num]);
		printf("%d", path[num]);
		return;
	}
		
	for (w = 0; w < g->n; w++)
		if (g->adj_mat[start][w] && !visited[w]) {
			parent[w] = start;
			dfs_mat_path(g, w, goal);
		}

}

void main() {
	int start, goal;
	GraphType g = { 9,{{0,0,0,1,1,1,0,0,0},{0,0,0,0,1,0,0,1,0},{0,0,0,1,1,1,0,0,1},{1,0,1,0,0,0,1,0,0},{1,1,1,0,0,1,0,0,0},{1,0,1,0,1,0,1,0,0},{0,0,0,1,0,1,0,1,1},{0,1,0,0,0,0,1,0,0},{0,0,1,0,0,0,1,0,0}} };

	printf("start 값을 입력하시오 : ");
	scanf_s("%d", &start, sizeof(start));
	Start = start;
	printf("goal 값을 입력하시오 :  ");
	scanf_s("%d", &goal, sizeof(goal));
	dfs_mat_path(&g, start, goal);

	printf("\n");
	

	system("pause");

}