import java.util.*;

class StockPrices{
	public static ArrayList<Integer> stockPlan(ArrayList<Integer> list){
		ArrayList<Integer> sp = new ArrayList<Integer>();
		sp.add(1);
		Stack<Integer> stack = new Stack<Integer> ();
		stack.push(0);
		int i = 1;
		int n = list.size();
		while(i<n){
			System.out.println(i);
			while(!stack.empty() && list.get(i)>=list.get(stack.peek())){
				stack.pop();
				System.out.println("pop "+stack);
			}
			
			System.out.println("push "+stack);
			if (stack.empty()){
				sp.add(i+1);				
			}
			else{
				sp.add(i-stack.peek());
			}
			stack.push(i);
			i++;
		}
		return sp;
	}
	public static void main(String[] args) {
		ArrayList<Integer> list = new ArrayList<Integer> ();
		list.add(10);
		list.add(4);
		list.add(5);
		list.add(90);
		list.add(120);
		list.add(80);
		System.out.println("The stock span list is:"+list+ stockPlan(list));
	}
}