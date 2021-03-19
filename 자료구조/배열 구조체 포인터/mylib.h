#pragma once
#include<stdio.h>
#include<stdlib.h>
void input_scores(float *score, int n);
void input_scores_file(FILE *infile, float *score, int n);
void print_scores(float *score, int);
float max_score(float *score, int n);
float min_score(float *score, int n);
float sum_scores(float *score, int n);
void print_result(float max, float min, float sum, float mean);
void save_result_file(FILE *outfile, float max, float min, float sum, float mean);
