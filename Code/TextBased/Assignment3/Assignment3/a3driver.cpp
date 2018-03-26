#include <string>
#include <stdexcept>
#include <iostream>
#include <fstream>

using namespace std;

const int SELECTION = 0;
const int QUICK = 1;
const int RQUICK = 2;
const int MERGE = 3;
const int SHELL = 4;

// FUNCTION PROTOTYPES
template <class T>
T* ReadFile(string infile, int& n);

template <class T>
bool Sorted(T arr[], int n);

template <class T>
bool Contains(T arr1[], T arr2[], int n);

template <class T>
bool Search(T arr[], int n, T target);

template <class T>
void SortTestResult(T arr[], int n, int sort);

void SelSTest();
void QSTest();
void RQSTest();
void MSTest();
void ShSTest();

// Sorting function and helper function prototypes
// Implementations to be completed in sorting.cpp
template <class T>
int SelectionSort(T arr[], int n);

template <class T>
int Quicksort(T arr[], int n);
template <class T>
void QuicksortHelper(T arr[], int low, int high, int& counter);
template <class T>
int QSPartition(T arr[], int low, int high, int& counter);

template <class T>
int RQuicksort(T arr[], int n);
template <class T>
void RQuicksortHelper(T arr[], int low, int high, int& counter);
template <class T>
int RQSPartition(T arr[], int low, int high, int& counter);

template <class T>
int Mergesort(T arr[], int n);
template <class T>
void MergesortHelper(T arr[], int low, int high, int n, int& counter);
template <class T>
void Merge(T arr[], int low, int mid, int high, int n, int& counter);

template <class T>
int ShellSort(T arr[], int n);

#include "sorting.cpp"

// Main function
int main()
{
  string input;
  // insert your own testing code here if necessary
  
  SelSTest();
  QSTest();
  RQSTest();
  MSTest();
  ShSTest();
  
  cout << endl;
  system("pause");
  return 0;
}

// FUNCTION IMPLEMENTATIONS

// Tests the SelectionSort function
void SelSTest()
{
  try
  {
    cout << "SELECTION SORT" << endl << "--------------" << endl;
    int n = 0;
    int* arr1 = ReadFile<int>("test1.txt", n);
    SortTestResult(arr1, n, SELECTION);
    float* arr2 = ReadFile<float>("test2.txt", n);
    SortTestResult(arr2, n, SELECTION);
    string* arr3 = ReadFile<string>("test3.txt", n);
    SortTestResult(arr3, n, SELECTION);
    int* arr4 = ReadFile<int>("test4.txt", n);
    SortTestResult(arr4, n, SELECTION);
    cout << endl;
  }
  catch (exception e)
  {
    cout << e.what() << endl;
  }
}

// Tests the Quicksort function
void QSTest()
{
  try
  {
    cout << "QUICKSORT" << endl << "---------" << endl;
    int n = 0;
    int* arr1 = ReadFile<int>("test1.txt", n);
    SortTestResult(arr1, n, QUICK);
    float* arr2 = ReadFile<float>("test2.txt", n);
    SortTestResult(arr2, n, QUICK);
    string* arr3 = ReadFile<string>("test3.txt", n);
    SortTestResult(arr3, n, QUICK);
    int* arr4 = ReadFile<int>("test4.txt", n);
    SortTestResult(arr4, n, QUICK);
    cout << endl;
  }
  catch (exception e)
  {
    cout << e.what() << endl;
  }
}

// Tests the Randomized Quicksort function
void RQSTest()
{
  try
  {
    cout << "RANDOMIZED QUICKSORT" << endl << "--------------------" << endl;
    int n = 0;
    int* arr1 = ReadFile<int>("test1.txt", n);
    SortTestResult(arr1, n, RQUICK);
    float* arr2 = ReadFile<float>("test2.txt", n);
    SortTestResult(arr2, n, RQUICK);
    string* arr3 = ReadFile<string>("test3.txt", n);
    SortTestResult(arr3, n, RQUICK);
    int* arr4 = ReadFile<int>("test4.txt", n);
    SortTestResult(arr4, n, RQUICK);
    cout << endl;
  }
  catch (exception e)
  {
    cout << e.what() << endl;
  }
}

