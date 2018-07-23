import java.util.*;

class Node{
	int val;
	Node left,right;
	Node(int a){
		val = a;
	}
}
class Tree{
	Node root;
	Tree(){
		root = null;
	}
	void preOrder(Node cur){
		if(cur != null){
			System.out.print(cur.val+"->");
			preOrder(cur.left);
			preOrder(cur.right);
		}
	}
	ArrayList<Tree> allTrees(ArrayList<Integer> inOrder, int start, int end){
		ArrayList<Tree> list = new ArrayList<Tree>();
		if (start>end){
			Tree t = new Tree();
			list.add(t);
			return list;
		}
		if(start == end){
			Tree t = new Tree();
			t.root = new Node(inOrder.get(start));
			list.add(t);
			return list;
		}
		int i;
		for(i=start;i<=end;i++){
			ArrayList<Tree> llist = allTrees(inOrder,start,i-1);
			ArrayList<Tree> rlist = allTrees(inOrder,i+1,end);
			Node n = new Node(inOrder.get(i));
			int j,k;
			for(j=0;j<llist.size();j++){
				n.left = llist.get(j).root;
				for(k=0;k<rlist.size();k++){
					n.right = rlist.get(k).root;
					Tree t = new Tree();
					t.root = n;
					list.add(t);
				}
			}
		}
		return list;
	}
	void pre() {preOrder(root);}
}
class AllPossibleBST{
	public static void main(String[] args) {
		ArrayList<Integer> inOrder = new ArrayList<Integer> ();
		inOrder.add(4);
		inOrder.add(5);
		inOrder.add(7);
		int i;
		ArrayList<Tree> trees = new ArrayList<Tree>();
		Tree t = new Tree();
		trees = t.allTrees(inOrder,0,inOrder.size()-1);
		System.out.print("Number of trees:"+trees.size());
		for(i=0;i<trees.size();i++){
			System.out.print("\n");
			trees.get(i).pre();
		}
	}
}