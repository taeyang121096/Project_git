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


	input_scores(score, n);
	max = max_score(score, n - 1);
	min = min_score(score, n - 1);
	sum = sum_scores(score, n - 1);
	mean = (float)sum / n;
	print_result(max, min, sum, mean);

	free(score);
}