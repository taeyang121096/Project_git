#include<stdio.h>

int main()
{
	int n, c;
	float score[30];
	float max, min, sum, mean;

	printf("�л���?");
	scanf_s("%d", &n);

	printf("������ �Է��ϼ���.\n");

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
	printf("�ְ�����: %f\n", max);
	printf("��������: %f\n", min);
	printf("�հ�����: %f\n", sum);
	printf("�������: %f\n", mean);
	printf("**************************\n");

}