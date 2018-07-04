import java.util.*;

class WaveSort{
	public static ArrayList<Integer> sort(ArrayList<Integer> array){
		int i = 1;
		for (;i<array.size();i++){
			if(i%2 !=0){
				if (array.get(i-1)<array.get(i)){
					int temp = array.get(i);
					array.set(i,array.get(i-1));
					array.set(i-1,temp);
				}
			}
			else{
				if (array.get(i-1)>array.get(i)){
					int temp = array.get(i);
					array.set(i,array.get(i-1));
					array.set(i-1,temp);
				}
			}
		}
		return array;
	}
	public static void main(String[] args) {
		ArrayList<Integer> array = new ArrayList<Integer>();
		array.add(10);
		array.add(90);
		array.add(49);
		array.add(2);
		array.add(1);
		array.add(5);
		array.add(23);
		System.out.println("The sorted array is: "+ sort(array));
	}
}