#include <cstdlib>

// File:        sorting.cpp
// Author:      Geoffrey Tien
//              (your name)
// Date:        2016-02-08
// Description: Skeleton file for CMPT 225 assignment #3 sorting functions and helpers
//              Function bodies to be completed by you!

// Complete your sorting algorithm function implementations here

// Selection Sort
/*
	Look through entire arr for minimum value, at the end place the minimum at start of arr
	do this for all values of the arr to ensure for sorted array

	return count
*/
template <class T>
int SelectionSort(T arr[], int n)
{
	int count = 0; // counter for barometer operations

	for (int i = 0; i < n - 1; i++)
	{
		int smallest = i;

		for (int j = i + 1; j < n; j++)
		{
			count += 1; // Compare j to length
			count += 1; // Increment j

			if (arr[j] < arr[smallest])
			{
				count += 1; // Compare j to smallest
				smallest = j;
				count += 1; // Change Smallest
			}
		}

		count += 1;
		T temp = arr[i];
		arr[i] = arr[smallest];
		arr[smallest] = temp;
	}

  return count;
}

// Quicksort
/*
	Partition the arr into right and left where right is higher than the pivot and left is lower, 
	while you partition up to 1 cell left in the array, you sort the arrays as they get smaller,
	once you have fully gone through entire arr, arr will be sorted

	return count
*/
template <class T>
int Quicksort(T arr[], int n)
{
  int count = 0;
  QuicksortHelper(arr, 0, n - 1, count);
  return count;
}

template <class T>
void QuicksortHelper(T arr[], int low, int high, int& counter)
{
	if (low < high)
	{
		counter++; // change pivot
		int pivot = QSPartition(arr, low, high, counter);
		QuicksortHelper(arr, low, pivot, counter);
		QuicksortHelper(arr, pivot + 1, high, counter);
	}
}

template <class T>
int QSPartition(T arr[], int low, int high, int& counter)
{
	int pivotindex = low;

	int i = low;
	int j = high;

	while (true)
	{

		while (arr[i] < arr[pivotindex])
		{
			counter++; // compare i to pivot
			i += 1;
			counter++; // increment i
		}
		
		while (arr[j] > arr[pivotindex])
		{
			counter++; // compare j to pivot
			j -= 1;
			counter++; // decrement j
		}

		if (i >= j)
			return pivotindex;

		T temp = arr[i];
		arr[i] = arr[j];
		arr[j] = temp;

	}

	return 0;
}

// Randomized Quicksort
/*
	Selete a random value from the array to place at the arr[low] and then 
	proceed with standard quicksorting.

	return count
*/
template <class T>
int RQuicksort(T arr[], int n)
{
  int count = 0;
  RQuicksortHelper(arr, 0, n - 1, count);
  return count;
}

template <class T>
void RQuicksortHelper(T arr[], int low, int high, int& counter)
{
	if (low < high)
	{
		counter++; // change pivot
		int pivot = RQSPartition(arr, low, high, counter);
		RQuicksortHelper(arr, low, pivot, counter);
		RQuicksortHelper(arr, pivot + 1, high, counter);
	}
}

template <class T>
int RQSPartition(T arr[], int low, int high, int& counter)
{
	counter++; // change pivot randomly
	int pivotindex = low + rand() % (high - low + 1);
	T temp = arr[pivotindex];
	arr[pivotindex] = arr[low];
	arr[low] = temp;

	pivotindex = low;

	int i = low;
	int j = high;

	while (true)
	{

		while (arr[i] < arr[pivotindex])
		{
			counter++; // compare i to pivot
			i += 1;
			counter++; // increment i
		}

		while (arr[j] > arr[pivotindex])
		{
			counter++; // compare j to pivot
			j -= 1;
			counter++; // decrement j
		}

		if (i >= j)
			return pivotindex;

		T temp = arr[i];
		arr[i] = arr[j];
		arr[j] = temp;

	}

	return 0;
}

// Mergesort
/*
	Break arr into sets of 1 then in a new array pull everything back sorted and then 
	place back into arr

	return count
*/
template <class T>
int Mergesort(T arr[], int n)
{
  int count = 0;

  MergesortHelper(arr, 0, n - 1, n, count);

  return count;
}

template <class T>
void MergesortHelper(T arr[], int low, int high, int n, int& counter)
{
	if (low < high)
	{
		int mid = (low + high) / 2; 
		counter++;// Change mid

		MergesortHelper(arr, low, mid, n, counter);

		MergesortHelper(arr, mid + 1, high, n, counter);

		Merge(arr, low, mid, high, n, counter);
	}
}

template <class T>
void Merge(T arr[], int low, int mid, int high, int n, int& counter)
{
	
	T *temp = new T[high - low + 1];

	int left = low;
	int right = mid + 1;
	int current = 0;

	while (left <= mid && right <= high)
	{
		if (arr[left] < arr[right])
		{
			counter++; // compare left to right
			temp[current] = arr[left];
			left++;
			counter++;// increment left
		}
		else // if (arr[left] > arr[right])
		{
			counter++; // compare right to left
			temp[current] = arr[right];
			right++;
			counter++; // increment right
		}
		current++;
	}

	if (left > mid)
	{
		for (int i = right; i <= high; i++)
		{
			temp[current] = arr[i];
			current++;
		}
	}
	else
	{
		for (int i = left; i <= mid; i++)
		{
			temp[current] = arr[i];
			current++;
		}
	}

	for (int i = 0; i <= high - low; i++)
	{
		arr[i + low] = temp[i];
	}

	delete[] temp;
}

// Shell Sort
/*
	Move through arr halving the value step each time while swapping elements while needed
	until step at been completely depleted

	return count
*/
template <class T>
int ShellSort(T arr[], int n)
{
	int count = 0;

	int i, j;
	int step = n / 2;
	T temp;
	while (step)
	{
		for (i = step; i < n; i++)
		{
			count++; // compare i to length
			temp = arr[i];
			j = i;
			while (j >= step && arr[j - step] > temp)
			{
				count++; // compare j to smallest
				arr[j] = arr[j - step];

				count++; // change smallest

				j -= step;
				count++; // increment j
			}
			arr[j] = temp;
		}

		step = step / 2;
	}

	return count;
}