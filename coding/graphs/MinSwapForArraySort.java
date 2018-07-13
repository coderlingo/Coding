import java.util.*;

class Pair{
	int a,b;
	Pair(int p, int q){
		a = p;
		b = q;
	}
}
class MinSwapForArraySort{
	public static int findSwaps(ArrayList<Integer> list){
		ArrayList<Pair> pairList = new ArrayList<Pair>();
		int i = 0;
		for(i=0;i<list.size();i++){
			pairList.add(new Pair(list.get(i),i));
		}
		for(i=0;i<pairList.size();i++){
			System.out.println("<"+pairList.get(i).a+","+pairList.get(i).b+">");
		}
		Collections.sort(pairList,new Comparator<Pair>(){
			public int compare(Pair o1,Pair o2){
				if(o1.a<o2.a)
					return -1;
				if(o1.a>o2.a)
					return 1;
				else return 0;
			}
		});
		for(i=0;i<pairList.size();i++){
			System.out.println("<"+pairList.get(i).a+","+pairList.get(i).b+">");
		}
		int visited[] = new int[list.size()];
		for(i=0;i<list.size();i++){
			visited[i] = 0;
		}
		int swap = 0;
		for(i=0;i<list.size();i++){
			int cycle = 0;
			int j = i;
			while(visited[j]!=1){
				cycle = cycle+1;
				visited[j] = 1;
				j = pairList.get(j).b;
			}
			swap = swap + cycle - 1 ;
		}
		return swap;
	}
	public static void main(String[] args) {
		ArrayList<Integer> list = new ArrayList<Integer>();
		list.add(1);
		list.add(5);
		list.add(4);
		list.add(3);
		list.add(2);
		System.out.println("The min number of swaps:" + findSwaps(list));
	}
}