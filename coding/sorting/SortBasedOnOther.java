import java.util.*;

class SortBasedOnOther {
	public static ArrayList<Integer> sort(ArrayList<Integer> list1,ArrayList<Integer> list2){
		HashMap<Integer,Integer> map = new HashMap<>();
		int i = 0;
		for (;i<list2.size();i++){
			map.put(list2.get(i),0);
		}
		ArrayList<Integer> list = new ArrayList<Integer>();
		for (i=0;i<list1.size();i++){
			if(map.containsKey(list1.get(i))){
				map.put(list1.get(i),map.get(list1.get(i))+1);
			}
			else{
				list.add(list1.get(i));
			}
		}
		Collections.sort(list);
		int j = 0;
		for(i=0;i<list2.size();i++){
			int count = map.get(list2.get(i));
			for(;count > 0;count--){
				list1.set(j++,list2.get(i));
			}
		}
		for(i=0;i<list.size();i++){
			list1.set(j++,list.get(i));
		}
		return list1;
	}
	public static void main(String[] args) {
		ArrayList<Integer> list1 = new ArrayList<Integer>();
		ArrayList<Integer> list2 = new ArrayList<Integer>();
		list1.add(2);
		list1.add(1);
		list1.add(2);
		list1.add(5);
		list1.add(7);
		list1.add(1);
		list1.add(9);
		list1.add(3);
		list1.add(6);
		list1.add(8);
		list1.add(8);
		list2.add(2);
		list2.add(1);
		list2.add(8);
		list2.add(3);
		System.out.println("sorted list is:"+sort(list1,list2)); 	
	}
}