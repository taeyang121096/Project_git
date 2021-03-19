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


	input_scores(score, n);
	max = max_score(score, n - 1);
	min = min_score(score, n - 1);
	sum = sum_scores(score, n - 1);
	mean = (float)sum / n;
	print_result(max, min, sum, mean);

	free(score);
}