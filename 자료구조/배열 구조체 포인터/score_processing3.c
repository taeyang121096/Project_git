#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
float max = 0;
float min = 100;
float sum = 0;

void input_score_file(FILE*infile, float score[], int n);
void printf_score(float score[], int n);
float max_score(float score[], int n);
float min_score(float score[], int n);
float sum_score(float score[], int n);
void save_result_file(FILE *outfile, float max, float min, float sum, float mean);
void print_result(float max, float min, float sum, float mean);

int main()
{
	int n;
	float score[30];
	float max, min, sum, mean;
	FILE *infile, *outfile;

	printf("학생수?");
	scanf_s("%d", &n);

	infile = (FILE*)fopen("score.txt", "r");
	if (infile == NULL)
	{
		printf("에러 : 입력 파일을 열 수 없음!!!\n\n");
		return;
	}

	input_score_file(infile, score, n);
	printf_score(score, n);
	fclose(infile);

	max = max_score(score, n - 1);
	min = min_score(score, n - 1);
	sum = sum_score(score, n - 1);
	mean = (float)sum / n;

	print_result(max, min, sum, mean);

	outfile = (FILE*)fopen("result.txt", "w");
	if (outfile == NULL)
	{
		printf("에러: 출력 파일을 열 수 없음!!!\n\n");
		return;
	}
	save_result_file(outfile, max, min, sum, mean);
	fclose(outfile);

}


void input_score_file(FILE*infile, float score[], int n)
{
	int c;
	printf("점수를 입력하세요\n");
	for (c = 0; c < n; c++)
		fscanf_s(infile, "%f", &score[c]);
}
void printf_score(float score[], int n)
{
	int c;
	for (c = 0; c < n; c++)
		printf("%f\n", score[c]);
}
float max_score(float score[], int n)
{
	if (n < 0) return max;
	else if (max < score[n])
		max = score[n];

	return max_score(score, n - 1);
}
float min_score(float score[], int n)
{
	if (n < 0) return min;
	else if (min > score[n])
		min = score[n];

	return min_score(score, n - 1);
}
float sum_score(float score[], int n)
{
	if (n < 0) return sum;
	else sum += score[n];

	return sum_score(score, n - 1);
}
void save_result_file(FILE *outfile, float max, float min, float sum, float mean)
{
	fprintf(outfile, "**************************\n");
	fprintf(outfile, "최고점수: %f\n", max);
	fprintf(outfile, "최저점수: %f\n", min);
	fprintf(outfile, "합계점수: %f\n", sum);
	fprintf(outfile, "평균점수: %f\n", mean);
	fprintf(outfile, "**************************\n");
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
