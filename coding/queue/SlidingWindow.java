import java.util.*;

class SlidingWindow{
	public static ArrayList<Integer> maxElements(ArrayList<Integer> list, int k){
		Deque<Integer> q = new LinkedList<Integer>();
		ArrayList<Integer> array = new ArrayList<Integer>();
		int i = 0;
		for(;i<k;i++){
			while(!q.isEmpty() && list.get(i)>= list.get(q.peekLast())){
				q.removeLast();
			}
			q.addFirst(i);
		}	
		System.out.println(list.size());
		for(;i<list.size();i++){
			System.out.println("queue:"+q+" i:"+list.get(i));
			array.add(list.get(q.peek()));
			if(i-q.peek()+1 > k){
				q.removeFirst();
			}			
			while(!q.isEmpty() && list.get(q.peekLast()) < list.get(i)){
				q.removeLast();
			}
			q.addLast(i);
		}
		array.add(list.get(q.pop()));
		return array;
	}
	public static void main(String[] args) {
		ArrayList<Integer>  list = new ArrayList<Integer>();
		list.add(12);
		list.add(1);
		list.add(78);
		list.add(90);
		list.add(57);
		list.add(89);
		list.add(56);
		int k = 3;
		System.out.println("The list of max elements for each window is : " + maxElements(list,k));
	}
}