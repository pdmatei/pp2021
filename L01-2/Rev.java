public class Rev {
	public static void show (Integer[] v){
		for (Integer i:v)
			System.out.println(i);
	}
	public static void main (String[] args) {
		Integer[] v = new Integer[] {1,2,3,4,5,6,7,8,9};
		int i=0;
		while (i < v.length/2){
			int t = v[i];
			v[i] = v[v.length-1-i];
			v[v.length-1-i] = t;
			i++;
		} 
		show(v);
	}
}
/*
    "oldschool"
	reversal in place
	operates on an array
	the datastructure is assumed to be mutable

*/

