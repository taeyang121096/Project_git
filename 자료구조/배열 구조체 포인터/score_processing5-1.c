#define _CRT_SECURE_NO_WARNINGS
#include "mylib.h"

int main()
{
	int n;
	float *score;
	float max, min, sum, mean;
	FILE *infile, *outfile;

	printf("�л���?");
	scanf_s("%d", &n);

	score = (float*)malloc(n * sizeof(float));
	if (score == NULL)
	{
		printf("����:���� �޸� �Ҵ� ����!!!\n\n");
		return 0;
	}

	infile = (FILE*)fopen("score.txt", "r");
	if (infile == NULL)
	{
		printf("���� : �Է� ������ �� �� ����!!!\n\n");
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
		printf("����: ��� ������ �� �� ����!!!\n\n");
		return 0;
	}
	save_result_file(outfile, max, min, sum, mean);
	fclose(outfile);

	free(score);

}