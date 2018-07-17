import java.util.*;

class NextGreaterElement{
	public static Stack<Integer> elements(ArrayList<Integer> list){
		Stack<Integer> stack = new Stack<Integer> ();
		Stack<Integer> out = new Stack<Integer>();
		int i = list.size()-1;
		stack.push(i);
		out.push(-1);
		i = i-1;
		while(i>=0){
			System.out.println(i);
			while(!stack.empty() && list.get(stack.peek())<=list.get(i)){
				System.out.println(stack);
				stack.pop();
			}
			if(stack.empty()){
				out.push(-1);	
			}
			else{
				out.push(list.get(stack.peek()));
			}
			stack.push(i);
			i = i-1;
		}
		return out;
	}
	public static void main(String[] args) {
		ArrayList<Integer> list = new ArrayList<Integer> ();
		list.add(11);
		list.add(13);
		list.add(21);
		list.add(3);
		System.out.println("The next greatest elements(in reverse) are: "+ elements(list));
	}
}