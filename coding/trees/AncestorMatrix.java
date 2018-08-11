import java.util.*;

class Node {
	int val;
	Node left;
	Node right;
	public Node(int value){
		val = value;
		left = null;
		right = null;
	}
}
class Tree{
	Node root;
	static List<List<Integer>> m = new ArrayList<List<Integer>>();
	Tree(Node r, int size){
		root = r;
		int i;
		for (i=0;i<size;i++){
			ArrayList<Integer> l = new ArrayList<Integer>();
			m.add(l);
		}
	}
	void ancestorMatrix(Node n, int prev){
		if (n==null){
			return;
		}
		if(prev != -1){
			m.get(n.val).addAll(m.get(prev));
			m.get(n.val).add(prev);
		}
		ancestorMatrix(n.left,n.val);
		ancestorMatrix(n.right,n.val);
	}
	void printAncestor(){
		int i,j;
		for(i =0;i<m.size();i++){
			List<Integer> l = m.get(i);
			System.out.print("[");
			for(j=0;j<l.size();j++){
				System.out.print(" "+l.get(j));
			}
			System.out.println(" ]");
		}
	}
}
class AncestorMatrix{
	public static void main(String[] args) {
		Node root = new Node(5);
		Tree t = new Tree(root,6);
		t.root.left = new Node(1);
		t.root.right = new Node(2);
		t.root.left.left = new Node(0);
		t.root.left.right = new Node(4);
		t.root.right.left = new Node(3);
		t.ancestorMatrix(root,-1);
		t.printAncestor();
	}
}