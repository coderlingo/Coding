import java.util.*;

class ElementsBetweenRange{
	public void heapify(int index, ArrayList<Integer> list, int size){
		int min = index;
		int lChild = index*2+1;
		int rChild = index*2+2;
		if(lChild <= size && list.get(min)>list.get(lChild)){
			min = lChild;
		}
		if(rChild <= size && list.get(min)> list.get(rChild)){
			min = rChild;
		}
		if(min != index){
			int temp = list.get(index);
			list.set(index,list.get(min));
			list.set(min,temp);
			heapify(min,list,size);
		}

	}
	public void buildHeap(ArrayList<Integer> list){
		System.out.println("Array before buildHeap:"+list);
		int i;
		int n = (list.size()-1);
		for(i=n/2;i>=0;i--){
			heapify(i,list,n);
			System.out.println("Array step "+ i+ " buildHeap:"+list);
		}
		System.out.println("Array after buildHeap:"+list);
	}
	public int heapSort(ArrayList<Integer> list, int n){
		int temp = list.get(0);
		list.remove(0);
		heapify(0,list,n-1);
		return temp;
	}
	public int getElements(ArrayList<Integer> list, int k1, int k2){
		buildHeap(list);
		int n = list.size()-1;
		int k = k1;
		while(k>0){
			int temp = heapSort(list,n);
			n = n-1;
			k -= 1;
		}
		int sum = 0;
		while(k1<k2-1){
			sum = sum + heapSort(list,n);
			n = n-1;
			k1 = k1+1;
		}
		return sum;
	}
	public static void main(String[] args) {
		ArrayList<Integer> list = new ArrayList<Integer>();
		list.add(20);
		list.add(8);
		list.add(22);
		list.add(4);
		list.add(12);
		list.add(10);
		list.add(14);
		int k1 = 3;
		int k2 = 6;
		ElementsBetweenRange obj = new ElementsBetweenRange();
		System.out.println("The elements between "+k1+" and "+k2+" are:"+obj.getElements(list,k1,k2));
	}
}