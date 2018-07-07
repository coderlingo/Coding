import java.util.*;

class Interval{
	int x,y;
	public Interval(int a,int b){
		this.x = a;
		this.y = b;
	}
	boolean compare(Interval a){
		if(a.x<this.x)
			return true;
		else
			return false;
	}
	void exchange(Interval obj1){
		int temp;
		temp = obj1.x;
		obj1.x = this.x;
		this.x = temp;
		temp = obj1.y;
		obj1.y = this.y;
		this.y = temp;
	}
	boolean check(Interval obj){
		if(this.y<obj.x)
			return true;
		else return false;
	}
	void print(){
		System.out.println("("+x+","+y+")");
	}
	int getx(){
		return x;
	}
	int gety(){
		return y;
	}
}

public class MaxOverlapPoint{
	void printList(ArrayList<Interval> list){
		int i;
		for(i=0;i<list.size();i++){
			list.get(i).print();
			System.out.println(" ");
		}
	}

	void sort(ArrayList<Interval> list){
		Interval obj1,obj2 ;
		int i,j;
		printList(list);
		for(i = 0;i < list.size();i++){
			for(j=0; j<=list.size()-i-2 ; j++){
				if (list.get(j).compare(list.get(j+1))){
					obj1 = list.get(j);
					obj2 = list.get(j+1);
					obj1.exchange(obj2);
				}
			}
		}
		printList(list);
	}
	void checkOverlap(ArrayList<Interval> list){
		int i;
		int flag =0;
		for(i =0;i<list.size()-1;i++){
			if(list.get(i).check(list.get(i+1))==false){
				System.out.println("Overlap exist");
				flag = 1;
				break;
			}

		}
		if (flag ==0){
			System.out.println("Overlap does not exist");
		}
	}
	public static void main(String[] args) {
		ArrayList<Interval>array = new ArrayList<Interval>();
		array.add(new Interval(1,4));
		array.add(new Interval(2,5));
		array.add(new Interval(10,12));
		array.add(new Interval(5,9));
		array.add(new Interval(5,12));
		MaxOverlapPoint obj = new MaxOverlapPoint();
		obj.sort(array);
		ArrayList<Integer> entry = new ArrayList<Integer>();
		ArrayList<Integer> exit = new ArrayList<Integer>();
		int i = 0;
		for(i=0;i<array.size();i++){
			entry.add(array.get(i).getx());
			exit.add(array.get(i).gety());
		}
		int j;
		i=0;
		j=0;
		int count = 0;
		int count_max = 0;
		int time = 0;
		while(i<array.size() && j<array.size()){
			if(entry.get(i)<=exit.get(j)){
				count++;
				if (count>count_max){
					count_max = count;
					time = entry.get(i);
				}
				i++;
			}
			else{
				count--;
				j++;
			}
		}
		System.out.println("the count is:"+count_max+"The point is:"+time);
	}
}


