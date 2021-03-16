import java.util.Iterator;

class RVList<T> implements Iterable<T> {
	private T[] array;

	public RVList(T[] array){
		this.array = array;
	}

	@Override
	public Iterator<T> iterator() {
		return new Iterator<T>(){
			private int crtIndex = array.length - 1;

			@Override
			public boolean hasNext(){
				return crtIndex >= 0;
			}

			@Override
			public T next(){
				return array[crtIndex--];
			} 

			@Override
			public void remove () {}
		};
	}
}

public class OORev {

	public static void main (String[] args) {
		String[] s = new String[]{"1", "2", "3", "4", "5", "6"};
		
		Iterator<String> r = (new RVList<String>(s)).iterator();
		while (r.hasNext()){
			System.out.println(r.next());
		}
	}
}
/*
    operates on an array,
    but the result is an Iterable !!

     
      object that supports   -> RVList      -> iterator that explores
        .toArray(...)           (Iterable)     elements in reverse

	focuses on exploration of the elements, does not provide
	a datastructure as result 
	
    abstract - can work on arbitrary collections
*/

