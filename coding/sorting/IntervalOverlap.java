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
}

public class IntervalOverlap{
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
		array.add(new Interval(1,3));
		array.add(new Interval(7,9));
		array.add(new Interval(4,6));
		array.add(new Interval(10,13));
		IntervalOverlap obj = new IntervalOverlap();
		obj.sort(array);
		System.out.println("the Intervals overlap?");
		obj.checkOverlap(array);
		ArrayList<Interval>array1 = new ArrayList<Interval>();
		array1.add(new Interval(6,8));
		array1.add(new Interval(1,3));
		array1.add(new Interval(2,4));
		array1.add(new Interval(4,7));
		IntervalOverlap obj1 = new IntervalOverlap();
		obj1.sort(array1);
		System.out.println("the Intervals overlap?");
		obj1.checkOverlap(array1);
	}
}

