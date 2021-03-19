#include<stdio.h>
#include<stdlib.h>

float max = 0;
float min = 100;
float sum = 0;

void input_score(float *score, int n);
float max_score(float *score, int n);
float min_score(float *score, int n);
float sum_score(float *score, int n);
void print_result(float max, float min, float sum, float mean);

int main()
{
	int n;
	float *score;
	float max, min, sum, mean;

	printf("학생수?");
	scanf_s("%d", &n);

	score = (float*)malloc(n * sizeof(float));
	if (score == NULL)
	{
		printf("에러:동적 메모리 할당 실패!!!\n\n");
		return;
	}
	input_score(score, n);
	max = max_score(score, n - 1);
	min = min_score(score, n - 1);
	sum = sum_score(score, n - 1);
	mean = (float)sum / n;
	print_result(max, min, sum, mean);

	free(score);

}

void input_score(float *score, int n)
{
	int c;
	printf("점수를 입력하세요.\n");
	for (c = 0; c < n; c++)
		scanf_s("%f", &score[c]);
}
float max_score(float *score, int n)
{
	if (n < 0)return max;
	else if (max < score[n])
		max = score[n];

	return max_score(score, n - 1);
}
float min_score(float *score, int n)
{
	if (n < 0)return min;
	else if (min > score[n])
		min = score[n];

	return min_score(score, n - 1);
}
float sum_score(float *score, int n)
{
	if (n < 0)return sum;
	sum += score[n];

	return sum_score(score, n - 1);
}
void print_result(float max, float min, float sum, float mean)
{
	printf("**************************\n");
	printf("최고점수: %f\n", max);
	printf("최저점수: %f\n", min);
	printf("합계점수: %f\n", sum);
	printf("평균점수: %f\n", mean);
	printf("**************************\n");
}