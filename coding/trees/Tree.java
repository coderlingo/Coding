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
	void inOrder(Node cur){
		if(cur!=null){
			inOrder(cur.left);
			System.out.print(cur.val+"->");
			inOrder(cur.right);
		}
	}
	void postOrder(Node cur){
		if(cur!=null){
			postOrder(cur.left);
			postOrder(cur.right);
			System.out.print(cur.val+"->");
		}
	}
	void pre() {preOrder(root);}
	void post() {postOrder(root);}
	void in() {inOrder(root);}
	public static void main(String[] args) {
		Tree t = new Tree();
		t.root = new Node(1);
		t.root.left = new Node(2);
		t.root.right = new Node(3);
		t.root.left.right = new Node(4);
		t.root.right.left = new Node(5);
		System.out.println("The inorder traversal is:");
		t.in();
		System.out.println("\nThe preorder traversal is : ");
		t.pre();
		System.out.println("\nThe postOrder traversal is:");
		t.post();
	}
}