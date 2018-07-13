import java.util.*;

class SubsequenceOccurrence{	
	public static int findSubsequenceCount(String S,String T){
		int m = T.length()+1;
		int n = S.length()+1;
		if( m == 0 )
			return 1;
		if( n == 0 )
			return 0;
		int[][] map = new int[m][n];
		int i,j;
		for(i=0;i<m;i++)
			map[i][0] = 0;
		for(j=0;j<n;j++)
			map[0][j] = 1;
  		for(i=1;i<m;i++){
  			for(j=1;j<n;j++){
  				if(S.charAt(j-1) == T.charAt(i-1)){
  					map[i][j] = map[i-1][j-1] + map[i][j-1] ;
  				}
  				else {
  					map[i][j] = map[i][j-1]; 	
  				}
  			}
  		}
		return map[i-1][j-1];		
	}
	public static void main(String[] args) {
			
			String T = "ge";
        	String S = "geeksforgeeks";
        	System.out.println(findSubsequenceCount(S, T));
		}	
}