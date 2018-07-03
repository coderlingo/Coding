import java.util.*;

class PairDiffK{
	public void findPairs(ArrayList<Integer> array,int k,int i,int j){
		if(i>=j)
			return;
	    if (Math.abs(array.get(i)-array.get(j)) == k )
			System.out.println("Pair "+array.get(i)+" and "+array.get(j));
		this.findPairs(array,k,i+1,j);
		this.findPairs(array,k,i,j-1);
	}
	public static void main(String[] args) {
		ArrayList<Integer> array = new ArrayList<Integer>();
		array.add(1);
		array.add(5);
		array.add(3);
		array.add(4);
		array.add(2);
		int k = 3;
		Collections.sort(array);
		PairDiffK obj = new PairDiffK();
		obj.findPairs(array,k,0,array.size()-1);
	}
}