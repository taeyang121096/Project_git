#define _CRT_SECURE_NO_WARNINGS
#include "mylib.h"

int main()
{
	int n;
	float *score;
	float max, min, sum, mean;
	FILE *infile, *outfile;

	printf("학생수?");
	scanf_s("%d", &n);

	score = (float*)malloc(n * sizeof(float));
	if (score == NULL)
	{
		printf("에러:동적 메모리 할당 실패!!!\n\n");
		return 0;
	}

	infile = (FILE*)fopen("score.txt", "r");
	if (infile == NULL)
	{
		printf("에러 : 입력 파일을 열 수 없음!!!\n\n");
		return 0;
	}
	input_scores_file(infile, score, n);
	print_scores(score, n);
	fclose(infile);

	max = max_score(score, n - 1);
	min = min_score(score, n - 1);
	sum = sum_scores(score, n - 1);
	mean = (float)sum / n;
	print_result(max, min, sum, mean);

	outfile = (FILE*)fopen("result.txt", "w");
	if (outfile == NULL)
	{
		printf("에러: 출력 파일을 열 수 없음!!!\n\n");
		return 0;
	}
	save_result_file(outfile, max, min, sum, mean);
	fclose(outfile);

	free(score);

}