// Tests the Mrgesort function
void MSTest()
{
  try
  {
    cout << "MERGESORT" << endl << "---------" << endl;
    int n = 0;
    int* arr1 = ReadFile<int>("test1.txt", n);
    SortTestResult(arr1, n, MERGE);
    float* arr2 = ReadFile<float>("test2.txt", n);
    SortTestResult(arr2, n, MERGE);
    string* arr3 = ReadFile<string>("test3.txt", n);
    SortTestResult(arr3, n, MERGE);
    int* arr4 = ReadFile<int>("test4.txt", n);
    SortTestResult(arr4, n, MERGE);
    cout << endl;
  }
  catch (exception e)
  {
    cout << e.what() << endl;
  }
}

// Tests the shellsort function
void ShSTest()
{
  try
  {
    cout << "SHELL SORT" << endl << "----------" << endl;
    int n = 0;
    int* arr1 = ReadFile<int>("test1.txt", n);
    SortTestResult(arr1, n, SHELL);
    float* arr2 = ReadFile<float>("test2.txt", n);
    SortTestResult(arr2, n, SHELL);
    string* arr3 = ReadFile<string>("test3.txt", n);
    SortTestResult(arr3, n, SHELL);
    int* arr4 = ReadFile<int>("test4.txt", n);
    SortTestResult(arr4, n, SHELL);
    cout << endl;
  }
  catch (exception e)
  {
    cout << e.what() << endl;
  }
}

// Tests that array is correctly sorted
template <class T>
void SortTestResult(T arr[], int n, int sort)
{
  T* arrcopy = new T[n];
  for (int i = 0; i < n; i++)
  {
    arrcopy[i] = arr[i];
  }

  cout << "n = " << n;
  if (sort == SELECTION)
  {
    cout << ", comparisons = " << SelectionSort(arr, n);
  }
  else if (sort == QUICK)
  {
    cout << ", comparisons = " << Quicksort(arr, n);
  }
  else if (sort == RQUICK)
  {
    cout << ", comparisons = " << RQuicksort(arr, n);
  }
  else if (sort == MERGE)
  {
    cout << ", comparisons = " << Mergesort(arr, n);
  }
  else if (sort == SHELL)
  {
    cout << ", comparisons = " << ShellSort(arr, n);
  }
  cout <<", values = " << Contains(arr, arrcopy, n);
  cout <<", sorted = " << Sorted(arr, n) << endl;

  delete[] arr;
  delete[] arrcopy;
}

// Opens a file and reads the contents into an array
// PARAM: infile = name of the file to be opened
//        n = the size of the result array
// PRE: the file contains values separated by white space
// POST: returns an array containing the contents of infile
template <class T>
T* ReadFile(string infile, int& n)
{
  T* result;
  T next;
  n = 0;

  ifstream ist(infile.c_str()); // open file
  // Check if file opened correctly
  if(ist.fail())
    throw runtime_error(infile + " not found");

  // Find file size
  while(ist >> next)
  {
    n++;
  }

  // Read file into array
  ist.close();
  ist.open(infile.c_str());
  result = new T[n];
  for (int i = 0; i < n; i++)
  {
    ist >> result[i];
  }

  ist.close();

  return result;
}

// Checks to see if the input array is in ascending order
// PARAM: arr = name of the array
//        n = size of arr
// PRE:
// POST: returns true iff arr is in ascending order
template <class T>
bool Sorted(T arr[], int n)
{
  // Check to see each element i <= element i+1
  for(int i = 0; i < n-1; i++)
  {
    if (arr[i] > arr[i+1])
    {
      return false;
    }
  }
  return true;
}

// Checks to see if the two arrays contain the same values
// PARAM: arr1, arr2 = name of the arrays
//        n = size of both arrays
// PRE: arr1 and arr2 are the same size, arr1 is sorted
// POST: returns true iff arr1 contains all values in arr2
template <class T>
bool Contains(T arr1[], T arr2[], int n)
{
  // Check to see each element of arr2 is in arr1
  for (int i = 0; i < n; i++)
  {
    if (!Search(arr1, n, arr2[i]))
    {
      return false;
    }
  }
  return true;
}

// Checks to see if target value is in array
// PARAM: arr = array to be searched
//        n = size of array
//        target =  value to be searched for
// PRE: arr is sorted
// POST: returns true iff target is in arr
template <class T>
bool Search(T arr[], int n, T target)
{
  int low = 0;
  int high = n-1;
  int mid = 0;

  while (low <= high)
  {
    mid = (low + high) / 2;
    if (arr[mid] == target)
    {
      return true;
    }
    else if (target < arr[mid])
    {
      high = mid - 1;
    }
    else
    {
      low = mid + 1;
    }
  }
  return false;
}