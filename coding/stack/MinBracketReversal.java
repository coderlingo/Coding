import java.util.*;

class MinBracketReversal{
	public static int minReversal(String str){
		int i=0;
		int m = 0;
		int n = 0;
		Stack<Integer> stack = new Stack<Integer>();
		for(;i<str.length();i++){
			if(str.charAt(i) == '{'){
				stack.push(i);
			}
			else{
				if(stack.empty()){
					m++;
				}
				else{
					stack.pop();
				}
			}
		}
		n = stack.size();
		System.out.println(n);
		System.out.println(m);
		return (m+n)/2 + n%2;
	}
	public static void main(String[] args) {
		String str = "}{{}}{{{";
		System.out.println("The num number of brackets to reverse are :"+minReversal(str));
	}
}