#include<stdio.h>
#include<stdlib.h>
float max = 0;
float min = 100;
float sum = 0;
void input_scores(float *score, int n)
{
	int c;
	printf("������ �Է��ϼ���.\n");
	for (c = 0; c < n; c++)
		scanf_s("%f", &score[c]);
}
void input_scores_file(FILE *infile, float *score, int n)
{
	int c;
	printf("������ �Է��ϼ���\n");
	for (c = 0; c < n; c++)
		fscanf_s(infile, "%f", &score[c]);
}
void print_scores(float *score, int n)
{
	int c;
	for (c = 0; c < n; c++)
		printf("%f\n", score[c]);
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
float sum_scores(float *score, int n)
{
	if (n < 0)return sum;
	sum += score[n];

	return sum_scores(score, n - 1);
}
void print_result(float max, float min, float sum, float mean)
{
	printf("**************************\n");
	printf("�ְ�����: %f\n", max);
	printf("��������: %f\n", min);
	printf("�հ�����: %f\n", sum);
	printf("�������: %f\n", mean);
	printf("**************************\n");
}
void save_result_file(FILE *outfile, float max, float min, float sum, float mean)
{
	fprintf(outfile, "**************************\n");
	fprintf(outfile, "�ְ�����: %f\n", max);
	fprintf(outfile, "��������: %f\n", min);
	fprintf(outfile, "�հ�����: %f\n", sum);
	fprintf(outfile, "�������: %f\n", mean);
	fprintf(outfile, "**************************\n");
}
