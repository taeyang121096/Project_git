#include<stdio.h>

int main()
{
	int n, c;
	float score[30];
	float max, min, sum, mean;

	printf("학생수?");
	scanf_s("%d", &n);

	printf("점수를 입력하세요.\n");

	for (c = 0; c < n; c++) {
		scanf_s("%f", &score[c]);
	}
	max = 0; min = 100; sum = 0; mean = 0;

	for (c = 0; c < n; c++) {
		if (max < score[c])
			max = score[c];
		else if (min > score[c])
			min = score[c];
		sum += score[c];
	}

	mean = (float)sum / c;

	printf("**************************\n");
	printf("최고점수: %f\n", max);
	printf("최저점수: %f\n", min);
	printf("합계점수: %f\n", sum);
	printf("평균점수: %f\n", mean);
	printf("**************************\n");

}