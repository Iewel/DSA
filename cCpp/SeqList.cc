#include<iostream>
using namespace std;

#define InitSize 10
#define ElemType int

typedef struct {
	ElemType *data;
	int len, MaxSize;
}SeqList;

bool InitList(SeqList *L){
	L->data=(ElemType*)malloc(sizeof(ElemType));
	if(!L->data){
		cout << "Init List Failed!" << endl;
		return false;
	}else{
		L->len=0;
		L->MaxSize=InitSize;
		cout << "Init List Success!" << endl;
		return true;
	}
}

void ShowList(SeqList L){
	if(L.len==0){
		cout << "Empty List" << endl;
		return;
	}
	cout << "-----List Show-----" << endl;
	for(int i=0; i<L.len; i++)
		cout << "List[" << i+1 << "]=" << L.data[i] << endl;
	cout << "--------End--------" << endl;
}

bool InsertList(SeqList *L, int i, ElemType e){
	if(i<1 || i>L->MaxSize)
		cout << "Insert Failed. Out of range" << endl;
	for(int j=L->len; j>i; j--)
		L->data[j] = L->data[j-1];
	L->data[i-1]=e;
	L->len+=1;
	cout << "Insert " << e << " to List[" << i << "] Success!" << endl;
	return true;
}

bool ListDelete(SeqList *L, int i, ElemType &e){
	if(i<1 || i>L->len){
		cout << "Delete Failed. Out of range" << endl;
		return false;
	}
	e=L->data[i-1];
	cout << "Delete List[" << i << "]="<< e << " Success. "<< endl;
	for(int j=i-1; j<L->len-1;j++)
		L->data[j]=L->data[j-1];
	L->len-=1;
	return true;
}

int ElemLocate(SeqList L, ElemType e){
	for (int i = 0; i < L.len; ++i)
		if(L.data[i]==e)
			return i+1;
	return -1;
}

int main(){
	cout << "------SeqList------" << endl;
	SeqList L;
	InitList(&L);
	for (int i = 1; i < 6; ++i)
		if(!InsertList(&L, i, 2*i+1))
			cout << "Something Wrong!" << endl;
	ShowList(L);
	ElemType delVal;
	ListDelete(&L,5, delVal);
	ShowList(L);
	int loc=ElemLocate(L, 7);
	if(loc!=-1)
		cout << "Elem 7 is List[" << loc << "]."<< endl;
	else
		cout << "Elem 7 is not in List." << endl;
	return 0;
}