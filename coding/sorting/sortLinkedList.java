import java.util.*;

public class sortLinkedList {
       public void sort(LinkedList<Integer> obj) {
             int count0=0;
	     int count1=0;
	     int count2=0;
	     int i=0;
	     System.out.println("size:"+obj.size());
             for(i =0; i < obj.size();i++) {
		     int val = obj.get(i);
		     System.out.println("val:"+val);
		     if(val == 0) 
			     count0 += 1;
		     if(val == 1)
			     count1 += 1;
		     if(val == 2)
			     count2 +=1;
	     }
	     System.out.println("count0 :"+count0+" count1: "+count1+ " count2: "+count2); 
             for(i = 0;i<count0;i++)
		     obj.set(i,0);
             for(;i<count1+count0;i++)
		     obj.set(i,1);
	     for(;i<count2+count0+count1;i++)
		     obj.set(i,2);
       }	       
       public static void main( String args[]) {
             LinkedList<Integer> list = new LinkedList<Integer>();
             list.add(1);
             list.add(2);
             list.add(0);
             list.add(2);
             list.add(1);
             list.add(1);
             list.add(2);
             list.add(1);
             list.add(2);	     
       	     System.out.println("Linked list before sorting" + list);
             sortLinkedList d = new sortLinkedList();    
	     d.sort(list);
             System.out.println("linked list after sorting" + list);
       }
}
