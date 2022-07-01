

int add(int a, int b)
{
	return a + b;
}

int multiply(int a, int b)
{
	int i;
	int ret = 0;
	for (i = 0; i < a; ++i)
		ret = add(ret, b);
	return ret;
}


