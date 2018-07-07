import java.util.*;
class TwoSwappedInSortedList{
	public static void findSwapped(ArrayList<Integer> array){
		int i,j;
		i=0;
		j=array.size()-1;
		while(array.get(i)<array.get(i+1))
			i++;
		while(array.get(j)>array.get(j-1))
			j--;
		System.out.println("The swapped positions are:"+i+","+j);
	}
	public static void main(String[] args) {
		ArrayList<Integer> array = new ArrayList<Integer>();
		array.add(70);
		array.add(20);
		array.add(30);
		array.add(40);
		array.add(50);
		array.add(60);
		array.add(10);
		System.out.println(array);
		findSwapped(array);
	}
}